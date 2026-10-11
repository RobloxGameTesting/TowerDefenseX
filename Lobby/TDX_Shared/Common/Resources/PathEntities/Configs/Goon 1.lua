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
	IgnoreResistance = false,
	Damage = 1.5,
	ReloadTime = 0.12,
	Range = 12,
	IsBurst = false
}
return {
	Health = 25,
	Speed = 2.3,
	AnimationCalibratedSpeed = 1.5,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Gun",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	AttackData = { v }
}