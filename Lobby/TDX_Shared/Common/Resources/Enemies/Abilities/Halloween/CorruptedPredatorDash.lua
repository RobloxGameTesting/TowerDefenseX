local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 110,
	Animated = false,
	Delay = 0,
	ExecutionTime = 3,
	ContinueMovingWhileUsing = true,
	EffectParentInstanceNames = {},
	SelfEnemyBuffNames = { Enums.EnemyBuffs.CorruptedPredatorDash }
}