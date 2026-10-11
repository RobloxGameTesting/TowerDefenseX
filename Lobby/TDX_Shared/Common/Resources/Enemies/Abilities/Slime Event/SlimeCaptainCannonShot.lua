local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		BuffName = Enums.TowerBuffs.SlimeCaptainGooBallFirerateDebuff,
		BuffName2 = Enums.TowerBuffs.SlimeCaptainGooBallDamageDebuff
	},
	StartingCooldown = 13,
	Cooldown = 75,
	Animated = true,
	Delay = 2.617,
	ExecutionTime = 4.183,
	AnimationName = "CannonShot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.CaptainSlimeGooBall,
			Range = 40,
			MinimumRange = 5,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "RootPart>SFX>Cannon" }
}