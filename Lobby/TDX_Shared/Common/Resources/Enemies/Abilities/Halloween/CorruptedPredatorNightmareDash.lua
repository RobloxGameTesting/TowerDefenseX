local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 8,
	Cooldown = 35,
	Animated = false,
	Delay = 0,
	ExecutionTime = 6,
	ContinueMovingWhileUsing = true,
	EffectParentInstanceNames = {},
	SelfEnemyBuffNames = { Enums.EnemyBuffs.CorruptedPredatorNightmareDash }
}