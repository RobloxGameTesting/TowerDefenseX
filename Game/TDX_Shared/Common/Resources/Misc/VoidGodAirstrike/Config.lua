local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	InterruptibleAbilityNames = {
		Enums.EnemyAbilities.VoidGodHandSmashLeft,
		Enums.EnemyAbilities.VoidGodHandSmashRight
	},
	MinPlaneCount = 5,
	MaxPlaneCount = 5,
	MissilesPerPlane = 3,
	FirstMissileHitTime = 0.2,
	PlaneInterval = 1.75,
	PlaneIntervalVariance = 0.4,
	MissileBurstInterval = 0.4,
	MissileBurstIntervalVariance = 0.15,
	TotalDamageByDifficulty = {
		[Enums.Difficulties.TBPart2Casual] = 1200000,
		[Enums.Difficulties.TBPart2Hard] = 1250000,
		[Enums.Difficulties.TBPart2Nightmare] = 1000000,
		[Enums.Difficulties.TBPart2Voidmare] = 1000000
	},
	DefaultTotalDamage = 800000,
	MissileDamageWeight = 1,
	CrashDamageWeight = 6,
	MissileDamageType = Enums.DamageTypes.Explosive,
	CrashChance = 1,
	CrashDamageType = Enums.DamageTypes.Explosive,
	CrashDiveTime = 0.3,
	DefaultPromptCooldown = 10,
	AvailableMapAttribute = "VoidGodAirstrikeAvailable",
	StationLitColor = Color3.fromRGB(185, 0, 0),
	StationLitMaterial = Enum.Material.Neon,
	StationUnlitColor = Color3.fromRGB(35, 0, 0),
	StationUnlitMaterial = Enum.Material.SmoothPlastic,
	StationFlashInterval = 0.4,
	WarningAttachmentName = "Warning",
	WarningDifficulties = {
		[Enums.Difficulties.Test] = true,
		[Enums.Difficulties.TBPart2Hard] = true
	},
	LeadPlaneSpeed = 230,
	FollowingPlaneSpeed = 170,
	FollowingPlaneSpeedVariance = 15,
	PortalDuration = 3,
	DirectionVarianceDegrees = 10,
	MissileFlightTime = 0.5,
	ReleaseDistance = 220,
	ExitDistance = 1000,
	AltitudeAboveTargets = 60,
	FormationSpacing = 28,
	FormationAltitudeStep = 8,
	ProjectileName = Enums.Projectiles.F22MissileWithTrail,
	CrashExplosionEffectName = Enums.VisualEffects.F22CrashExplosion
}