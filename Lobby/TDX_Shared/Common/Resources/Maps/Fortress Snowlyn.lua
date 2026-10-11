local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("MapTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EntityCreationTypes"))
local v = {
	NewMapEntityData = {
		Type = Enums.MapEntities.ArcticHQGate,
		SpawnCFrame = CFrame.new(-1.631, 0.585, 85.94),
		IsFriendly = true,
		DefeatIfDeath = true,
		UseForLives = true,
		CanQuery = true,
		TargetableThroughEndNodes = true,
		EndNodeRadius = 0.2,
		UseForFirstLastQuery = true
	}
}
local newTowerData = {
	Type = Enums.Towers.Sentry,
	Position = createVector(24.215618, 0.9417204, 83.31738),
	RotationIncrement = 1,
	SpawnRotationOffset = 0.2617993877991494,
	TotalCost = 0,
	Path1Level = 3,
	Path2Level = 2
}
local v2 = {
	NewTowerData = {
		Type = Enums.Towers.Sentry,
		Position = createVector(-27.303282, 1.4522462, 83.32789),
		RotationIncrement = 7,
		SpawnRotationOffset = -0.2617993877991494,
		TotalCost = 0,
		Path1Level = 3,
		Path2Level = 2
	}
}
return {
	PathEntityStartingPathPercentageLowerBound = 0.0075,
	PathEntityStartingPathPercentageUpperBound = 0.011,
	GainLivesProximityPrompt = true,
	DifficultyToPlayerCountToGainLivesMap = {
		[Enums.Difficulties.Test] = { 100, 100, 100, 100 },
		[Enums.Difficulties.Christmas24Part2] = { 150, 90, 70, 60 },
		[Enums.Difficulties.Christmas24Part2Nightmare] = { 200, 140, 100, 80 }
	},
	MapEntitiesSpawnData = { v },
	TowersSpawnData = {
		{ NewTowerData = newTowerData },
		v2
	}
}