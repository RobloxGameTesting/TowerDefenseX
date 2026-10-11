local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 70000,
	Shield = 25000,
	Speed = 3,
	BodyHeat = 20000,
	BodyHeatRegenerationRate = 700,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.63,
	IsMiniBoss = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	ShieldModelName = "ForceField",
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.VoidEmpressSpinCharge, Enums.EnemyAbilities.VoidEmpressStab },
	AbilityBufferTime = 2,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7
}