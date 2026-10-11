local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	Damage = 0,
	Range = 14,
	ReloadTime = 1e999,
	DamageType = Enums.DamageTypes.None
}
return {
	OverrideDisplayName = "Medic Drone Level 2",
	Radius = 0.1,
	HoverHeight = 4,
	HoverHeightVariance = 0.5,
	AnimationTimeScale = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	SpawnAnimationTime = 1,
	Lifetime = 60,
	ExplodeAfterLifetime = true,
	HasAttack = true,
	AttackData = { v },
	MultiHealData = {
		MaximumTargets = 6,
		HealAmountPerTarget = 40,
		ReloadTime = 0.2,
		CanTargetParentTower = true,
		AffectedEntityEffectData = {
			BeamEffectHandlingData = {
				{
					BeamParentInstanceName = "BeamSource",
					MakeNewBeam = true,
					OscillationXZ = 0.2,
					OscillationXZPeriod = 2,
					OscillationY = 0.12,
					OscillationYPeriod = 1.25
				}
			},
			TryRestartExistingBeam = true
		}
	},
	ExplosionEffectNames = { Enums.VisualEffects.GrenadierGrenadeBlastSmall }
}