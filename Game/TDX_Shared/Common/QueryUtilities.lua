local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))

local function DefaultRangeQuery(items, p, p2)
	local x = p.X
	local z = p.Z
	local v = p2 * p2
	local count = 0
	local result = {}

	for _, item in pairs(items) do
		local v2 = item.X - x
		local v3 = item.Z - z

		if not (v2 * v2 + v3 * v3 <= v) then
			continue
		end

		count += 1
		result[count] = item
	end

	return result, count
end

local function VisualizeClusters(items)
	for _, list in pairs(items) do
		local color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))

		for _, v in ipairs(list) do
			local partAtPosition = Utilities.PartAtPosition(
				Vector3.new(v.X, MapHandler.GetRangeDisplayHeight(), v.Z),
				color,
				3
			)
			partAtPosition.Size = createVector(0.25, 20, 0.25)
		end
	end
end

local QueryUtilities = {}

function QueryUtilities.DBScan(items, value: number?, value2: number?, p)
	local v = p or DefaultRangeQuery
	local v2 = {}
	local v3 = value or 6
	local v4 = value2 or 1
	local v5 = {}
	local result = {}

	for _, item in pairs(items) do
		if v2[item] then
			continue
		end

		local v6, v7 = v(items, item, v3)
		v2[item] = true

		if not (v4 <= v7) then
			continue
		end

		local v8 = {}

		for _, v9 in ipairs(v6) do
			if not v2[v9] then
				local v10, v11 = v(items, v9, v3)
				v2[v9] = true

				if v4 <= v11 then
					for _, v12 in ipairs(v10) do
						table.insert(v6, v12)
					end
				end
			end

			if v5[v9] then
				continue
			end

			table.insert(v8, v9)
			v5[v9] = true
		end

		table.insert(result, v8)
	end

	return result
end

function QueryUtilities.GetClusterCenter(list)
	local v = 1e999
	local v2 = -1e999
	local v3 = 1e999
	local v4 = -1e999

	for _, v5 in ipairs(list) do
		local x = v5.X
		local z = v5.Z

		if x < v then
			v = x
		end

		if v2 < x then
			v2 = x
		end

		if z < v3 then
			v3 = z
		end

		if v4 < z then
			v4 = z
		end
	end

	local midpoint = (v2 + v) / 2
	local midpoint2 = (v4 + v3) / 2
	return (Vector3.new(midpoint, MapHandler.GetRangeDisplayHeight(), midpoint2))
end

return QueryUtilities