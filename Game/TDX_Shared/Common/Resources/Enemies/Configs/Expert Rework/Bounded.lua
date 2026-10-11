local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 20000,
	Shield = 1250,
	Speed = 2.4,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 70,
	HasCustomCode = true,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.BoundedTransition },
	DamageReductionTable = {},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Shield = 500 },
		[3] = { Shield = 1400 },
		[4] = { Shield = 4000 }
	}
}