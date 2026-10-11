local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local WarMachine0 = require(script.Parent:WaitForChild("WarMachine0"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.ExtraSmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 20,
	ReloadTime = 0.15,
	Range = 25,
	MinimumRange = 2
}
local v2 = {
	Description = "Rockets",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.WarMachineRocket,
	IsSplash = true,
	SplashRadius = 2,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 40,
	ReloadTime = 15,
	Range = 40,
	MinimumRange = 4,
	IsBurst = true,
	BurstSize = 8,
	BurstInterval = 0.8,
	AlwaysMaintainBurst = false,
	NoStopToAttack = true,
	NoAnimation = true
}
local copy = TableUtilities.DeepCopy(WarMachine0)
copy.OverrideDisplayName = "Abrams Walker Level 1"
copy.Health = 3250
copy.Speed = 2.9
copy.AttackData = { v, v2 }
return copy