local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate)
local V2TopBar = { ClassName = script.Name, ClassModule = script }
V2TopBar.__index = V2TopBar

function V2TopBar.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, V2TopBar))
end

local function go(p: string)
	local v = nil

	for _, v2 in Director.GetItemsFromClass(Director.Classes.Sidebar) do
		v = v2:IsFrameVisible(p) and "N/A" or p
		break
	end

	for _, v2 in Director.GetItemsFromClass(Director.Classes.V2Sidebar) do
		v2:HideAll()
	end

	for _, v2 in Director.GetItemsFromClass(Director.Classes.Sidebar) do
		v2:ShowFrame(v)
	end
end

function V2TopBar:UpdatePosition(flag: boolean)
	self.Root.UIListLayout.HorizontalAlignment = flag and Enum.HorizontalAlignment.Right
		or Enum.HorizontalAlignment.Left

	for _, frame in self.Root:GetChildren() do
		if frame:IsA("Frame") then
			frame.LayoutOrder = math.abs(frame.LayoutOrder) * (flag and -1 or 1)
		end
	end

	self.Root.Misc.Frame.AnchorPoint = Vector2.new(flag and 1 or 0, 0)
	self.Root.Misc.Frame.Position = UDim2.new(flag and 1 or 0, 0, 1.1, 0)
	self.Root.Position = UDim2.new(0, 12, 0, flag and 2 or 10)
end

function V2TopBar:Init()
	local root = self.Root
	self.Cleaner:Add(root.Misc.Background.MouseButton1Click:Connect(function()
		root.Misc.Frame.Visible = not root.Misc.Frame.Visible
	end))
	self.Cleaner:Add(root.Achievements.Background.MouseButton1Click:Connect(function()
		go("Achievements")
	end))
	self.Cleaner:Add(root.Settings.Background.MouseButton1Click:Connect(function()
		go("Settings")
	end))
	self.Cleaner:Add(root.Quests.Background.MouseButton1Click:Connect(function()
		go("Quests")
	end))
	root.Quests.Visible = true
	self.Cleaner:Add(Data.Updated:Connect(function(p: string, p2)
		if p == "Quests" then
			root.Quests.Background.NewQuests.Visible = not (p2.Daily.HasSeenNewQuests and p2.Weekly.HasSeenNewQuests)
		end
	end))
	self.Cleaner:Add(UserInputService.LastInputTypeChanged:Connect(function(p)
		self:UpdatePosition(p == Enum.UserInputType.Touch)
	end))

	for _, child in root.Misc.Frame:GetChildren() do
		self.Cleaner:Add(child.TextButton.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
		end))
		local v = child
		self.Cleaner:Add(child.TextButton.MouseButton1Click:Connect(function()
			SoundHandler.Play("ClickUp")
			root.Misc.Frame.Visible = false
			go(v.Name)
		end))
	end

	self:UpdatePosition(UserInputService:GetLastInputType() == Enum.UserInputType.Touch or UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled or UserInputService.MouseEnabled))
end

function V2TopBar.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { V2TopBar }, game.Players)
return V2TopBar