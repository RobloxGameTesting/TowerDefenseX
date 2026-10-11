local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 6.8,
	ExecutionTime = 9.8,
	AnimationName = "TransitionWarMachine",
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_Predator,
	TriggeredAtHealthPercentage = 0,
	MaximumUses = 1,
	MovementSpeedIncrease = 1.5,
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.EasterEngineerPredLaserArc,
		Enums.EnemyAbilities.EasterEngineerPredLaserBurst,
		Enums.EnemyAbilities.EasterEngineerPredLaserBurst_PathEntity,
		Enums.EnemyAbilities.EasterEngineerPredSummon
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>TransitionWarMachine" },
	EffectParentInstanceNames = { "TransitionWarMachine", "Appearance>Arm_Predator", "FingerSnap" },
	HealData = {
		HealToMaxHealth = true,
		ShieldGainToMaxShield = true,
		OverrideMaxHealth = 550000,
		OverrideMaxShield = 20000
	},
	ReplaceAnimationMap = { Move = "Move_WarMachine" }
}