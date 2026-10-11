local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("MapTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EntityCreationTypes"))
local v = {
	NewMapEntityData = {
		Type = Enums.MapEntities.NorthforgeEnemyBase,
		SpawnCFrame = CFrame.new(75.314, 55.912, 232.777) * CFrame.Angles(0, -1.7777051096188243, 0),
		IsFriendly = false,
		CanQuery = false,
		PlayerVictoryDelayTriggersDeath = true,
		PlayerVictoryDelayTriggersDeathDelay = 6
	}
}
local v2 = {
	NewMapEntityData = {
		Type = Enums.MapEntities.NorthforgeMissileSilo,
		SpawnCFrame = CFrame.new(70.659, 50.507, 61) * CFrame.Angles(0, 0, 0),
		IsFriendly = true,
		DefeatIfDeath = true,
		UseForLives = true,
		CanQuery = true,
		TargetableThroughEndNodes = true,
		EndNodeRadius = 0.5,
		UseForFirstLastQuery = true
	}
}
return {
	FlagCaptureTime = 20,
	GainLivesProximityPrompt = true,
	DifficultyToPlayerCountToGainLivesMap = {
		[Enums.Difficulties.Test] = { 100, 60, 50, 40 },
		[Enums.Difficulties.Christmas25Part2Easy] = { 150, 75, 60, 50 },
		[Enums.Difficulties.Christmas25Part2] = { 125, 65, 55, 45 },
		[Enums.Difficulties.Christmas25Part2Nightmare] = { 100, 60, 50, 40 }
	},
	MapEntitiesSpawnData = { v, v2 }
}