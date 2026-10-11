local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	EnemyTypeChanceMap = {
		[Enums.Enemies.TBBoss2] = 1,
		[Enums.Enemies.TBSlimeBoss] = 3,
		[Enums.Enemies.TBLava] = 6,
		[Enums.Enemies.TBHiddenBoss] = 1,
		[Enums.Enemies.TBLightning] = 2,
		[Enums.Enemies.TBToxic] = 3
	},
	Count = 1,
	ExactPosition = true,
	NoCash = true
}
return {
	OverrideDisplayName = "Mystery 2",
	Health = 100,
	Speed = 2,
	AnimationCalibratedSpeed = 1.5,
	BodyHeat = 250,
	BodyHeatRegenerationRate = 125,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = { v }
}