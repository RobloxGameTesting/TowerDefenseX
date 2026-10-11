local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Melee,
	IgnoreResistance = false,
	Damage = 3500,
	DamageDelay = 0.48888888888888893,
	ReloadTime = 1.8,
	Range = 6,
	MinimumRange = 1.5,
	IsBurst = false
}
return {
	AirUnit = true,
	OverrideDisplayName = "Seraph",
	Health = 7500,
	Speed = 2.2,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	ReverseDirection = true,
	HoverHeight = 5,
	HoverHeightVariance = 0.3,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Weapon",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = false,
	AttackData = { v },
	FootstepEffectInstanceNames = "RootPart>FootstepSFX"
}