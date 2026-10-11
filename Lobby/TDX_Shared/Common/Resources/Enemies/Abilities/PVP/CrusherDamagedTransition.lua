local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	MaximumUses = 1,
	TriggeredAtHealthPercentage = 0.6,
	ReplaceAnimationMap = { Move = "Damaged Walk" },
	DisableAbilityListIfUsed = { Enums.EnemyAbilities.CrusherCrush }
}