local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2,
		Damage = 15000,
		BuffName = Enums.TowerBuffs.PartyGeneralCelgarAxeFirerateDebuff,
		BuffName2 = Enums.TowerBuffs.PartyGeneralCelgarAxeStun
	},
	StartingCooldown = 15,
	Cooldown = 60,
	Animated = true,
	Delay = 2.03,
	ExecutionTime = 5.8,
	AnimationName = "Axe Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.GeneralCelgarAxe,
			Range = 30,
			MinimumRange = 5,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "AxeThrowIceBreath", "Torso>AxeThrowSFX" }
}