local PathUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("MapHandler"))

local function LinePoint(data, p: number, p2: number) -- 1 equivalent call inferred from this helper
	local start = data.Start
	local v = data.End
	local v2 = start.X - p
	local v3 = start.Z - p2
	local v4 = v.X - p
	local v5 = v.Z - p2
	return math.abs(math.sqrt(v2 * v2 + v3 * v3) + math.sqrt(v4 * v4 + v5 * v5) - data.XZLength) < 0.01
end

local function CirclePoint(p: number, p2: number, p3: number, p4: number, p5: number)
	local v = p4 - p
	local v2 = p5 - p2
	return v * v + v2 * v2 <= p3 * p3
end

local function CircleIntersectsLine(data, p: number, p2: number, p3: number)
	local start = data.Start
	local v = data.End
	local x = start.X
	local z = start.Z
	local x2 = v.X
	local z2 = v.Z
	local xzLength = data.XZLength
	local v2 = ((p - x) * (x2 - x) + (p2 - z) * (z2 - z)) / (xzLength * xzLength)
	local v3 = x + v2 * (x2 - x)
	local v4 = z + v2 * (z2 - z)
	local v5 = x - p
	local v6 = z - p2

	if v5 * v5 + v6 * v6 <= p3 * p3 then
		return true
	end

	local v7 = x2 - p
	local v8 = z2 - p2

	if v7 * v7 + v8 * v8 <= p3 * p3 then
		return true
	end

	if not LinePoint(data, v3, v4) then -- inferred equivalent call
		return false
	end

	local v9 = p - v3
	local v10 = p2 - v4
	return v9 * v9 + v10 * v10 <= p3 * p3
end

local function GetPercentageAlongLine(data, p: number, p2: number)
	local start = data.Start
	local v = data.End
	local x = start.X
	local z = start.Z
	local x2 = v.X
	local z2 = v.Z
	local xzLength = data.XZLength
	local v2 = ((p - x) * (x2 - x) + (p2 - z) * (z2 - z)) / (xzLength * xzLength)
	local v3 = x + v2 * (x2 - x)
	local v4 = z + v2 * (z2 - z)
	return math.sqrt((v3 - x) ^ 2 + (v4 - z) ^ 2) / xzLength
end

function PathUtilities.GetCircleLineIntersections(data, p: number, p2: number, p3: number)
	if not CircleIntersectsLine(data, p, p2, p3) then
		return nil, nil
	end

	local start = data.Start
	local v = data.End
	local x = start.X
	local y = start.Y
	local z = start.Z
	local x2 = v.X
	local y2 = v.Y
	local z2 = v.Z
	local v2 = math.min(x, x2)
	local v3 = math.min(z, z2)
	local v4 = math.max(x, x2)
	local v5 = math.max(z, z2)
	local v6 = x2 - x
	local v7 = y2 - y
	local v8 = z2 - z
	local v9 = math.abs(v6 * (p2 - z) - v8 * (p - x))
	local v10 = math.sqrt(v6 * v6 + v8 * v8)
	local v11 = v9 / v10
	local v12 = v6 / v10 * (p - x) + v8 / v10 * (p2 - z)
	local v13 = math.sqrt(p3 * p3 - v11 * v11)
	local v14 = math.clamp(x + (v12 - v13) * (v6 / v10), v2, v4)
	local v15 = math.clamp(z + (v12 - v13) * (v8 / v10), v3, v5)
	local v16 = math.clamp(x + (v12 + v13) * (v6 / v10), v2, v4)
	local v17 = math.clamp(z + (v12 + v13) * (v8 / v10), v3, v5)
	local percentageAlongLine = GetPercentageAlongLine(data, v14, v15)
	local percentageAlongLine2 = GetPercentageAlongLine(data, v16, v17)
	local v18 = y + v7 * percentageAlongLine
	local v19 = y + v7 * percentageAlongLine2
	local vector = Vector3.new(v14, v18, v15)
	local vector2 = Vector3.new(v16, v19, v17)
	return vector, vector2, {
		Start = vector,
		End = vector2,
		XZLength = math.sqrt((v16 - v14) ^ 2 + (v17 - v15) ^ 2),
		Length = (vector2 - vector).Magnitude,
		PathIndex = data.PathIndex
	}
end

function PathUtilities.GetRandomPointOnLineSegment(p)
	return p.Start:Lerp(p.End, math.random())
end

local function GetClosestPointOnLine(vector: Vector3, start: Vector3, vector2: Vector3, startIsPathEnd: boolean, endIsPathEnd: boolean)
	local x = vector.X
	local z = vector.Z
	local x2 = start.X
	local y = start.Y
	local z2 = start.Z
	local x3 = vector2.X
	local y2 = vector2.Y
	local z3 = vector2.Z
	local v = x - x2
	local v2 = z - z2
	local v3 = x3 - x2
	local v4 = z3 - z2
	local v5 = v3 ^ 2 + v4 ^ 2
	local v6 = v * v3 + v2 * v4
	local v7 = v5 == 0 and -1 or v6 / v5
	local v8 = false

	if v7 < 0 then
		if startIsPathEnd then
			z3 = z2
			y2 = y
			x3 = x2
			v8 = true
		else
			z3 = z2
			y2 = y
			x3 = x2
		end
	elseif v7 > 1 then
		if endIsPathEnd then
			v8 = true
		end
	else
		x3 = x2 + v3 * v7
		y2 = y + (y2 - y) * v7
		z3 = z2 + v4 * v7
	end

	return Vector3.new(x3, y2, z3), v8
end

function PathUtilities.GetClosestPointOnLineSegment(vector: Vector3, data)
	return GetClosestPointOnLine(vector, data.Start, data.End, data.StartIsPathEnd, data.EndIsPathEnd)
end

local function GetClosestSegment(vector: Vector3, items, _, _: Vector3?, p: number?)
	local v = 1e999
	local v2 = nil
	local v3 = nil
	local v4 = false

	for _, item in pairs(items) do
		if not (not p or item.PathIndex == p) then
			continue
		end

		local closestPointOnLineSegment, v5 = PathUtilities.GetClosestPointOnLineSegment(vector, item)
		local magnitude = (closestPointOnLineSegment - vector).Magnitude

		if not (magnitude < v) then
			continue
		end

		v4 = v5
		v3 = item
		v2 = closestPointOnLineSegment
		v = magnitude
	end

	return v2, v, v3, v4
end

function PathUtilities.GetClosestPointOnPath(vector: Vector3, items, flag: boolean?, flag2: boolean?, p: number?)
	local v, magnitude, v2, v3 = GetClosestSegment(vector, items, nil, nil, p)

	if flag2 and not v3 then
		magnitude = (vector - vector).Magnitude

		if flag then
			warn("GetPathPercentage is not supported with FreeAimForPathTargeting")
		end

		v = vector
	end

	if v2 then
		if not flag then
			return v, magnitude
		end

		local pathIndex = v2.PathIndex
		local total = 0
		local v4 = false
		local total2 = 0

		for _, item in pairs(items) do
			if item.PathIndex ~= pathIndex then
				continue
			end

			local length = item.Length
			total += length

			if v4 then
				continue
			end

			if item == v2 then
				total2 += length * GetPercentageAlongLine(v2, v.X, v.Z)
				v4 = true
			else
				total2 += length
			end
		end

		return v, magnitude, pathIndex, total2 / total
	elseif p then
		warn("Likely no path at index", p, "so defaulting to ForcePathIndex = nil")
		return PathUtilities.GetClosestPointOnPath(vector, items, flag, flag2)
	else
		warn("Closest segment not found on map", workspace:GetAttribute("MapName") or "Unknown")
		return Vector3.new(), 10000, 1, 0
	end
end

function PathUtilities.VerifyPointNearPath(vector: Vector3, p, p2: number, flag: boolean?)
	local _, v = PathUtilities.GetClosestPointOnPath(vector, p, nil, flag)
	return v <= p2
end

return PathUtilities