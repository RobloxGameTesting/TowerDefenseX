local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.KnifeHit,
		TargetTorsoInsteadOfGround = true
	},
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Melee,
	IgnoreResistance = false,
	Damage = 30,
	DamageDelay = 0.4,
	ReloadTime = 1.5,
	Range = 4,
	IsBurst = false
}
return {
	Health = 80,
	Speed = 2.8,
	AnimationCalibratedSpeed = 2.8,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	NoPathOffset = false,
	ReverseDirection = true,
	HoverHeight = 1.351,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	GunModelName = "Weapon",
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = false,
	AttackData = { v }
}