local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
return {
	IsPVP = true,
	Category = Enums.PowerUpCategories.Offensive,
	Cooldown = 200,
	MaxUses = 2,
	ShieldPercentage = 0.2,
	BossShieldPercentage = 0.05
}