local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 8,
		SplashAlwaysHitAirAndGround = true,
		Damage = 1250,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "Scout Helicopter Bomb",
	DisplayName = "Bomb (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 4,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	CustomQueryData = { Range = 0.5, QueryType = "Strongest" },
	ProjectileNoPredictTargetPosition = true,
	Icon = "",
	Description = "Combat Drone Bomb.",
	ProjectileName = Enums.Projectiles.ScoutHelicopterBomb,
	EffectParentInstanceNames = { "BombEffects" }
}