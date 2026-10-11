local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 20,
	Cooldown = 45,
	Animated = true,
	AnimationName = "LaserEye",
	AutoHandleEffects = true,
	Delay = 1.1,
	ExecutionTime = 8.366999999999999,
	PathLaserData = {
		StartTime = 1.1,
		EndTime = 7.333,
		MinimumPathPercentage = 0.1,
		MaximumPathPercentage = 0.9,
		TargetPathPercentage = 0.45,
		TargetPathPercentageVariance = 0.05,
		RandomizeSweepDirection = true,
		SplashRadius = 12,
		EnemyHealPerSecond = 10000,
		TowerDamagePerSecond = 3000,
		KillPathEntities = true
	}
}