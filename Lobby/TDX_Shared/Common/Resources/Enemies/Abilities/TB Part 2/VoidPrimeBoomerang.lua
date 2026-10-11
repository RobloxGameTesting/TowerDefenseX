local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 5,
	Cooldown = 50,
	Animated = true,
	Delay = 43 / 30,
	ExecutionTime = 97 / 30,
	AnimationName = "Boomerang",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 4000 },
			Range = 30,
			CustomRangedHandlerData = {
				HandlerName = "VoidPrimeBoomerangClass",
				ReleaseTime = 43 / 30,
				ApexTime = 2,
				CatchTime = 31 / 12,
				ReleaseDistance = 7.8,
				PeakDistance = 55.8,
				CatchDistance = 5.1,
				OutEasePower = 1,
				ReturnEasePower = 1.85,
				HitRadius = 6
			}
		}
	},
	InstantPlayEffectParentInstanceNames = { "BoomerangSFX" },
	EffectParentInstanceNames = { "Sword>Base", "Sword2>Base2" },
	EffectsStartDelay = 43 / 30,
	EffectsStopDelay = 31 / 12
}