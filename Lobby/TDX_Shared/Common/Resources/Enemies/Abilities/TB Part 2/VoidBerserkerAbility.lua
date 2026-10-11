local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	MaximumRange = 18,
	TowerBuffNames = {
		Enums.TowerBuffs.VoidBerserkerShockFirerateDebuff,
		Enums.TowerBuffs.VoidBerserkerShockDamageTowers
	}
}
return {
	StartingCooldown = 8,
	Cooldown = 30,
	Animated = true,
	AnimationName = "BerserkerAttack",
	AutoHandleEffects = true,
	Delay = 0.9,
	ExecutionTime = 4.233,
	EffectsStartDelay = 0.9,
	EffectsStopDelay = 3.2,
	ParallelAbilityNames = { Enums.EnemyAbilities.VoidBerserkerAbility_PathEntity },
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}