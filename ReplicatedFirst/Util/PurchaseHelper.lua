local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Director = require(TDX_Shared.Modules.Director)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local ShopUtil = require(ReplicatedStorage.Modules.ShopUtil)
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local Data = require(TDX_Shared.Client.Services.Data)
local Network = require(ReplicatedFirst.Client.Network)
local Util = require(TDX_Shared.Modules.Util)
local Lang = require(TDX_Shared.Modules.Lang)
local Shared = require(TDX_Shared.Modules.Shared)
local UIHelper = require(script.Parent.UIHelper)
require(ReplicatedFirst.Classes.UI.V2.PopupWindows)
require(ReplicatedStorage.TDX_Shared.Common.CurrencyTypes)
local Crates = require(TDX_Shared.Modules.Crates)
local ItemDiscountClient = require(ReplicatedFirst.Client.ItemDiscountClient)
local ClientUtil = require(script.Parent.ClientUtil)
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
local v2 = utf8.char(57346)
local LocalPlayer = Players.LocalPlayer
local v3 = nil

local function GetPopupWindow() -- 19 equivalent calls inferred from this helper
	return Director.GetFirstItemFromClass(Director.Classes.PopupWindows)
end

local function CreatePopupOptions(displayName: string, internalName: string, itemType: string, currency, price: number, currentBalance: number, titleVerb: string?)
	return {
		ItemOptions = {
			DisplayName = displayName,
			InternalName = internalName,
			ItemType = itemType,
			Currency = currency,
			Price = price,
			CurrentBalance = currentBalance,
			TitleVerb = titleVerb
		}
	}
end

local function PlayRandomPurchaseSound() -- 9 equivalent calls inferred from this helper
	v[math.random(1, #v)]:Play()
end

local PurchaseHelper = { OpeningCrateDebounce = false }

function PurchaseHelper.PromptPurchaseWithRobux(p: string, p2: string)
	local v4 = ShopDataV2.Items[p][p2]

	if not v4 then
		error(`Unknown {p}: {p2}`)
	end

	if v4.IsOffsale then
		return
	end

	if v4.PriceInRobux and v4.ProductId then
		MarketplaceService:PromptProductPurchase(Players.LocalPlayer, v4.ProductId)
	else
		warn(`Invalid PromptPurchaseWithRobux call for {p}:{p2}: item not for sale for Robux`)
	end
end

function PurchaseHelper.PromptTowerPurchase(name: string, callback)
	local tower = ShopDataV2.Items.Towers[name]

	if not tower then
		error(`Unknown tower {name}`)
	end

	if tower.IsRobuxOnly or tower.IsOffsale then
		warn(`Tower {name} is offsale or Robux only`)
		return
	end

	local currency = tower.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "Towers", Name = name }) or tower.Price
	local popupOptions = CreatePopupOptions(
		Lang.Get(Lang.Strings.AssetInfo.Towers[name].Name),
		name,
		"Towers",
		currency,
		v5,
		v4
	)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true and Network.Invoke("PurchaseTower", name, "Shop") then
				PlayRandomPurchaseSound() -- inferred equivalent call
				Data.Update("Inventory", function(p)
					p.Towers[name] = true
					return p
				end)

				if callback then
					callback()
				end
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.PromptPurchaseCrate(name: string)
	local crate = ShopDataV2.Items.Crates[name]

	if not crate then
		error(`Unknown crate {name}`)
	end

	if crate.IsRobuxOnly or crate.IsOffsale then
		warn(`Crate {name} is offsale or Robux only`)
		return
	end

	if PurchaseHelper.IsCratePurchaseRestricted(true, name, false) then
		return
	end

	local currency = crate.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "Crates", Name = name }) or crate.Price
	local popupOptions = CreatePopupOptions(
		Lang.Get(Lang.Strings.AssetInfo.Crates[name].Name),
		name,
		"Crates",
		currency,
		v5,
		v4
	)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true then
				if PurchaseHelper.OpeningCrateDebounce then
					return
				end

				PurchaseHelper.OpeningCrateDebounce = true

				if Network.Invoke("ClientOpenCrateRequest", name, false, "Shop") then
					PlayRandomPurchaseSound() -- inferred equivalent call
					UIHelper.HideMainShopWindows()
				end

				PurchaseHelper.OpeningCrateDebounce = false
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.PromptPowerUpPurchase(name: string)
	local powerUp = ShopDataV2.Items.PowerUps[name]

	if not powerUp then
		error(`Unknown powerup {name}`)
	end

	if powerUp.IsRobuxOnly or powerUp.IsOffsale then
		warn(`Powerup {name} is offsale or Robux only`)
		return
	end

	local currency = powerUp.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "PowerUps", Name = name }) or powerUp.Price
	local popupOptions = CreatePopupOptions(
		Lang.Get(Lang.Strings.AssetInfo.PowerUps[name].Name),
		name,
		"PowerUps",
		currency,
		v5,
		v4
	)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true then
				Network.Fire("ClientPurchasePowerUpRequest", name)
				PlayRandomPurchaseSound() -- inferred equivalent call
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.PromptSkinPurchase(name: string)
	local skin = ShopDataV2.Items.Skins[name]

	if not skin then
		error(`Unknown skin {name}`)
	end

	if skin.IsRobuxOnly or skin.IsOffsale or skin.FromCrate then
		warn(`Powerup {name} is offsale, Robux only, or from a crate`)
		return
	end

	local currency = skin.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "Skins", Name = name }) or skin.Price
	local v6, v7 = unpack(string.split(name, "_"))
	local popupOptions = CreatePopupOptions(
		`{v6} - {Crates.GetSkinData(name).DisplayName or v7}`,
		name,
		"Skins",
		currency,
		v5,
		v4
	)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true and Network.Invoke("PurchaseSkin", name) then
				PlayRandomPurchaseSound() -- inferred equivalent call
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.PromptNameTagEffectPurchase(name: string)
	local nameTagEffect = ShopDataV2.Items.NameTagEffects[name]

	if not nameTagEffect then
		error(`Unknown name tag effect {name}`)
	end

	if nameTagEffect.IsRobuxOnly or nameTagEffect.IsOffsale then
		warn(`Powerup {name} is offsale or Robux only`)
		return
	end

	local currency = nameTagEffect.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "NameTagEffects", Name = name }) or nameTagEffect.Price
	local popupOptions = CreatePopupOptions(
		Lang.Get(Lang.Strings.AssetInfo.NameTagEffects[name].Name),
		name,
		"NameTagEffects",
		currency,
		v5,
		v4
	)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true and Network.Invoke("PurchaseNameTagEffect", name) then
				PlayRandomPurchaseSound() -- inferred equivalent call
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.PromptEmotePurchase(name: string)
	local emote = ShopDataV2.Items.Emotes[name]

	if not emote then
		error(`Unknown emote {name}`)
	end

	if emote.IsRobuxOnly or emote.IsOffsale then
		warn(`Emote {name} is offsale or Robux only`)
		return
	end

	local currency = emote.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "Emotes", Name = name }) or emote.Price
	local popupOptions = CreatePopupOptions(
		Lang.Get(Lang.Strings.AssetInfo.Emotes[name].Name),
		name,
		"Emotes",
		currency,
		v5,
		v4
	)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true and Network.Invoke("PurchaseEmote", name) then
				PlayRandomPurchaseSound() -- inferred equivalent call
				Data.Update("Inventory", function(p)
					p.Emotes[name] = true
					return p
				end)
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.PromptEnemyPurchase(name: string)
	local enemy = ShopDataV2.Items.Enemies[name]

	if not enemy then
		error(`Unknown enemy {name}`)
	end

	if enemy.IsRobuxOnly or enemy.IsOffsale then
		warn(`enemy {name} is offsale or Robux only`)
		return
	end

	local currency = enemy.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "Enemies", Name = name }) or enemy.Price
	local popupOptions = CreatePopupOptions(name, name, "Enemies", currency, v5, v4)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true and Network.Invoke("PurchaseEnemy", name) then
				PlayRandomPurchaseSound() -- inferred equivalent call
				Data.Update("Inventory", function(p)
					p.Enemies[name] = true
					return p
				end)
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.PromptBundlePurchase(name: string)
	local bundle = ShopDataV2.Items.Bundles[name]

	if not bundle then
		error(`Unknown bundle {name}`)
	end

	if bundle.IsRobuxOnly or bundle.IsOffsale then
		warn(`Bundle {name} is offsale or Robux only`)
		return
	end

	local currency = bundle.Currency or "Gold"
	local v4 = Data.Get(currency)
	local v5 = ItemDiscountClient.GetPriceWithDiscount({ Type = "Bundles", Name = name }) or bundle.Price
	local popupOptions = CreatePopupOptions(
		Lang.Get(Lang.Strings.AssetInfo.Bundles[name].Name),
		name,
		"Bundles",
		currency,
		v5,
		v4
	)

	if v5 <= v4 then
		GetPopupWindow():DoPopup("Confirmation", function(flag: boolean) -- inferred equivalent call
			if flag == true and Network.Invoke("PurchaseBundle", name) then
				PlayRandomPurchaseSound() -- inferred equivalent call
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.GetPurchaseMode(p: string, p2: string)
	local v4 = ShopDataV2.Items[p][p2]

	if v4.FromCrate or v4.FromBundle then
		return "FromCrate"
	end

	if v4.IsRobuxOnly then
		return "RobuxOnly"
	end

	if v4.PriceInRobux == nil then
		return "CurrencyOnly"
	end

	return "Both"
end

function PurchaseHelper.ArePaidRandomItemsRestricted()
	if Shared.FORCE_PAID_RANDOM_ITEMS_RESTRICTED then
		return true
	end

	if v3 ~= nil then
		return v3
	end

	local success, policyInfoForPlayerAsync = pcall(
		PolicyService.GetPolicyInfoForPlayerAsync,
		PolicyService,
		LocalPlayer
	)

	if success then
		v3 = policyInfoForPlayerAsync.ArePaidRandomItemsRestricted == true
		return v3
	end

	warn(`Failed to get policy info: {policyInfoForPlayerAsync}`)
	return true
end

function PurchaseHelper.GetBuyAllCrateSkinsInfo(p: string)
	return ShopUtil.GetBuyAllCrateSkinsInfo(p, ClientUtil.GetOwnedSkinsSet())
end

function PurchaseHelper.PromptBuyAllCrateSkins(internalName: string, flag: boolean)
	local buyAllCrateSkinsInfo = PurchaseHelper.GetBuyAllCrateSkinsInfo(internalName)

	if not buyAllCrateSkinsInfo then
		return
	end

	local v4

	if flag then
		v4 = buyAllCrateSkinsInfo.ProductId ~= nil
	else
		v4 = buyAllCrateSkinsInfo.Price == nil
	end

	if v4 then
		MarketplaceService:PromptProductPurchase(LocalPlayer, buyAllCrateSkinsInfo.ProductId)
		return
	end

	local price = buyAllCrateSkinsInfo.Price
	local currentBalance = Data.Get(buyAllCrateSkinsInfo.Currency)
	local v5 = Lang.Get(Lang.Strings.AssetInfo.Crates[internalName].Name)
	local popupOptions = CreatePopupOptions(
		`{#buyAllCrateSkinsInfo.MissingSkins} {v5} Skins`,
		internalName,
		"Crates",
		buyAllCrateSkinsInfo.Currency,
		price,
		currentBalance,
		"Buy"
	)

	if price <= currentBalance then
		GetPopupWindow():DoPopup("Confirmation", function(flag2: boolean) -- inferred equivalent call
			if flag2 == true and Network.Invoke("PurchaseAllCrateSkins", internalName) then
				PlayRandomPurchaseSound() -- inferred equivalent call
			end
		end, popupOptions)
	else
		GetPopupWindow():DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, popupOptions) -- inferred equivalent call
	end
end

function PurchaseHelper.IsCratePurchaseRestricted(flag: boolean?, p: string?, flag2: boolean?)
	local arePaidRandomItemsRestricted = PurchaseHelper.ArePaidRandomItemsRestricted()

	if not (arePaidRandomItemsRestricted and flag) then
		return arePaidRandomItemsRestricted
	end

	local popupWindow = GetPopupWindow() -- inferred equivalent call
	local v4 = p and PurchaseHelper.GetBuyAllCrateSkinsInfo(p)
	local description = "You are restricted from purchasing paid random items due to your region/account settings"
	local primaryButtonText, secondaryButtonText

	if v4 then
		local v5

		if flag2 then
			v5 = v4.ProductId ~= nil
		else
			v5 = v4.Price == nil
		end

		local v6

		if v5 then
			v6 = `{v2} {Util.FormatCurrency(v4.PriceInRobux)}`
		else
			v6 = `{Util.FormatCurrency(v4.Price)} {v4.Currency}`
		end

		local v7 = Lang.Get(Lang.Strings.AssetInfo.Crates[p].Name)
		description ..= `, but you can buy all {#v4.MissingSkins} skins from the {v7} at once for {v6}.`
		primaryButtonText = "Buy All"
		secondaryButtonText = "Cancel"
	else
		primaryButtonText = "OK"
		secondaryButtonText = ""
	end

	popupWindow:DoPopup("TextConfirmation", function(flag3: boolean)
		if v4 and flag3 then
			PurchaseHelper.PromptBuyAllCrateSkins(p, flag2 == true)
		end
	end, {
		TextConfirmationOptions = {
			Title = "Purchase Restricted",
			Subtitle = "Paid Random Item Purchase Restricted",
			Description = description,
			PrimaryButtonText = primaryButtonText,
			SecondaryButtonText = secondaryButtonText,
			Color = Color3.fromRGB(255, 60, 60)
		}
	})
	return arePaidRandomItemsRestricted
end

task.spawn(PurchaseHelper.ArePaidRandomItemsRestricted)
return PurchaseHelper