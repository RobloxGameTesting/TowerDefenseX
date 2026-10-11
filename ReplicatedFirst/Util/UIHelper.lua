local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
require(TDX_Shared.Common.CurrencyTypes)

local function FindWindowHandler(p: string)
	for _, v in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		if v.Root.Name == p then
			return v
		end
	end

	error(`Failed to find WindowHandler {p}`)
end

local function FindClassInstance(instance, p: string)
	for _, v in Director.GetItemsFromClass(instance) do
		if v.Root.Parent.Name == p then
			return v
		end
	end

	error(`Failed to find {instance.ClassName} with in WindowHandler {p}`)
end

local UIHelper = {}

function UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK(flag: boolean, p)
	if flag == true then
		assert(p ~= nil, "Currency is not passed")
		UIHelper.ShowCurrencyShop(p)
	end
end

function UIHelper.ShowCurrencyShop(p)
	if not UIHelper.IsCurrencyPurchasable(p) then
		warn(`There is no currency shop for {p}`)
	end

	Director.GetFirstItemFromClass(Director.Classes.Sidebar):ShowFrame(`{p}Shop`)

	if p == "Crystals" then
		SoundHandler.Play("CrystalShopOpen")
	else
		SoundHandler.Play("CurrencyJingle")
	end
end

function UIHelper.IsCurrencyPurchasable(p)
	return p == "Gold" or p == "Crystals"
end

function UIHelper.HideMainShopWindows()
	for _, v in {
		Director.Classes.ShopWindowV2,
		Director.Classes.NewShopWindow,
		Director.Classes.CratePreview,
		Director.Classes.PowerUpPreview,
		Director.Classes.EnemyPreview,
		Director.Classes.TowerPreview,
		Director.Classes.BundlePreview
	} do
		for _, v2 in Director.GetItemsFromClass(v) do
			v2:HideMainWindow()
		end
	end

	for _, v in Director.GetItemsFromClass(Director.Classes.EventShopWindow) do
		v:Hide()
	end
end

function UIHelper.NavigateToWindow(p: string, p2: string, p3: string?, callback)
	local windowHandler = FindWindowHandler(p2)

	if p3 ~= nil then
		windowHandler:PushToBackStack(p3, callback)
	end

	windowHandler:Navigate(p)
end

function UIHelper.NavigateToCratePreview(p: string, p2: string, p3: string?, callback)
	FindClassInstance(Director.Classes.CratePreview, p):ShowCrate(p2)
	UIHelper.NavigateToWindow("CratePreview", p, p3, callback)
end

function UIHelper.NavigateToTowerPreview(p: string, p2: string, p3: string?, p4: string?, callback)
	FindClassInstance(Director.Classes.TowerPreview, p):ShowTowerAndSkin(p2, p3, false)
	UIHelper.NavigateToWindow("TowerPreview", p, p4, callback)
end

function UIHelper.NavigateToPowerUpPreview(p: string, p2: string, p3: string?, callback)
	FindClassInstance(Director.Classes.PowerUpPreview, p):ShowPowerUp(p2)
	UIHelper.NavigateToWindow("PowerUpPreview", p, p3, callback)
end

function UIHelper.NativateToEnemyPreview(p: string, p2: string, p3: string?, callback)
	FindClassInstance(Director.Classes.EnemyPreview, p):ShowEnemy(p2)
	UIHelper.NavigateToWindow("EnemyPreview", p, p3, callback)
end

function UIHelper.NavigateToBundlePreview(p: string, p2: string, p3: string?, callback)
	FindClassInstance(Director.Classes.BundlePreview, p):ShowBundle(p2)
	UIHelper.NavigateToWindow("BundlePreview", p, p3, callback)
end

function UIHelper.FindWindowHandlerGroup(parent)
	while parent and not parent:IsA("ScreenGui") do
		if parent:HasTag("WindowHandler") then
			return parent.Name
		else
			parent = parent.Parent
		end
	end

	return nil
end

function UIHelper.ShowPVPShop()
	Director.GetFirstItemFromClass(Director.Classes.PVPShopWindow):Show()
end

table.freeze(UIHelper)
return UIHelper