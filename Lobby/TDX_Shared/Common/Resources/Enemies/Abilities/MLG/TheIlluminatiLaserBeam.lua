local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	MaximumRange = 40,
	MaximumTargets = 16,
	TowerBuffNames = { Enums.TowerBuffs.TheIlluminatiDamageDebuff }
}
return {
	StartingCooldown = 5,
	Cooldown = 20,
	Animated = true,
	AnimationName = "LaserBeam",
	Delay = 0.1,
	ExecutionTime = 2.283,
	ContinueMovingWhileUsing = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.TheIlluminatiRage,
	EffectParentInstanceNames = { "LaserBeam>BeamOrigin>LightningSFX", "LaserBeam>BeamOrigin>LightningVFX" },
	EffectsStartDelay = 0.1,
	EffectsStopDelay = 2.4,
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "LaserBeam>BeamOrigin>LightningBeam",
				MakeNewBeam = true,
				BeamDuration = 2.3,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}