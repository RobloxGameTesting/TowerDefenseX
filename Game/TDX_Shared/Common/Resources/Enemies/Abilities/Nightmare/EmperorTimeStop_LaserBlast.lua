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
	Delay = 9.3,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	DoNotTryToUse = true,
	FaceTarget = true,
	FaceTargetDelay = 7.3,
	ForceFaceOverideTime = 1,
	RemoveForceFaceOnExecution = true,
	EnemyToMapEntityRangedData = {
		ProjectileName = Enums.Projectiles.EmperorLaserBlastProjectile,
		Range = 1e999
	},
	EffectParentInstanceNames = {}
}