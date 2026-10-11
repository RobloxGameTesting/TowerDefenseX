local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 12,
	Animated = true,
	Delay = 0,
	ExecutionTime = 11 / 6,
	AnimationName = "Fireball",
	FaceTarget = true,
	EffectParentInstanceNames = { "DarkPresenceFireball>Main>VFX", "DarkPresenceFireball>Main>SFX" },
	EffectsStartDelay = 0,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.DarkPresenceFireball,
			CanTargetAir = false,
			Range = 25,
			MinimumRange = 4,
			ConsiderTargetsWithNoAttack = false,
			TargetRandomTower = true
		}
	},
	ProjectileHitData = { IsSplash = true, SplashRadius = 5, Damage = 4700 }
}