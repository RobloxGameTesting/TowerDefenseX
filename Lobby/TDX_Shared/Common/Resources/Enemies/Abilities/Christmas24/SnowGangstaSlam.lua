local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 9,
	StartingCooldownVariance = 2,
	Cooldown = 15,
	Animated = true,
	Delay = 1.983,
	ExecutionTime = 3.3,
	AnimationName = "AbilityAttack",
	EffectParentInstanceNames = { "Weapon" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 200 },
			Range = 10,
			HitAllTargetsInRange = true
		}
	}
}