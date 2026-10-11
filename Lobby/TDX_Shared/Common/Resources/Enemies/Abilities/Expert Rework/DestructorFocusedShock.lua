local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		RemoveTowerInvulnerability = true,
		Damage = 5000,
		BuffName = Enums.TowerBuffs.DestructorFocusedShockStun,
		BuffName2 = Enums.TowerBuffs.DestructorFocusedShockFirerateDebuff
	},
	StartingCooldown = 6,
	Cooldown = 30,
	Animated = true,
	AnimationName = "FocusedShock",
	SecondaryAnimationForKeyframeEventsName = "FocusedShockDamaged",
	Delay = 1.3,
	ExecutionTime = 2.5669999999999997,
	InstantPlayEffectParentInstanceNames = { "FocusedShock>SFX" },
	EffectParentInstanceNames = { "FocusedShock>Shot" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.DestructorHandShot,
			Range = 25,
			MinimumRange = 5,
			ConsiderTargetsWithNoAttack = false,
			TargetMostExpensiveTower = true
		}
	}
}