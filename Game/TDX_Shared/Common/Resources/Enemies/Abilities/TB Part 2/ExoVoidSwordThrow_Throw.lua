local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 1000 },
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 0.783,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	FaceTarget = true,
	FaceTargetDelay = 1,
	ForceFaceOverideTime = 1,
	RemoveForceFaceOnExecution = true,
	EnemyToMapEntityRangedData = { ProjectileName = Enums.Projectiles.ExoVoidSword, Range = 1e999 },
	EffectParentInstanceNames = {}
}