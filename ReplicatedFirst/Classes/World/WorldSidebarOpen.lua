local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local WorldSidebarOpen = { ClassName = script.Name, ClassModule = script }
WorldSidebarOpen.__index = WorldSidebarOpen

function WorldSidebarOpen.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, WorldSidebarOpen))
end

function WorldSidebarOpen.Init(p)
	local parent = p.Root.Parent
	local StarterGui = game:GetService("StarterGui")

	if parent == StarterGui then
		return
	end

	local function fn()
		for _, v in Director.GetItemsFromClass(Director.Classes.Sidebar) do
			v:ShowFrame(p.Root:GetAttribute("GoToFrame"))
		end
	end

	if p.Root:IsA("ProximityPrompt") then
		p.Cleaner:Add(p.Root.Triggered:Connect(fn))
	elseif p.Root:IsA("GuiButton") then
		p.Cleaner:Add(p.Root.Activated:Connect(fn))
	else
		warn(`Unable to bind WorldSideBarOpen to instance of type {p.Root.ClassName}`)
	end
end

function WorldSidebarOpen.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { WorldSidebarOpen })
return WorldSidebarOpen