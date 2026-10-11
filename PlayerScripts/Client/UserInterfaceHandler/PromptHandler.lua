local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local event = NetworkingHandler.GetEvent("ServerMessagePrompt")
local event2 = BindableHandler.GetEvent("MessagePrompt")
local event3 = BindableHandler.GetEvent("ErrorPrompt")
local innerFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TopAreaQueueFrame"):WaitForChild("PromptHolderFrame"):WaitForChild("InnerFrame")
local messageTemplate = innerFrame:WaitForChild("MessageTemplate")
local errorTemplate = innerFrame:WaitForChild("ErrorTemplate")
local v = {}
local count = 0
local v2 = 0

local function GetHash() -- 1 equivalent call inferred from this helper
	count += 1
	return count
end

local function RemoveOldestPrompt()
	local v3 = nil
	local v4 = nil

	for k, v5 in pairs(v) do
		if not (not v3 or v5.Hash < v4) then
			continue
		end

		v4 = k
		v3 = v5
	end

	if v3 then
		v3:Destroy()
	end
end

local function NewBasePrompt(clone, text: string, value: number?)
	if v2 >= 4 then
		RemoveOldestPrompt()
	end

	local v3 = GetHash() -- inferred equivalent call
	v2 += 1
	clone.LayoutOrder = v3
	clone.Parent = innerFrame
	clone.Visible = true
	local textLabel = clone:WaitForChild("TextLabel")
	textLabel.Text = text
	local v4 = {
		Hash = v3,
		Frame = clone,
		TextLabel = textLabel,
		TimeLeft = value or 3.5,
		TotalTimeLeft = value or 3.5,
		FadeOutTimeLeft = 0.3,
		TotalFadeOutTimeLeft = 0.3,
		ShrinkTimeLeft = 0.2,
		TotalShrinkTimeLeft = 0.2,
		FrameHeightOriginal = clone.Size.Y.Scale,
		Run = function(self, p: number)
			if self.TimeLeft > 0 then
				self.TimeLeft -= p
			elseif self.FadeOutTimeLeft > 0 then
				self.FadeOutTimeLeft -= p
				self.TextLabel.TextTransparency = 1 - self.FadeOutTimeLeft / self.TotalFadeOutTimeLeft
			elseif self.ShrinkTimeLeft > 0 then
				self.ShrinkTimeLeft -= p
				self.Frame.Size = UDim2.new(
					1,
					0,
					self.FrameHeightOriginal * (self.ShrinkTimeLeft / self.TotalShrinkTimeLeft) ^ 2,
					0
				)
			else
				self:Destroy()
			end
		end,
		Destroy = function(self)
			self.Frame:Destroy()
			v2 -= 1
			v[self.Hash] = nil
		end
	}
	v[v3] = v4
	return v4
end

local function NewError(p: string, _: number?) -- 1 equivalent call inferred from this helper
	NewBasePrompt(errorTemplate:Clone(), p)
	SoundHandler.Play("Error")
end

local function NewMessage(text: string, p: number?, flag: boolean?) -- 2 equivalent calls inferred from this helper
	local newBasePrompt = NewBasePrompt(messageTemplate:Clone(), text, p)
	local uiGradient = flag and newBasePrompt.TextLabel:FindFirstChildOfClass("UIGradient")

	if uiGradient then
		uiGradient.Enabled = true
	end
end

messageTemplate.Visible = false
errorTemplate.Visible = false
event:AttachCallback(function(text: string, p: number?, flag: boolean?)
	NewMessage(text, p, flag) -- inferred equivalent call
end)
event2:AttachCallback(function(text: string, p: number?, flag: boolean?)
	NewMessage(text, p, flag) -- inferred equivalent call
end)
event3:AttachCallback(function(p: string, _: number?)
	NewError(p) -- inferred equivalent call
end)
return {
	Update = function(p: number)
		for _, v3 in pairs(v) do
			v3:Run(p)
		end
	end
}