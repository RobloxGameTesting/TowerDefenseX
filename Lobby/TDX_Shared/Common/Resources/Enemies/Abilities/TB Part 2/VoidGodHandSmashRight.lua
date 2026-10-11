local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
local centerPositionByMap = {
	[Enums.Maps.Genesis] = createVector(65.778, 145.769, 92.009)
}
return {
	StartingCooldown = 15,
	Cooldown = 30,
	Animated = true,
	AnimationName = "HandSmashRight",
	AutoHandleEffects = true,
	Delay = 3.5,
	ExecutionTime = 5.976,
	AbilityCycleGroup = "HandSmash",
	CanBeInterrupted = true,
	InterruptAnimationName = "HandSmashRightInterrupt",
	InterruptDuration = 4.7,
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 50,
		MinimumTargets = 0,
		AffectTargetsWithNoAttack = true,
		CenterPosition = createVector(227.313, 39.769, 48.51),
		CenterPositionByMap = centerPositionByMap,
		DamageData = { Damage = 1000 },
		TowerBuffNames = { Enums.TowerBuffs.VoidGodHandSmashStun }
	}
}