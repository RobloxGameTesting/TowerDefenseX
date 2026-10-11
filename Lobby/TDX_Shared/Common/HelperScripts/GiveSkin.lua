local v = "Player" .. tostring(39561762)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	error("Profile is nil")
	return
end

local inventory = profileAsync.Data.Inventory

if inventory then
	local skins = inventory.Skins

	if skins then
		skins["Atrazine_Manual_Skin_" .. tostring(os.clock())] = "Barracks_Tower Battles"

		for k, skin in pairs(skins) do
			print(k, skin)
		end
	end
end

profileAsync:Release()