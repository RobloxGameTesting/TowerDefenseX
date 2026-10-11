local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("MapTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EntityCreationTypes"))
local v = {
	NewMapEntityData = {
		Type = Enums.MapEntities.GDABase,
		SpawnCFrame = CFrame.new(48.485, 33.097, -22.358),
		IsFriendly = true,
		DefeatIfDeath = true,
		UseForLives = true,
		CanQuery = true,
		TargetableThroughEndNodes = true,
		EndNodeRadius = 0.15,
		UseForFirstLastQuery = true
	}
}
return {
	PathEntityStartingPathPercentageLowerBound = 0.0075,
	PathEntityStartingPathPercentageUpperBound = 0.011,
	GainLivesProximityPrompt = true,
	DifficultyToPlayerCountToGainLivesMap = {
		[Enums.Difficulties.Test] = { 50, 40, 30, 25 },
		[Enums.Difficulties.HalloweenPart4] = { 50, 40, 30, 25 },
		[Enums.Difficulties.HalloweenNightmarePart4] = { 50, 40, 30, 25 }
	},
	MapEntitiesSpawnData = { v }
}