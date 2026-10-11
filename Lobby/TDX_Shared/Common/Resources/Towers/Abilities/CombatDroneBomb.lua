local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 6,
		Damage = 4000,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "CombatDroneBomb",
	DisplayName = "Bomb (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 18,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	CustomQueryData = { Range = 0.5, QueryType = "Strongest" },
	ProjectileNoPredictTargetPosition = true,
	Icon = "",
	Description = "Combat Drone Bomb.",
	ProjectileName = Enums.Projectiles.CombatDroneBomb,
	EffectParentInstanceNames = { "BombEffects" }
}