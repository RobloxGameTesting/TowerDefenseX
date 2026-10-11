local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 6,
	Cooldown = 18,
	Animated = true,
	Delay = 29 / 15,
	ExecutionTime = 2.8,
	AnimationName = "HammerSlam",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 800 },
			TowerBuffNames = { Enums.TowerBuffs.VoidGuardHammerSlamStun },
			Range = 14,
			ArcSpreadAngle = 90,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = { "HammerSlam" }
}