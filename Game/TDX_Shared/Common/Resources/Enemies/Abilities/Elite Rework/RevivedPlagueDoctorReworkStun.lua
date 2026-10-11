local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 30,
	Animated = true,
	Delay = 37 / 60,
	ExecutionTime = 109 / 60,
	AnimationName = "Stun",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RevivedPlagueDoctorStunDebuff },
			DamageData = { Damage = 125 },
			Range = 15,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "StunEffectPart"
		}
	}
}