local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local ClickEffect3 = { ClassName = script.Name, ClassModule = script }
ClickEffect3.__index = ClickEffect3

function ClickEffect3.new(instance)
	return (setmetatable({
		Root = instance,
		Cleaner = Cleaner.new(),
		Clicked = false,
		Hovered = false,
		HoverTextColor = instance:GetAttribute("HoverTextColor"),
		DefaultTextColor = instance:GetAttribute("DefaultTextColor"),
		Label = instance:FindFirstChild("label")
	}, ClickEffect3))
end

function ClickEffect3:Init()
	self.Cleaner:Add(self.Root.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
		self.Clicked = true
		self:Update()
	end))
	self.Cleaner:Add(self.Root.MouseButton1Up:Connect(function()
		SoundHandler.Play("ClickUp")
		self.Clicked = false
		self:Update()
	end))
	self.Cleaner:Add(self.Root.MouseEnter:Connect(function()
		if self.Label and self.HoverTextColor then
			self.Label.TextColor3 = self.Root:GetAttribute("HoverTextColor")
		end

		self.Hovered = true
		self:Update()
	end))
	self.Cleaner:Add(self.Root.MouseLeave:Connect(function()
		if self.Label and self.DefaultTextColor then
			self.Label.TextColor3 = self.Root:GetAttribute("DefaultTextColor")
		end

		self.Hovered = false
		self.Clicked = false
		self:Update()
	end))
end

function ClickEffect3:Update()
	local v = self.Hovered and 2 or 1
	local v2 = self.Clicked and 3 or v

	for k, v3 in { self.Root, self.Root:FindFirstChild("HoverState"), self.Root:FindFirstChild("ClickState") } do
		v3.ImageTransparency = k == v2 and 0 or 1
	end
end

function ClickEffect3.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { ClickEffect3 }, game.Players)
return ClickEffect3