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
	DamageType = Enums.DamageTypes.Golden,
	IgnoreResistance = false,
	Damage = 12,
	ReloadTime = 0.1,
	Range = 22,
	IsBurst = false
}
return {
	Health = 300,
	Speed = 2.3,
	AnimationCalibratedSpeed = 2.8,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Gun",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	AttackData = { v }
}