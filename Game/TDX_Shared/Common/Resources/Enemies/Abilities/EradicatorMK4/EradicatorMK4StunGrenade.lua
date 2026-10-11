local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 6,
		BuffName = Enums.TowerBuffs.EradicatorMK4StunDebuff,
		BuffName2 = Enums.TowerBuffs.EradicatorMK4FirerateDebuff
	},
	StartingCooldown = 12,
	Cooldown = 40,
	Animated = true,
	Delay = 1.566,
	ExecutionTime = 3.433,
	BurstSize = 2,
	BurstInterval = 0.30000000000000004,
	AnimationName = "LegGrenadesStun",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.EradicatorMK4GrenadeBlue,
			Range = 28,
			MinimumRange = 12,
			TargetRandomTower = true,
			TargetMinimumValue = 1500
		}
	},
	EffectParentInstanceNames = { "LegGrenadeEffectsPart" }
}