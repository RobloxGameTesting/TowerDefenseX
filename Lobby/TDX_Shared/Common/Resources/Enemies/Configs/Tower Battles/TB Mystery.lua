local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	EnemyTypeChanceMap = {
		[Enums.Enemies.TBBoss1] = 2,
		[Enums.Enemies.TBHidden] = 4,
		[Enums.Enemies.TBSlow] = 5,
		[Enums.Enemies.TBSpeedy] = 3,
		[Enums.Enemies.TBNecromancer] = 1
	},
	Count = 1,
	ExactPosition = true,
	NoCash = true
}
return {
	OverrideDisplayName = "Mystery",
	Health = 10,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.5,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 20,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = { v }
}