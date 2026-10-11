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
	Delay = 1.05,
	ExecutionTime = 2.4669999999999996,
	InstantPlayEffectParentInstanceNames = { "SwordSlash>SFX" },
	EffectParentInstanceNames = { "SwordSlash>Sword" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.KingSwordSlashStun, Enums.TowerBuffs.KingSwordSlashFirerateDebuff },
			DamageData = { Damage = 200 },
			Range = 9,
			HitAllTargetsInRange = true
		}
	}
}