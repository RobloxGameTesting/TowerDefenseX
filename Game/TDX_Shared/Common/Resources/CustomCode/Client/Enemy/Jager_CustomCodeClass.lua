local createVector = vector.create
local JagerCustomCodeClass = {}
JagerCustomCodeClass.__index = JagerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))

function JagerCustomCodeClass.New(speedMultiplier: number)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		BeamRaycastParams = raycastParams,
		LaserSweepOn = false,
		LeftLaserSweepBeam = nil,
		RightLaserSweepBeam = nil,
		LeftLaserSweepAttachment = nil,
		RightLaserSweepAttachment = nil,
		_TimingHelpers = {},
		_Wrappers = { BeamEffects = nil }
	}, JagerCustomCodeClass))
end

function JagerCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local laserSweep = self.CharacterModel:FindFirstChild("LaserSweep")
	local beamLeft = laserSweep:FindFirstChild("BeamLeft")
	local beamRight = laserSweep:FindFirstChild("BeamRight")
	self.LeftLaserSweepBeam = beamLeft:FindFirstChild("Beam")
	self.RightLaserSweepBeam = beamRight:FindFirstChild("Beam")
	self.LeftLaserSweepAttachment = beamLeft:FindFirstChild("End")
	self.RightLaserSweepAttachment = beamRight:FindFirstChild("End")
	self._Wrappers.BeamEffects = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._Wrappers.BeamEffects:AddFrom(laserSweep, speedMultiplier)
end

function JagerCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	self:_RunLaserSweep()
end

function JagerCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function JagerCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.JagerLaserSweep then
		if p2 == "Laser" then
			self:_StartLaserSweep()
		elseif p2 == "Laser_Stop" then
			self:_StopLaserSweep()
		end
	end
end

function JagerCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function JagerCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	self.DeathStarted = true
	self:_StopLaserSweep()
end

function JagerCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function JagerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function JagerCustomCodeClass:_StartLaserSweep()
	self.LaserSweepOn = true
	self.LeftLaserSweepBeam.Enabled = true
	self.RightLaserSweepBeam.Enabled = true
	self:_RunLaserSweep()
	self._Wrappers.BeamEffects:PlayAll()
end

function JagerCustomCodeClass:_StopLaserSweep()
	self.LaserSweepOn = false
	self.LeftLaserSweepBeam.Enabled = false
	self.RightLaserSweepBeam.Enabled = false
	self:_RunLaserSweep()
	self._Wrappers.BeamEffects:StopContinuous()
end

function JagerCustomCodeClass:_RunLaserSweep()
	if self.LaserSweepOn then
		local function RaycastForBeamHit(p)
			if not self.BeamRaycastParams then
				warn("No BeamRaycastParams")
			end

			local parent = p.Parent
			local position = parent.CFrame.Position
			local v = 15 * ((parent.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)).LookVector.Unit - createVector(0, 0.2, 0)).Unit
			local raycastResult = workspace:Raycast(position, v, self.BeamRaycastParams)

			if raycastResult then
				p.WorldCFrame = CFrame.new(raycastResult.Position)
			else
				p.CFrame = CFrame.new(-15, 0, 0)
			end
		end

		RaycastForBeamHit(self.LeftLaserSweepAttachment)
		RaycastForBeamHit(self.RightLaserSweepAttachment)
	end
end

return JagerCustomCodeClass