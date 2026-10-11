local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 50,
	Animated = true,
	AnimationName = "SwordClang",
	Delay = 1.467,
	ExecutionTime = 3.133,
	EffectParentInstanceNames = { "SwordClang" },
	EnemyToTowerRangedDataSequence = {
		{
			CanAffectAir = true,
			TowerBuffNames = { Enums.TowerBuffs.SlimeKingSwordClangDebuff },
			Range = 18,
			HitAllTargetsInRange = true
		}
	}
}