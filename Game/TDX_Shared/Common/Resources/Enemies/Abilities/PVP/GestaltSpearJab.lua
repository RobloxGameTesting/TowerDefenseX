local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 1,
	Cooldown = 10,
	Animated = true,
	Delay = 13 / 6,
	ExecutionTime = 3.5333333333333337,
	AutoHandleEffects = true,
	AnimationName = "Spear Jab",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1950 },
			Range = 5,
			TargetMostExpensiveTower = true
		}
	}
}