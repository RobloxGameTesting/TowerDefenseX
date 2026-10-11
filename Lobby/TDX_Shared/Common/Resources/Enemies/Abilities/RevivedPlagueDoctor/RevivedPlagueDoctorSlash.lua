local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 25,
	Animated = true,
	Delay = 47 / 60,
	ExecutionTime = 121 / 60,
	AnimationName = "Slash",
	EffectParentInstanceNames = { "BladeSlashVFX" },
	EffectsStartDelay = 0,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RevivedPlagueDoctorSlashStun },
			Range = 12,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "BladeSlashSFX",
			EffectsStartDelay = 28 / 60
		}
	}
}