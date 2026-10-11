local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 22,
	Animated = true,
	Delay = 4 / 3,
	ExecutionTime = 3.5,
	AnimationName = "Super Crush",
	AutoHandleEffects = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 150 },
			TowerBuffNames = { Enums.TowerBuffs.SuperCrushDebuff },
			Range = 18,
			HitAllTargetsInRange = true
		}
	},
	BurstSize = 3,
	BurstInterval = 8 / 15,
	CustomBurstDelayMap = { 8 / 15, 19 / 30 },
	TriggeredAtHealthPercentage = 0.6
}