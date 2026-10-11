local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local HoverTextColor = { ClassName = script.Name, ClassModule = script }
HoverTextColor.__index = HoverTextColor

function HoverTextColor.new(textLabel)
	local v = {
		Root = textLabel,
		Cleaner = Cleaner.new(),
		State = false,
		Force = false,
		Text = 0
	}

	if textLabel:IsA("ImageButton") then
		textLabel = textLabel:FindFirstChildOfClass("TextLabel") or textLabel
	end

	v.Text = textLabel
	return (setmetatable(v, HoverTextColor))
end

function HoverTextColor:Init()
	self.Cleaner:Add(self.Root.MouseEnter:Connect(function()
		self:SetState(true)
	end))
	self.Cleaner:Add(self.Root.MouseLeave:Connect(function()
		self:SetState(false)
	end))
	self.Cleaner:Add(self.Root.MouseButton1Down:Connect(function()
		if self.Root:GetAttribute("BSM_Ignore") then
			return
		end

		if self.Root:GetAttribute("HoverColorClickIgnore") then
			self:SetState(false)
		else
			self:SetState(true, true)
		end
	end))
end

function HoverTextColor:SetState(state, p)
	if self.Force and p == nil then
		return
	end

	self.Force = p or false
	self.State = state
	self.Text.TextColor3 = state and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
end

function HoverTextColor.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { HoverTextColor }, PlayerGui)
return HoverTextColor