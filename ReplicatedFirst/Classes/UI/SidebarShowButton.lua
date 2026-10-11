local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local SidebarShowButton = { ClassName = script.Name, ClassModule = script }
SidebarShowButton.__index = SidebarShowButton

function SidebarShowButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, SidebarShowButton))
end

function SidebarShowButton.Init(p)
	p.Cleaner:Add(p.Root.MouseButton1Down:Connect(function()
		for _, v in Director.GetItemsFromClass(Director.Classes.Sidebar) do
			v:ShowFrame(p.Root:GetAttribute("GoToFrame"))
		end
	end))
end

function SidebarShowButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { SidebarShowButton })
return SidebarShowButton