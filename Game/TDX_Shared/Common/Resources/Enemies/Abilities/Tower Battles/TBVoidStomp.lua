local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 25,
	Animated = true,
	Delay = 1.983,
	ExecutionTime = 3.367,
	AnimationName = "Stomp",
	EffectParentInstanceNames = { "StompVFX" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.VoidStompStun },
			DamageData = { Damage = 150 },
			Range = 25,
			HitAllTargetsInRange = true
		}
	}
}