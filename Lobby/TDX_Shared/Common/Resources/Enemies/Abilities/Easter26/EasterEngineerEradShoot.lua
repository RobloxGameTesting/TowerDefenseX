local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	DamageData = { Damage = 1250 },
	MinimumRange = 9,
	Range = 50,
	HitVisualEffectName = Enums.VisualEffects.MinigunHit_3Hits,
	HitVisualEffectVarianceXZ = 0.4,
	HitVisualEffectVarianceY = 0.25
}
return {
	StartingCooldown = 10,
	Cooldown = 30,
	Animated = true,
	Delay = 2,
	ExecutionTime = 5.3,
	BurstSize = 20,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_Eradicator,
	AnimationName = "EradShoot",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1.1,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = { "EradShoot" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>EradShoot" }
}