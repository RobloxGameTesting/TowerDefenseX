local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	AnimationName = "Echo Attack",
	StartingCooldown = 5,
	Cooldown = 15,
	Delay = 1,
	ExecutionTime = 26 / 15,
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1 },
			TowerBuffNames = { Enums.TowerBuffs.BatCultistEchoBlastDebuff },
			Range = 10,
			TargetRandomTower = true,
			HitAllTargetsInRange = true,
			MinimumTargetsInRange = 1
		}
	},
	EffectsStartDelay = 1,
	EffectsStopDelay = 1.5,
	EffectParentInstanceNames = { "FX>VFX" },
	InstantPlayEffectParentInstanceNames = { "FX>SFX" }
}