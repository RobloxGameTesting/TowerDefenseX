local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 8,
	Cooldown = 30,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 3.9333333333333336,
	BurstSize = 25,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "FocusFire",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.8,
	AutoHandleEffects = true,
	EffectsStartDelay = 1.4,
	EffectsStopDelay = 4,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {
				Enums.TowerBuffs.VoidJuggernaut2FocusFireDoT,
				Enums.TowerBuffs.VoidJuggernaut2FocusFireDebuff
			},
			Range = 30
		}
	}
}