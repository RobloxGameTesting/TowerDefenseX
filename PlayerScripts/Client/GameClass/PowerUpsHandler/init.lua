local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local PowerUpsConfigHandler = require(common:WaitForChild("Resources").Misc.PowerUpsConfigHandler)
local RegularPowerUps = script:WaitForChild("RegularPowerUps")
local CustomTriggeredPowerUps = script:WaitForChild("CustomTriggeredPowerUps")
local modulesByPowerUp = {}
local modulesByCustomTriggeredPowerUp = {}

for _, powerUp in pairs(Enums.PowerUps) do
	local child = RegularPowerUps:FindFirstChild(powerUp .. "Handler")

	if not child then
		continue
	end

	local module = require(child)
	modulesByPowerUp[powerUp] = module
end

for _, customTriggeredPowerUp in pairs(Enums.CustomTriggeredPowerUps) do
	local child = CustomTriggeredPowerUps:FindFirstChild(customTriggeredPowerUp .. "Handler")

	if not child then
		continue
	end

	local module = require(child)
	modulesByCustomTriggeredPowerUp[customTriggeredPowerUp] = module
end

PowerUpsConfigHandler.Initialize()
local PowerUpsHandler = {}

function PowerUpsHandler.Initialize()
	for _, v in pairs(modulesByPowerUp) do
		v.Initialize()
	end

	for _, v in pairs(modulesByCustomTriggeredPowerUp) do
		v.Initialize()
	end
end

function PowerUpsHandler.Run(p: number)
	for _, v in pairs(modulesByPowerUp) do
		v.Run(p)
	end

	for _, v in pairs(modulesByCustomTriggeredPowerUp) do
		v.Run(p)
	end
end

function PowerUpsHandler.SetSpeedMultiplier(p: number)
	for _, v in pairs(modulesByPowerUp) do
		v.SetSpeedMultiplier(p)
	end

	for _, v in pairs(modulesByCustomTriggeredPowerUp) do
		v.SetSpeedMultiplier(p)
	end
end

return PowerUpsHandler