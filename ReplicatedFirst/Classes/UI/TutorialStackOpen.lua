local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local TutorialStackOpen = { ClassName = script.Name, ClassModule = script }
TutorialStackOpen.__index = TutorialStackOpen

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

function TutorialStackOpen.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, TutorialStackOpen))
end

function TutorialStackOpen.Init(p)
	p.Cleaner:Add(p.Root.play.MouseButton1Click:Connect(function()
		go("TutorialWindow")
	end))

	if not Data.Cache.JoinsSinceTutorialAdded then
		repeat
			task.wait(0.1)
		until Data.Cache.JoinsSinceTutorialAdded
	end

	local joinsSinceTutorialAdded = Data.Get("JoinsSinceTutorialAdded")
	local root = p.Root
	root.Visible = Data.Get("MapAndDifficultyWins").Tutorial == nil and joinsSinceTutorialAdded <= 3

	if joinsSinceTutorialAdded <= 1 then
		go("TutorialWindow")
	end
end

function TutorialStackOpen.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { TutorialStackOpen }, Players)
return TutorialStackOpen