local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(TDX_Shared.Modules.DataTemplate)
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
require(script.Parent.Tabs)
local Shared = require(TDX_Shared.Modules.Shared)
local Data = require(TDX_Shared.Client.Services.Data)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
require(TDX_Shared.Modules.BattlePass)
require(TDX_Shared.Modules.Lang)
local Network = require(game.ReplicatedFirst.Client.Network)
local MagicShop = require(TDX_Shared.Modules.MagicShop)
local MagicShopWindow = { ClassName = script.Name, ClassModule = script }
MagicShopWindow.__index = MagicShopWindow

function MagicShopWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, MagicShopWindow))
end

function MagicShopWindow:Init()
	Data.Updated:Connect(function(p: string)
		if p == "MagicShop" or p == "Gold" then
			self:Update()
		end
	end)
	self:Update()
	self.Root.Frame.Header.Refresh.Activated:Connect(function()
		if Shared.IS_DEV_PLACE and not RunService:IsStudio() then
			Network.Fire("ClientRequestFreeMagicShopRefresh")
		else
			MarketplaceService:PromptProductPurchase(Players.LocalPlayer, Shared.MAGIC_SHOP_REFRESH_PRODUCT_ID)
		end
	end)
	Network.HookEvent("MagicShopDespawn", function()
		self.Root.Visible = false
	end)
	self:OnEndTimeChanged()
	workspace:GetAttributeChangedSignal(MagicShop.ATTR_MAGIC_SHOP_END_TIME):Connect(function()
		self:OnEndTimeChanged()
	end)
	self.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		if self.Root.Visible then
			SoundHandler.Play("MagicShopOpen")
		end
	end)
end

function MagicShopWindow:Update()
	self.Cleaner:Clean()
	local magicShop = Data.Get("MagicShop")
	local v, v2 = next(magicShop.Entries)

	if not v then
		warn("No entry")
		return
	end

	local child = self.Root.Templates:FindFirstChild(v2.Type)

	if not child then
		warn(`Unknown entry type: {v2.Type}`)
		return
	end

	local clone = child:Clone()
	clone.Parent = self.Root.Frame.ShopEntryHolder

	if v2.Type == "GoldToCrystalsConversion" then
		clone.Available.Text = `{v2.RemainingCrystals} CRYSTALS REMAINING`
		clone.Frame.Gold.Value.Amount.Text = v2.GoldRatio
		clone.Frame.Crystals.Value.Amount.Text = "1"
		clone.Convert1.Visible = v2.RemainingCrystals > 0
		clone.Convert10.Visible = v2.RemainingCrystals > 0
		local gold = Data.Get("Gold")
		clone.CannotConvert1.Visible = v2.RemainingCrystals < 1 or gold < v2.GoldRatio
		clone.CannotConvert10.Visible = v2.RemainingCrystals < 10 or gold < v2.GoldRatio * 10

		if v2.RemainingCrystals < 0 then
			clone.CannotConvert1.label.Text = "No crystals remaining"
		elseif gold < v2.GoldRatio then
			clone.CannotConvert1.label.Text = "Not enough gold"
		end

		if v2.RemainingCrystals < 10 then
			clone.CannotConvert10.label.Text = "No crystals remaining"
		elseif gold < v2.GoldRatio * 10 then
			clone.CannotConvert10.label.Text = "Not enough gold"
		end
	elseif v2.Type == "CrystalsToCookiesConversion" then
		clone.Available.Text = `{v2.RemainingCrystals} COOKIES REMAINING`
		clone.Frame.Crystals.Value.Amount.Text = v2.GoldRatio
		clone.Frame.Cookies.Value.Amount.Text = "1"
		clone.Convert1.Visible = v2.RemainingCrystals > 0
		local crystals = Data.Get("Crystals")
		clone.CannotConvert1.Visible = v2.RemainingCrystals < 1 or crystals < v2.GoldRatio

		if v2.RemainingCrystals < 0 then
			clone.CannotConvert1.label.Text = "No crystals remaining"
		elseif crystals < v2.GoldRatio then
			clone.CannotConvert1.label.Text = "Not enough gold"
		end
	end

	self.Cleaner:Add(clone)
	self.Cleaner:Add(clone.Convert1.Activated:Connect(function()
		Network.Fire("ClientRequestPurchaseMagicShopEntry", v, 1)
		SoundHandler.Play("MagicShopCrystalsPurchase")
	end))

	if clone:FindFirstChild("Convert10") then
		self.Cleaner:Add(clone.Convert10.Activated:Connect(function()
			Network.Fire("ClientRequestPurchaseMagicShopEntry", v, 10)
			SoundHandler.Play("MagicShopCrystalsPurchase")
		end))
	end
end

function MagicShopWindow:OnEndTimeChanged()
	local attribute = workspace:GetAttribute(MagicShop.ATTR_MAGIC_SHOP_END_TIME)

	if self.TimerThread then
		task.cancel(self.TimerThread)
		self.TimerThread = nil
	end

	if attribute ~= nil and os.time() < attribute then
		self.TimerThread = task.spawn(function()
			local now = os.time()

			while now <= attribute do
				local v = attribute - now
				self.Root.Frame.Header.Timer.Text = string.format("Leaving in %02d:%02d", v // 60, v % 60)
				task.wait(1)
				now = os.time()
			end
		end)
	end
end

function MagicShopWindow.Destroy(_) end

Director.Register(script.Name, { MagicShopWindow }, game.Players)
return MagicShopWindow