local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 5,
		Damage = 300,
		DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance
	},
	Name = "AviatorBomb",
	DisplayName = "Bomb (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 3,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	CustomQueryData = { Range = 1, QueryType = "Strongest", QueryAtTowerPosition = true },
	ProjectileNoPredictTargetPosition = true,
	Icon = "",
	Description = "Aviator Bomb.",
	ProjectileName = Enums.Projectiles.AviatorBombL2,
	EffectParentInstanceNames = { "BombEffects" }
}