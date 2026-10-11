local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 5,
	Delay = 0.2,
	ExecutionTime = 0.9000000000000001,
	Animated = true,
	AnimationName = "Slash",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1000 },
			TowerBuffNames = { Enums.TowerBuffs.JXDamageDebuff },
			Range = 6,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = { "HumanoidRootPart>AttackSFX" }
}