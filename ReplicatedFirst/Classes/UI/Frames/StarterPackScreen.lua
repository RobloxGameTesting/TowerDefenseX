local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = game:GetService("RunService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Utilities = require(Common:WaitForChild("Utilities"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
require(TDX_Shared.Modules.Shared)
local Data = require(TDX_Shared.Client.Services.Data)
local Network = require(ReplicatedFirst.Client.Network)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local STARTERPACK_TIME = _G.STARTERPACK_TIME
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(255, 255, 255)
local gui = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GUI")
local dailyRewards = gui:WaitForChild("DailyRewards")
local StarterPackScreen = { ClassName = script.Name, ClassModule = script }
StarterPackScreen.__index = StarterPackScreen

function StarterPackScreen.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Hovered = false, Enabled = true }, StarterPackScreen))
end

function StarterPackScreen:Init()
	local root = self.Root
	local buy = root.buy
	self.BuyButton = buy
	self.BuyButtonText = buy.label
	self.OriginalText = buy.label.Text
	self.TimerTextLabel1 = root.timer
	self:_InitStarterPackOpenFrame()
	self.IsFirstGame = Data.Get("GamesPlayed") < 1
	self.HasBeenOpened = false
	buy.label.Text = Lang.Get(Lang.Strings.Shop.BuyWithRobux, _G.STARTER_PACK_PRICE_IN_ROBUX)
	self.Cleaner:Add(buy.Activated:Connect(function()
		if self.Enabled then
			SoundHandler.Play("ShopSelectOption")
			Network.Fire("ClientRequestBuyStarterPack")
		end
	end))
	self.StarterPackTimer = Data.Get("StarterPackTimer")
	self.Cleaner:Add(RunService.Heartbeat:Connect(function()
		if self.Expired then
			return
		end

		local v = os.time() - self.StarterPackTimer
		local v2 = math.max(0, STARTERPACK_TIME - v)
		local convertToTimeStringFull = Utilities.ConvertToTimeStringFull(v2)
		self.TimerTextLabel1.Text = convertToTimeStringFull
		self.TimerTextLabel2.Text = ("%s LEFT"):format(convertToTimeStringFull)

		if
			v2 > 0
			and not self.PurchasedStarterPack
			and self.IsFirstGame
			and not (self.HasBeenOpened or dailyRewards.Visible)
		then
			self.Root.Visible = true
			self.HasBeenOpened = true
		end

		if v2 <= 0 then
			self:SetExpired()
		end
	end))
	self.PurchasedStarterPack = Data.Get("PurchasedStarterPack")
	Data.Updated:Connect(function(p)
		if p == "PurchasedStarterPack" then
			local purchasedStarterPack = Data.Get("PurchasedStarterPack")

			if purchasedStarterPack ~= self.PurchasedStarterPack then
				self.PurchasedStarterPack = purchasedStarterPack
				SoundHandler.Play("GamepassPurchaseSuccess")
			end

			self:UpdateState()
		end
	end)
	self:UpdateState()
end

function StarterPackScreen:_InitStarterPackOpenFrame()
	local starterPackOpen = gui:FindFirstChild("XPLevel"):FindFirstChild("QueueFrame"):FindFirstChild("StarterPackOpen")
	local textButton = starterPackOpen:FindFirstChild("TextButton")
	local text = starterPackOpen:FindFirstChild("Text")
	local background = starterPackOpen:WaitForChild("Background")
	local plus = starterPackOpen:WaitForChild("Plus")
	self.StarterPackOpenFrame = starterPackOpen
	self.TimerTextLabel2 = text
	self.Cleaner:Add(textButton.MouseEnter:Connect(function()
		background.ImageColor3 = color2
		plus.Image = "rbxassetid://15344491224"
	end))
	self.Cleaner:Add(textButton.MouseLeave:Connect(function()
		background.ImageColor3 = color
		plus.Image = "rbxassetid://15344491300"
	end))
	self.Cleaner:Add(textButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(textButton.Activated:Connect(function()
		for _, v in Director.GetItemsFromClass(Director.Classes.Sidebar) do
			v:ShowFrame("StarterPack")
		end

		if self.Root.Visible then
			self.HasBeenOpened = true
		end

		SoundHandler.Play("ClickUp")
	end))
	self.Cleaner:Add(starterPackOpen.buy.MouseButton1Click:Connect(function()
		if self.Enabled then
			SoundHandler.Play("ShopSelectOption")
			Network.Fire("ClientRequestBuyStarterPack")
		end
	end))
	starterPackOpen.buy.label.Text = Lang.Get(Lang.Strings.Shop.BuyWithRobux, _G.STARTER_PACK_PRICE_IN_ROBUX)
end

function StarterPackScreen:SetExpired()
	self.Expired = true
	self:UpdateState()
end

function StarterPackScreen:UpdateState()
	local root = self.Root
	local starterPackOpenFrame = self.StarterPackOpenFrame

	if self.PurchasedStarterPack or self.Expired then
		root.Visible = false
		starterPackOpenFrame.Visible = false
	else
		starterPackOpenFrame.Visible = true
	end
end

function StarterPackScreen.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { StarterPackScreen }, gui)
return StarterPackScreen