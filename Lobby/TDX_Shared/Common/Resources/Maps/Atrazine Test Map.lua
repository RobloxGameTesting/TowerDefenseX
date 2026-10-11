local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("MapTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EntityCreationTypes"))
local v = {
	NewMapEntityData = {
		Type = Enums.MapEntities.AtrazineTestMapBase,
		SpawnCFrame = CFrame.new(58.174, -5, 73.231) * CFrame.Angles(0, 3.141592653589793, 0),
		IsFriendly = true,
		DefeatIfDeath = true,
		UseForLives = true,
		CanQuery = true,
		TargetableThroughEndNodes = false
	}
}
local _ = {
	NewTowerData = {
		Type = Enums.Towers.Sentry,
		Position = createVector(64.15, -9.28, 65.557),
		RotationIncrement = 1,
		SpawnRotationOffset = -0.2617993877991494,
		TotalCost = 0,
		Path1Level = 3,
		Path2Level = 2
	}
}
local _ = {
	NewTowerData = {
		Type = Enums.Towers.Sentry,
		Position = createVector(52.15, -9.28, 65.557),
		RotationIncrement = 7,
		SpawnRotationOffset = 0.2617993877991494,
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
		[Enums.Difficulties.Test] = { 100, 100, 100, 100 }
	},
	MapEntitiesSpawnData = { v },
	TowersSpawnData = {}
}