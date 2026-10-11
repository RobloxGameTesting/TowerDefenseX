local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 20,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 2.25,
	AnimationName = "Sword Slam",
	EffectParentInstanceNames = { "SwordSlamVFX" },
	PrerequisiteAbilityName = Enums.EnemyAbilities.EradicatorRage,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 60 },
			Range = 25,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SwordSlamSFX",
			EffectsStartDelay = 0.95
		}
	}
}