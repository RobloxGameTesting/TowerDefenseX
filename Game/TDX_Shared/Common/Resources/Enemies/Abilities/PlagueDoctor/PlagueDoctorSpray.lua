local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	Delay = 0.75,
	ExecutionTime = 3.45,
	AnimationName = "Spray",
	FaceTarget = true,
	HiddenWhenBeingUsedModelName = "SprayGunIdle",
	ShownWhenBeingUsedModelNames = { "SprayGunActive" },
	IntroSwitchDelay = 0.5333,
	OutroSwitchDelay = 3.2,
	EffectsStartDelay = 1.1,
	EffectsStopDelay = 2.3,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.PlagueDoctorRangeDebuff },
			Range = 20,
			ArcSpreadAngle = 32,
			EffectParentInstanceName = "RangeSprayEffectPart",
			ChangeColorPartsColor = Color3.fromRGB(0, 170, 255)
		},
		{
			TowerBuffNames = { Enums.TowerBuffs.PlagueDoctorFirerateDebuff },
			Range = 20,
			ArcSpreadAngle = 32,
			EffectParentInstanceName = "FirerateSprayEffectPart",
			ChangeColorPartsColor = Color3.fromRGB(255, 0, 0)
		},
		{
			TowerBuffNames = { Enums.TowerBuffs.PlagueDoctorDamageDebuff },
			Range = 20,
			ArcSpreadAngle = 32,
			EffectParentInstanceName = "DamageSprayEffectPart",
			ChangeColorPartsColor = Color3.fromRGB(88, 153, 45)
		}
	}
}