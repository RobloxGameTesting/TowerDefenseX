game:GetService("RunService")
game:GetService("Players")
local BattlePass = {}
require(game.ReplicatedStorage.TDX_Shared.Common.Types)
local modulesByName = {}

function BattlePass.GetCurrentPass(_: number?)
	if _G.TB2_EVENT_ENABLED then
		return "TB2"
	end

	return nil
end

function BattlePass.GetPassData(p: string)
	if p == "TB2" and not _G.TB2_EVENT_ENABLED then
		return nil
	end

	return modulesByName[p]
end

function BattlePass.GetAllPasses()
	local result = {}

	for k, v in modulesByName do
		if k ~= "TB2" or _G.TB2_EVENT_ENABLED then
			result[k] = v
		end
	end

	return result
end

function BattlePass.GetPassProgress(p: string, p2: number, flag: boolean?)
	local passData = BattlePass.GetPassData(p)

	if not passData then
		return nil
	end

	local v = 1

	for _, tier in passData.Tiers do
		local originalTokensNeeded = flag and tier.OriginalTokensNeeded or tier.TokensNeeded

		if originalTokensNeeded <= p2 then
			p2 -= originalTokensNeeded
			v += 1
		else
			return v, p2, originalTokensNeeded
		end
	end

	return v, 99999, 99999
end

function BattlePass.GetTotalTokensNeeded(p: string)
	local total = 0

	for _, tier in BattlePass.GetPassData(p).Tiers do
		total += tier.TokensNeeded
	end

	return total
end

function BattlePass.CalculateTokensForChangedTiers(p: string, p2: number)
	local passData = BattlePass.GetPassData(p)

	if not passData then
		return 0
	end

	local passProgress, v, v2 = BattlePass.GetPassProgress(p, p2, true)

	if v == 99999 and v2 == 99999 then
		return p2
	end

	for i = 1, passProgress - 1 do
		local tier = passData.Tiers[i]

		if not tier.OriginalTokensNeeded then
			continue
		end

		local v3 = tier.OriginalTokensNeeded - tier.TokensNeeded
		p2 -= v3
		print(`Reducing tokens for {p} by {v3} for tier {i} (original = {tier.OriginalTokensNeeded}, new = {tier.TokensNeeded})`)
	end

	local tier = passData.Tiers[passProgress]

	if tier and tier.OriginalTokensNeeded then
		local v3 = v / tier.OriginalTokensNeeded
		local v4 = v - math.floor(v3 * tier.TokensNeeded)
		p2 -= v4
		print(`Reducing tokens for {p} by {v4} for current tier {passProgress} (progress = {v3})`)
	end

	return p2
end

for _, moduleScript in script.Passes:GetChildren() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	local name = moduleScript.Name
	local module = require(moduleScript)
	modulesByName[name] = module
end

table.freeze(modulesByName)
return BattlePass