local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("MapTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EntityCreationTypes"))
return {
	MapEntitiesSpawnData = {
		{
			NewMapEntityData = {
				Type = Enums.MapEntities.GUNFacilityBase,
				SpawnCFrame = CFrame.new(-39.426, 61.443, 202.913),
				IsFriendly = true,
				DefeatIfDeath = true,
				UseForLives = true,
				CanQuery = true,
				TargetableThroughEndNodes = false
			}
		}
	}
}