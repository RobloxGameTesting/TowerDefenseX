local v = "Player" .. tostring(780184430)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	error("Profile is nil")
	return
end

profileAsync.Data.Gold += 500000
print("New gold: ", profileAsync.Data.Gold)
profileAsync:Release()