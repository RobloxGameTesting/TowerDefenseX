local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("MapTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EntityCreationTypes"))
local v = {
	NewMapEntityData = {
		Type = Enums.MapEntities.WinterContingencyBase,
		SpawnCFrame = CFrame.new(-22.226, 21.814, 94.083) * CFrame.Angles(0, 3.141592653589793, 0),
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
	PathEntityStartingPathPercentageLowerBound = 0.0075,
	PathEntityStartingPathPercentageUpperBound = 0.011,
	GainLivesProximityPrompt = true,
	DifficultyToPlayerCountToGainLivesMap = {
		[Enums.Difficulties.Test] = { 50, 30, 30, 30 },
		[Enums.Difficulties.Christmas25Part1Easy] = { 50, 30, 30, 30 },
		[Enums.Difficulties.Christmas25Part1] = { 50, 30, 30, 30 },
		[Enums.Difficulties.Christmas25Part1Nightmare] = { 40, 25, 25, 25 }
	},
	MapEntitiesSpawnData = { v }
}