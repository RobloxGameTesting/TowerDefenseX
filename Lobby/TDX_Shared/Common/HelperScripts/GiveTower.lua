local v = "Player" .. tostring(1786493365)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	error("Profile is nil")
	return
end

local inventory = profileAsync.Data.Inventory

if inventory then
	local towers = inventory.Towers

	if towers then
		if towers.Commander then
			print("Player already has the tower:", "Commander")
		else
			towers.Commander = true
		end

		for k, tower in pairs(towers) do
			print(k, tower)
		end
	end
end

profileAsync:Release()