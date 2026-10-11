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
	Damage = 13,
	ReloadTime = 0.8,
	Range = 21,
	IsBurst = true,
	BurstSize = 3,
	BurstInterval = 0.2
}
return {
	OverrideDisplayName = "Scout Level 4",
	Health = 85,
	Speed = 2.5,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "G36C",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	AttackData = { v }
}