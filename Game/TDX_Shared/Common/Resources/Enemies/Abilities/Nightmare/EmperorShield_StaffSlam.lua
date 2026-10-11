local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 7,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	DoNotTryToUse = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.EmperorShieldStaffSlamDebuff },
			DamageData = { Damage = 3000 },
			Range = 25,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		AffectPathEntitiesOnly = true,
		MaximumRange = 10,
		DamageData = { InstantKill = true },
		MinimumTargets = 0,
		AffectTargetsWithNoAttack = true
	},
	EffectParentInstanceNames = {}
}