local BunnyTank900CustomCodeClass = {}
BunnyTank900CustomCodeClass.__index = BunnyTank900CustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local tweenInfo = TweenInfo.new(17 / 30, Enum.EasingStyle.Linear)

local function HideInstances(baseInstances)
	for _, instance in ipairs(baseInstances) do
		if instance:IsA("BasePart") then
			instance.CanQuery = false
			TweenService:Create(instance, tweenInfo, { Transparency = 1 }):Play()
			instance:SetAttribute("OriginalTransparency", 1)
		elseif instance:IsA("Decal") then
			TweenService:Create(instance, tweenInfo, { Transparency = 1 }):Play()
		end
	end
end

function BunnyTank900CustomCodeClass.New(speedMultiplier: number)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		RootPart = nil,
		BaseInstances = nil,
		BeamRaycastParams = raycastParams,
		LaserSweepOn = false,
		LaserSweepBeams = {},
		LaserSweepAttachment = nil,
		LaserSweepBeamPart = nil,
		_TimingHelpers = { HideTimer = nil },
		_Wrappers = { BeamEffects = nil, Phase2EffectWrapper = nil }
	}, BunnyTank900CustomCodeClass))
end

function BunnyTank900CustomCodeClass:Initialize(enemy, config)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	self.Config = config
	self.RootPart = characterModel.PrimaryPart
	local base = characterModel:FindFirstChild("Base")
	local baseInstances

	if base then
		baseInstances = base:GetDescendants()
	end

	self.BaseInstances = baseInstances
	local speedMultiplier = self.SpeedMultiplier
	local laserSpinBeams = characterModel:FindFirstChild("LaserSpinBeams")
	local _1 = laserSpinBeams:FindFirstChild("1")
	self.LaserSweepBeamPart = _1

	for _, beam in pairs(_1:GetChildren()) do
		if beam:IsA("Beam") then
			table.insert(self.LaserSweepBeams, beam)
		end
	end

	self.LaserSweepAttachment = _1:FindFirstChild("End")
	self._Wrappers.BeamEffects = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._Wrappers.BeamEffects:AddFrom(laserSpinBeams, speedMultiplier)
	local phase2Effects = characterModel:FindFirstChild("Phase2Effects")
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(phase2Effects, speedMultiplier)
	self._Wrappers.Phase2EffectWrapper = emitterAndSoundWrapper
end

function BunnyTank900CustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	self:_RunLaserSweep(p)
end

function BunnyTank900CustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.BunnyTank900Transition then
		if not self.BaseInstances then
			return
		end

		local hideTimer = TimingHelperClass.New({
			TimeUntilCallback = 79 / 30,
			Callback = function()
				HideInstances(self.BaseInstances)
			end
		})
		hideTimer:Start()

		for _, timingHelper in pairs(self._TimingHelpers) do
			timingHelper:Destroy()
		end

		self._TimingHelpers.HideTimer = hideTimer
		self._Wrappers.Phase2EffectWrapper:PlayAll()
	end
end

function BunnyTank900CustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.BunnyTank900LaserSpin then
		if p2 == "Laser" then
			self:_StartLaserSweep()
		elseif p2 == "Laser_Stop" then
			self:_StopLaserSweep()
		end
	end
end

function BunnyTank900CustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function BunnyTank900CustomCodeClass:EnemyDestroyed(_: boolean?, _: boolean?)
	self:_StopLaserSweep()
end

function BunnyTank900CustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function BunnyTank900CustomCodeClass.AnimationStateChanged(_, _: string, _) end

function BunnyTank900CustomCodeClass:_StartLaserSweep()
	self.LaserSweepOn = true

	for _, laserSweepBeam in pairs(self.LaserSweepBeams) do
		laserSweepBeam.Enabled = true
	end

	self:_RunLaserSweep(0)
	self._Wrappers.BeamEffects:PlayAll()
end

function BunnyTank900CustomCodeClass:_StopLaserSweep()
	self.LaserSweepOn = false

	for _, laserSweepBeam in pairs(self.LaserSweepBeams) do
		laserSweepBeam.Enabled = false
	end

	if self._Wrappers.BeamEffects then
		self._Wrappers.BeamEffects:StopContinuous()
	end
end

function BunnyTank900CustomCodeClass:_RunLaserSweep(_: number)
	if not self.LaserSweepOn then
		return
	end

	local laserSweepBeamPart = self.LaserSweepBeamPart
	local lookVector = laserSweepBeamPart.CFrame.LookVector
	local v = -self.RootPart.CFrame.UpVector
	local v2 = math.acos((math.clamp(lookVector:Dot(v), -1, 1)))

	if v2 > 1.2217304763960306 then
		local cross = lookVector:Cross(v)

		if cross.Magnitude > 0.001 then
			local unit = cross.Unit
			local v3 = v2 - 1.2217304763960306
			lookVector = CFrame.fromAxisAngle(unit, v3):VectorToWorldSpace(lookVector)
		end
	end

	local v3 = lookVector * 30
	local position = laserSweepBeamPart.CFrame.Position
	local laserSweepAttachment = self.LaserSweepAttachment
	local raycastResult = workspace:Raycast(position, v3, self.BeamRaycastParams)

	if raycastResult then
		laserSweepAttachment.WorldCFrame = CFrame.new(raycastResult.Position)
	else
		laserSweepAttachment.WorldCFrame = CFrame.new(position + v3)
	end
end

return BunnyTank900CustomCodeClass