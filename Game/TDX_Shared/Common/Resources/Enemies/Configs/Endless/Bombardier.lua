local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 150000,
	Speed = 2,
	AnimationCalibratedSpeed = 1.5,
	BodyHeat = 7500,
	BodyHeatRegenerationRate = 5000,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.BombardierC4Ground, Enums.EnemyAbilities.BombardierC4Tower },
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.35,
	ForceFaceOutroTime = 0.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}