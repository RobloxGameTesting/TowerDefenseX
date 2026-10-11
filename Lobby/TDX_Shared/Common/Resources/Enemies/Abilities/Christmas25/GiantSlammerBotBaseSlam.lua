local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	Animated = true,
	FaceTarget = true,
	StartingCooldown = 5,
	StartingCooldownVariance = 2,
	Cooldown = 0,
	Delay = 23 / 30,
	ExecutionTime = 1.8169999999999997,
	AnimationName = "Slam1",
	AnimationName2 = "Slam2",
	EffectParentInstanceNames = { "SlamEffects" },
	EnemyToMapEntityRangedData = { Range = 6.5, Damage = 500 }
}