local v = "Player" .. tostring(32412172)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	error("Profile is nil")
	return
end

local inventory = profileAsync.Data.Inventory

if inventory then
	local powerUps = inventory.PowerUps

	if powerUps then
		powerUps.DropPod = (powerUps.DropPod or 0) + 5

		for k, powerUp in pairs(powerUps) do
			print(k, powerUp)
		end
	end
end

profileAsync:Release()