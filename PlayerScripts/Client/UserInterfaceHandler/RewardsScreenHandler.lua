local RewardsScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WaveTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local MapDifficultyRewardsData = require(common:WaitForChild("MapDifficultyRewardsData"))
local RewardMultipliers = require(common:WaitForChild("RewardMultipliers"))
local rewards = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("DifficultyVoteScreen"):WaitForChild("Rewards")

local function GetMaximumWaveConfigReward(waveConfig, p: string)
	if not waveConfig.IntervalRewardData then
		return 0
	end

	local v = 0

	for _, v2 in pairs(waveConfig.IntervalRewardData) do
		if not (v2[p] and v < v2[p]) then
			continue
		end

		local wave = waveConfig.Waves[v2.WaveNumber]

		if wave == nil or not wave.IsSecretWave then
			v = v2[p]
		end
	end

	return v
end

function GetMaximumWaveXPReward(p)
	local total = 0

	for i = 1, #p.Waves do
		local wave = p.Waves[i]

		if wave.IsSecretWave then
			continue
		end

		if wave and wave.OverrideXP then
			total += wave.OverrideXP
		else
			total += p.DefaultXPPerWavePassed or 0
		end
	end

	return total
end

function RewardsScreenHandler.Update(p: string, p2: string)
	local waveConfig = ResourceManager.GetWaveConfig(p)

	if waveConfig then
		local v = math.round(GetMaximumWaveConfigReward(waveConfig, "GoldReward") * RewardMultipliers.Get("Gold") * MapDifficultyRewardsData.GetGoldMultiplier(p2))
		rewards.ContentFrame.Gold.Visible = v > 0
		rewards.ContentFrame.Gold.TextLabel.Text = `+{v}`
		local v2 = math.round(GetMaximumWaveConfigReward(waveConfig, "CrystalsReward") * RewardMultipliers.Get("Crystals") * MapDifficultyRewardsData.GetCrystalsMultiplier(p2))
		rewards.ContentFrame.Crystals.Visible = v2 > 0
		rewards.ContentFrame.Crystals.TextLabel.Text = `+{v2}`
		local v3 = math.round(GetMaximumWaveConfigReward(waveConfig, "TokensReward") * RewardMultipliers.Get("Tokens") * MapDifficultyRewardsData.GetTokensMultiplier(p2))
		rewards.ContentFrame.Tokens.Visible = v3 > 0
		rewards.ContentFrame.Tokens.TextLabel.Text = `+{v3}`
		local v4 = math.round(GetMaximumWaveXPReward(waveConfig) * RewardMultipliers.Get("XP") * MapDifficultyRewardsData.GetXPMultiplier(p2))
		rewards.ContentFrame.XP.Visible = v4 > 0
		rewards.ContentFrame.XP.TextLabel.Text = `+{v4}`
		local v5 = math.round((GetMaximumWaveConfigReward(waveConfig, "CookiesReward"))) * MapDifficultyRewardsData.GetCookiesMultiplier(p2)
		rewards.ContentFrame.Cookies.Visible = v5 > 0
		rewards.ContentFrame.Cookies.TextLabel.Text = `+{v5}`

		if p == Enums.Difficulties.Tutorial then
			rewards.Position += UDim2.fromOffset(20, 0)
		end

		rewards.Visible = true
	else
		warn("No wave config found for mode: " .. p)
		rewards.Visible = false
	end
end

rewards.Visible = false
return RewardsScreenHandler