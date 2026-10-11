local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { Damage = 150, IsSplash = false },
	StartingCooldown = 3,
	Cooldown = 8,
	Animated = true,
	Delay = 13 / 12,
	ExecutionTime = 2.65,
	AnimationName = "Fire",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.RavagedPredatorProjectile,
			Range = 30,
			TowerBuffNames = { Enums.TowerBuffs.RavagedPredatorFireDebuff }
		}
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Fire" }
}