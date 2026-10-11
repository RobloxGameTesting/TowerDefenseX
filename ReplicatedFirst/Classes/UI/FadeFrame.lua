local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local Players = game:GetService("Players")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local FadeFrame = { ClassName = "FadeFrame", ClassModule = script }
FadeFrame.__index = FadeFrame

function FadeFrame.new(root)
	return (setmetatable({ Root = root, Frame = root.Frame, IsFading = false }, FadeFrame))
end

function FadeFrame.Init(p)
	p.Root.Enabled = false
	p.Frame.BackgroundTransparency = 1
end

function FadeFrame:FadeIn(duration: number, callback)
	if self.IsFading then
		return
	end

	ProximityPromptService.Enabled = false
	self.IsFading = true
	self.Root.Enabled = true
	self.Frame.BackgroundTransparency = 1
	local tween = TweenService:Create(self.Frame, TweenInfo.new(duration), {
		BackgroundTransparency = 0
	})
	tween.Completed:Connect(function()
		self.IsFading = false

		if callback then
			callback()
		end
	end)
	tween:Play()
end

function FadeFrame:FadeOut(duration: number, callback)
	if self.IsFading then
		return
	end

	self.IsFading = true
	self.Frame.BackgroundTransparency = 0
	local tween = TweenService:Create(self.Frame, TweenInfo.new(duration), {
		BackgroundTransparency = 1
	})
	tween.Completed:Connect(function()
		self.IsFading = false
		self.Root.Enabled = false
		ProximityPromptService.Enabled = true

		if callback then
			callback()
		end
	end)
	tween:Play()
end

function FadeFrame.IsFading(p)
	return p.IsFading
end

Director.Register("FadeFrame", { FadeFrame }, Players.LocalPlayer)
return FadeFrame