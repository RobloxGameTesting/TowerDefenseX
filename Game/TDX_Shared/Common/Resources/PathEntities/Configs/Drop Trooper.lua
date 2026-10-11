local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.RailTrooperLaser,
	IsSplash = false,
	AimTime = 0.3,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	DamageType = Enums.DamageTypes.Laser,
	IgnoreResistance = false,
	Damage = 1200,
	ReloadTime = 1.5,
	Range = 21,
	IsBurst = false
}
return {
	Health = 5250,
	Speed = 1.4,
	Radius = 1,
	AnimationTimeScale = 1,
	StunImmunity = true,
	NoPathOffset = true,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Gun",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	AttackData = { v }
}