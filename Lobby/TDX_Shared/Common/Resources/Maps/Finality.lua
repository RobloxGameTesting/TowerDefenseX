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
				Type = Enums.MapEntities.FinalityBase,
				SpawnCFrame = CFrame.new(-265.923, 54.664, -227.449),
				IsFriendly = true,
				DefeatIfDeath = true,
				UseForLives = true,
				CanQuery = true,
				TargetableThroughEndNodes = false
			}
		}
	}
}