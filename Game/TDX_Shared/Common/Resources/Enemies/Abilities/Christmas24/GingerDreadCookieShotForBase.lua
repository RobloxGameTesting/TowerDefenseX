local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 4000 },
	StartingCooldown = 180,
	StartingCooldownVariance = 5,
	Cooldown = 45,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 2.267,
	AnimationName = "CookieShot",
	SecondaryAnimationForKeyframeEventsName = "Damaged_CookieShot",
	FaceTarget = true,
	EnemyToMapEntityRangedData = {
		ProjectileName = Enums.Projectiles.Cookie,
		Range = 90,
		MinimumRange = 20
	},
	EffectParentInstanceNames = {}
}