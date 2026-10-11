local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 1,
	ContinueMovingWhileUsing = true,
	TriggeredAtHealthPercentage = 0.5,
	MaximumUses = 1,
	HealData = { HealAmount = 0 },
	MovementSpeedIncrease = 2.2,
	DisableAbilityListIfUsed = { Enums.EnemyAbilities.TheIlluminatiSlam },
	InstantPlayEffectParentInstanceNames = { "Rage" },
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}