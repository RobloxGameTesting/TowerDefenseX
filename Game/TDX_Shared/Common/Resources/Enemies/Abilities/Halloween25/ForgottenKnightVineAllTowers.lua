local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 50,
	Cooldown = 80,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 3.65,
	AnimationName = "VineAllTowers",
	EffectParentInstanceNames = { "VineAllTowers" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>VineAllTowers" },
	EnemyToTowerRadiusEffectData = {
		MinimumTargets = 1,
		NoAffectStealth = true,
		TowerBuffNames = { Enums.TowerBuffs.ForgottenKnightVineStunDebuff }
	}
}