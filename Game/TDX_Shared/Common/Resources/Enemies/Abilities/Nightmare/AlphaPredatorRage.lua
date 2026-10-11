local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 8,
	ExecutionTime = 12.133000000000001,
	AnimationName = "Rage",
	ParallelAbilityNames = { Enums.EnemyAbilities.AlphaPredatorRage_Invulnerable },
	TriggeredAtHealthPercentage = 0,
	MaximumUses = 1,
	MovementSpeedIncrease = 0,
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Rage" },
	EffectParentInstanceNames = { "Rage" },
	HealData = { HealToMaxHealth = true, ShieldGainToMaxShield = true },
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}