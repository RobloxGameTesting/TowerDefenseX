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
				Type = Enums.MapEntities.CastellanReachBase,
				SpawnCFrame = CFrame.new(-29.185, -0.18, -40.78),
				IsFriendly = true,
				DefeatIfDeath = true,
				UseForLives = true,
				CanQuery = true,
				TargetableThroughEndNodes = false
			}
		}
	}
}