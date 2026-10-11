local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 1.95,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRangedDataSequence = {
		{
			Range = 15,
			HitAllTargetsInRange = true,
			DamageData = { Damage = 100 }
		}
	}
}