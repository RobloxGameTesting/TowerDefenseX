local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 20,
	Animated = true,
	Delay = 79 / 60,
	ExecutionTime = 8.25,
	BurstSize = 60,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Minigun",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.8,
	EffectParentInstanceNames = { "EliteVoid>MiniGun>MuzzleFlash" },
	EffectsStartDelay = 79 / 60,
	EffectsStopDelay = 439 / 60,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 100 },
			TowerBuffNames = { Enums.TowerBuffs.CorruptedGoldenCommandoDamageDebuff },
			Range = 125,
			MinimumRange = 40
		}
	}
}