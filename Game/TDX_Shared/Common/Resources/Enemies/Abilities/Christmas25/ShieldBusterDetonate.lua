local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	MaximumRange = 10,
	DamageData = { Damage = 3500 },
	TowerTypeMinimumCountMap = { [Enums.Towers.ShieldTower] = 1 },
	TowerInstantKillData = {
		{ InstantKillType = "Void", TowerType = Enums.Towers.ShieldTower, Count = 1 }
	},
	AffectTargetsWithNoAttack = true
}
return {
	StartingCooldown = 4,
	Cooldown = 1e999,
	MaximumUses = 1,
	Animated = true,
	Delay = 2.25,
	ExecutionTime = 34 / 15,
	AnimationName = "Detonate",
	EffectParentInstanceNames = { "DetonateFX" },
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	Kamikaze = true
}