local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2, Damage = 125 },
	StartingCooldown = 4,
	Cooldown = 8,
	Animated = true,
	AnimationName = "Fire",
	FaceTarget = true,
	Delay = 29 / 60,
	ExecutionTime = 0.8,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.CystVoidFireball,
			Range = 25
		}
	}
}