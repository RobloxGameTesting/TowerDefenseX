local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local tweenInfo = TweenInfo.new(0.1)
local ClickEffect = { ClassName = script.Name, ClassModule = script }
ClickEffect.__index = ClickEffect

function ClickEffect.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Scale = nil }, ClickEffect))
end

function ClickEffect:Init()
	self.Scale = Instance.new("UIScale")
	self.Scale.Scale = 1
	self.Scale.Parent = self.Root
	self.TweenDown = TweenService:Create(self.Scale, tweenInfo, { Scale = 0.9 })
	self.TweenUp = TweenService:Create(self.Scale, tweenInfo, { Scale = 1 })
	self.Cleaner:Add(self.Scale)
	self.Cleaner:Add(self.TweenDown)
	self.Cleaner:Add(self.TweenUp)
	self.Cleaner:Add(self.Root.MouseButton1Down:Connect(function()
		self.TweenDown:Play()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(self.Root.MouseButton1Up:Connect(function()
		self.TweenUp:Play()
		SoundHandler.Play("ClickUp")
	end))
end

function ClickEffect.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { ClickEffect })
return ClickEffect