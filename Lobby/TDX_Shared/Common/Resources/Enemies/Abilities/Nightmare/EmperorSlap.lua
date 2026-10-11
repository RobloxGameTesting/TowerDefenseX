local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 40,
	Cooldown = 45,
	Delay = 1.7,
	ExecutionTime = 2.9,
	Animated = true,
	AnimationName = "Slap",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			Range = 5,
			MinimumRange = 2.5,
			TargetMostExpensiveTower = true,
			TargetMinimumValue = 20000,
			DamageData = { InstantKill = true }
		}
	},
	EffectParentInstanceNames = { "Slap" }
}