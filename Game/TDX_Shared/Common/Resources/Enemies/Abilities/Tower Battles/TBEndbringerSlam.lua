local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 15,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 2.4669999999999996,
	AnimationName = "Slam",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {},
			DamageData = { Damage = 1000 },
			Range = 10,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SlamEffectPart"
		}
	},
	EffectParentInstanceNames = {}
}