local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 1050 },
	StartingCooldown = 1,
	Cooldown = 11,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 35 / 12,
	AnimationName = "Spear Throw",
	FaceTarget = true,
	AutoHandleEffects = true,
	HiddenWhenBeingUsedModelName = "GestaltSpear",
	IntroSwitchDelay = 73 / 60,
	OutroSwitchDelay = 35 / 12,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.GestaltSpear,
			Range = 35,
			MinimumRange = 10,
			TargetMostExpensiveTower = true
		}
	}
}