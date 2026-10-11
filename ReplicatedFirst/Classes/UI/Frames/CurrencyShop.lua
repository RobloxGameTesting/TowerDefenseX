local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Shared = require(TDX_Shared.Modules.Shared)
require(ReplicatedStorage.Modules.ShopDataV2)
local udim = UDim2.new(0.75, 0, 0.75, 0)
local udim2 = UDim2.new(0.8, 0, 0.8, 0)
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local color = Color3.fromRGB(200, 200, 200)
local color2 = Color3.fromRGB(255, 255, 255)
local event = NetworkingHandler.GetEvent("CurrencyPurchaseSucceeded")
local LocalPlayer = Players.LocalPlayer

local function PromptGiftCurrency(p: number, currency)
	local firstItem = Director.GetFirstItemFromClass(Director.Classes.GiftingWindow)
	local formatted = `{p} {currency}`
	firstItem:SetTargetPlayerId(nil, nil)
	firstItem:SetTargetGift(currency, formatted, formatted)
	Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("Gifting", function() end)
end

local function CheckValidCurrency(p: string) -- 3 equivalent calls inferred from this helper
	assert(p == "Gold" or p == "Crystals", "Unknown currency")
	return p
end

local function GetCurrencyDataMaps(p)
	if CheckValidCurrency(p) == "Crystals" then -- inferred equivalent call
		return Shared.CRYSTALS_TIER_TO_DEV_ID_MAP, Shared.CRYSTALS_DEV_ID_TO_AMOUNT_MAP
	end

	return Shared.GOLD_TIER_TO_DEV_ID_MAP, Shared.GOLD_DEV_ID_TO_AMOUNT_MAP
end

local CurrencyShop = { ClassName = script.Name, ClassModule = script }
CurrencyShop.__index = CurrencyShop

function CurrencyShop.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, CurrencyShop))
end

function CurrencyShop:Init()
	self.Currency = CheckValidCurrency(self.Root:GetAttribute("Currency")) -- inferred equivalent call

	for _, button in self.Root.Frame:GetChildren() do
		if not button:IsA("ImageButton") then
			continue
		end

		local name = tonumber(button.Name)
		assert(name, "CurrencyShop:Init() - Tier is not a number")
		local checkValidCurrency = CheckValidCurrency(self.Currency) -- inferred equivalent call
		local CRYSTALS_TIER_TO_DEV_ID_MAP, CRYSTALS_DEV_ID_TO_AMOUNT_MAP

		if checkValidCurrency == "Crystals" then
			CRYSTALS_TIER_TO_DEV_ID_MAP = Shared.CRYSTALS_TIER_TO_DEV_ID_MAP
			CRYSTALS_DEV_ID_TO_AMOUNT_MAP = Shared.CRYSTALS_DEV_ID_TO_AMOUNT_MAP
		else
			CRYSTALS_TIER_TO_DEV_ID_MAP = Shared.GOLD_TIER_TO_DEV_ID_MAP
			CRYSTALS_DEV_ID_TO_AMOUNT_MAP = Shared.GOLD_DEV_ID_TO_AMOUNT_MAP
		end

		local v = CRYSTALS_TIER_TO_DEV_ID_MAP[name]
		assert(v, "CurrencyShop:Init() - DevProductId is nil")
		local v2 = CRYSTALS_DEV_ID_TO_AMOUNT_MAP[v]
		assert(v2, "CurrencyShop:Init() - amount is nil")
		local buy = button.buy
		local img = button.img
		self.Cleaner:Add(button.Activated:Connect(function()
			SoundHandler.Play("ShopSelectOption")
			MarketplaceService:PromptProductPurchase(LocalPlayer, v)
		end))
		self.Cleaner:Add(buy.Activated:Connect(function()
			SoundHandler.Play("ShopSelectOption")
			MarketplaceService:PromptProductPurchase(LocalPlayer, v)
		end))
		self.Cleaner:Add(button.gift.Activated:Connect(function()
			PromptGiftCurrency(v2, self.Currency)
		end))
		local v3 = button
		self.Cleaner:Add(button.MouseEnter:Connect(function()
			v3.ImageColor3 = color2
			TweenService:Create(img, tweenInfo, { Size = udim2 }):Play()
		end))
		local v4 = button
		self.Cleaner:Add(button.MouseLeave:Connect(function()
			v4.ImageColor3 = color
			TweenService:Create(img, tweenInfo, { Size = udim }):Play()
		end))
	end
end

function CurrencyShop.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { CurrencyShop }, game.Players)
event:AttachCallback(function(_) end)
return CurrencyShop