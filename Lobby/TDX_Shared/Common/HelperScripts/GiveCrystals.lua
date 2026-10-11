local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileStore = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone)

for _, v in pairs({ 1365069395 }) do
	local profileAsync = profileStore:LoadProfileAsync("Player" .. tostring(v))

	if profileAsync == nil then
		error("Profile is nil")
	else
		print("Previous crystals: ", profileAsync.Data.Crystals)
		profileAsync.Data.Crystals += 1500
		print("New crystals: ", profileAsync.Data.Crystals)
		profileAsync:Release()
	end
end