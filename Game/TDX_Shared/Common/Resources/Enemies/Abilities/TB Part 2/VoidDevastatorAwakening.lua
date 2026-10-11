local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	AnimationName = "Awakening",
	AutoHandleEffects = true,
	DoNotTryToUse = true,
	Delay = 3,
	ExecutionTime = 4.582999999999999,
	MovementSpeedIncrease = 0,
	HealData = { HealToMaxHealth = true, ShieldGainToMaxShield = true },
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.VoidDevastatorCrystalInfection,
		Enums.EnemyAbilities.VoidDevastatorCrystalInfection_Summon,
		Enums.EnemyAbilities.VoidDevastatorAxeSlam
	},
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}