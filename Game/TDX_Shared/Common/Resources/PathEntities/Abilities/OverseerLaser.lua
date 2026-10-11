local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Laser",
	StartingCooldown = 30,
	Cooldown = 95,
	Animated = true,
	Delay = 4.1,
	ExecutionTime = 9.7,
	BurstSize = 28,
	BurstInterval = 0.15,
	BurstTargetEntityUntilNotAlive = true,
	BurstNoRetargetIfTargetNotAlive = true,
	FaceTarget = true,
	ForceFaceOverideTimeInitial = 0.5,
	AnimationName = "Laser",
	EffectParentInstanceNames = { "Laser>VFX" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Laser" },
	PathEntityToEnemyRangedData = {
		CanTargetAir = true,
		QueryType = "Strongest",
		Damage = 30000 / 7,
		DamageType = Enums.DamageTypes.Lightning,
		Range = 300,
		MinimumRange = 15,
		BeamEffectHandlingData = {
			{ BeamParentInstanceName = "Laser>Beam", BeamDuration = 4.200000000000001 }
		}
	}
}