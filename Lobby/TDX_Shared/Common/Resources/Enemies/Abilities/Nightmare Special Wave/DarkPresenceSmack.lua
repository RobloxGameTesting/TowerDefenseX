local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 5,
	StartingCooldownVariance = 2,
	Cooldown = 8,
	CooldownVariance = 2,
	Delay = 0.61,
	ExecutionTime = 1.7533333333333332,
	FaceTarget = true,
	AnimationName = "Smack",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 29000 },
			TowerBuffNames = {},
			Range = 4
		}
	},
	EffectParentInstanceNames = { "Smack>Main>VFX", "Smack>Main>SFX" },
	EffectsStartDelay = 0
}