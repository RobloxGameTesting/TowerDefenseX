local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 1.85,
	ExecutionTime = 4,
	AnimationName = "Swing",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 800 },
			TowerBuffNames = { Enums.TowerBuffs.BunnyGuardianSwingStun },
			Range = 9,
			ArcSpreadAngle = 90,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = { "RootPart" }
}