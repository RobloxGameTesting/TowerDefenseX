local v = "Player" .. tostring(766984079)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	error("Profile is nil")
	return
end

print("Previous XP: ", profileAsync.Data.XP)
profileAsync.Data.XP += 50000
print("New XP: ", profileAsync.Data.XP)
profileAsync:Release()