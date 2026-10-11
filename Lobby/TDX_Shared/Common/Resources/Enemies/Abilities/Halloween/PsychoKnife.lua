local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		Damage = 50,
		BuffName = Enums.TowerBuffs.PsychoKnifeBleedDebuff
	},
	StartingCooldown = 3,
	Cooldown = 6,
	Animated = true,
	Delay = 0.62,
	ExecutionTime = 2.2159999999999997,
	AnimationName = "Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.PsychoKnife, Range = 13 }
	},
	EffectParentInstanceNames = { "RootPart>KnifeThrow" },
	EffectsStartDelay = 0
}