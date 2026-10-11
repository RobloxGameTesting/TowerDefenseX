local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local ShopWindowV2 = { ClassName = script.Name, ClassModule = script }
ShopWindowV2.__index = ShopWindowV2

function ShopWindowV2.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, ShopWindowV2))
end

function ShopWindowV2.HideMainWindow(p)
	for _, v in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v:ClearState()
	end

	p.Root.Visible = false
end

function ShopWindowV2.ShowMainWindow(p)
	p.Root.Visible = true
end

function ShopWindowV2.Init(_) end

function ShopWindowV2.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { ShopWindowV2 }, game.Players)
return ShopWindowV2