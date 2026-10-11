local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 30,
	Animated = true,
	Delay = 5 / 6,
	ExecutionTime = 1.5,
	AnimationName = "Crush",
	AutoHandleEffects = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 125 },
			TowerBuffNames = { Enums.TowerBuffs.CrushDebuff },
			Range = 12,
			HitAllTargetsInRange = true
		}
	}
}