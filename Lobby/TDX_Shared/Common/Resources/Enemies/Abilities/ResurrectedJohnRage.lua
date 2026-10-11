local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 50,
	StartingCooldownVariance = 5,
	CooldownVariance = 10,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Torso" },
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 12,
		EnemyBuffNames = { Enums.EnemyBuffs.ResurrectedJohnRageBuff }
	},
	SelfEnemyBuffNames = { Enums.EnemyBuffs.ResurrectedJohnRageSelfBuff }
}