local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 6,
	ExecutionTime = 8.8,
	AnimationName = "TransitionEradicator",
	TriggeredAtHealthPercentage = 0,
	MaximumUses = 1,
	MovementSpeedIncrease = 0,
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.EasterEngineerCloakSummon,
		Enums.EnemyAbilities.EasterEngineerCloakMG,
		Enums.EnemyAbilities.EasterEngineerCloakMG_PathEntity
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>TransitionEradicator" },
	EffectParentInstanceNames = { "TransitionEradicator", "FingerSnap" },
	HealData = {
		HealToMaxHealth = true,
		ShieldGainToMaxShield = true,
		OverrideMaxHealth = 280000,
		OverrideMaxShield = 5000
	},
	ReplaceAnimationMap = { Move = "Move_Eradicator" }
}