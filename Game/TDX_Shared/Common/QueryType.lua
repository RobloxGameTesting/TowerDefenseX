local QueryType = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local v = { "First", "Last", "Strongest", "Weakest", "Random" }
QueryType.Manual = "Manual"

function QueryType.IndexToQueryType(p: number)
	return v[p + 1]
end

function QueryType.GetQueryTypeCount()
	return #v
end

function QueryType.WithManualOption(p)
	local result = {}

	for _, v2 in ipairs(p or v) do
		table.insert(result, v2)
	end

	table.insert(result, QueryType.Manual)
	return result
end

function QueryType.GetManualOptionIndex(list)
	return list and #list or #v
end

return QueryType