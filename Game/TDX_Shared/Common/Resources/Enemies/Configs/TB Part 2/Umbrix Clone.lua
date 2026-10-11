local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100000,
	Speed = 0,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	SuperStunResistance = true,
	IgnoreAdditionalSpeedMultiplier = true,
	AbilityNames = { Enums.EnemyAbilities.UmbrixCloneIdle },
	RotationOffset = CFrame.Angles(0, 0, 0),
	FakeEnemy = false,
	FadeOutOnDeath = true
}