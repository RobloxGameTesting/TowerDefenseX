local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 8,
	Animated = true,
	Delay = 7 / 15,
	ExecutionTime = 1.2,
	AnimationName = "Spin",
	EffectParentInstanceNames = { "BladeSlashVFX" },
	EffectsStartDelay = 0,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.ElfGuardianStunDebuff },
			Range = 10,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "BladeSlashSFX",
			EffectsStartDelay = 0.15
		}
	}
}