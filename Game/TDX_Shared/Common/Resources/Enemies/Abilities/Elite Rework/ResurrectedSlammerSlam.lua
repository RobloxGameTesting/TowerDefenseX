local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 5,
	StartingCooldownVariance = 2,
	Cooldown = 15,
	CooldownVariance = 2,
	Delay = 31 / 30,
	ExecutionTime = 1.85,
	AnimationName = "Slam",
	EffectParentInstanceNames = { "SlamEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 100 },
			TowerBuffNames = { Enums.TowerBuffs.ResurrectedSlammerStun },
			Range = 10,
			HitAllTargetsInRange = true
		}
	}
}