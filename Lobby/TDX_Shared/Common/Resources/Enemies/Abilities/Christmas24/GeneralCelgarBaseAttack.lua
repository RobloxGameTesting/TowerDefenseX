local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 55,
	Animated = true,
	Delay = 0.667,
	ExecutionTime = 7.533,
	BurstSize = 7,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	CustomBurstDelayMap = {
		1.3829999999999998,
		0.9670000000000001,
		0.3500000000000001,
		0.3500000000000001,
		0.5829999999999997,
		1.2670000000000003
	},
	AnimationName = "Base Attack",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.5,
	EnemyToMapEntityRangedData = { Damage = 1143, Range = 11.5 },
	EffectParentInstanceNames = { "RootPart>BaseAttackSFX", "RightHand", "SlamEffectPart" }
}