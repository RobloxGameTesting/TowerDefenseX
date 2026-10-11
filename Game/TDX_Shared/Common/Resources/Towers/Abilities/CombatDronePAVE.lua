local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("DamageTypes"))
local stunData = {
	StunType = Enums.StunTypes.PunkbusterStun,
	StunDuration = 3.5,
	CanStunBoss = true,
	IgnoreStunResistance = true
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 5,
		Damage = 5000,
		DamageType = Enums.DamageTypes.Explosive,
		DamageData = { StunData = stunData }
	},
	Name = "CombatDronePAVE",
	DisplayName = "PAVE Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	CustomTriggered = true,
	Passive = false,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 15,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Combat Drone PAVE missiles.",
	ProjectileName = Enums.Projectiles.CombatDronePAVE,
	EffectParentInstanceNames = {}
}