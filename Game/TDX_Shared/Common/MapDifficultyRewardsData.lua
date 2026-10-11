local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local v = {
	[Enums.MapDifficulties.Simple] = {
		GoldMultiplier = 0.95,
		XPMultiplier = 0.9,
		TokensMultiplier = 0.9,
		CrystalsMultiplier = 0.95,
		CookiesMultiplier = 1
	},
	[Enums.MapDifficulties.Easy] = {
		GoldMultiplier = 1,
		CrystalsMultiplier = 1,
		XPMultiplier = 1,
		TokensMultiplier = 1,
		CookiesMultiplier = 1
	},
	[Enums.MapDifficulties.Normal] = {
		GoldMultiplier = 1.15,
		CrystalsMultiplier = 1.1,
		XPMultiplier = 1.15,
		TokensMultiplier = 1.1,
		CookiesMultiplier = 1
	},
	[Enums.MapDifficulties.Hard] = {
		GoldMultiplier = 1.35,
		CrystalsMultiplier = 1.25,
		XPMultiplier = 1.3,
		TokensMultiplier = 1.2,
		CookiesMultiplier = 1
	},
	[Enums.MapDifficulties.Impossible] = {
		GoldMultiplier = 1.65,
		CrystalsMultiplier = 1.65,
		XPMultiplier = 1.5,
		TokensMultiplier = 1.2,
		CookiesMultiplier = 1
	},
	[Enums.MapDifficulties.Nightmare] = {
		GoldMultiplier = 1.5,
		CrystalsMultiplier = 1.5,
		XPMultiplier = 1.5,
		TokensMultiplier = 1.2,
		CookiesMultiplier = 1
	}
}
local MapDifficultyRewardsData = {}

function MapDifficultyRewardsData.GetGoldMultiplier(p: string)
	return v[p] and v[p].GoldMultiplier or 1
end

function MapDifficultyRewardsData.GetXPMultiplier(p: string)
	return v[p] and v[p].XPMultiplier or 1
end

function MapDifficultyRewardsData.GetTokensMultiplier(p: string)
	return v[p] and v[p].TokensMultiplier or 1
end

function MapDifficultyRewardsData.GetCrystalsMultiplier(p: string)
	return v[p] and v[p].CrystalsMultiplier or 1
end

function MapDifficultyRewardsData.GetCookiesMultiplier(p: string)
	return v[p] and v[p].CookiesMultiplier or 1
end

return MapDifficultyRewardsData