local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 1.5,
	DamageType = Enums.DamageTypes.Melee,
	IgnoreResistance = false,
	Damage = 675,
	DamageDelay = 24 / 29,
	ReloadTime = 3,
	Range = 5,
	IsBurst = false
}
return {
	Health = 1900,
	CollisionResistance = 0.15,
	Speed = 2.1,
	AnimationCalibratedSpeed = 2.1,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.25,
	AnimationDefaultStopFadeTime = 0.25,
	NoPathOffset = false,
	ReverseDirection = true,
	HoverHeight = 1.712,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Weapon",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = false,
	AttackData = { v }
}