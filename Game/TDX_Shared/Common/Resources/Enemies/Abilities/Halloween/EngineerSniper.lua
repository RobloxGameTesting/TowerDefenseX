local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 2000 },
	StartingCooldown = 15,
	Cooldown = 40,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 2.933,
	AnimationName = "Sniper Gun",
	FaceTarget = true,
	ForceFaceOverideTimeInitial = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.EngineerSniperBullet,
			Range = 150,
			MinimumRange = 10,
			TargetMostExpensiveTower = true
		}
	},
	EffectParentInstanceNames = { "RootPart>SniperSFX", "AttachmentHelper_Gun>SniperVFX" }
}