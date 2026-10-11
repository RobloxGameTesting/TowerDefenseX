local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 30,
	Animated = true,
	Delay = 2.4,
	ExecutionTime = 3.4669999999999996,
	AnimationName = "Asteroids",
	BombardmentData = {
		Attacks = {
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 30,
				TargetGroundMaximumHeightDelta = 18,
				Duration = 4,
				Count = 6,
				ProjectileName = Enums.Projectiles.NightmareSlimeKingAsteroidSmall,
				TowerBuffName = Enums.TowerBuffs.NightmareSlimeKingAsteroidDebuff,
				SplashRadius = 2
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 30,
				TargetGroundMaximumHeightDelta = 18,
				Duration = 2.5,
				Count = 3,
				ProjectileName = Enums.Projectiles.NightmareSlimeKingAsteroidMedium,
				TowerBuffName = Enums.TowerBuffs.NightmareSlimeKingAsteroidDebuff,
				SplashRadius = 5
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 50,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 30,
				TargetGroundMaximumHeightDelta = 18,
				Duration = 1,
				Count = 2,
				ProjectileName = Enums.Projectiles.NightmareSlimeKingAsteroidLarge,
				TowerBuffName = Enums.TowerBuffs.NightmareSlimeKingAsteroidDebuff,
				SplashRadius = 8
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetRandomTower = true,
				TargetTowerMinimumRange = 20,
				TargetTowerMinimumValue = 10000,
				TargetRandomIgnoreMap = { [Enums.Towers.Medic] = true },
				Delay = 1,
				Duration = 4,
				Count = 6,
				ProjectileName = Enums.Projectiles.NightmareSlimeKingAsteroidSmall,
				TowerBuffName = Enums.TowerBuffs.NightmareSlimeKingAsteroidDebuff,
				SplashRadius = 2
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetRandomTower = true,
				TargetTowerMinimumRange = 20,
				TargetTowerMinimumValue = 10000,
				TargetRandomIgnoreMap = { [Enums.Towers.Medic] = true },
				Delay = 1,
				Duration = 2.5,
				Count = 3,
				ProjectileName = Enums.Projectiles.NightmareSlimeKingAsteroidMedium,
				TowerBuffName = Enums.TowerBuffs.NightmareSlimeKingAsteroidDebuff,
				SplashRadius = 3
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 50,
				SpawnVarianceY = 50,
				TargetRandomTower = true,
				TargetTowerMinimumRange = 20,
				TargetTowerMinimumValue = 10000,
				TargetRandomIgnoreMap = { [Enums.Towers.Medic] = true },
				Delay = 1,
				Duration = 1,
				Count = 2,
				ProjectileName = Enums.Projectiles.NightmareSlimeKingAsteroidLarge,
				TowerBuffName = Enums.TowerBuffs.NightmareSlimeKingAsteroidDebuff,
				SplashRadius = 8
			}
		}
	}
}