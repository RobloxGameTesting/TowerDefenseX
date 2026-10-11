local TableUtilities = {}

function TableUtilities.DeepCopy(items)
	local result = {}

	for k, item in items do
		if typeof(item) == "table" then
			result[k] = TableUtilities.DeepCopy(item)
		else
			result[k] = item
		end
	end

	return result
end

function TableUtilities.Extend(p, items)
	local copy = TableUtilities.DeepCopy(p)

	for k, item in items do
		if copy[k] == nil then
			copy[k] = item
		elseif typeof(copy[k]) == "table" and typeof(item) == "table" then
			copy[k] = TableUtilities.Extend(copy[k], item)
		else
			copy[k] = item
		end
	end

	return copy
end

return TableUtilities