local RewindHelper = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("WaveTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local MapDifficultyRewardsData = require(common:WaitForChild("MapDifficultyRewardsData"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))

function RewindHelper.GetRewindData(p: string, p2: string, p3: number)
	local waveConfig = ResourceManager.GetWaveConfig(p)

	if not waveConfig then
		warn("RewindHelper.GetRewindData - WaveConfig not found for difficulty", p)
		return
	end

	local goldMultiplier = MapDifficultyRewardsData.GetGoldMultiplier(p2)

	if not goldMultiplier then
		warn("RewindHelper.GetRewindData - GoldMultiplier not found for map difficulty", p2)
		return
	end

	local rewindProductIntervalMap = waveConfig.RewindProductIntervalMap

	if not rewindProductIntervalMap then
		return
	end

	local v = rewindProductIntervalMap[1]

	for _, v2 in ipairs(rewindProductIntervalMap) do
		if v2.WaveNumber <= p3 then
			v = v2
		else
			break
		end
	end

	local robuxProductId = v.RobuxProductId
	local costRobux = robuxProductId and RewindProducts.ProductToRobuxCostMap[robuxProductId]

	if robuxProductId and not costRobux then
		warn("RewindHelper.GetRewindData - CostRobux not found for RobuxProductId", v.RobuxProductId)
	else
		local costGold = v.CostGold and math.ceil(v.CostGold * goldMultiplier)
		return {
			GainCash = v.GainCash,
			GainHP = v.GainHP,
			CostRobux = costRobux,
			CostGold = costGold,
			ProductId = v.RobuxProductId
		}
	end
end

function RewindHelper.GetAllRewindProductIds()
	return RewindProducts.RobuxProducts
end

return RewindHelper