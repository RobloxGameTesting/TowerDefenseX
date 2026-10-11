local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ProjectileName = Enums.Projectiles.EradicatorMK2ReworkMiniRocketNaval,
	Range = 2000,
	MinimumRange = 100,
	TargetHighestRangeTower = true,
	TargetMinimumValue = 100000,
	TowerTypeIncludeMap = { [Enums.Towers.Warship] = true, [Enums.Towers.GoldenWarship] = true }
}
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 1000 },
	StartingCooldown = 1,
	Cooldown = 60,
	Animated = true,
	AnimationName = "RocketRain",
	Delay = 3.667,
	ExecutionTime = 7.433,
	FaceTarget = false,
	BurstSize = 72,
	BurstInterval = 0.0333333325,
	ModelBurstSize = 18,
	ParallelAbilityNames = { Enums.EnemyAbilities.EradicatorMK2ReworkRocketRain_Stomp },
	InstantPlayEffectParentInstanceNames = { "RocketRain>SFX" },
	EffectParentInstanceNames = { "RocketRain>SlamEffectPart" },
	EnemyToTowerRangedDataSequence = { v }
}