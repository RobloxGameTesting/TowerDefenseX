local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 9,
	Cooldown = 30,
	Animated = true,
	Delay = 1.167,
	ExecutionTime = 4.6,
	BurstSize = 6,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		0.5,
		0.41600000000000015,
		0.3839999999999999,
		0.3999999999999999,
		0.766
	},
	AnimationName = "Sword Earthquake",
	PrerequisiteAbilityName = Enums.EnemyAbilities.EradicatorMKICRage,
	EffectParentInstanceNames = { "SwordSlamEffectPart" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 350 },
			Range = 18,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		AffectPathEntitiesOnly = true,
		MaximumRange = 12,
		DamageData = { Damage = 10000 }
	}
}