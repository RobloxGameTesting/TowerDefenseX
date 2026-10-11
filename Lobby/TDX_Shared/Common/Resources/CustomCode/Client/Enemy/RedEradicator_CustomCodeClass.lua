local RedEradicatorCustomCodeClass = {}
RedEradicatorCustomCodeClass.__index = RedEradicatorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))

function RedEradicatorCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		AnimationHandler = nil,
		Config = nil,
		GroundPosition = nil,
		DeathStarted = false,
		DeathTimePassed = 0,
		DeathStage1Triggered = false,
		DeathStage2Triggered = false,
		LiftoffStarted = false,
		LiftoffStopped = false,
		DeathStage1EmitterWrapper = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier),
		DeathStage2EmitterWrapper = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier),
		LiftoffEmitterWrapper = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier),
		LiftoffSoundWrapper = WrapperFactory.NewSoundWrapper(nil, speedMultiplier),
		LiftoffInstance = nil
	}, RedEradicatorCustomCodeClass))
end

function RedEradicatorCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local characterModel = self.CharacterModel
	local deathVFX1 = characterModel:FindFirstChild("DeathVFX1")
	local deathVFX2 = characterModel:FindFirstChild("DeathVFX2")
	local liftoffEffect = characterModel:FindFirstChild("LiftoffEffect")
	self.DeathStage1EmitterWrapper:AddEmittersFrom(deathVFX1, self.SpeedMultiplier)
	self.DeathStage2EmitterWrapper:AddEmittersFrom(deathVFX2, self.SpeedMultiplier)
	self.LiftoffEmitterWrapper:AddEmittersFrom(liftoffEffect, self.SpeedMultiplier)
	self.LiftoffSoundWrapper:AddSoundsFrom(liftoffEffect, self.SpeedMultiplier)
	self.LiftoffInstance = liftoffEffect
end

function RedEradicatorCustomCodeClass:Run_FromCharacter(p: number)
	if self.DeathStarted then
		self.DeathTimePassed += p

		if not self.DeathStage1Triggered and self.DeathTimePassed >= 0 then
			self.DeathStage1EmitterWrapper:PlayAll()
			self.DeathStage1Triggered = true
		end

		if not self.DeathStage2Triggered and self.DeathTimePassed >= 3 then
			self.DeathStage2EmitterWrapper:PlayAll()
			self.DeathStage2Triggered = true
		end

		if not self.LiftoffStarted and self.DeathTimePassed >= 3 then
			self.LiftoffEmitterWrapper:PlayAll()
			self.LiftoffStarted = true
		end

		if not self.LiftoffStopped and self.DeathTimePassed >= 4 then
			self.LiftoffEmitterWrapper:StopContinuous()
			self.LiftoffStopped = true
		end
	end
end

function RedEradicatorCustomCodeClass.AbilityUsed(_, _: string) end

function RedEradicatorCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function RedEradicatorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
	self.DeathStage1EmitterWrapper:SpeedMultiplierChanged(speedMultiplier)
	self.DeathStage2EmitterWrapper:SpeedMultiplierChanged(speedMultiplier)
	self.LiftoffEmitterWrapper:SpeedMultiplierChanged(speedMultiplier)
end

function RedEradicatorCustomCodeClass:EnemyDestroyed(_: boolean?, flag: boolean?)
	self.DeathStarted = true

	if not self.LiftoffInstance.Anchored then
		self.LiftoffInstance.Anchored = true
	end

	self.LiftoffInstance.Position = self.Enemy:GetPosition()

	if not flag then
		self.LiftoffSoundWrapper:PlayTriggered()
	end
end

function RedEradicatorCustomCodeClass.CharacterCleanedUp(_) end

function RedEradicatorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return RedEradicatorCustomCodeClass