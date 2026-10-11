local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local WarMachineX_3 = require(script.Parent:WaitForChild("WarMachineX_3"))
local v = {
	Description = "Flame Thrower",
	IsProjectile = false,
	IsPiercing = true,
	PierceCount = 15,
	IsSplash = false,
	AimTime = 0.9,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	DamageType = Enums.DamageTypes.Fire,
	IgnoreResistance = true,
	Damage = 1200,
	ReloadTime = 0.12,
	MinimumRange = 4,
	Range = 17,
	IsBurst = false
}
local copy = TableUtilities.DeepCopy(WarMachineX_3)
copy.OverrideDisplayName = "War Machine III"
copy.Health = 175000
copy.Speed = 2.9
copy.CollisionResistance = 0.25
copy.AttackData = { v }
copy.AbilityNames = {
	Enums.PathEntityAbilities.WarMachineX_5_Punch,
	Enums.PathEntityAbilities.WarMachineX_5_Railgun,
	Enums.PathEntityAbilities.WarMachineX_5_Rockets,
	Enums.PathEntityAbilities.WarMachineX_5_Stomp
}
copy.AbilityBufferTime = 1
return copy