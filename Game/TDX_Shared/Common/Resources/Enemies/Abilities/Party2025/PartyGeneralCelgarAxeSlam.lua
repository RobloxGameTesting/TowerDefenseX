local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 45,
	Animated = true,
	Delay = 0.983,
	ExecutionTime = 2.6500000000000004,
	AnimationName = "Axe Slam",
	EnemyToTowerRangedDataSequence = {
		{
			MinimumTargetsInRange = 3,
			DamageData = { Damage = 3000 },
			TowerBuffNames = { Enums.TowerBuffs.PartyGeneralCelgarAxeStun },
			Range = 22,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		AffectPathEntitiesOnly = true,
		MaximumRange = 22,
		DamageData = { InstantKill = true }
	},
	EffectParentInstanceNames = { "AxeSlamEffectPart" }
}