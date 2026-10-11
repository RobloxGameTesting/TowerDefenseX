local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Lang = require(TDX_Shared.Modules.Lang)
require(TDX_Shared.Modules.Shared)
local VIP_GAMEPASS_ID = _G.VIP_GAMEPASS_ID
local color = Color3.fromRGB(0, 0, 0)
local color2 = Color3.fromRGB(255, 255, 255)
local event = NetworkingHandler.GetEvent("GamepassPurchased")
local LocalPlayer = Players.LocalPlayer
local v = nil
local VIPPurchaseScreen = { ClassName = script.Name, ClassModule = script }
VIPPurchaseScreen.__index = VIPPurchaseScreen

function VIPPurchaseScreen.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Hovered = false, Enabled = true }, VIPPurchaseScreen))
end

function VIPPurchaseScreen:Init()
	local buyButton = self.Root:FindFirstChild("BuyButton")
	local success, result = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, VIP_GAMEPASS_ID)
	end)
	_ = success
	v = result
	self.Enabled = v ~= true
	self.Cleaner:Add(buyButton.MouseEnter:Connect(function()
		self:Hover()
	end))
	self.Cleaner:Add(buyButton.MouseLeave:Connect(function()
		self:Unhover()
	end))
	self.Cleaner:Add(buyButton.Activated:Connect(function()
		if self.Enabled then
			SoundHandler.Play("ShopSelectOption")
			MarketplaceService:PromptGamePassPurchase(LocalPlayer, VIP_GAMEPASS_ID)
		end
	end))
	self:UpdateState()
end

function VIPPurchaseScreen:UpdateState()
	local buyButton = self.Root:FindFirstChild("BuyButton")
	local text = buyButton:FindFirstChild("Text")
	local hovered = buyButton:FindFirstChild("Hovered")
	local owned = buyButton:FindFirstChild("Owned")

	if self.Enabled then
		if self.Hovered then
			hovered.ImageTransparency = 0
		else
			hovered.ImageTransparency = 1
		end

		owned.ImageTransparency = 1
	else
		hovered.ImageTransparency = 1
		owned.ImageTransparency = 0
	end

	if self.Enabled then
		text.Text = Lang.Get(Lang.Strings.Shop.BuyNow)
		text.TextColor3 = color
	else
		text.Text = Lang.Get(Lang.Strings.Shop.Owned)
		text.TextColor3 = color2
	end
end

function VIPPurchaseScreen:Hover()
	self.Hovered = true
	self:UpdateState()
end

function VIPPurchaseScreen:Unhover()
	self.Hovered = false
	self:UpdateState()
end

function VIPPurchaseScreen:Enable()
	self.Enabled = true
	self:UpdateState()
end

function VIPPurchaseScreen:Disable()
	self.Enabled = false
	self:UpdateState()
end

function VIPPurchaseScreen.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { VIPPurchaseScreen })
event:AttachCallback(function(p: number)
	if p == VIP_GAMEPASS_ID then
		for k, v2 in Director.GetItemsFromClass(Director.Classes.VIPPurchaseScreen) do
			v2:Disable()
		end

		SoundHandler.Play("GamepassPurchaseSuccess")
		v = true
	end
end)
return VIPPurchaseScreen