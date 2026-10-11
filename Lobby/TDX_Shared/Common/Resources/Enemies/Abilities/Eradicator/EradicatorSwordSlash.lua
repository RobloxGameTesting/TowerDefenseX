local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 45,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.35,
	AnimationName = "Sword Spin",
	EffectParentInstanceNames = { "BladeSlashVFX" },
	EffectsStartDelay = 0,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.EradicatorSwordSlashStun },
			Range = 12,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "BladeSlashSFX",
			EffectsStartDelay = 0.4
		}
	}
}