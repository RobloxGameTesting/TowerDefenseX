local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileStore = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone)

for _, v in pairs({ 157446826 }) do
	local profileAsync = profileStore:LoadProfileAsync("Player" .. tostring(v))

	if profileAsync == nil then
		error("Profile is nil")
	else
		print("Previous cookies: ", profileAsync.Data.Cookies)
		profileAsync.Data.Cookies += 1000
		print("New cookies: ", profileAsync.Data.Cookies)
		profileAsync:Release()
	end
end