local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 82,
	Animated = true,
	Delay = 1.183,
	ExecutionTime = 4.3999999999999995,
	AnimationName = "PurpleAsteroid",
	EffectParentInstanceNames = { "MeteorVFXLeftArm" },
	EffectsStartDelay = 1.183,
	EffectsStopDelay = 3.133,
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
				Count = 3,
				ProjectileName = Enums.Projectiles.VoidMeteoriteSmall,
				Damage = 75,
				TowerBuffName = Enums.TowerBuffs.VoidMeteoriteStun,
				SplashRadius = 2.5
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 150,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 30,
				TargetGroundMaximumHeightDelta = 18,
				Duration = 2.5,
				Count = 2,
				ProjectileName = Enums.Projectiles.VoidMeteoriteMedium,
				Damage = 150,
				TowerBuffName = Enums.TowerBuffs.VoidMeteoriteStun,
				SplashRadius = 3
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.8726646259971648,
				SpawnVarianceXZ = 50,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 30,
				TargetGroundMaximumHeightDelta = 18,
				Duration = 1,
				Count = 1,
				ProjectileName = Enums.Projectiles.VoidMeteoriteLarge,
				Damage = 175,
				TowerBuffName = Enums.TowerBuffs.VoidMeteoriteStun,
				SplashRadius = 6
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
				Count = 4,
				ProjectileName = Enums.Projectiles.VoidMeteoriteSmall,
				Damage = 125,
				TowerBuffName = Enums.TowerBuffs.VoidMeteoriteStun,
				SplashRadius = 2.5
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
				Count = 1,
				ProjectileName = Enums.Projectiles.VoidMeteoriteMedium,
				Damage = 155,
				TowerBuffName = Enums.TowerBuffs.VoidMeteoriteStun,
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
				Count = 1,
				ProjectileName = Enums.Projectiles.VoidMeteoriteLarge,
				Damage = 250,
				TowerBuffName = Enums.TowerBuffs.VoidMeteoriteStun,
				SplashRadius = 6
			}
		}
	}
}