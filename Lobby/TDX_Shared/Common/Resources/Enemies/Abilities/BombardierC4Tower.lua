local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 12000 },
	StartingCooldown = 5,
	Cooldown = 20,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 6.933,
	AnimationName = "ThrowAtTower",
	FaceTarget = true,
	ShownWhenBeingUsedModelNames = { "BombardierC4Tower" },
	IntroSwitchDelay = 0,
	OutroSwitchDelay = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.BombardierC4Tower,
			Range = 20,
			TargetMostExpensiveTower = true,
			TargetMinimumValue = 2000,
			BombardierC4Data = { TriggerTimeAfterDelay = 5.25 }
		}
	}
}