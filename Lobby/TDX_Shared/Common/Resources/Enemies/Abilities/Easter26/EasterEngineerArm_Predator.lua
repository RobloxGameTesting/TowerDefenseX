local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 6.9,
	ExecutionTime = 9.8,
	AnimationName = "TransitionPredator",
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_Eradicator,
	TriggeredAtHealthPercentage = 0,
	MaximumUses = 1,
	MovementSpeedIncrease = 0,
	ParallelAbilityNames = { Enums.EnemyAbilities.EasterEngineerArm_PredatorLasers },
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.EasterEngineerEradShoot,
		Enums.EnemyAbilities.EasterEngineerEradShoot_PathEntity,
		Enums.EnemyAbilities.EasterEngineerEradStrafe
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>TransitionPredator" },
	EffectParentInstanceNames = { "TransitionPredator", "Appearance>Arm_Eradicator", "FingerSnap" },
	HealData = {
		HealToMaxHealth = true,
		ShieldGainToMaxShield = true,
		OverrideMaxHealth = 350000,
		OverrideMaxShield = 7500
	},
	ReplaceAnimationMap = { Move = "Move_Predator" }
}