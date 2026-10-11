local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Director = require(TDX_Shared.Modules.Director)
local ItemBox = require(game.ReplicatedFirst.Classes.UI.V2.ItemBox)
local ItemBoxHolder = { ClassName = script.Name, ClassModule = script }
ItemBoxHolder.__index = ItemBoxHolder

function ItemBoxHolder.new(root)
	return (setmetatable({ Root = root }, ItemBoxHolder))
end

function ItemBoxHolder.Init(p)
	local category = p.Root:GetAttribute("Category")
	local itemName = p.Root:GetAttribute("ItemName")
	local clone = game.ReplicatedStorage.LobbyResources.GuiTemplates.ItemBox:Clone()
	clone.Parent = p.Root
	clone:AddTag("ItemBox")
	local classObjectYields = Director.GetClassObjectYields(clone, ItemBox)
	classObjectYields:SetHeight(UDim.new(1, 0))
	classObjectYields:SetItem(category, itemName)
end

function ItemBoxHolder.Destroy(_) end

Director.Register(script.Name, { ItemBoxHolder }, game.Players)
return ItemBoxHolder