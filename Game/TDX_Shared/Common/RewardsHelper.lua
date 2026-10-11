local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local RewardsHelper = {}

function RewardsHelper.GetMaximumWaveReward(data, p: string)
	local pvpVictoryIntervalRewardData = data.PVPVictoryIntervalRewardData or data.IntervalRewardData

	if not pvpVictoryIntervalRewardData then
		return 0
	end

	local v = 0

	for _, v2 in pairs(pvpVictoryIntervalRewardData) do
		if not (v2[p] and v < v2[p]) then
			continue
		end

		local wave = data.Waves[v2.WaveNumber]

		if wave == nil or not wave.IsSecretWave then
			v = v2[p]
		end
	end

	return v
end

function RewardsHelper.GetMaximumWaveXPReward(p)
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

return RewardsHelper