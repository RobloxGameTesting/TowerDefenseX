local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.M202Missile,
	IsSplash = true,
	SplashRadius = 2.5,
	AimTime = 0.3,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 45,
	ReloadTime = 7.5,
	Range = 20,
	IsBurst = true,
	BurstSize = 4,
	BurstInterval = 0.5,
	AlwaysMaintainBurst = true
}
return {
	Health = 100,
	Speed = 2,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "m202 FLASH",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	AttackData = { v }
}