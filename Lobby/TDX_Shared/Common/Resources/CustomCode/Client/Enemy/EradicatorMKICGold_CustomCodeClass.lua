local EradicatorMKICGoldCustomCodeClass = {}
EradicatorMKICGoldCustomCodeClass.__index = EradicatorMKICGoldCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

local function GetRandomInitialVelocity() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-45, 45), math.random(60, 110), math.random(-45, 45)))
end

local function GetRandomInitialAngularImpulse() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-35, 35) / 100, math.random(-55, 55) / 100, 0))
end

function EradicatorMKICGoldCustomCodeClass.New(speedMultiplier: number)
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
		PreviousAbilityName = nil,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = {
			BeamEffects = nil,
			DeathExplode = nil,
			Death = nil,
			DeathStage1EmitterWrapper = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier),
			DeathStage2EmitterWrapper = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier),
			LiftoffEmitterWrapper = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier),
			LiftoffSoundWrapper = WrapperFactory.NewSoundWrapper(nil, speedMultiplier),
			RageModeSmokeWrapper = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier)
		},
		DeathStarted = false,
		DeathTimePassed = 0,
		DeathStage1Triggered = false,
		DeathStage2Triggered = false,
		LiftoffStarted = false,
		LiftoffStopped = false,
		LiftoffInstance = nil
	}, EradicatorMKICGoldCustomCodeClass))
end

function EradicatorMKICGoldCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	local laserSweepBeamPartLeft = characterModel:FindFirstChild("LaserSweepBeamPartLeft")
	local laserSweepBeamPartRight = characterModel:FindFirstChild("LaserSweepBeamPartRight")
	self.LeftLaserSweepBeam = laserSweepBeamPartLeft:FindFirstChild("Beam")
	self.RightLaserSweepBeam = laserSweepBeamPartRight:FindFirstChild("Beam")
	self.LeftLaserSweepAttachment = laserSweepBeamPartLeft:FindFirstChild("End")
	self.RightLaserSweepAttachment = laserSweepBeamPartRight:FindFirstChild("End")
	self._Wrappers.BeamEffects = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._Wrappers.BeamEffects:AddFrom(laserSweepBeamPartLeft, speedMultiplier)
	self._Wrappers.BeamEffects:AddFrom(laserSweepBeamPartRight, speedMultiplier)
	local deathVFX1 = characterModel:FindFirstChild("DeathVFX1")
	local deathVFX2 = characterModel:FindFirstChild("DeathVFX2")
	local liftoffEffect = characterModel:FindFirstChild("LiftoffEffect")
	local deathRageModeSmoke = characterModel:FindFirstChild("DeathRageModeSmoke")
	self._Wrappers.DeathStage1EmitterWrapper:AddEmittersFrom(deathVFX1, speedMultiplier)
	self._Wrappers.DeathStage2EmitterWrapper:AddEmittersFrom(deathVFX2, speedMultiplier)
	self._Wrappers.LiftoffEmitterWrapper:AddEmittersFrom(liftoffEffect, speedMultiplier)
	self._Wrappers.LiftoffSoundWrapper:AddSoundsFrom(liftoffEffect, speedMultiplier)
	self._Wrappers.RageModeSmokeWrapper:AddEmittersFrom(deathRageModeSmoke, speedMultiplier)
	self.LiftoffInstance = liftoffEffect
	local deathEffectsPart = characterModel:FindFirstChild("DeathEffectsPart")
	self._Wrappers.Death = WrapperFactory.NewEmitterAndSoundWrapper(deathEffectsPart, speedMultiplier)
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 7.75,
		Callback = function()
			self._Wrappers.DeathExplode:PlayAll()

			for _, descendant in pairs(characterModel:GetDescendants()) do
				if not (descendant:IsA("Weld") or descendant:IsA("Motor6D")) then
					continue
				end

				local part1 = descendant.Part1

				if not part1 or part1.Transparency > 0.99 then
					continue
				end

				descendant:Destroy()
				local mass = part1:GetMass()
				part1.Parent = raycastIgnore
				part1:ApplyImpulse(GetRandomInitialVelocity() * mass) -- inferred equivalent call
				part1:ApplyAngularImpulse(GetRandomInitialAngularImpulse() * mass) -- inferred equivalent call
				task.delay(0.1, function()
					part1.CanCollide = true
					task.wait(4)
					local total = 0

					while total < 1.5 do
						total += task.wait()
						part1.Transparency = total / 1.5
					end

					part1:Destroy()
				end)
			end
		end
	})
	self._TimingHelpers.DeathRageModeSmokeStartTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 1.4,
		Callback = function()
			self._Wrappers.RageModeSmokeWrapper:PlayAll()
		end
	})
	self._TimingHelpers.DeathRageModeSmokeStopTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 3.917,
		Callback = function()
			self._Wrappers.RageModeSmokeWrapper:StopContinuous()
		end
	})
end

function EradicatorMKICGoldCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	self:_RunLaserSweep()

	if self.DeathStarted then
		self.DeathTimePassed += p

		if not self.DeathStage1Triggered and self.DeathTimePassed >= 5.2 then
			self._Wrappers.DeathStage1EmitterWrapper:PlayAll()
			self.DeathStage1Triggered = true
		end

		if not self.DeathStage2Triggered and self.DeathTimePassed >= 6.5 then
			self._Wrappers.DeathStage2EmitterWrapper:PlayAll()
			self.DeathStage2Triggered = true
		end

		if not self.LiftoffStarted and self.DeathTimePassed >= 7.1 then
			self._Wrappers.LiftoffEmitterWrapper:PlayAll()
			self.LiftoffStarted = true
		end

		if not self.LiftoffStopped and self.DeathTimePassed >= 8 then
			self._Wrappers.LiftoffEmitterWrapper:StopContinuous()
			self._Wrappers.DeathStage1EmitterWrapper:StopContinuous()
			self._Wrappers.DeathStage2EmitterWrapper:StopContinuous()
			self.LiftoffStopped = true
		end
	end
end

function EradicatorMKICGoldCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName

	if previousAbilityName == Enums.EnemyAbilities.EradicatorMKICGoldRage then
		self:_EnterDamagedState()
	end
end

function EradicatorMKICGoldCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.EradicatorMKICGoldLaserSweep then
		if p2 == "Laser" then
			self:_StartLaserSweep()
		elseif p2 == "Laser_Stop" then
			self:_StopLaserSweep()
		end
	end
end

function EradicatorMKICGoldCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function EradicatorMKICGoldCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	self.DeathStarted = true
	self:_StopLaserSweep()
	self._Wrappers.Death:PlayAll()
	self._TimingHelpers.DeathTimingHelper:Start()
	self._TimingHelpers.DeathRageModeSmokeStartTimingHelper:Start()
	self._TimingHelpers.DeathRageModeSmokeStopTimingHelper:Start()

	if not self.LiftoffInstance.Anchored then
		self.LiftoffInstance.Anchored = true
	end

	self.LiftoffInstance.Position = self.Enemy:GetPosition()

	if not flag2 then
		self._Wrappers.LiftoffSoundWrapper:PlayTriggered()
	end
end

function EradicatorMKICGoldCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function EradicatorMKICGoldCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function EradicatorMKICGoldCustomCodeClass:_StartLaserSweep()
	self.LaserSweepOn = true
	self.LeftLaserSweepBeam.Enabled = true
	self.RightLaserSweepBeam.Enabled = true
	self:_RunLaserSweep()
	self._Wrappers.BeamEffects:PlayAll()
end

function EradicatorMKICGoldCustomCodeClass:_StopLaserSweep()
	self.LaserSweepOn = false
	self.LeftLaserSweepBeam.Enabled = false
	self.RightLaserSweepBeam.Enabled = false
	self:_RunLaserSweep()
	self._Wrappers.BeamEffects:StopContinuous()
end

function EradicatorMKICGoldCustomCodeClass:_RunLaserSweep()
	if self.LaserSweepOn then
		local function RaycastForBeamHit(p)
			if not self.BeamRaycastParams then
				warn("No BeamRaycastParams")
			end

			local parent = p.Parent
			local position = parent.CFrame.Position
			local v = 30 * (parent.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)).LookVector.Unit
			local raycastResult = workspace:Raycast(position, v, self.BeamRaycastParams)
			local v2 = not raycastResult and 30 or (raycastResult.Position - position).Magnitude
			p.CFrame = CFrame.new(-v2, 0, 0)
		end

		RaycastForBeamHit(self.LeftLaserSweepAttachment)
		RaycastForBeamHit(self.RightLaserSweepAttachment)
	end
end

function EradicatorMKICGoldCustomCodeClass:_EnterDamagedState()
	for _, part in pairs(self.CharacterModel:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		if part:GetAttribute("HideWhenDamaged") then
			part.Transparency = 1
		elseif part:GetAttribute("ShowWhenDamaged") then
			part.Transparency = 0
		end
	end

	self.Character:OverrideAnimation("Move", "Move Damaged")
end

return EradicatorMKICGoldCustomCodeClass