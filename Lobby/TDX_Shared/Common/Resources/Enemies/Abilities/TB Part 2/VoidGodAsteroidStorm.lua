local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local epicenterByMap = {
	[Enums.Maps.Exegesis] = createVector(184.183, 39.615, 75.023),
	[Enums.Maps.Genesis] = createVector(33.19, 145.637, 90.21)
}
return {
	StartingCooldown = 30,
	Cooldown = 80,
	Animated = true,
	AnimationName = "AsteroidStorm",
	AutoHandleEffects = true,
	Delay = 1.85,
	ExecutionTime = 5.2,
	BombardmentData = {
		Attacks = {
			{
				EpicenterByMap = epicenterByMap,
				SpawnDistance = 450,
				SpawnOffsetFromOrigin = createVector(-0.5, 0, -1),
				SpawnAngleFromParallel = 0.6108652381980153,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 40,
				TargetGroundMaximumHeightDelta = 18,
				Duration = 6,
				Count = 8,
				ProjectileName = Enums.Projectiles.VoidGodAsteroidSmall,
				Damage = 1000,
				TowerBuffName = Enums.TowerBuffs.VoidGodAsteroidStun,
				SplashRadius = 2.5
			},
			{
				EpicenterByMap = epicenterByMap,
				SpawnDistance = 450,
				SpawnOffsetFromOrigin = createVector(-0.5, 0, -1),
				SpawnAngleFromParallel = 0.6108652381980153,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 40,
				TargetGroundMaximumHeightDelta = 18,
				Delay = 0.5,
				Duration = 5.5,
				Count = 3,
				ProjectileName = Enums.Projectiles.VoidGodAsteroidMedium,
				Damage = 1500,
				TowerBuffName = Enums.TowerBuffs.VoidGodAsteroidStun,
				SplashRadius = 4
			},
			{
				EpicenterByMap = epicenterByMap,
				NoTargetFallbackRadius = 40,
				SpawnDistance = 450,
				SpawnOffsetFromOrigin = createVector(-0.5, 0, -1),
				SpawnAngleFromParallel = 0.6108652381980153,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetRandomTower = true,
				Duration = 6,
				Count = 12,
				ProjectileName = Enums.Projectiles.VoidGodAsteroidSmall,
				Damage = 1000,
				TowerBuffName = Enums.TowerBuffs.VoidGodAsteroidStun,
				SplashRadius = 2.5
			},
			{
				EpicenterByMap = epicenterByMap,
				NoTargetFallbackRadius = 40,
				SpawnDistance = 450,
				SpawnOffsetFromOrigin = createVector(-0.5, 0, -1),
				SpawnAngleFromParallel = 0.6108652381980153,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetRandomTower = true,
				Delay = 0.5,
				Duration = 5.5,
				Count = 6,
				ProjectileName = Enums.Projectiles.VoidGodAsteroidMedium,
				Damage = 1500,
				TowerBuffName = Enums.TowerBuffs.VoidGodAsteroidStun,
				SplashRadius = 4
			},
			{
				EpicenterByMap = epicenterByMap,
				NoTargetFallbackRadius = 40,
				SpawnDistance = 450,
				SpawnOffsetFromOrigin = createVector(-0.5, 0, -1),
				SpawnAngleFromParallel = 0.6108652381980153,
				SpawnVarianceXZ = 50,
				SpawnVarianceY = 50,
				TargetMostExpensiveTower = true,
				Delay = 1,
				Duration = 5,
				Count = 3,
				ProjectileName = Enums.Projectiles.VoidGodAsteroidLarge,
				Damage = 3000,
				TowerBuffName = Enums.TowerBuffs.VoidGodAsteroidStun,
				SplashRadius = 8
			},
			{
				EpicenterByMap = epicenterByMap,
				SpawnDistance = 450,
				SpawnOffsetFromOrigin = createVector(-0.5, 0, -1),
				SpawnAngleFromParallel = 0.6108652381980153,
				SpawnVarianceXZ = 200,
				SpawnVarianceY = 80,
				VisualOnly = true,
				FlyByHeight = 60,
				FlyByRadius = 50,
				Duration = 6,
				Count = 20,
				ProjectileName = Enums.Projectiles.VoidGodAsteroidSmallFlyBy
			}
		}
	}
}