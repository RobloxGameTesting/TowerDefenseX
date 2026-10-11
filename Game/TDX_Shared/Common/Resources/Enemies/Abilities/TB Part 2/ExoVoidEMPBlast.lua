local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	AnimationName = "EMPBlast",
	Delay = 1.817,
	ExecutionTime = 5.0329999999999995,
	AutoHandleEffects = true,
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 35,
		MinimumTargets = 2,
		AffectTargetsWithNoAttack = true,
		AffectMechanicalOrGoldenOnly = true,
		TowerBuffNames = { Enums.TowerBuffs.ExoVoidEMPDebuff }
	}
}