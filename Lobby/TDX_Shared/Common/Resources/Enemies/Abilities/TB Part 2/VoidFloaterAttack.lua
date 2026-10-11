local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 500 },
	StartingCooldown = 3,
	Cooldown = 25,
	Animated = true,
	AnimationName = "Attack",
	FaceTarget = true,
	Delay = 31 / 60,
	ExecutionTime = 1.3,
	BurstSize = 2,
	BurstInterval = 0,
	ModelBurstSize = 2,
	CustomBurstDelayMap = { 19 / 60 },
	EnemyToTowerRangedDataSequence = {
		{ CanTargetAir = false, ProjectileName = Enums.Projectiles.VoidFloaterCrystal, Range = 80 }
	}
}