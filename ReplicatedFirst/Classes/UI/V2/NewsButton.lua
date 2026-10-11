local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate)
local NewsButton = { ClassName = script.Name, ClassModule = script }
NewsButton.__index = NewsButton

function NewsButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, NewsButton))
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

function NewsButton.Init(p)
	local root = p.Root
	local uiStroke = root:FindFirstChild("UIStroke")
	p.Cleaner:Add(root.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	p.Cleaner:Add(root.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		go("Announcements")
	end))
	p.Cleaner:Add(root.MouseEnter:Connect(function()
		uiStroke.Color = Color3.fromRGB(180, 180, 180)
	end))
	p.Cleaner:Add(root.MouseLeave:Connect(function()
		uiStroke.Color = Color3.fromRGB(255, 255, 255)
	end))
end

function NewsButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { NewsButton }, game.Players)
return NewsButton