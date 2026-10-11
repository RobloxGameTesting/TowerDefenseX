local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local projectileHitData = {
	IsSplash = true,
	SplashRadius = 0.5,
	Damage = 5000,
	BuffName = Enums.TowerBuffs.BunnyTank900LaserBallDebuff
}
local v = {
	CanTargetAir = true,
	ProjectileName = Enums.Projectiles.BunnyTank900LaserBall,
	Range = 50,
	MinimumRange = 5,
	TargetRandomTower = true
}
return {
	PrerequisiteAbilityName = Enums.EnemyAbilities.BunnyTank900Transition,
	ProjectileHitData = projectileHitData,
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 0,
	ExecutionTime = 67 / 30,
	AnimationName = "Phase 2 Laser Ball",
	FaceTarget = true,
	ForceFaceOverideTime = 0.4,
	ForceFaceOverideTimeInitial = 0.4,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>LaserBall" }
}