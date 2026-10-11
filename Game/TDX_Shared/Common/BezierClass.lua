local BezierClass = {}
BezierClass.__index = BezierClass

local function Evaluate(vector: Vector3, vector2: Vector3, vector3: Vector3, vector4: Vector3, p: number) -- 2 equivalent calls inferred from this helper
	local v = 1 - p
	local v2 = p * p
	local v3 = v * v
	return v3 * v * vector + v3 * 3 * p * vector2 + v * 3 * v2 * vector3 + v2 * p * vector4
end

local function Derivative(vector: Vector3, vector2: Vector3, vector3: Vector3, vector4: Vector3, p: number) -- 1 equivalent call inferred from this helper
	local v = 1 - p
	return v * 3 * v * (vector2 - vector) + v * 6 * p * (vector3 - vector2) + p * 3 * p * (vector4 - vector3)
end

local function Speed(vector: Vector3, vector2: Vector3, vector3: Vector3, vector4: Vector3, p: number) -- 2 equivalent calls inferred from this helper
	local v = 1 - p
	return (v * 3 * v * (vector2 - vector) + v * 6 * p * (vector3 - vector2) + p * 3 * p * (vector4 - vector3)).Magnitude
end

local function Integrate(vector: Vector3, vector2: Vector3, vector3: Vector3, vector4: Vector3, p: number, p2: number, p3: number)
	local v = (p2 - p) / p3
	local total = 0

	for i = 0, p3 do
		local v2 = p + i * v
		total += ((i == 0 or i == p3) and 1 or i % 2 == 0 and 2 or 4) * Speed(vector, vector2, vector3, vector4, v2) -- inferred equivalent call
	end

	return total * v / 3
end

local function BuildArcTable(vector: Vector3, vector2: Vector3, vector3: Vector3, vector4: Vector3, p: number)
	local result = table.create(p + 1)
	result[1] = { T = 0, S = 0 }
	local v = 0
	local total = 0

	for i = 1, p do
		local v2 = i / p
		total += Integrate(vector, vector2, vector3, vector4, v, v2, 4)
		result[i + 1] = { T = v2, S = total }
		v = v2
	end

	for i = 1, #result do
		result[i].S /= total
	end

	return result, total
end

local function FindTFromArc(arcTable, p: number)
	local count = #arcTable
	local v = 1

	while v <= count do
		local v2 = math.floor((v + count) / 2)

		if arcTable[v2].S < p then
			v = v2 + 1
		else
			count = v2 - 1
		end
	end

	local v2 = math.max(1, count)
	local v3 = arcTable[v2]
	local v4 = arcTable[v2 + 1]

	if not v4 then
		return v3.T
	end

	local v5 = (p - v3.S) / (v4.S - v3.S)
	return v3.T + v5 * (v4.T - v3.T)
end

local function RefineT(vector: Vector3, vector2: Vector3, vector3: Vector3, vector4: Vector3, p: number, p2: number, totalLength: number)
	for _ = 1, 3 do
		local v = Integrate(vector, vector2, vector3, vector4, 0, p, 8) / totalLength
		local vector5 = Speed(vector, vector2, vector3, vector4, p) -- inferred equivalent call

		if vector5 == 0 then
			break
		else
			p = math.clamp(p - (v - p2) / (vector5 / totalLength), 0, 1)
		end
	end

	return p
end

function BezierClass.New(vector: Vector3, vector2: Vector3, vector3: Vector3, vector4: Vector3, value: number?)
	local arcTable, totalLength = BuildArcTable(vector, vector2, vector3, vector4, value or 50)
	return (setmetatable({
		P0 = vector,
		P1 = vector2,
		P2 = vector3,
		P3 = vector4,
		ArcTable = arcTable,
		TotalLength = totalLength
	}, BezierClass))
end

function BezierClass.GetPointAt(data, p: number, flag: boolean?)
	local tFromArc = FindTFromArc(data.ArcTable, p)
	local p0 = data.P0
	local p1 = data.P1
	local p2 = data.P2
	local p3 = data.P3

	if flag then
		tFromArc = RefineT(p0, p1, p2, p3, tFromArc, p, data.TotalLength)
	end

	return Evaluate(p0, p1, p2, p3, tFromArc) -- inferred equivalent call
end

function BezierClass.GetCFrameAt(data, p: number, flag: boolean?)
	local tFromArc = FindTFromArc(data.ArcTable, p)
	local p0 = data.P0
	local p1 = data.P1
	local p2 = data.P2
	local p3 = data.P3

	if flag then
		tFromArc = RefineT(p0, p1, p2, p3, tFromArc, p, data.TotalLength)
	end

	local evaluate = Evaluate(p0, p1, p2, p3, tFromArc) -- inferred equivalent call
	local unit = Derivative(p0, p1, p2, p3, tFromArc).Unit -- inferred equivalent call
	return CFrame.lookAt(evaluate, evaluate + unit)
end

return BezierClass