require(script.Parent:WaitForChild("GlobalConstants"))
local PVPAbandonment = {}
local PVP_ABANDON_WINDOW = _G.PVP_ABANDON_WINDOW
local PVP_ABANDON_MAX_TRACKED = _G.PVP_ABANDON_MAX_TRACKED
local PVP_ABANDON_QUEUE_COOLDOWNS = _G.PVP_ABANDON_QUEUE_COOLDOWNS

function PVPAbandonment.CountRecentAbandons(list, p: number?)
	if not list then
		return 0
	end

	local v = (p or os.time()) - PVP_ABANDON_WINDOW
	local count = 0

	for _, v2 in ipairs(list) do
		if v < v2 then
			count += 1
		end
	end

	return count
end

function PVPAbandonment.RecordAbandon(options, p: number?)
	local v = p or os.time()
	local v2 = v - PVP_ABANDON_WINDOW
	local result = {}

	for _, v3 in ipairs(options or {}) do
		if v2 < v3 then
			table.insert(result, v3)
		end
	end

	table.insert(result, v)

	while true do
		if not (PVP_ABANDON_MAX_TRACKED < #result) then
			break
		end

		table.remove(result, 1)
	end

	return result
end

function PVPAbandonment.UndoAbandon(options, p: number)
	local v = false
	local result = {}

	for _, v2 in ipairs(options or {}) do
		if v or v2 ~= p then
			table.insert(result, v2)
		else
			v = true
		end
	end

	return result
end

function PVPAbandonment.GetQueueCooldownExpiry(list, p: number?)
	local countRecentAbandons = PVPAbandonment.CountRecentAbandons(list, p)

	if countRecentAbandons == 0 then
		return 0
	end

	local v = PVP_ABANDON_QUEUE_COOLDOWNS[math.min(countRecentAbandons, #PVP_ABANDON_QUEUE_COOLDOWNS)]
	return list[#list] + v
end

function PVPAbandonment.GetRemainingQueueCooldown(p, p2: number?)
	local v = p2 or os.time()
	return (math.max(0, PVPAbandonment.GetQueueCooldownExpiry(p, v) - v))
end

return PVPAbandonment