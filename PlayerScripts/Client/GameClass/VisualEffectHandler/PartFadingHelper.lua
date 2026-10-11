local PartFadingHelper = {}
PartFadingHelper.__index = PartFadingHelper
local object = setmetatable({}, { __mode = "k" })

local function GetOriginalTransparency(p)
	local transparency = object[p]

	if transparency == nil then
		transparency = p.Transparency
		object[p] = transparency
	end

	return transparency
end

function PartFadingHelper.New()
	return (setmetatable({ Parts = {}, IsFadeOut = nil, Duration = nil, TimeRemaining = nil }, PartFadingHelper))
end

function PartFadingHelper.Add(p, p2)
	if object[p2] == nil then
		object[p2] = p2.Transparency
	end

	table.insert(p.Parts, p2)
end

function PartFadingHelper:ResetTransparency()
	for _, part in self.Parts do
		local transparency = object[part]

		if transparency ~= nil then
			part.Transparency = transparency
		end
	end

	self.IsFadeOut = nil
	self.Duration = nil
	self.TimeRemaining = nil
end

function PartFadingHelper:_ApplyAlpha(p: number)
	local isFadeOut = self.IsFadeOut

	for _, part in self.Parts do
		local v = object[part] or 0
		local transparency

		if isFadeOut then
			transparency = math.lerp(v, 1, p)
		else
			transparency = math.lerp(1, v, p)
		end

		part.Transparency = transparency
	end
end

function PartFadingHelper:Fade(isFadeOut: boolean, p: number)
	if #self.Parts == 0 then
		return
	end

	self.IsFadeOut = isFadeOut
	self.Duration = p
	self.TimeRemaining = p
	self:_ApplyAlpha(0)
end

function PartFadingHelper:Run(p: number)
	if self.TimeRemaining == nil then
		return
	end

	if self.TimeRemaining > 0 then
		self.TimeRemaining = math.max(0, self.TimeRemaining - p)
		self:_ApplyAlpha((self.Duration - self.TimeRemaining) / self.Duration)
	else
		self:_ApplyAlpha(1)
		self.IsFadeOut = nil
		self.Duration = nil
		self.TimeRemaining = nil
	end
end

function PartFadingHelper:Destroy()
	self.Parts = nil
	setmetatable(self, nil)
end

return PartFadingHelper