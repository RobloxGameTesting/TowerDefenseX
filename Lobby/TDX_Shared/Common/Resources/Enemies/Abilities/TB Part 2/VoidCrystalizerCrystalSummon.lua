local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 120,
	Animated = true,
	AnimationName = "CrystalSummon",
	Delay = 6.5,
	ExecutionTime = 9.133000000000001,
	EffectsStartDelay = 2.66,
	EffectsStopDelay = 6.5,
	AutoHandleEffects = true,
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 }
		}
	},
	ParallelAbilityNames = { Enums.EnemyAbilities.VoidCrystalizerCrystalSummon_Spawn }
}