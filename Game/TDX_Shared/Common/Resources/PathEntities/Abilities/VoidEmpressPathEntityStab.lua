local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Stab",
	StartingCooldown = 2,
	Cooldown = 6,
	Animated = true,
	AnimationName = "Stab",
	AutoHandleEffects = true,
	FaceTarget = true,
	ForceFaceOverideTime = 0.6,
	Delay = 1.3,
	ExecutionTime = 2.8,
	EffectsStartDelay = 1.1,
	EffectsStopDelay = 2.3,
	PathEntityToEnemyRangedData = { Damage = 6000, DamageType = Enums.DamageTypes.Melee, Range = 9 }
}