local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 155,
	Speed = 2.5,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 3,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.GrenadierGrenade },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}