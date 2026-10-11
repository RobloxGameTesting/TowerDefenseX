local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 2.2,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	DoNotTryToUse = true,
	SelfEnemyBuffNames = { Enums.EnemyBuffs.EmperorHealBuff }
}