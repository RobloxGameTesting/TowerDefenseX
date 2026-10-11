local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 6,
	Cooldown = 16,
	Animated = true,
	AnimationName = "Stab",
	AutoHandleEffects = true,
	FaceTarget = true,
	Delay = 1.3,
	ExecutionTime = 2.8,
	EffectsStartDelay = 1.1,
	EffectsStopDelay = 2.3,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 5000 },
			Range = 5
		}
	}
}