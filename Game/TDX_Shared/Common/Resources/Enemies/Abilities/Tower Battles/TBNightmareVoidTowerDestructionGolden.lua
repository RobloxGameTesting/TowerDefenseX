local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 6,
	Cooldown = 25,
	Animated = true,
	Delay = 0.567,
	ExecutionTime = 6.9,
	AnimationName = "TowerDestruction",
	EffectParentInstanceNames = { "DestructionVFXTop", "DestructionVFXBottom" },
	EnemyToTowerRadiusEffectData = {
		TowerBuffNames = { Enums.TowerBuffs.NightmareVoidTowerDestructionFirerateDebuff },
		TowerTypeMinimumCountMap = { [Enums.Towers.GoldenWarship] = 2 },
		TowerInstantKillData = {
			{ InstantKillType = "Void", TowerType = Enums.Towers.GoldenWarship, Count = 2 }
		}
	}
}