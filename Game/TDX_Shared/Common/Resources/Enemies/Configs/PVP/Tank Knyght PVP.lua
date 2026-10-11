local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local TankKnyght = require(script.Parent.Parent:WaitForChild("Elite Rework"):WaitForChild("Tank Knyght"))
return (TableUtilities.Extend(TankKnyght, {
	OverrideCharacterModelName = "Tank Knyght",
	OverrideDisplayName = "Tank Knyght",
	IsPVP = true,
	SendCost = 22750,
	UnlockWave = 29,
	BuildDuration = 12,
	SendEco = -105
}))