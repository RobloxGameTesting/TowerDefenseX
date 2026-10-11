local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 110,
	Animated = true,
	Delay = 1,
	ExecutionTime = 16.767000000000003,
	AnimationName = "DroneStrike",
	ParallelAbilityNames = { Enums.EnemyAbilities.EmperorDroneStrike_Invulnerable },
	EffectParentInstanceNames = { "DroneStrike" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>DroneStrike" },
	BombardmentData = {
		Attacks = {
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.5235987755982988,
				SpawnVarianceXZ = 350,
				SpawnVarianceY = 50,
				TargetGroundAroundEnemyRadius = 35,
				TargetGroundMaximumHeightDelta = 18,
				Duration = 4,
				Count = 160,
				ProjectileName = Enums.Projectiles.EmperorDrone,
				Damage = 1200,
				TowerBuffName = Enums.TowerBuffs.EmperorDroneStrikeDebuff,
				SplashRadius = 1.5
			},
			{
				SpawnDistance = 600,
				SpawnAngleFromParallel = 0.5235987755982988,
				SpawnVarianceXZ = 350,
				SpawnVarianceY = 50,
				TargetRandomTower = true,
				TargetTowerMinimumRange = 20,
				TargetTowerMinimumValue = 10000,
				TargetRandomIgnoreMap = { [Enums.Towers.Medic] = true },
				Delay = 1,
				Duration = 4,
				Count = 18,
				ProjectileName = Enums.Projectiles.EmperorDrone,
				Damage = 850,
				TowerBuffName = Enums.TowerBuffs.EmperorDroneStrikeDebuff,
				SplashRadius = 3.5
			}
		}
	}
}