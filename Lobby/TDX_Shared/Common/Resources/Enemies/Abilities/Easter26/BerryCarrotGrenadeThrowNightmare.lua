local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 100,
		BuffName = Enums.TowerBuffs.BerryNightmareDebuff
	},
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 13 / 15,
	ExecutionTime = 2.05,
	AnimationName = "Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.BerryCarrotGrenade,
			Range = 20,
			TargetRandomTower = true,
			ConsiderTargetsWithNoAttack = true
		}
	},
	EffectParentInstanceNames = { "Root>SFX" },
	EffectsStartDelay = 0.15
}