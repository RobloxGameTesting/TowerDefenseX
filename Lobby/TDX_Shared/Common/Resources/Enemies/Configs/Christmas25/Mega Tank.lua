local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 350000,
	Shield = 240000,
	SuperStunResistance = true,
	Speed = 2.2,
	BodyHeat = 188840,
	BodyHeatRegenerationRate = 5000,
	Radius = 1,
	NoHead = true,
	NoTorso = true,
	IsMechanical = true,
	AbilityNames = { Enums.EnemyAbilities.MegaTankSelfDestruct },
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GrumbleDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 }
	}
}