local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TableUtilities"))
local v = {
	Description = "Flame Thrower",
	IsProjectile = false,
	IsPiercing = true,
	PierceCount = 15,
	IsSplash = false,
	AimTime = 0.9,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	DamageType = Enums.DamageTypes.Fire,
	IgnoreResistance = false,
	Damage = 500,
	ReloadTime = 0.12,
	MinimumRange = 4,
	Range = 17,
	IsBurst = false
}
return {
	OverrideDisplayName = "War Machine I",
	Health = 75000,
	CollisionResistance = 0.1,
	Speed = 2.9,
	Radius = 2,
	CollisionRadius = 2,
	AnimationTimeScale = 1,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.BehemothTankDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	DeathExplodePartsScale = 1,
	GunModelName = "FlameThrower",
	HasAttack = true,
	StopToAttack = true,
	MovementStartDelayLowerBound = 0.9,
	MovementStartDelayUpperBound = 1,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v },
	AbilityNames = { Enums.PathEntityAbilities.WarMachineX_3_Punch, Enums.PathEntityAbilities.WarMachineX_3_Stomp },
	AbilityBufferTime = 1,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true
}