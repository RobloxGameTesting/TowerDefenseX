local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = true,
	Delay = 1,
	ExecutionTime = 1.2,
	AnimationName = "Run Chargeup",
	AutoHandleEffects = true,
	MaximumUses = 1,
	TriggeredAtHealthPercentage = 0.5,
	MovementSpeedIncrease = 5.4,
	ReplaceAnimationMap = { Move = "Run" },
	DisableAbilityListIfUsed = { Enums.EnemyAbilities.GestaltSpearJab, Enums.EnemyAbilities.GestaltSpearThrow }
}