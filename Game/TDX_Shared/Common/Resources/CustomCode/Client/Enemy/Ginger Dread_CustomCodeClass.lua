local createVector = vector.create
local GingerDreadCustomCodeClass = {}
GingerDreadCustomCodeClass.__index = GingerDreadCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))

function GingerDreadCustomCodeClass.New(speedMultiplier: number)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		AnimationHandler = nil,
		Config = nil,
		BeamRaycastParams = raycastParams,
		LaserSweepOn = false,
		LaserSweepBeam = nil,
		LaserSweepAttachment = nil,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil, BeamEffects = nil }
	}, GingerDreadCustomCodeClass))
end

function GingerDreadCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	local deathAnimationVFX = characterModel:FindFirstChild("DeathAnimationVFX")
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2.3,
		Callback = function()
			deathAnimationVFX:Destroy()
			self._Wrappers.DeathExplode:PlayAll()
			self.Character:ExplodeParts(2)
		end
	})
	local laserEyeBeamPart2 = characterModel:FindFirstChild("LaserEyeBeamPart2")
	self.LaserSweepBeam = laserEyeBeamPart2:FindFirstChild("Beam")
	self.LaserSweepAttachment = laserEyeBeamPart2:FindFirstChild("End")
	self._Wrappers.BeamEffects = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._Wrappers.BeamEffects:AddFrom(laserEyeBeamPart2, speedMultiplier)
end

function GingerDreadCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	self:_RunLaserSweep()
end

function GingerDreadCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.GingerDreadRage then
		self:_EnterDamagedState()
	end
end

function GingerDreadCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.GingerDreadRage then
		if p2 == "FaceUnanchor" then
			self:_FacePlateFallOff()
		end
	elseif p == Enums.EnemyAbilities.GingerDreadLaserSweep then
		if p2 == "Laser" then
			self:_StartLaserSweep()
		elseif p2 == "Laser_Stop" then
			self:_StopLaserSweep()
		end
	end
end

function GingerDreadCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	local laserSweepBeam = self.LaserSweepBeam

	if laserSweepBeam then
		if not laserSweepBeam:GetAttribute("OriginalTextureSpeed") then
			laserSweepBeam:SetAttribute("OriginalTextureSpeed", laserSweepBeam.TextureSpeed)
		end

		laserSweepBeam.TextureSpeed = laserSweepBeam:GetAttribute("OriginalTextureSpeed") * speedMultiplier
	end
end

function GingerDreadCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	self:_StopLaserSweep()

	if flag then
		return
	end

	self._TimingHelpers.DeathTimingHelper:Start()
end

function GingerDreadCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function GingerDreadCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function GingerDreadCustomCodeClass:_EnterDamagedState() end

function GingerDreadCustomCodeClass:_FacePlateFallOff()
	local characterModel = self.CharacterModel
	local primaryPart = characterModel.PrimaryPart
	local v = Utilities.TryGetInstanceFromPath(characterModel, "Face_Plate")
	local v2 = Utilities.TryGetInstanceFromPath(characterModel, "Head>Face_Plate")

	if v2 then
		v2:Destroy()
	end

	if v then
		v.CanCollide = true
		local unit = (v.Position - primaryPart.Position + createVector(0, 0.2, 0)).Unit
		local mass = v:GetMass()
		v:ApplyImpulse(45 * unit * mass)
	end
end

function GingerDreadCustomCodeClass:_StartLaserSweep()
	self.LaserSweepOn = true
	self.LaserSweepBeam.Enabled = true
	self:_RunLaserSweep()
	self._Wrappers.BeamEffects:PlayAll()
end

function GingerDreadCustomCodeClass:_StopLaserSweep()
	self.LaserSweepOn = false
	self.LaserSweepBeam.Enabled = false
	self:_RunLaserSweep()
	self._Wrappers.BeamEffects:StopContinuous()
end

function GingerDreadCustomCodeClass:_RunLaserSweep()
	if self.LaserSweepOn then
		local function RaycastForBeamHit(laserSweepAttachment)
			if not self.BeamRaycastParams then
				warn("No BeamRaycastParams")
			end

			local parent = laserSweepAttachment.Parent
			local position = parent.CFrame.Position
			local v = 30 * (parent.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)).LookVector.Unit
			local raycastResult = workspace:Raycast(position, v, self.BeamRaycastParams)
			local v2 = not raycastResult and 30 or (raycastResult.Position - position).Magnitude
			laserSweepAttachment.CFrame = CFrame.new(-v2, 0, 0)
		end

		RaycastForBeamHit(self.LaserSweepAttachment)
	end
end

return GingerDreadCustomCodeClass