local createVector = vector.create
local AlphaPredatorCustomCodeClass = {}
AlphaPredatorCustomCodeClass.__index = AlphaPredatorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))

function AlphaPredatorCustomCodeClass.New(speedMultiplier: number)
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
		PreviousAbilityName = nil,
		NukeModel = nil,
		LaserSweepOn = false,
		LaserArcBeam = nil,
		LaserArcAttachment = nil,
		_TimingHelpers = {},
		_Wrappers = { LaserArcBeamEffects = nil }
	}, AlphaPredatorCustomCodeClass))
end

function AlphaPredatorCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local beam = characterModel:FindFirstChild("LaserArc"):FindFirstChild("Beam")
	local beam2 = beam:FindFirstChild("Beam")
	local firstChild = beam:FindFirstChild("End")
	self.LaserArcBeam = beam2
	self.LaserArcAttachment = firstChild
	self._Wrappers.LaserArcBeamEffects = WrapperFactory.NewEmitterAndSoundWrapper(beam, speedMultiplier)
	self.Character:HideModelWithName("Core")
end

function AlphaPredatorCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	self:_RunLaserSweep()
end

function AlphaPredatorCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName

	if previousAbilityName == Enums.EnemyAbilities.AlphaPredatorRage then
		local config = self.Config
		local folder = Utilities.TryGetInstanceFromPath(self.CharacterModel, config.FootstepEffectInstanceNames)

		if folder then
			for _, sound in pairs(folder:GetDescendants()) do
				if not sound:IsA("Sound") then
					continue
				end

				local damagedSoundId = sound:GetAttribute("DamagedSoundId")

				if damagedSoundId then
					sound.SoundId = damagedSoundId
				end
			end
		else
			warn("Could not find FootstepSFXHolder for Alpha Predator Rage ability")
		end
	end
end

function AlphaPredatorCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.AlphaPredatorRage then
		if p2 == "Start" then
			self.Character:ShowModelWithName("Core")
		elseif p2 == "Explode" then
			self.Character:HideModelWithName("Core")
		end
	elseif p == Enums.EnemyAbilities.AlphaPredatorLaserArc then
		if p2 == "Laser" then
			self:_StartLaserSweep()
		elseif p2 == "Laser_Stop" then
			self:_StopLaserSweep()
		end
	end
end

function AlphaPredatorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function AlphaPredatorCustomCodeClass.EnemyDestroyed(_, flag: boolean?, _: boolean?)
	if flag then
	end
end

function AlphaPredatorCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function AlphaPredatorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function AlphaPredatorCustomCodeClass:_StartLaserSweep()
	self.LaserSweepOn = true
	self.LaserArcBeam.Enabled = true
	self:_RunLaserSweep()
	self._Wrappers.LaserArcBeamEffects:PlayAll()
end

function AlphaPredatorCustomCodeClass:_StopLaserSweep()
	self.LaserSweepOn = false
	self.LaserArcBeam.Enabled = false
	self:_RunLaserSweep()
	self._Wrappers.LaserArcBeamEffects:StopContinuous()
end

function AlphaPredatorCustomCodeClass:_RunLaserSweep()
	if self.LaserSweepOn then
		local function RaycastForBeamHit(laserArcAttachment)
			if not self.BeamRaycastParams then
				warn("No BeamRaycastParams")
			end

			local parent = laserArcAttachment.Parent
			local position = parent.CFrame.Position
			local v = 30 * ((parent.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)).LookVector.Unit - createVector(0, 0.35, 0))
			local raycastResult = workspace:Raycast(position, v, self.BeamRaycastParams)

			if raycastResult then
				laserArcAttachment.WorldCFrame = CFrame.new(raycastResult.Position)
			else
				laserArcAttachment.CFrame = CFrame.new(-30, 0, 0)
			end
		end

		RaycastForBeamHit(self.LaserArcAttachment)
	end
end

return AlphaPredatorCustomCodeClass