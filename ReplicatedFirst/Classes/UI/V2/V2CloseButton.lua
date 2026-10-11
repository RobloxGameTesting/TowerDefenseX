local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local V2CloseButton = { ClassName = script.Name, ClassModule = script }
V2CloseButton.__index = V2CloseButton

function V2CloseButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, V2CloseButton))
end

function V2CloseButton:Close()
	SoundHandler.Play("CloseButtonClick")
	self.Root.Parent.Visible = false

	for _, v in Director.GetItemsFromClass(Director.Classes.V2Sidebar) do
		v:HideAll()
	end
end

function V2CloseButton:Init()
	self.Cleaner:Add(self.Root.Activated:Connect(function()
		self:Close()
	end))
	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input)
		if self.Root.Parent.Visible and input.KeyCode == Enum.KeyCode.ButtonB then
			self:Close()
		end
	end))
end

function V2CloseButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { V2CloseButton })
return V2CloseButton