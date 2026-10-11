local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 40,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.767,
	AnimationName = "Sword Spin",
	EffectParentInstanceNames = { "LeftBladeSwordSpinVFX", "RightBladeSwordSpinVFX" },
	EffectsStartDelay = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {
				Enums.TowerBuffs.EradicatorMKICGoldSwordSpinStun,
				Enums.TowerBuffs.EradicatorMKICGoldSwordSpinDamage
			},
			Range = 12,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SwordSpinSFX",
			EffectsStartDelay = 0.4
		}
	}
}