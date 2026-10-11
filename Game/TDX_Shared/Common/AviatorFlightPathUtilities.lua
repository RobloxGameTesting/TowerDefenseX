local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local Circle = Enums.AviatorFlightModes.Circle
local Figure8 = Enums.AviatorFlightModes.Figure8

local function Speed(p: number) -- 3 equivalent calls inferred from this helper
	local v = -math.sin(p)
	local v2 = math.cos(p * 2)
	return (math.sqrt(v * v + v2 * v2))
end

local v = { [0] = 0 }
local v2 = {}
local AviatorFlightPathUtilities = {}

for i = 1, 2048 do
	local v3 = (i - 1) * 0.0007669903939428206
	local v4 = i * 0.0007669903939428206
	local v5 = v[i - 1]
	local speed = Speed(v3) -- inferred equivalent call
	v[i] = v5 + 0.00012783173232380342 * (speed + Speed((v3 + v4) / 2) * 4 + Speed(v4)) -- inferred equivalent call
end

local v3 = v[2048]
local v4 = v3 * 4
local v5 = 1

for i = 0, 256 do
	local v6 = v3 * i / 256

	while v5 < 2048 and v[v5] < v6 do
		v5 += 1
	end

	local v7 = v[v5 - 1]
	local v8 = v[v5]
	local v9 = not (v7 < v8) and 0 or math.clamp((v6 - v7) / (v8 - v7), 0, 1)
	v2[i + 1] = (v5 - 1 + v9) * 0.0007669903939428206
end

v2[1] = 0
v2[257] = 1.5707963267948966

local function LookupQuarterT(value: number) -- 4 equivalent calls inferred from this helper
	local v6 = math.clamp(value, 0, 1) * 256
	local v7 = math.min(math.floor(v6), 255)
	local v8 = v6 - v7
	local v9 = v2[v7 + 1]
	return v9 + (v2[v7 + 2] - v9) * v8
end

local function GetFigure8T(p: number)
	local v6 = p % 1 * 4
	local v7 = math.min(math.floor(v6), 3)
	local v8 = v6 - v7

	if v7 == 0 then
		return LookupQuarterT(v8) -- inferred equivalent call
	elseif v7 == 1 then
		return 3.141592653589793 - LookupQuarterT(1 - v8) -- inferred equivalent call
	elseif v7 == 2 then
		return 3.141592653589793 + LookupQuarterT(v8) -- inferred equivalent call
	else
		return 6.283185307179586 - LookupQuarterT(1 - v8) -- inferred equivalent call
	end
end

function AviatorFlightPathUtilities.GetPathLength(p: string, p2: number)
	if p == Figure8 then
		return v4 * p2
	end

	return 6.283185307179586 * p2
end

function AviatorFlightPathUtilities.GetOffsetXZ(p: string, p2: number, p3: number)
	if p == Figure8 then
		local figure8T = GetFigure8T(p2)
		return math.cos(figure8T) * p3, math.sin(figure8T * 2) * p3 / 2
	end

	local v6 = 6.283185307179586 * p2
	return math.cos(v6) * p3, math.sin(v6) * p3
end

function AviatorFlightPathUtilities.GetTravelDirection(data)
	local v6, v7

	if data.Path == Figure8 then
		local figure8T = GetFigure8T(data.U)
		v6 = -math.sin(figure8T)
		v7 = math.cos(figure8T * 2)
	else
		local v8 = 6.283185307179586 * data.U
		v6 = -math.sin(v8)
		v7 = math.cos(v8)
	end

	return Vector3.new(v6, 0, v7).Unit * data.Sign
end

function AviatorFlightPathUtilities.GetNormalizedTurn(data)
	local v6

	if data.Path == Figure8 then
		local figure8T = GetFigure8T(data.U)
		local v7 = math.sin(figure8T)
		local v8 = math.cos(figure8T)
		local v9 = math.sin(figure8T * 2)
		local v10 = math.cos(figure8T * 2)
		local v11 = v7 * v7 + v10 * v10
		v6 = (v7 * 2 * v9 + v10 * v8) / v11 ^ 1.5
	else
		v6 = 1
	end

	return -data.Sign * v6
end

function AviatorFlightPathUtilities.GetUToNextJunction(p: number, p2: number)
	if p2 > 0 then
		return (math.floor(p * 2) + 1) / 2 - p
	end

	return p - (math.ceil(p * 2) - 1) / 2
end

function AviatorFlightPathUtilities:Advance(p: number, p2: number)
	while p > 0 do
		local pathLength = AviatorFlightPathUtilities.GetPathLength(self.Path, p2)
		local v6 = p / pathLength

		if self.Mode == self.Path then
			self.U = (self.U + self.Sign * v6) % 1
			p = 0
		else
			local uToNextJunction = AviatorFlightPathUtilities.GetUToNextJunction(self.U, self.Sign)

			if uToNextJunction <= v6 then
				p -= uToNextJunction * pathLength
				local v7 = math.round((self.U + self.Sign * uToNextJunction) * 2) / 2 % 1

				if v7 == 0.5 then
					self.Sign = -self.Sign
				end

				self.U = v7
				self.Path = self.Mode
			else
				self.U = (self.U + self.Sign * v6) % 1
				p = 0
			end
		end
	end
end

function AviatorFlightPathUtilities.CopyState(data)
	return { Path = data.Path, Mode = data.Mode, U = data.U, Sign = data.Sign }
end

function AviatorFlightPathUtilities.EncodeFlags(data)
	local total = 0

	if data.Path == Figure8 then
		total += 1
	end

	if data.Mode == Figure8 then
		total += 2
	end

	if data.Sign > 0 then
		total += 4
	end

	return total
end

function AviatorFlightPathUtilities.DecodeState(p: number, p2: number)
	local path

	if bit32.band(p, 1) == 0 then
		path = Circle
	else
		path = Figure8
	end

	local mode

	if bit32.band(p, 2) == 0 then
		mode = Circle
	else
		mode = Figure8
	end

	return {
		Path = path,
		Mode = mode,
		U = p2,
		Sign = bit32.band(p, 4) == 0 and -1 or 1
	}
end

return AviatorFlightPathUtilities