local function linear(p, p2, p3, p4)
	return p3 * p / p4 + p2
end

local function constant(p, _, _, p2)
	if p == p2 then
		return 1
	end

	return 0
end

local function inSine(p, p2, p3, p4) -- 2 equivalent calls inferred from this helper
	return -p3 * math.cos(p / p4 * 1.5707963267948966) + p3 + p2
end

local function outSine(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * math.sin(p / p4 * 1.5707963267948966) + p2
end

local function inOutSine(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	return -p3 / 2 * (math.cos(3.141592653589793 * p / p4) - 1) + p2
end

local function outInSine(p, p2, p3, p4)
	if p < p4 / 2 then
		return outSine(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	end

	return inSine(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
end

local function inQuad(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * math.pow(p / p4, 2) + p2
end

local function outQuad(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	local v = p / p4
	return -p3 * v * (v - 2) + p2
end

local function inOutQuad(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * math.pow(v, 2) + p2
	end

	return -p3 / 2 * ((v - 1) * (v - 3) - 1) + p2
end

local function outInQuad(p, p2, p3, p4)
	if p < p4 / 2 then
		return outQuad(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	else
		return inQuad(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
	end
end

local function inCubic(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * math.pow(p / p4, 3) + p2
end

local function outCubic(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * (math.pow(p / p4 - 1, 3) + 1) + p2
end

local function inOutCubic(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * v * v * v + p2
	end

	local v2 = v - 2
	return p3 / 2 * (v2 * v2 * v2 + 2) + p2
end

local function outInCubic(p, p2, p3, p4)
	if p < p4 / 2 then
		return outCubic(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	end

	return inCubic(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
end

local function inQuart(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * math.pow(p / p4, 4) + p2
end

local function outQuart(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	local v = p / p4 - 1
	return -p3 * (math.pow(v, 4) - 1) + p2
end

local function inOutQuart(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * math.pow(v, 4) + p2
	end

	local v2 = v - 2
	return -p3 / 2 * (math.pow(v2, 4) - 2) + p2
end

local function outInQuart(p, p2, p3, p4)
	if p < p4 / 2 then
		return outQuart(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	else
		return inQuart(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
	end
end

local function inQuint(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * math.pow(p / p4, 5) + p2
end

local function outQuint(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * (math.pow(p / p4 - 1, 5) + 1) + p2
end

local function inOutQuint(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * math.pow(v, 5) + p2
	end

	local v2 = v - 2
	return p3 / 2 * (math.pow(v2, 5) + 2) + p2
end

local function outInQuint(p, p2, p3, p4)
	if p < p4 / 2 then
		return outQuint(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	end

	return inQuint(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
end

local function inSextic(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * math.pow(p / p4, 6) + p2
end

local function outSextic(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	local v = p / p4 - 1
	return -p3 * (math.pow(v, 6) - 1) + p2
end

local function inOutSextic(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * math.pow(v, 6) + p2
	end

	local v2 = v - 2
	return -p3 / 2 * (math.pow(v2, 6) - 2) + p2
end

local function outInSextic(p, p2, p3, p4)
	if p < p4 / 2 then
		return outSextic(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	else
		return inSextic(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
	end
end

local function inExpo(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	if p == 0 then
		return p2
	end

	return p3 * math.pow(2, 10 * (p / p4 - 1)) + p2 - p3 * 0.001
end

local function outExpo(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	if p == p4 then
		return p2 + p3
	end

	return p3 * 1.001 * (-math.pow(2, -10 * p / p4) + 1) + p2
end

local function inOutExpo(p, p2, p3, p4)
	if p == 0 then
		return p2
	end

	if p == p4 then
		return p2 + p3
	end

	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * math.pow(2, 10 * (v - 1)) + p2 - p3 * 0.0005
	end

	local v2 = v - 1
	return p3 / 2 * 1.0005 * (-math.pow(2, -10 * v2) + 2) + p2
end

local function outInExpo(p, p2, p3, p4)
	if p < p4 / 2 then
		return outExpo(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	else
		return inExpo(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
	end
end

local function inCirc(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	local v = p / p4
	return -p3 * (math.sqrt(1 - math.pow(v, 2)) - 1) + p2
end

local function outCirc(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 * math.sqrt(1 - math.pow(p / p4 - 1, 2)) + p2
end

local function inOutCirc(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return -p3 / 2 * (math.sqrt(1 - v * v) - 1) + p2
	end

	local v2 = v - 2
	return p3 / 2 * (math.sqrt(1 - v2 * v2) + 1) + p2
end

local function outInCirc(p, p2, p3, p4)
	if p < p4 / 2 then
		return outCirc(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	end

	return inCirc(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
end

local function inBack(p, p2, p3, p4, value) -- 1 equivalent call inferred from this helper
	local v = value or 1.70158
	local v2 = p / p4
	return p3 * v2 * v2 * ((v + 1) * v2 - v) + p2
end

local function outBack(p, p2, p3, p4, value) -- 1 equivalent call inferred from this helper
	local v = value or 1.70158
	local v2 = p / p4 - 1
	return p3 * (v2 * v2 * ((v + 1) * v2 + v) + 1) + p2
end

local function inOutBack(p, p2, p3, p4, value)
	local v = (value or 1.70158) * 1.525
	local v2 = p / p4 * 2

	if v2 < 1 then
		return p3 / 2 * (v2 * v2 * ((v + 1) * v2 - v)) + p2
	end

	local v3 = v2 - 2
	return p3 / 2 * (v3 * v3 * ((v + 1) * v3 + v) + 2) + p2
end

local function outInBack(p, p2, p3, p4, value)
	if p < p4 / 2 then
		return outBack(p * 2, p2, p3 / 2, p4, value) -- inferred equivalent call
	else
		return inBack(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4, value) -- inferred equivalent call
	end
end

local function outBounce(p, p2, p3, p4)
	local v = p / p4

	if v < 4 / 11 then
		return p3 * (7.5625 * v * v) + p2
	end

	if v < 8 / 11 then
		local v2 = v - 6 / 11
		return p3 * (7.5625 * v2 * v2 + 0.75) + p2
	end

	if v < 10 / 11 then
		local v2 = v - 9 / 11
		return p3 * (7.5625 * v2 * v2 + 0.9375) + p2
	end

	local v2 = v - 21 / 22
	return p3 * (7.5625 * v2 * v2 + 0.984375) + p2
end

local function inBounce(p, p2, p3, p4) -- 3 equivalent calls inferred from this helper
	return p3 - outBounce(p4 - p, 0, p3, p4) + p2
end

local function inOutBounce(p, p2, p3, p4)
	if p < p4 / 2 then
		return inBounce(p * 2, 0, p3, p4) * 0.5 + p2 -- inferred equivalent call
	else
		return outBounce(p * 2 - p4, 0, p3, p4) * 0.5 + p3 * 0.5 + p2
	end
end

local function outInBounce(p, p2, p3, p4)
	if p < p4 / 2 then
		return (outBounce(p * 2, p2, p3 / 2, p4))
	end

	return inBounce(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
end

local EasingFunctions = {
	Linear = function(p)
		return 1 * p / 1 + 0
	end,
	Constant = function(p)
		if p == 1 then
			return 1
		end

		return 0
	end,
	SineIn = function(p)
		return inSine(p, 0, 1, 1) -- inferred equivalent call
	end,
	SineOut = function(p)
		return outSine(p, 0, 1, 1) -- inferred equivalent call
	end,
	SineInOut = function(p)
		return inOutSine(p, 0, 1, 1) -- inferred equivalent call
	end,
	SineOutIn = function(p)
		if p < 0.5 then
			return outSine(p * 2, 0, 0.5, 1) -- inferred equivalent call
		end

		return -0.5 * math.cos((p * 2 - 1) / 1 * 1.5707963267948966) + 0.5 + 0.5
	end,
	QuadIn = function(p)
		return inQuad(p, 0, 1, 1) -- inferred equivalent call
	end,
	QuadOut = function(p)
		local v = p / 1
		return -1 * v * (v - 2) + 0
	end,
	QuadInOut = function(p)
		local v = p / 1 * 2

		if v < 1 then
			return 0.5 * math.pow(v, 2) + 0
		end

		return -0.5 * ((v - 1) * (v - 3) - 1) + 0
	end,
	QuadOutIn = function(p)
		if p < 0.5 then
			local v = p * 2 / 1
			return -0.5 * v * (v - 2) + 0
		else
			return inQuad(p * 2 - 1, 0.5, 0.5, 1) -- inferred equivalent call
		end
	end,
	CubicIn = function(p)
		return inCubic(p, 0, 1, 1) -- inferred equivalent call
	end,
	CubicOut = function(p)
		return outCubic(p, 0, 1, 1) -- inferred equivalent call
	end,
	CubicInOut = function(p)
		local v = p / 1 * 2

		if v < 1 then
			return 0.5 * v * v * v + 0
		end

		local v2 = v - 2
		return 0.5 * (v2 * v2 * v2 + 2) + 0
	end,
	CubicOutIn = function(p)
		if p < 0.5 then
			return outCubic(p * 2, 0, 0.5, 1) -- inferred equivalent call
		end

		return inCubic(p * 2 - 1, 0.5, 0.5, 1) -- inferred equivalent call
	end,
	QuartIn = function(p)
		return inQuart(p, 0, 1, 1) -- inferred equivalent call
	end,
	QuartOut = function(p)
		return -1 * (math.pow(p / 1 - 1, 4) - 1) + 0
	end,
	QuartInOut = function(p)
		local v = p / 1 * 2

		if v < 1 then
			return 0.5 * math.pow(v, 4) + 0
		end

		return -0.5 * (math.pow(v - 2, 4) - 2) + 0
	end,
	QuartOutIn = function(p)
		if p < 0.5 then
			return -0.5 * (math.pow(p * 2 / 1 - 1, 4) - 1) + 0
		end

		return inQuart(p * 2 - 1, 0.5, 0.5, 1) -- inferred equivalent call
	end,
	QuintIn = function(p)
		return inQuint(p, 0, 1, 1) -- inferred equivalent call
	end,
	QuintOut = function(p)
		return outQuint(p, 0, 1, 1) -- inferred equivalent call
	end,
	QuintInOut = function(p)
		local v = p / 1 * 2

		if v < 1 then
			return 0.5 * math.pow(v, 5) + 0
		end

		return 0.5 * (math.pow(v - 2, 5) + 2) + 0
	end,
	QuintOutIn = function(p)
		if p < 0.5 then
			return outQuint(p * 2, 0, 0.5, 1) -- inferred equivalent call
		end

		return inQuint(p * 2 - 1, 0.5, 0.5, 1) -- inferred equivalent call
	end,
	SexticIn = function(p)
		return inSextic(p, 0, 1, 1) -- inferred equivalent call
	end,
	SexticOut = function(p)
		return -1 * (math.pow(p / 1 - 1, 6) - 1) + 0
	end,
	SexticInOut = function(p)
		local v = p / 1 * 2

		if v < 1 then
			return 0.5 * math.pow(v, 6) + 0
		end

		return -0.5 * (math.pow(v - 2, 6) - 2) + 0
	end,
	SexticOutIn = function(p)
		if p < 0.5 then
			return -0.5 * (math.pow(p * 2 / 1 - 1, 6) - 1) + 0
		end

		return inSextic(p * 2 - 1, 0.5, 0.5, 1) -- inferred equivalent call
	end,
	ExpoIn = function(p)
		if p == 0 then
			return 0
		end

		return 1 * math.pow(2, 10 * (p / 1 - 1)) + 0 - 0.001
	end,
	ExpoOut = function(p)
		if p == 1 then
			return 1
		end

		return 1.001 * (-math.pow(2, -10 * p / 1) + 1) + 0
	end,
	ExpoInOut = function(p)
		if p == 0 then
			return 0
		elseif p == 1 then
			return 1
		end

		local v = p / 1 * 2

		if v < 1 then
			return 0.5 * math.pow(2, 10 * (v - 1)) + 0 - 0.0005
		end

		return 0.50025 * (-math.pow(2, -10 * (v - 1)) + 2) + 0
	end,
	ExpoOutIn = function(p)
		if p < 0.5 then
			local v = p * 2

			if v == 1 then
				return 0.5
			end

			return 0.5005 * (-math.pow(2, -10 * v / 1) + 1) + 0
		else
			local v = p * 2 - 1

			if v == 0 then
				return 0.5
			end

			return 0.5 * math.pow(2, 10 * (v / 1 - 1)) + 0.5 - 0.0005
		end
	end,
	CircIn = function(p)
		return -1 * (math.sqrt(1 - math.pow(p / 1, 2)) - 1) + 0
	end,
	CircOut = function(p)
		return outCirc(p, 0, 1, 1) -- inferred equivalent call
	end,
	CircInOut = function(p)
		local v = p / 1 * 2

		if v < 1 then
			return -0.5 * (math.sqrt(1 - v * v) - 1) + 0
		end

		local v2 = v - 2
		return 0.5 * (math.sqrt(1 - v2 * v2) + 1) + 0
	end,
	CircOutIn = function(p)
		if p < 0.5 then
			return outCirc(p * 2, 0, 0.5, 1) -- inferred equivalent call
		end

		return -0.5 * (math.sqrt(1 - math.pow((p * 2 - 1) / 1, 2)) - 1) + 0.5
	end,
	BackIn = function(p, value)
		local v = value or 1.70158
		local v2 = p / 1
		return 1 * v2 * v2 * ((v + 1) * v2 - v) + 0
	end,
	BackOut = function(p, value)
		local v = value or 1.70158
		local v2 = p / 1 - 1
		return 1 * (v2 * v2 * ((v + 1) * v2 + v) + 1) + 0
	end,
	BackInOut = function(p, value)
		local v = (value or 1.70158) * 1.525
		local v2 = p / 1 * 2

		if v2 < 1 then
			return 0.5 * (v2 * v2 * ((v + 1) * v2 - v)) + 0
		end

		local v3 = v2 - 2
		return 0.5 * (v3 * v3 * ((v + 1) * v3 + v) + 2) + 0
	end,
	BackOutIn = function(p, value)
		if p < 0.5 then
			local v = value or 1.70158
			local v2 = p * 2 / 1 - 1
			return 0.5 * (v2 * v2 * ((v + 1) * v2 + v) + 1) + 0
		else
			local v = value or 1.70158
			local v2 = (p * 2 - 1) / 1
			return 0.5 * v2 * v2 * ((v + 1) * v2 - v) + 0.5
		end
	end,
	BounceIn = function(p)
		return inBounce(p, 0, 1, 1) -- inferred equivalent call
	end,
	BounceOut = function(p)
		return (outBounce(p, 0, 1, 1))
	end,
	BounceInOut = function(p)
		if p < 0.5 then
			return (1 - outBounce(1 - p * 2, 0, 1, 1) + 0) * 0.5 + 0
		else
			return outBounce(p * 2 - 1, 0, 1, 1) * 0.5 + 0.5 + 0
		end
	end,
	BounceOutIn = function(p)
		if p < 0.5 then
			return (outBounce(p * 2, 0, 0.5, 1))
		end

		return 0.5 - outBounce(1 - (p * 2 - 1), 0, 0.5, 1) + 0.5
	end
}

local function elastic_blend(p, p2, p3, p4, p5, p6)
	if p2 == 0 then
		return p6
	end

	local v = math.abs(p5)
	p6 = p4 == 0 and 0 or p6 * (p4 / math.abs(p2))

	if math.abs(p * p3) < v then
		local v2 = math.abs(p * p3) / v
		p6 = p6 * v2 + (1 - v2)
	end

	return p6
end

local function inElastic(p, p2, p3, p4, p5, p6)
	local v = 1

	if p == 0 then
		return p2
	end

	local v2 = p / p4

	if v2 == 1 then
		return p2 + p3
	end

	local v3 = v2 - 1

	if not p6 or p6 == 0 then
		p6 = p4 * 0.3
	end

	local v4

	if p5 and not (p5 < math.abs(p3)) then
		v4 = p6 / 6.283185307179586 * math.asin(p3 / p5)
	else
		v4 = p6 / 4

		if p3 ~= 0 then
			local v5 = math.abs(v4)
			v = p5 == 0 and 0 or v * (p5 / math.abs(p3))

			if math.abs(v3 * p4) < v5 then
				local v6 = math.abs(v3 * p4) / v5
				v = v * v6 + (1 - v6)
			end
		end

		p5 = p3
	end

	return -v * (p5 * math.pow(2, 10 * v3) * math.sin((v3 * p4 - v4) * 6.283185307179586 / p6)) + p2
end

local function outElastic(p, p2, p3, p4, p5, p6)
	local v = 1

	if p == 0 then
		return p2
	end

	local v2 = p / p4

	if v2 == 1 then
		return p2 + p3
	end

	local v3 = -v2

	if not p6 or p6 == 0 then
		p6 = p4 * 0.3
	end

	local v4

	if p5 and not (p5 < math.abs(p3)) then
		v4 = p6 / 6.283185307179586 * math.asin(p3 / p5)
	else
		v4 = p6 / 4

		if p3 ~= 0 then
			local v5 = math.abs(v4)
			v = p5 == 0 and 0 or v * (p5 / math.abs(p3))

			if math.abs(v3 * p4) < v5 then
				local v6 = math.abs(v3 * p4) / v5
				v = v * v6 + (1 - v6)
			end
		end

		p5 = p3
	end

	return v * (p5 * math.pow(2, 10 * v3) * math.sin((v3 * p4 - v4) * 6.283185307179586 / p6)) + p3 + p2
end

local function inOutElastic(p, p2, p3, p4, p5, p6)
	local v = 1

	if p == 0 then
		return p2
	end

	local v2 = p / (p4 / 2)

	if v2 == 2 then
		return p2 + p3
	end

	local v3 = v2 - 1

	if not p6 or p6 == 0 then
		p6 = p4 * 0.44999999999999996
	end

	local v4

	if p5 and not (p5 < math.abs(p3)) then
		v4 = p6 / 6.283185307179586 * math.asin(p3 / p5)
	else
		v4 = p6 / 4

		if p3 ~= 0 then
			local v5 = math.abs(v4)
			v = p5 == 0 and 0 or v * (p5 / math.abs(p3))

			if math.abs(v3 * p4) < v5 then
				local v6 = math.abs(v3 * p4) / v5
				v = v * v6 + (1 - v6)
			end
		end

		p5 = p3
	end

	if v3 < 0 then
		return v * -0.5 * (p5 * math.pow(2, 10 * v3) * math.sin((v3 * p4 - v4) * 6.283185307179586 / p6)) + p2
	end

	local v5 = -v3
	return v * 0.5 * (p5 * math.pow(2, 10 * v5) * math.sin((v5 * p4 - v4) * 6.283185307179586 / p6)) + p3 + p2
end

local function outInElastic(p, p2, p3, p4, p5, p6)
	if p < p4 / 2 then
		return (outElastic(p * 2, p2, p3 / 2, p4, p5, p6))
	end

	return (inElastic(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4, p5, p6))
end

function EasingFunctions.ElasticIn(p, p2, p3)
	return (inElastic(p, 0, 1, 1, p2, p3))
end

function EasingFunctions.ElasticOut(p, p2, p3)
	return (outElastic(p, 0, 1, 1, p2, p3))
end

function EasingFunctions.ElasticInOut(p, p2, p3)
	return (inOutElastic(p, 0, 1, 1, p2, p3))
end

function EasingFunctions.ElasticOutIn(p, p2, p3)
	if p < 0.5 then
		return (outElastic(p * 2, 0, 0.5, 1, p2, p3))
	end

	return (inElastic(p * 2 - 1, 0.5, 0.5, 1, p2, p3))
end

return EasingFunctions