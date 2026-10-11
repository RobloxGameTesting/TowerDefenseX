local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Humanity must accept its oncoming fate, for the event of arrival is nearing..",
	Health = 133337,
	Speed = 6,
	BodyHeat = 99999,
	SuperStunResistance = true,
	BodyHeatRegenerationRate = 999,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 }
	}
}