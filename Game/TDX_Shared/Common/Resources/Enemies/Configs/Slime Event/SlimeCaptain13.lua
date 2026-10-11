local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Cube",
	Health = 1000,
	Shield = 10000,
	Speed = 0.3,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "CaptainSlimeBossMusic",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BossGreenGloopTiny,
	FakeEnemy = false,
	NoHead = true,
	NoTorso = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 0, Shield = 0 },
		[4] = { Health = 0, Shield = 0 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.SlimeEventNightmare] = {
			Health = 1000,
			Shield = 1000,
			BodyHeat = 3000000,
			BodyHeatRegenerationRate = 100000
		}
	}
}