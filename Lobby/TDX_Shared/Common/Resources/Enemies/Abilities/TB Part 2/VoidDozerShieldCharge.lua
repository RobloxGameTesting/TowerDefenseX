local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 8,
	Cooldown = 30,
	Animated = true,
	AnimationName = "ShieldCharge",
	AutoHandleEffects = true,
	Delay = 0.9,
	ExecutionTime = 5.3999999999999995,
	EffectsStartDelay = 0.9,
	EffectsStopDelay = 5.3999999999999995,
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 }
		}
	},
	EnemyToEnemyRadiusEffectData = {
		NoAffectSelf = true,
		MaximumRange = 45,
		EnemyBuffNames = { Enums.EnemyBuffs.VoidDozerChargeDamageBuff, Enums.EnemyBuffs.VoidDozerChargeSpeedBuff }
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		MaximumRange = 18,
		TowerBuffNames = { Enums.TowerBuffs.VoidDozerChargeStun }
	}
}