local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	AnimationName = "Rage",
	Delay = 2,
	ExecutionTime = 6.567,
	ParallelAbilityNames = { Enums.EnemyAbilities.ArtemisRageBeams },
	InstantPlayEffectParentInstanceNames = { "Rage>SFX" },
	TriggeredAtHealthPercentage = 0.6,
	MaximumUses = 1,
	HealData = { HealAmount = 0 },
	MovementSpeedIncrease = 0.9,
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}