local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 3.6,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	DoNotTryToUse = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = { Damage = 200 },
			Range = 50,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		AffectPathEntitiesOnly = true,
		DamageData = { InstantKill = true },
		MinimumTargets = 0,
		AffectTargetsWithNoAttack = true
	},
	EffectParentInstanceNames = {}
}