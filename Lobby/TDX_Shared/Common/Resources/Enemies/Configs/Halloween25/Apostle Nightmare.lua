local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.TormentedSoul, Count = 40, MaxSpawnOffsetStuds = 5 }
}
return {
	OverrideCharacterModelName = Enums.Enemies.Apostle,
	Health = 333,
	Speed = 3.4,
	BodyHeat = 1,
	BodyHeatRegenerationRate = 1,
	OverrideDisplayName = "Apostle",
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ApostleDeath,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {}
}