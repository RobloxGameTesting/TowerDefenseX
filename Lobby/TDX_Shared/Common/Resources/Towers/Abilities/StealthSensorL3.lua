local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "StealthSensorL3",
	DisplayName = "Stealth Sensor LVL 3",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 8,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://15247555762",
	Description = "Permanently reveal nearby enemies.",
	HasRadiusEffect = true,
	EffectRadius = 11,
	RadiusDamage = 500,
	RadiusDamageType = Enums.DamageTypes.Laser,
	HasRevealEffect = true,
	RevealPermanent = true,
	EffectParentInstanceNames = { "Pulse Scan VFX" },
	HotbarData = { GroupName = "StealthSensor", Level = 3 }
}