local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		Damage = 575,
		BuffName = Enums.TowerBuffs.DreadcubusDamageDebuff
	},
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	AnimationName = "Shoot",
	Delay = 41 / 60,
	ExecutionTime = 1.75,
	BurstSize = 4,
	BurstInterval = 0,
	CustomBurstDelayMap = { 0, 0.3999999999999999, 0 },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.DreadcubusBall,
			Range = 40,
			MinimumRange = 10,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true
		}
	},
	ProjectileName = Enums.Projectiles.DreadcubusBall
}