local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local Config = {
	BodyHeatReductionPerSecond = 20000,
	DamagePerSecond = 1000,
	ReloadTime = 0.2,
	Duration = 5,
	Radius = 8,
	DifficultyOverrides = {}
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
return Config