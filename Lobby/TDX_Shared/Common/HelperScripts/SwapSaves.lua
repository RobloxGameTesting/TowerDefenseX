local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileStore = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone)

for k, v in pairs({
	{ 343871540, 9622459367 },
	{ 6049741216, 3053711055 },
	{ 2955417378, 2567859408 },
	{ 4350454696, 11218195340 },
	{ 4622193043, 11396288460 },
	{ 4536111377, 11465067025 },
	{ 7352244758, 11228765053 },
	{ 5169251495, 11724172380 },
	{ 717257886, 11324028151 },
	{ 154580342, 11671455661 },
	{ 649897940, 11222467884 },
	{ 2424861060, 11215870230 },
	{ 11733733800, 5393755929 },
	{ 1240750393, 11218094891 },
	{ 11734139747, 1680242333 },
	{ 2977742800, 11216942386 },
	{ 4686065865, 11734176130 },
	{ 1204420572, 11209068393 },
	{ 3802479725, 11734413064 },
	{ 813696756, 11206303958 },
	{ 524398798, 3872900341 },
	{ 4017888037, 11209224791 },
	{ 438228565, 11736660846 },
	{ 2015879284, 11183456582 },
	{ 4020045760, 11207380246 },
	{ 412483694, 2004049195 },
	{ 5474811682, 11398231750 },
	{ 1410158545, 11213718162 },
	{ 11736727805, 1480039958 },
	{ 3588203901, 2378260153 },
	{ 1524985279, 1968961967 },
	{ 221686862, 11306084021 },
	{ 8916389752, 11344366671 },
	{ 1061050164, 10563319893 },
	{ 363212348, 11484837975 },
	{ 754248886, 1696767289 },
	{ 2814514993, 11671366989 },
	{ 1459079823, 11738172964 },
	{ 1398017216, 11358135338 },
	{ 4302156682, 11738159976 },
	{ 3403414921, 3223912225 },
	{ 3500561233, 11616752181 },
	{ 5342459842, 11187512841 },
	{ 164704665, 895030911 },
	{ 911561626, 11216133444 },
	{ 3583658366, 11738400842 },
	{ 11362597693, 1365168668 },
	{ 1133101921, 8728428859 },
	{ 1268321765, 11307632824 },
	{ 495916246, 11213736956 },
	{ 922152183, 11211484507 },
	{ 3994473972, 11433927167 },
	{ 177004432, 11208659950 },
	{ 293895924, 3138008251 },
	{ 3838541842, 11214872790 },
	{ 512277603, 9052687349 },
	{ 636609543, 11025248328 },
	{ 3270255405, 11564920043 },
	{ 862427690, 11210400680 },
	{ 4980424590, 11313310181 },
	{ 951977, 11110373532 }
}) do
	local v2 = v[1]
	local v3 = v[2]
	local v4 = "Player" .. tostring(v2)
	local v5 = "Player" .. tostring(v3)
	local profileAsync = profileStore:LoadProfileAsync(v4)
	local profileAsync2 = profileStore:LoadProfileAsync(v5)
	print("Switching index:", k, "UserId1:", v2, "UserId2:", v3)

	if profileAsync == nil or profileAsync2 == nil then
		print("SWitch at index", k, "failed. One or both profiles are nil.")

		if profileAsync == nil then
			warn("Profile1 is nil")
		end

		if profileAsync2 == nil then
			warn("Profile2 is nil")
		end
	else
		local clone2 = table.clone(profileAsync.Data)
		profileAsync.Data = table.clone(profileAsync2.Data)
		profileAsync2.Data = clone2

		local function PrintProfileData(items, p)
			for k2, item in pairs(items) do
				if k2 == "Achievements" then
					continue
				end

				if k2 == "Skins" then
					local count = 0

					for _ in pairs(item) do
						count += 1
					end

					print("Skin count:", count)
				elseif p and type(item) == "table" then
					print(k2 .. ":")

					for k3, v6 in pairs(item) do
						print("  " .. k3 .. ": " .. tostring(v6))
					end
				else
					print(k2 .. ": " .. tostring(item))
				end
			end
		end

		profileAsync:Release()
		profileAsync2:Release()
		print("Switch at index", k, "completed successfully.")
	end
end