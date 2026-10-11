local v = "Player" .. tostring(340699926)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	error("Profile is nil")
	return
end

for k, v2 in pairs(profileAsync.Data) do
	print(k, "->", v2)
end

profileAsync:Release()