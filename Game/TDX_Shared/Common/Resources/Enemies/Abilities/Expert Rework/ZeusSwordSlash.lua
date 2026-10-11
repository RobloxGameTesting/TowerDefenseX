local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 30,
	Animated = true,
	AnimationName = "SwordSlash",
	Delay = 1,
	ExecutionTime = 2.8,
	BurstSize = 2,
	BurstInterval = 0.7,
	InstantPlayEffectParentInstanceNames = { "SwordSlash>SFX" },
	EffectParentInstanceNames = { "SwordSlash>Sword" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.ZeusSwordSlashStun },
			DamageData = { Damage = 625 },
			Range = 8,
			HitAllTargetsInRange = true
		}
	}
}