local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 500,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "CombatDroneRockets",
	DisplayName = "Rockets (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	FaceTargetPosition = true,
	TurretIndex = 2,
	Icon = "",
	Description = "Combat Drone Rockets.",
	ProjectileName = Enums.Projectiles.CombatDroneRocketMax,
	EffectParentInstanceNames = { "RocketEffects" }
}