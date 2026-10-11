local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 31 / 30,
	ExecutionTime = 3.4333333333333336,
	AnimationName = "Spray",
	FaceTarget = true,
	EffectsStartDelay = 31 / 30,
	EffectsStopDelay = 89 / 30,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RevivedPlagueDoctorToxicGasDebuff },
			Range = 20,
			ArcSpreadAngle = 32,
			EffectParentInstanceName = "ToxicGasSprayEffectPart",
			ChangeColorPartsColor = Color3.fromRGB(75, 75, 75)
		},
		{
			TowerBuffNames = { Enums.TowerBuffs.RevivedPlagueDoctorFirerateDebuff },
			Range = 20,
			ArcSpreadAngle = 32,
			EffectParentInstanceName = "FirerateSprayEffectPart",
			ChangeColorPartsColor = Color3.fromRGB(255, 0, 0)
		},
		{
			TowerBuffNames = { Enums.TowerBuffs.RevivedPlagueDoctorDamageDebuff },
			Range = 20,
			ArcSpreadAngle = 32,
			EffectParentInstanceName = "DamageSprayEffectPart",
			ChangeColorPartsColor = Color3.fromRGB(88, 153, 45)
		}
	}
}