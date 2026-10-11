local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 100 },
	StartingCooldown = 5,
	Cooldown = 20,
	Animated = true,
	FaceTarget = true,
	Delay = 1.2,
	ExecutionTime = 6.667,
	BurstSize = 36,
	BurstInterval = 2 / 15,
	AnimationName = "CrystalShot",
	AutoHandleEffects = true,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.VoidWardenCrystal, Range = 30, MinimumRange = 15 }
	},
	EffectParentInstanceNames = { "CrystalFlash" },
	HiddenWhenBeingUsedModelName = "VoidWardenCrystal",
	IntroSwitchDelay = 1.2,
	OutroSwitchDelay = 6
}