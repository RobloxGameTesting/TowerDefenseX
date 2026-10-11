local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 275 },
	StartingCooldown = 1,
	Cooldown = 15,
	Animated = true,
	FaceTarget = true,
	Delay = 1.333,
	ExecutionTime = 2.133,
	AnimationName = "AirShot",
	AutoHandleEffects = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.VoidWardenCrystal,
			Range = 60
		}
	},
	EffectParentInstanceNames = { "CrystalFlashAir" },
	HiddenWhenBeingUsedModelName = "VoidWardenCrystal",
	IntroSwitchDelay = 1.333,
	OutroSwitchDelay = 2
}