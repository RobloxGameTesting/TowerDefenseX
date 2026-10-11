local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 35,
	Animated = true,
	Delay = 5 / 3,
	ExecutionTime = 6.8,
	EffectsStartDelay = 5 / 6,
	EffectsStopDelay = 6.25,
	AutoHandleEffects = true,
	AnimationName = "StaffBuff",
	EnemyToEnemyRadiusEffectData = {
		RequeryBeforeExecution = true,
		NoAffectSelf = true,
		MaximumRange = 80,
		EnemyBuffNames = { Enums.EnemyBuffs.VoidLichSpeedBuff }
	}
}