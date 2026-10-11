local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.ArcherArrow,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Melee,
	IgnoreResistance = false,
	Damage = 45,
	ReloadTime = 2,
	Range = 19,
	IsBurst = false
}
return {
	Health = 200,
	Speed = 2.8,
	AnimationCalibratedSpeed = 2.8,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	NoPathOffset = false,
	ReverseDirection = true,
	HoverHeight = 1.355,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Weapon",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	AttackData = { v }
}