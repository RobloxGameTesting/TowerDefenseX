local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Network = require(game.ReplicatedFirst.Client.Network)
local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Util = require(TDX_Shared.Modules.Util)
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local Sidebar = require(ReplicatedFirst.Classes.UI.Sidebar)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local Shared = require(TDX_Shared.Modules.Shared)
local ClientUtil = require(game.ReplicatedFirst.Util.ClientUtil)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local v = {
	Util.Create("Sound", {
		Name = "Purchase1",
		SoundId = "rbxassetid://15098084380",
		Volume = 0.5,
		Parent = workspace,
		SoundGroup = GameSoundHandler.GetSoundGroup("UI")
	}),
	Util.Create("Sound", {
		Name = "Purchase2",
		SoundId = "rbxassetid://15098084298",
		Volume = 0.5,
		Parent = workspace,
		SoundGroup = GameSoundHandler.GetSoundGroup("UI")
	}),
	Util.Create("Sound", {
		Name = "Purchase3",
		SoundId = "rbxassetid://15098084032",
		Volume = 0.5,
		Parent = workspace,
		SoundGroup = GameSoundHandler.GetSoundGroup("UI")
	})
}
local UpdateLogPurchase = { ClassName = script.Name, ClassModule = script }
UpdateLogPurchase.__index = UpdateLogPurchase

function UpdateLogPurchase.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, UpdateLogPurchase))
end

local flag = false

function UpdateLogPurchase:UpdateDisplay(flag2: boolean?)
	local attributes = self.Root:GetAttributes()
	local v2 = false

	if attributes.BuyType == "Tower" then
		local tower = ShopDataV2.Items.Towers[attributes.BuyName]
		local tower2 = Data.Get("Inventory").Towers[attributes.BuyName]

		if tower2 or not (Util.XPToLevelAndProgress(Data.Get("XP")) < tower.MinLevel) then
			local currency = tower.Currency or "Gold"
			local text2

			if tower2 then
				text2 = Lang.Get(Lang.Strings.Shop.Owned)
			elseif currency == "Crystals" then
				text2 = Lang.Get(Lang.Strings.Shop.BuyForCrystals, tower.Price)
			else
				text2 = Lang.Get(Lang.Strings.Shop.BuyForGold, tower.Price)
			end

			local text = self.Root:FindFirstChild("Text")
			text.Text = text2
			text.TextColor3 = Shared.CURRENCY_COLORS[currency]
		elseif tower.ProductId then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.LockedBuyForRobux, tower.MinLevel, tower.PriceInRobux)
		else
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.UnlockedAt, tower.MinLevel)
		end
	elseif attributes.BuyType == "TowerRobux" then
		local tower = ShopDataV2.Items.Towers[attributes.BuyName]
		local tower2 = Data.Get("Inventory").Towers[attributes.BuyName]
		local text = self.Root:FindFirstChild("Text")
		text.Text = tower2 and Lang.Get(Lang.Strings.Shop.Owned)
			or Lang.Get(Lang.Strings.Shop.BuyForRobux, tower and tower.PriceInRobux or "???")
	elseif attributes.BuyType == "PowerUp" or attributes.BuyType == "PowerUpSingle" then
		local text = self.Root:FindFirstChild("Text")
		text.Text = Lang.Get(
			Lang.Strings.Shop.BuyOneForRobux,
			ShopDataV2.Items.PowerUps[attributes.BuyName].PriceInRobux
		)
	elseif attributes.BuyType == "PowerUpSingleGold" then
		local powerUp = ShopDataV2.Items.PowerUps[attributes.BuyName]

		if (powerUp.Currency or "Gold") == "Crystals" then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.BuyOneForCrystals, powerUp.Price)
		else
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.BuyOneFor, powerUp.Price)
		end
	elseif attributes.BuyType == "Skin" then
		local skin = ShopDataV2.Items.Skins[attributes.BuyName]

		if skin then
			v2 = ClientUtil.OwnsItem("Skins", skin.ExpectedSkin)
		end

		local text = self.Root:FindFirstChild("Text")
		text.Text = v2 and Lang.Get(Lang.Strings.Shop.Owned)
			or Lang.Get(Lang.Strings.Shop.BuyForRobux, skin and skin.PriceInRobux or "???")
	elseif attributes.BuyType == "RobloxAsset" then
		local success, result = pcall(function()
			return MarketplaceService:PlayerOwnsAsset(Players.LocalPlayer, (tonumber(attributes.BuyName)))
		end)

		if success and (result or flag2 == true) then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.Owned)
		elseif success and not result then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.BuyForRobux, attributes.RobuxPrice)
		else
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.General.WebCallFailed)
		end
	elseif attributes.BuyType == "TowerDiscount" then
		local tower = ShopDataV2.Items.Towers[attributes.BuyName]

		if Data.Get("Inventory").Towers[attributes.BuyName] then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.Owned)
			local discount = self.Root:FindFirstChild("discount")
			discount.Visible = false
			local discounted = self.Root:FindFirstChild("Text"):FindFirstChild("discounted")
			discounted.Visible = false
		elseif tower.PriceInRobux then
			local discount = self.Root:FindFirstChild("discount")
			discount.Text = Lang.Get(Lang.Strings.Shop.BuyWithRobux, tower.PriceInRobux)
		else
			warn("No PriceInRobux for tower", self.Root:GetFullName())
		end
	elseif attributes.BuyType == "SkinDiscount" then
		local skin = ShopDataV2.Items.Skins[attributes.BuyName]

		if skin and skin.ExpectedSkin then
			v2 = ClientUtil.OwnsItem("Skins", skin.ExpectedSkin)
		end

		if not v2 then
			local discount = self.Root:FindFirstChild("discount")
			discount.Text = Lang.Get(Lang.Strings.Shop.BuyWithRobux, skin.PriceInRobux)
			return
		end

		local text = self.Root:FindFirstChild("Text")
		text.Text = Lang.Get(Lang.Strings.Shop.Owned)
		local discount = self.Root:FindFirstChild("discount")
		discount.Visible = false
		local discounted = self.Root:FindFirstChild("Text"):FindFirstChild("discounted")
		discounted.Visible = false
	elseif attributes.BuyType == "Bundle" then
		local bundle = ShopDataV2.Items.Bundles[attributes.BuyName]

		if ClientUtil.OwnsItem("Bundles", attributes.BuyName) then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.Owned)
		else
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.BuyBundleForRobux, bundle.PriceInRobux)
		end
	elseif attributes.BuyType == "Emote" then
		local emote = ShopDataV2.Items.Emotes[attributes.BuyName]

		if Data.Get("Inventory").Emotes[attributes.BuyName] then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.Owned)
		elseif attributes.BuyForRobux == true then
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.BuyForRobux, emote.PriceInRobux)
		else
			local text = self.Root:FindFirstChild("Text")
			text.Text = Lang.Get(Lang.Strings.Shop.BuyForGold, emote.Price)
		end
	end
end

function UpdateLogPurchase:Init()
	local attributes = self.Root:GetAttributes()
	self.Cleaner:Add(self.Root.MouseButton1Click:Connect(function()
		if attributes.BuyType == "PowerUp" or attributes.BuyType == "PowerUpSingle" then
			Network.Invoke("PromptPurchasePowerUp", attributes.BuyName)
		elseif attributes.BuyType == "PowerUpSingleGold" then
			local powerUp = ShopDataV2.Items.PowerUps[attributes.BuyName]
			local currency = powerUp.Currency or "Gold"

			if Data.Get(currency) < powerUp.Price then
				UIHelper.ShowCurrencyShop(currency)
				return
			end

			Network.Fire("ClientPurchasePowerUpRequest", attributes.BuyName)
			v[math.random(1, #v)]:Play()
		elseif attributes.BuyType == "Tower" then
			local tower = ShopDataV2.Items.Towers[attributes.BuyName]

			if Util.XPToLevelAndProgress(Data.Get("XP")) < tower.MinLevel then
				if tower.ProductId and not tower.IsOffsale then
					MarketplaceService:PromptProductPurchase(Players.LocalPlayer, tower.ProductId)
				end
			else
				if Network.Invoke("PurchaseTower", attributes.BuyName, attributes.Source) then
					v[math.random(1, #v)]:Play()
					return
				end

				local currency = tower.Currency or "Gold"

				if Data.Get(currency) < ShopDataV2.Items.Towers[attributes.BuyName].Price then
					UIHelper.ShowCurrencyShop(currency)
				end
			end
		elseif attributes.BuyType == "TowerRobux" or attributes.BuyType == "TowerDiscount" then
			if Data.Get("Inventory").Towers[attributes.BuyName] then
				return
			end

			local tower = ShopDataV2.Items.Towers[attributes.BuyName]

			if tower.ProductId and not tower.IsOffsale then
				MarketplaceService:PromptProductPurchase(Players.LocalPlayer, tower.ProductId)
			end
		elseif attributes.BuyType == "Skin" or attributes.BuyType == "SkinDiscount" then
			local skin = ShopDataV2.Items.Skins[attributes.BuyName]

			if
				skin
				and skin.ExpectedSkin
				and not (ClientUtil.OwnsItem("Skins", skin.ExpectedSkin) or skin.IsOffsale)
			then
				MarketplaceService:PromptProductPurchase(Players.LocalPlayer, skin.ProductId)
			end
		elseif attributes.BuyType == "RobloxAsset" then
			MarketplaceService:PromptPurchase(Players.LocalPlayer, (tonumber(attributes.BuyName)))
		elseif attributes.BuyType == "Bundle" then
			local bundle = ShopDataV2.Items.Bundles[attributes.BuyName]

			if not (ClientUtil.OwnsItem("Bundles", attributes.BuyName) or bundle.IsOffsale) then
				MarketplaceService:PromptProductPurchase(Players.LocalPlayer, bundle.ProductId)
			end
		elseif attributes.BuyType == "Crates" then
			if
				PurchaseHelper.IsCratePurchaseRestricted(true, attributes.BuyName, attributes.BuyForRobux == true)
				or flag
			then
				return
			end

			flag = true

			if Network.Invoke(
				"ClientOpenCrateRequest",
				attributes.BuyName,
				attributes.BuyForRobux == true,
				attributes.Source
			) then
				v[math.random(1, #v)]:Play()

				for _, v2 in Director.GetItemsFromClass(Director.Classes.AnnouncementsWindow) do
					v2.Root.Visible = false
				end
			elseif
				not attributes.BuyForRobux
				and Data.Get("Gold") < ShopDataV2.Items.Crates[attributes.BuyName].Price
			then
				for _, v2 in Director.GetItemsFromClass(Sidebar) do
					v2:ShowFrame("GoldShop")
				end

				SoundHandler.Play("CurrencyJingle")
			end

			flag = false
		elseif attributes.BuyType == "Emote" then
			local emote = ShopDataV2.Items.Emotes[attributes.BuyName]
			local emote2 = Data.Get("Inventory").Emotes[attributes.BuyName]
			local buyForRobux = attributes.BuyForRobux == true

			if not emote2 then
				if buyForRobux and not emote.IsOffsale then
					MarketplaceService:PromptProductPurchase(Players.LocalPlayer, emote.ProductId)
				elseif Network.Invoke("PurchaseEmote", attributes.BuyName, attributes.Source) then
					v[math.random(1, #v)]:Play()
				elseif Data.Get("Gold") < emote.Price then
					for _, v2 in Director.GetItemsFromClass(Sidebar) do
						v2:ShowFrame("GoldShop", { Announcements = true })
					end

					SoundHandler.Play("CurrencyJingle")
				end
			end
		end
	end))
	self:UpdateDisplay()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Inventory" or p == "XP" then
			self:UpdateDisplay()
		end
	end))

	if attributes.BuyType == "RobloxAsset" then
		self.Cleaner:Add(MarketplaceService.PromptPurchaseFinished:Connect(function(p, p2, p3)
			if p == Players.LocalPlayer and p2 == tonumber(attributes.BuyName) and p3 then
				self:UpdateDisplay(true)
			end
		end))
	end
end

function UpdateLogPurchase.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { UpdateLogPurchase }, Players)
return UpdateLogPurchase