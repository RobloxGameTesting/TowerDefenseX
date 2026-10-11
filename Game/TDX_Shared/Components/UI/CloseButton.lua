local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local CloseButton = { ClassName = script.Name, ClassModule = script }
CloseButton.__index = CloseButton

function CloseButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, CloseButton))
end

function CloseButton:Close()
	SoundHandler.Play("CloseButtonClick")
	self.Root.Parent.Visible = false
end

function CloseButton:Init()
	self.Cleaner:Add(self.Root.Activated:Connect(function()
		self:Close()
	end))
	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input)
		if self.Root.Parent.Visible and input.KeyCode == Enum.KeyCode.ButtonB then
			self:Close()
		end
	end))
end

function CloseButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { CloseButton })
return CloseButton