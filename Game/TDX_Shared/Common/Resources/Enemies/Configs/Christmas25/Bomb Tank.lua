local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 150000,
	Shield = 125000,
	Speed = 2.4,
	BodyHeat = 120000,
	BodyHeatRegenerationRate = 5750,
	Radius = 1,
	NoHead = true,
	NoTorso = true,
	IsMechanical = true,
	AbilityNames = { Enums.EnemyAbilities.BombTankSelfDestruct },
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.GrumbleDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 }
	}
}