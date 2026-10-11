local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	IsPVP = true,
	SendCost = 2500,
	BuildDuration = 4,
	UnlockWave = 19,
	SendEco = -30,
	Health = 1700,
	Shield = 1000,
	Speed = 7,
	AnimationCalibratedSpeed = 7,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 40,
	Radius = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.EMPDeath },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.EMP,
	FakeEnemy = false,
	DamageReductionTable = {}
}