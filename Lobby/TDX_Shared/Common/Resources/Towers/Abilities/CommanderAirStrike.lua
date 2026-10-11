local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Air Strike",
	DisplayName = "Air Strike",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 20,
	Animated = true,
	Delay = 0,
	ExecutionTime = 2,
	Icon = "rbxassetid://18462087750",
	FullSizeIcon = true,
	Description = "Call in an airstrike.",
	AnimationName = "Airstrike Call",
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 6,
		DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
		Damage = 2000
	},
	CustomTriggeredPowerUpName = Enums.CustomTriggeredPowerUps.CommanderAirStrike,
	IsManualAimAtGround = true,
	ManualAimInfiniteRange = true,
	EffectParentInstanceNames = { "AirStrike" }
}