local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 35,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 2.267,
	AnimationName = "Swing",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {},
			DamageData = { Damage = 600 },
			Range = 13,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SlamEffectPart"
		}
	},
	EffectParentInstanceNames = {}
}