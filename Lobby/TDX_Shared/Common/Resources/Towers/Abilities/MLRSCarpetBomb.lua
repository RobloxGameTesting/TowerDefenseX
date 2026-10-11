local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Config = require(common.Resources.Misc.CustomTriggeredPowerUps.MLRSCarpetBomb.Config)
return {
	Name = "MLRSCarpetBomb",
	DisplayName = "Carpet Bomb",
	Passive = false,
	StartingCooldown = 20,
	Cooldown = 120,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://106141929315475",
	FullSizeIcon = true,
	Description = "Call in a B52 carpet bomb strike.",
	CustomTriggeredPowerUpName = Enums.CustomTriggeredPowerUps.MLRSCarpetBomb,
	IsManualAimAtGroundDirectional = true,
	ManualAimInfiniteRange = true,
	StrikeZoneLength = Config.StrikeZoneLength,
	StrikeZoneWidth = Config.StrikeZoneWidth,
	EffectParentInstanceNames = { "Root>CarpetBombActivationSFX" }
}