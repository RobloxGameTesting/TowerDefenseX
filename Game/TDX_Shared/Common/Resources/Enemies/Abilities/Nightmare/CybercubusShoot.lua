local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		BuffName = Enums.TowerBuffs.CybercubusToxicDebuff,
		Damage = 600
	},
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	AnimationName = "Shoot",
	Delay = 41 / 60,
	ExecutionTime = 53 / 30,
	BurstSize = 4,
	BurstInterval = 0,
	CustomBurstDelayMap = { 0, 0.3999999999999999, 0 },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.CybercubusBall,
			Range = 40,
			MinimumRange = 25,
			TargetPath = true
		}
	},
	ProjectileName = Enums.Projectiles.CybercubusBall
}