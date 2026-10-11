local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 9,
	Cooldown = 15,
	Animated = true,
	Delay = 0.933,
	ExecutionTime = 1.583,
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