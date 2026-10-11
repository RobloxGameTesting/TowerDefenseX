local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
local centerPositionByMap = {
	[Enums.Maps.Genesis] = createVector(18.213, 145.769, 125.91)
}
return {
	StartingCooldown = 15,
	Cooldown = 30,
	Animated = true,
	AnimationName = "HandSmashLeft",
	AutoHandleEffects = true,
	Delay = 3.5,
	ExecutionTime = 5.976,
	AbilityCycleGroup = "HandSmash",
	CanBeInterrupted = true,
	InterruptAnimationName = "HandSmashLeftInterrupt",
	InterruptDuration = 4.7,
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 50,
		MinimumTargets = 0,
		AffectTargetsWithNoAttack = true,
		CenterPosition = createVector(173.213, 39.769, 64.91),
		CenterPositionByMap = centerPositionByMap,
		DamageData = { Damage = 1000 },
		TowerBuffNames = { Enums.TowerBuffs.VoidGodHandSmashStun }
	}
}