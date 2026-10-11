local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = false,
	IsSplash = false,
	AimTime = 0.3,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = true,
	Damage = 8,
	ReloadTime = 0.14,
	Range = 21,
	IsBurst = false
}
return {
	Health = 135,
	Speed = 2.3,
	AnimationCalibratedSpeed = 1.5,
	Radius = 1,
	AnimationTimeScale = 1,
	StunImmunity = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Gun",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	AttackData = { v }
}