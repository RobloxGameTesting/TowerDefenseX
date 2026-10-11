local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 6,
	Cooldown = 40,
	Animated = true,
	AnimationName = "EnemyBuff",
	AutoHandleEffects = true,
	ContinueMovingWhileUsing = true,
	Delay = 131 / 60,
	ExecutionTime = 79 / 30,
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 25,
		NoAffectSelf = true,
		HealData = { ShieldGainPercentageOfTargetMaxHealth = 0.5 }
	}
}