local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Shared = require(TDX_Shared:WaitForChild("Modules").Shared)
require(TDX_Shared:WaitForChild("Common").Types)
require(TDX_Shared:WaitForChild("Modules").DataTemplate)
local modulesByName = {}

for _, moduleScript in script:GetChildren() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	local name = moduleScript.Name
	local module = require(moduleScript)
	modulesByName[name] = module
end

local Quests = {}

function Quests.GetQuestDefinition(p: string, p2: string)
	assert(modulesByName[p] ~= nil, "Quest category does not exist")
	return modulesByName[p][p2]
end

function Quests.GetRandomQuests(p: string, p2: number, p3: number)
	assert(modulesByName[p] ~= nil, "Quest category does not exist")
	assert(p2 > 0, "Count must be greater than 0")
	local v = {}

	for k, v2 in modulesByName[p] do
		local levelRequirement = v2.LevelRequirement

		if not levelRequirement or levelRequirement and levelRequirement.Min <= p3 and p3 <= levelRequirement.Max then
			table.insert(v, k)
		end
	end

	local result = {}
	local count = #v

	if count < p2 then
		warn(`Could not find {p2} valid {p} quests!`)
		return {}
	end

	for _ = 1, p2 do
		local v2 = table.remove(v, math.random(1, count))
		count -= 1
		local v3 = modulesByName[p][v2]
		result[v2] = {
			Progress = 0,
			QuestType = v3.QuestType,
			Identifier = v3.Identifier,
			MaxProgress = v3.ProgressRequired
		}
	end

	return result
end

function Quests.GetWeeklyRefreshProductId(p: number)
	if p <= 29 then
		return Shared.QUESTS_REFRESH_WEEKLY_0_TO_29_PRODUCT_ID
	end

	if p <= 59 then
		return Shared.QUESTS_REFRESH_WEEKLY_30_TO_59_PRODUCT_ID
	end

	if p <= 89 then
		return Shared.QUESTS_REFRESH_WEEKLY_60_TO_89_PRODUCT_ID
	end

	return Shared.QUESTS_REFRESH_WEEKLY_90_PLUS_PRODUCT_ID
end

function Quests.CalculateDailyQuestRewardMultiplier(p: number)
	if p <= 0 then
		return 1
	end

	return (math.min(1.25, (p + 6) // 7 / 100 + 1))
end

return Quests