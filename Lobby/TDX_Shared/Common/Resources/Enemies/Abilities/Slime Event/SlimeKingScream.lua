local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 70,
	Animated = true,
	Delay = 1.65,
	ExecutionTime = 3.8,
	AnimationName = "Scream",
	EffectParentInstanceNames = { "Scream" },
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Scream" },
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.SlimeKingScreamDebuff },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	}
}