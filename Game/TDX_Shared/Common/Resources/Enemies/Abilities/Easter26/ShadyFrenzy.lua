local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 50 },
	StartingCooldown = 7,
	StartingCooldownVariance = 3,
	Cooldown = 22,
	CooldownVariance = 8,
	Animated = true,
	Delay = 2 / 15,
	ExecutionTime = 43 / 15,
	BurstSize = 16,
	BurstInterval = 0,
	ModelBurstSize = 2,
	CustomBurstDelayMap = {
		13 / 60,
		1 / 12,
		13 / 60,
		1 / 12,
		0.2,
		0.1,
		0.2,
		1 / 12,
		0.2,
		0.1,
		0.2,
		1 / 12,
		0.2,
		0.1,
		0.2
	},
	AnimationName = "Frenzy",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.ShadyKnife,
			Range = 30,
			MinimumRange = 5
		}
	},
	EffectParentInstanceNames = {}
}