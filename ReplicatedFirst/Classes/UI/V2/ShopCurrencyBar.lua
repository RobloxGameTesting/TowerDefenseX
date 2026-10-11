local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Util = require(ReplicatedStorage.TDX_Shared.Modules.Util)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
require(ReplicatedStorage.TDX_Shared.Common.CurrencyTypes)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)

local function ShowCurrencyShop(p)
	for _, v in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v:ClearState()
		v:Navigate("N/A")
	end

	UIHelper.ShowCurrencyShop(p)
end

local ShopCurrencyBar = { ClassName = script.Name, ClassModule = script }
ShopCurrencyBar.__index = ShopCurrencyBar

function ShopCurrencyBar.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, ShopCurrencyBar))
end

function ShopCurrencyBar:Init()
	self.GoldField = self.Root:FindFirstChild("Gold")

	if self.GoldField then
		self.Cleaner:Add(self.Root.Gold.MouseButton1Click:Connect(function()
			ShowCurrencyShop("Gold")
		end))
	end

	self.CrystalsField = self.Root:FindFirstChild("Crystals")

	if self.CrystalsField then
		self.Cleaner:Add(self.Root.Crystals.MouseButton1Click:Connect(function()
			ShowCurrencyShop("Crystals")
		end))
	end

	local gift = self.Root:FindFirstChild("Gift")

	if gift then
		self.Cleaner:Add(gift.MouseButton1Click:Connect(function()
			local firstItem = Director.GetFirstItemFromClass(Director.Classes.GiftingWindow)
			firstItem:SetTargetPlayerId(nil, nil)
			firstItem:SetTargetGift(nil, nil, nil)
			Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("Gifting", function() end)
		end))
	end

	self.XPField = self.Root:FindFirstChild("Level")
	self:Update()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Gold" or p == "Crystals" or p == "XP" then
			self:Update()
		end
	end))
end

function ShopCurrencyBar:Update()
	if self.GoldField then
		self.GoldField.label.Text = `${Util.FormatCurrency((math.floor((Data.Get("Gold")))))}`
	end

	if self.CrystalsField then
		self.CrystalsField.label.Text = `${Util.FormatCurrency((math.floor((Data.Get("Crystals")))))}`
	end

	if self.XPField then
		self.XPField.Text = `LVL {Util.XPToLevelAndProgress(Data.Get("XP"))}`
	end
end

function ShopCurrencyBar.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { ShopCurrencyBar }, game.Players)
return ShopCurrencyBar