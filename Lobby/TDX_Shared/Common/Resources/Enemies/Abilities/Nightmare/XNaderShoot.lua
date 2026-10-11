local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 250 },
	StartingCooldown = 3,
	Cooldown = 10,
	Animated = true,
	AnimationName = "Shoot",
	Delay = 47 / 60,
	ExecutionTime = 131 / 60,
	BurstSize = 4,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		0,
		0.31666666666666676,
		0.2833333333333332,
		5917 / 60
	},
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.XNaderGrenade,
			Range = 40,
			MinimumRange = 10,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true
		}
	},
	ProjectileName = Enums.Projectiles.M203
}