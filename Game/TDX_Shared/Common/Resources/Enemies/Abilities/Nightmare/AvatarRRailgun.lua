local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 20,
	Animated = true,
	AnimationName = "Railgun",
	Delay = 1.333,
	ExecutionTime = 3.033,
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 4000 },
			Range = 50,
			MinimumRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true,
			HitVisualEffectName = Enums.VisualEffects.EradidogRailgunBlast,
			HitVisualEffectVarianceXZ = 0.25,
			HitVisualEffectVarianceY = 0.15
		}
	},
	EffectParentInstanceNames = { "Railgun" }
}