local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	Speed = 400,
	Altitude = 65,
	EntranceDistance = 750,
	ExitDistance = 2000,
	Attacks = {
		CommanderF22Missile = {
			ReloadTime = 10000,
			BurstSize = 1,
			BurstInterval = 0.39,
			EnabledTime = 1.1,
			DisabledTime = 2.5,
			ProjectileName = Enums.Projectiles.CommanderF22Missile
		}
	}
}