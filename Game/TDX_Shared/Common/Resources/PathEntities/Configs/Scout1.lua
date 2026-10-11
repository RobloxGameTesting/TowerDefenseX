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
	Damage = 2,
	ReloadTime = 0.8,
	Range = 15,
	IsBurst = false
}
return {
	OverrideDisplayName = "Scout Level 1",
	Health = 20,
	Speed = 2.8,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "M9",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	AttackData = { v }
}