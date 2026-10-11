local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 8,
	StartingCooldownVariance = 2,
	Cooldown = 14,
	CooldownVariance = 8,
	Delay = 0.533,
	ExecutionTime = 163 / 150,
	FaceTarget = true,
	AnimationName = "Claw Swipe",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 10000 },
			TowerBuffNames = {},
			Range = 3
		}
	},
	EffectParentInstanceNames = { "VFXInstance" }
}