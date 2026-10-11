local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 50,
	Animated = true,
	Delay = 0,
	ExecutionTime = 227 / 30,
	AnimationName = "ClawCalling",
	GlobalLockGroup = "VoidPortal",
	GlobalLockDuration = 24,
	BombardmentData = {
		ContinueWhileDisabled = true,
		Attacks = {
			{
				Delay = 3,
				SpawnDistance = 180,
				SpawnOffsetFromOrigin = createVector(0, 1, 0),
				TargetMostExpensiveTower = true,
				TargetTowerMinimumRange = 5,
				Duration = 0,
				Count = 1,
				ProjectileName = Enums.Projectiles.VoidPrimeMeteor,
				Damage = 500,
				SplashRadius = 40,
				SplashAlwaysHitAirAndGround = true
			},
			{
				Delay = 4.5,
				Duration = 12,
				Count = 16,
				SpawnDistance = 180,
				SpawnOffsetFromOrigin = createVector(0, 1, 0),
				TargetRandomTower = true,
				TargetTowerMinimumRange = 5,
				ProjectileName = Enums.Projectiles.VoidPrimeMeteor,
				Damage = 300,
				SplashRadius = 25,
				SplashAlwaysHitAirAndGround = true
			},
			{
				Delay = 17,
				Duration = 0,
				Count = 1,
				SpawnDistance = 180,
				SpawnOffsetFromOrigin = createVector(0, 1, 0),
				TargetMostExpensiveTower = true,
				TargetTowerMinimumRange = 5,
				ProjectileName = Enums.Projectiles.VoidPrimeMeteor,
				Damage = 1000,
				SplashRadius = 60,
				SplashAlwaysHitAirAndGround = true
			}
		}
	},
	InstantPlayEffectParentInstanceNames = { "ClawCallingSFX" }
}