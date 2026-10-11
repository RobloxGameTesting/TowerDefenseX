local SwagTextClass = {}
SwagTextClass.__index = SwagTextClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local Utilities = require(common:WaitForChild("Utilities"))

function SwagTextClass.New(data)
	local textLabel = data.TextLabel
	local formatString = data.FormatString
	local v = {
		TextLabel = textLabel,
		ImageLabels = data.ImageLabels,
		FormatString = formatString,
		AppendStringOnceComplete = data.AppendStringOnceComplete,
		StartNumber = data.StartNumber,
		EndNumber = data.EndNumber,
		PreviousNumber = data.StartNumber,
		DelayRemaining = data.StartDelay,
		FadeInTimeRemaining = data.FadeInTime,
		TotalFadeInTime = data.FadeInTime,
		TimeRemaining = data.Duration,
		TotalTime = data.Duration,
		TimeToNextTextUpdate = data.MinimumInterval,
		MinimumInterval = data.MinimumInterval or 0.05,
		SoundName = data.SoundName
	}
	setmetatable(v, SwagTextClass)
	textLabel.Text = string.format(formatString, data.StartNumber)
	textLabel.TextTransparency = 1
	v:_UpdateOtherElementTransparencies(1)
	return v
end

function SwagTextClass:Run(p: number)
	if self.DelayRemaining > 0 then
		self.DelayRemaining -= p
		return
	end

	local textTransparency

	if self.FadeInTimeRemaining > 0 then
		self.FadeInTimeRemaining -= p
		textTransparency = math.clamp(self.FadeInTimeRemaining / self.TotalFadeInTime, 0, 1)
	else
		textTransparency = 0
	end

	self.TextLabel.TextTransparency = textTransparency
	self:_UpdateOtherElementTransparencies(textTransparency)
	self.TimeRemaining -= p

	if self.TimeRemaining <= 0 then
		self.TextLabel.Text = string.format(self.FormatString, self.EndNumber) .. (self.AppendStringOnceComplete or "")
		return
	end

	self.TimeToNextTextUpdate -= p

	if self.TimeToNextTextUpdate <= 0 then
		local v = 1 - math.clamp(self.TimeRemaining / self.TotalTime, 0, 1)
		local lerped = Utilities.Lerp(self.StartNumber, self.EndNumber, v)

		if lerped ~= self.PreviousNumber then
			self.TextLabel.Text = string.format(self.FormatString, (math.ceil(lerped)))
			self.TimeToNextTextUpdate = self.MinimumInterval
			SoundHandler.Play(self.SoundName)
			self.PreviousNumber = lerped
		end
	end
end

function SwagTextClass:_UpdateOtherElementTransparencies(imageTransparency: number)
	if self.ImageLabels then
		for _, imageLabel in pairs(self.ImageLabels) do
			imageLabel.ImageTransparency = imageTransparency
		end
	end
end

return SwagTextClass