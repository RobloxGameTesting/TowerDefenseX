local v = "Player" .. tostring(8644709266)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	if nil == nil then
		error("Profile is nil")
	end
else
	local function PrintProfileData(items, p)
		for k, item in pairs(items) do
			if k == "Achievements" then
				continue
			end

			if k == "Skins" then
				local count = 0

				for _ in pairs(item) do
					count += 1
				end

				print("Skin count:", count)
			elseif p and type(item) == "table" then
				print(k .. ":")

				for k2, v2 in pairs(item) do
					print("  " .. k2 .. ": " .. tostring(v2))
				end
			else
				print(k .. ": " .. tostring(item))
			end
		end
	end

	print("\n\n")
	print("== Profile Data ==")
	print("\n")
	print(" - Loadout -")
	PrintProfileData(profileAsync.Data.Inventory, true)
	print("\n")
	print(" - Other Data -")
	PrintProfileData(profileAsync.Data)
	print("\n\n")
	profileAsync:Release()
end