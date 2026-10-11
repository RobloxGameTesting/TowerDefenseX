local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 15,
	CooldownVariance = 5,
	Animated = true,
	Delay = 0.55,
	ExecutionTime = 1.75,
	AnimationName = "Axe Spin",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 50 },
			Range = 8,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = { "AxeSpinVFX" }
}