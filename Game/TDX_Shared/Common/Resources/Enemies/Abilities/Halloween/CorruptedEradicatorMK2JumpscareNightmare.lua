local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local CORRUPTED_ERADICATOR_MK2_JUMPSCARE_TIME = _G.CORRUPTED_ERADICATOR_MK2_JUMPSCARE_TIME
local corruptedEradicatorMK2JumpscareData = {
	SpawnEnemiesTime = 1.5,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.BlueEradicatorMK2,
			Count = 5,
			StaggerMaxDelay = 3,
			EvenStagger = true,
			OverridePathIndices = { 18 },
			PathPercentageLowerBound = 0.01,
			PathPercentageUpperBound = 0.99,
			PathPercentageEvenStagger = true
		}
	}
}
return {
	StartingCooldown = CORRUPTED_ERADICATOR_MK2_JUMPSCARE_TIME,
	Cooldown = 1e999,
	Animated = true,
	AnimationName = "Hide",
	Delay = 0,
	ExecutionTime = 30,
	MaximumUses = 1,
	EffectParentInstanceNames = { "Root>Jumpscare" },
	EffectsStartDelay = 29.8,
	SetInvulnerableForTime = 30,
	CorruptedEradicatorMK2JumpscareData = corruptedEradicatorMK2JumpscareData,
	DisableAbilityListIfUsed = { Enums.EnemyAbilities.CorruptedEradicatorMK2PreJumpscareShield }
}