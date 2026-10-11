local Players = game:GetService("Players")
local nameFromUserIdAsyncs = {}
return {
	GetNameFromUserId = function(p)
		if tonumber(p) and tonumber(p) < 0 then
			return "_TEST_" .. tostring((math.abs(p)))
		end

		local v = nameFromUserIdAsyncs[p]

		if v then
			return v
		end

		local nameFromUserIdAsync = nil
		local success, _ = pcall(function()
			nameFromUserIdAsync = Players:GetNameFromUserIdAsync(p)
		end)

		if not success then
			return "Loading..."
		end

		nameFromUserIdAsyncs[p] = nameFromUserIdAsync
		return nameFromUserIdAsync
	end
}