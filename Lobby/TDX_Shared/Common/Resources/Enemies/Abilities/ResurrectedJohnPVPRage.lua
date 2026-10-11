local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 8,
	Cooldown = 50,
	StartingCooldownVariance = 0,
	CooldownVariance = 0,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Torso" },
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 32,
		EnemyBuffNames = { Enums.EnemyBuffs.ResurrectedJohnPVPRageBuff }
	},
	SelfEnemyBuffNames = { Enums.EnemyBuffs.ResurrectedJohnPVPRageSelfBuff }
}