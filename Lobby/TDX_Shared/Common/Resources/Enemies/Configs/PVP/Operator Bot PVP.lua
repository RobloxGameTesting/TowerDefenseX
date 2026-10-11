local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local Boterator = require(script.Parent.Parent:WaitForChild("Christmas25"):WaitForChild("Boterator"))
return (TableUtilities.Extend(Boterator, {
	OverrideCharacterModelName = "Boterator",
	OverrideDisplayName = "Operator Bot",
	IsPVP = true,
	SendCost = 1000,
	UnlockWave = 15,
	BuildDuration = 5,
	SendEco = -20,
	BodyHeat = 690,
	StealthDetection = true,
	AttackData = {
		{
			Range = 22,
			Damage = 13,
			BurstSize = 8,
			ReloadTime = 1.2,
			BurstInterval = 0.2
		}
	}
}))