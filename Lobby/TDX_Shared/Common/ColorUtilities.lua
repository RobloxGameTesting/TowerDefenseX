local color = Color3.fromRGB(0, 181, 12)
local color2 = Color3.fromRGB(222, 178, 0)
local color3 = Color3.fromRGB(223, 101, 48)
local color4 = Color3.fromRGB(232, 53, 45)
local color5 = Color3.fromRGB(120, 0, 0)
local color6 = Color3.fromRGB(100, 75, 181)
local color7 = Color3.fromRGB(0, 181, 12)
local color8 = Color3.fromRGB(222, 178, 0)
local color9 = Color3.fromRGB(223, 101, 48)
local color10 = Color3.fromRGB(232, 53, 45)
local color11 = Color3.fromRGB(120, 0, 0)
local ColorUtilities = {}

function ColorUtilities.GetHealthbarColor(p: number, p2: number, flag: boolean?)
	local v = p / p2

	if flag then
		return color6
	end

	if v >= 0.8 then
		return color
	end

	if v >= 0.6 then
		return color2
	end

	if v >= 0.4 then
		return color3
	end

	if v >= 0.2 then
		return color4
	end

	return color5
end

function ColorUtilities.GetLivesBarColor(p: number, p2: number)
	local v = p / p2

	if v >= 0.8 then
		return color7
	end

	if v >= 0.6 then
		return color8
	end

	if v >= 0.4 then
		return color9
	end

	if v >= 0.2 then
		return color10
	end

	return color11
end

return ColorUtilities