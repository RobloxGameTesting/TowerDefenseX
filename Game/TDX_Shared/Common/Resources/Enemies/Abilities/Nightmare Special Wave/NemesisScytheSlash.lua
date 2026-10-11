local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	AnimationName = "Scythe Slash",
	StartingCooldown = 18,
	Cooldown = 25,
	Delay = 151 / 60,
	ExecutionTime = 4.7,
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 5000 },
			TowerBuffNames = { Enums.TowerBuffs.NemesisFirerateDebuff },
			Range = 10,
			TargetRandomTower = true,
			HitAllTargetsInRange = true,
			ArcSpreadAngle = 180
		}
	},
	EffectsStartDelay = 0,
	EffectParentInstanceNames = { "FX>ScytheSlash" }
}