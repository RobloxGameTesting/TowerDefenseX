local v = "Player" .. tostring(2171104)
local clone = table.clone(require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate))
local ProfileService = require(game.ReplicatedStorage.TDX_Shared.Common.ProfileService)
local profileAsync = ProfileService.GetProfileStore("DEV" .. "Data" .. 7, clone):LoadProfileAsync(v)

if profileAsync == nil then
	error("Profile is nil")
	return
end

local v2 = {
	2500,
	2700,
	2900,
	3000,
	3250,
	3500,
	3750,
	3850,
	3950,
	4000,
	4150,
	4250,
	4300,
	4450,
	4500,
	4600,
	4700,
	4800,
	4950,
	5000,
	5250,
	5350,
	5450,
	5500,
	5600,
	5750,
	5800,
	5900,
	5950,
	6000,
	6150,
	6250,
	6350,
	6400,
	6500,
	6600,
	6750,
	6850,
	6950,
	7000,
	7200,
	7400,
	7600,
	7800,
	8000,
	8500,
	9000,
	9500,
	9850,
	10000
}

local function LevelToXP(p: number)
	if p == 0 then
		return 0
	end

	local total = 0

	for i = 1, p do
		if v2[i] then
			total += v2[i]
		else
			total += v2[#v2] + math.ceil(((i - 49) / 0.03) ^ 1.7 * 0.1)
		end
	end

	return total
end

profileAsync.Data.XP = LevelToXP(188)
print("New XP: ", profileAsync.Data.XP)
profileAsync:Release()