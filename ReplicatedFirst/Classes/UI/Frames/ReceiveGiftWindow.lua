local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Network = require(ReplicatedFirst.Client.Network)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local BattlePass = require(game.ReplicatedStorage.TDX_Shared.Modules.BattlePass)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
local ResourceManager = require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
require(ReplicatedStorage.TDX_Shared.Common.SkinHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local EnemyViewport = require(ReplicatedStorage.TDX_Shared.Common.EnemyViewport)
local ReceiveGiftWindow = { ClassName = script.Name, ClassModule = script }
ReceiveGiftWindow.__index = ReceiveGiftWindow
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local udim = UDim2.new(1, 0, 1, 0)
local udim2 = UDim2.new(0.5, 0, 0.5, 0)

local function GetViewport(p: string, p2: string, reveal, udim3: UDim2?) -- 2 equivalent calls inferred from this helper
	local viewport = TowerUtilities.GetViewport(reveal, p, p2)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

function ReceiveGiftWindow.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		QueuedGiftIndices = {},
		Queue = {},
		ProcessingQueue = false
	}, ReceiveGiftWindow))
end

function ReceiveGiftWindow:Init()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Gifts" then
			self:ProcessGifts()
		end
	end))

	repeat
		task.wait()
	until Data.Cache and Data.Cache.Gifts

	self:ProcessGifts()
end

function ReceiveGiftWindow:ProcessGifts()
	local function CheckCanClaim(data)
		if not data.Claimed then
			return true
		end

		if not (data.Type == "Skin" and data.OpenedTimestamp <= 1745736086) then
			return false
		end

		local item = data.Item
		local inventory = Data.Get("Inventory")
		local flag = false

		for _, v in pairs(inventory and inventory.Skins or {}) do
			if v == item then
				flag = true
			end
		end

		return not flag
	end

	print("processing gifts", Data.Get("Gifts"))

	for k, v in Data.Get("Gifts") do
		if not CheckCanClaim(v) or self.QueuedGiftIndices[k] then
			continue
		end

		local clone = table.clone(v)
		clone.GiftIndex = k
		table.insert(self.Queue, clone)
	end

	if not self.ProcessingQueue then
		print("processing queue")
		self:ProcessQueue()
	end
end

function ReceiveGiftWindow:ProcessQueue()
	self.ProcessingQueue = true
	local v = table.remove(self.Queue, 1)

	if v then
		print("processing gift", v)
		self.Root.Visible = true
		self.Root.Close.Visible = false
		self.Root.from.Text = "From ..."
		task.spawn(pcall, function()
			self.Root.from.Text = `From {Players:GetNameFromUserIdAsync(v.FromUserId)}`
		end)
		self.Root.ready.Visible = true
		self.Root.giftitem.Size = UDim2.new(0.75, 0, 0.75, 0)
		self.Root.reveal.Size = UDim2.new(0, 0, 0, 0)
		self.Root.label.Text = "YOU HAVE A GIFT"
		self.Root.ready.label.Text = "OPEN"
		self.Root.ready.MouseButton1Click:Wait()
		self.Root.ready.label.Text = "..."
		Network.Invoke("ClaimGiftRequest", v.GiftIndex)
		self.Root.ready.Visible = false
		TweenService:Create(self.Root.giftitem, tweenInfo, { Size = UDim2.new(0, 0, 0, 0) }):Play()

		for _, viewportFrame in self.Root.reveal:GetChildren() do
			if viewportFrame:IsA("ViewportFrame") then
				viewportFrame:Destroy()
			end
		end

		task.wait(0.1)
		TweenService:Create(self.Root.reveal, tweenInfo2, { Size = UDim2.new(0.75, 0, 0.75, 0) }):Play()

		if v.Type == "Tower" then
			self.Root.label.Text = Lang.Get(Lang.Strings.AssetInfo.Towers[v.Item].Name)
			self.Root.reveal.Image = ""
			GetViewport(v.Item, "", self.Root.reveal) -- inferred equivalent call
		elseif v.Type == "Crate" then
			self.Root.label.Text = Lang.Get(Lang.Strings.AssetInfo.Crates[v.Item].Name)
			self.Root.reveal.Image = ShopDataV2.Items.Crates[v.Item].Image
		elseif v.Type == "PowerUp" then
			self.Root.label.Text = Lang.Get(Lang.Strings.AssetInfo.PowerUps[v.Item].Name) .. ` (x{v.Count or 1})`
			self.Root.reveal.Image = PowerUpsData[v.Item].NoBGImage
		elseif v.Type == "Gold" then
			self.Root.label.Text = `{v.Count} GOLD`
			self.Root.reveal.Image = "rbxassetid://14608329033"
		elseif v.Type == "Crystals" then
			self.Root.label.Text = `{v.Count} CRYSTALS`
			self.Root.reveal.Image = "rbxassetid://93938811857380"
		elseif v.Type == "Skin" then
			local v2 = string.split(v.Item, "_")
			self.Root.label.Text = `{v2[2]} {v2[1]}`
			self.Root.reveal.Image = ""
			GetViewport(v2[1], v2[2], self.Root.reveal) -- inferred equivalent call
		elseif v.Type == "Bundle" then
			self.Root.label.Text = Lang.Get(Lang.Strings.AssetInfo.Bundles[v.Item].Name)
			self.Root.reveal.Image = ShopDataV2.Items.Bundles[v.Item].Image
		elseif v.Type == "BattlePass" then
			local passData = BattlePass.GetPassData(v.Item)
			self.Root.label.Text = `Battle Pass - {Lang.Get(passData.DisplayName)}`
			self.Root.reveal.Image = `rbxassetid://{passData.CardImage}`
		elseif v.Type == "NameTagEffect" then
			self.Root.label.Text = `Name Tag - {Lang.Get(Lang.Strings.AssetInfo.NameTagEffects[v.Item].Name)}`
			self.Root.reveal.Image = ShopDataV2.Items.NameTagEffects[v.Item].Image
		elseif v.Type == "DoubleTokens" then
			self.Root.label.Text = "2X TOKENS (1 HOUR)"
			self.Root.reveal.Image = Shared.DOUBLE_TOKENS_IMAGE
		elseif v.Type == "Enemies" then
			local success, enemyConfig = pcall(ResourceManager.GetEnemyConfig, v.Item)
			self.Root.label.Text = success and enemyConfig and (enemyConfig.OverrideDisplayName or v.Item) or v.Item
			self.Root.reveal.Image = ""
			EnemyViewport.Build(self.Root.reveal, v.Item)
		else
			self.Root.label.Text = v.Item
			self.Root.reveal.Image = ""
		end

		self.Root.Close.Visible = true
		self.Root.Close.MouseButton1Click:Wait()
		self:ProcessQueue()
		self.Root.Visible = false
	end

	self.ProcessingQueue = false
end

function ReceiveGiftWindow:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { ReceiveGiftWindow }, Players)
return ReceiveGiftWindow