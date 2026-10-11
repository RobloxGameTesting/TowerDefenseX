local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	EntranceSpeed = 200,
	PylonSpeed = 45,
	ExitSpeed = 300,
	EntranceDistance = 300,
	ExitDistance = 1200,
	PylonRadius = 130,
	PylonDuration = 180,
	PylonPortAngle = 25,
	PylonAltitute = 50,
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({ MaxUses = 2 })
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
return Config