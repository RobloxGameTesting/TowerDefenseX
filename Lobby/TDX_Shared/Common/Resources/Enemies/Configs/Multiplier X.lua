local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100000,
	NoCash = true,
	DeathIfCollideWithBoss = true,
	Speed = 20,
	BodyHeat = 1000000,
	BodyHeatRegenerationRate = 1000000,
	Radius = 1,
	HoverHeight = 1.626,
	AnimationTimeScale = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.MultiplierXClone },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.MultiplierXClone,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}