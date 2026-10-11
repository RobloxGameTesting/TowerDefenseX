local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("MapTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EntityCreationTypes"))
local v = {
	NewMapEntityData = {
		Type = Enums.MapEntities.HellspireArtillery,
		SpawnCFrame = CFrame.new(7.375, 21.924, -28.374),
		IsFriendly = true,
		DefeatIfDeath = true,
		UseForLives = true,
		CanQuery = true,
		TargetableThroughEndNodes = true,
		EndNodeRadius = 0.5,
		UseForFirstLastQuery = true
	}
}
local v2 = {
	NewMapEntityData = {
		Type = Enums.MapEntities.VoidCitadel,
		SpawnCFrame = CFrame.new(-10.787, 162.94, 168.207),
		IsFriendly = false,
		CanQuery = false,
		PlayerVictoryDelayTriggersDeath = true,
		PlayerVictoryDelayTriggersDeathDelay = 6
	}
}
return {
	PathEntityStartingPathPercentageLowerBound = 0.0075,
	PathEntityStartingPathPercentageUpperBound = 0.011,
	GainLivesProximityPrompt = true,
	DifficultyToPlayerCountToGainLivesMap = {
		[Enums.Difficulties.Test] = { 50, 30, 30, 30 },
		[Enums.Difficulties.HalloweenPart3] = { 50, 30, 30, 30 },
		[Enums.Difficulties.HalloweenNightmarePart3] = { 40, 25, 25, 25 }
	},
	MapEntitiesSpawnData = { v, v2 }
}