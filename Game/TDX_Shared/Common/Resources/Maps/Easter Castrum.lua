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
				Type = Enums.MapEntities.EasterCastrumBase,
				SpawnCFrame = CFrame.new(42.511, 36.867, -1.255),
				IsFriendly = true,
				DefeatIfDeath = true,
				UseForLives = true,
				CanQuery = true,
				TargetableThroughEndNodes = false
			}
		}
	}
}