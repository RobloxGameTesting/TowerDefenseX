local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Network = require(ReplicatedFirst.Client.Network)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local BattlePass = require(ReplicatedStorage.TDX_Shared.Modules.BattlePass)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
local ResourceManager = require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
require(ReplicatedStorage.TDX_Shared.Common.SkinHandler)
local EnemyViewport = require(ReplicatedStorage.TDX_Shared.Common.EnemyViewport)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
local ViewportCuller = require(ReplicatedFirst.Util.ViewportCuller)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local color = Color3.new(1, 1, 1)
local color2 = Color3.new(0.7, 0.7, 0.7)
local color3 = Color3.fromRGB(167, 91, 238)
local color4 = Color3.fromRGB(117, 64, 166)
local color5 = Color3.fromRGB(113, 113, 113)
local color6 = Color3.fromRGB(184, 126, 233)
local v = {
	[Enums.GiftingResult.PlayerLeftGame] = "User is no longer in-game.",
	[Enums.GiftingResult.AlreadyOwned] = "User already owns that item.",
	[Enums.GiftingResult.AlreadyOwnsAllSkinsInCrate] = "User already owns all items in that crate.",
	[Enums.GiftingResult.CapacityReached] = "User is at maximum capacity for that item.",
	[Enums.GiftingResult.PlayerIdInvalid] = "User ID is invalid.",
	[Enums.GiftingResult.PlayerDataNotLoaded] = "User's data has not loaded yet.",
	[Enums.GiftingResult.UnknownGiftType] = "Unknown gift type",
	[Enums.GiftingResult.UnknownGiftItem] = "Unknown gift item",
	[Enums.GiftingResult.ProductIdResolutionFailure] = "Could not resolve product ID",
	[Enums.GiftingResult.NoActiveBattlePass] = "User doesn't have an active battle pass."
}
local udim = UDim2.new(1, 0, 1, 0)
local udim2 = UDim2.new(0.5, 0, 0.5, 0)

local function GetViewport(p: string, p2: string, icon, udim3: UDim2?) -- 1 equivalent call inferred from this helper
	local viewport = TowerUtilities.GetViewport(icon, p, p2)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

local GiftingWindow = { ClassName = script.Name, ClassModule = script }
GiftingWindow.__index = GiftingWindow

function GiftingWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Error = false }, GiftingWindow))
end

function GiftingWindow:Init()
	self:SetErrorState(nil)

	for _, v2 in { "gift", "user" } do
		local child = self.Root:FindFirstChild(`{v2}search`)
		local child2 = self.Root:FindFirstChild(`{v2}dropdown`)
		local v3 = false
		self.Cleaner:Add(child2.MouseEnter:Connect(function()
			v3 = true
		end))
		self.Cleaner:Add(child2.MouseLeave:Connect(function()
			v3 = false

			if child.TextBox.Text == "" and child.focus.Visible == false and child2.Visible then
				child2.Visible = false
			end
		end))
		self.Cleaner:Add(child.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
			self:UpdateDropdown(child2, child.TextBox.Text)
		end))
		self.Cleaner:Add(child.TextBox.Focused:Connect(function()
			child.hover.Visible = false
			child.focus.Visible = true
			child.icon.ImageColor3 = color6
			self:UpdateDropdown(child2, child.TextBox.Text)
			child2.Visible = true
		end))
		self.Cleaner:Add(child.TextBox.FocusLost:Connect(function()
			child.focus.Visible = false
			child.icon.ImageColor3 = color5

			if child.TextBox.Text == "" and not v3 then
				child2.Visible = false
			end
		end))
		self.Cleaner:Add(child.MouseEnter:Connect(function()
			if child.focus.Visible == false then
				child.hover.Visible = true
			end
		end))
		self.Cleaner:Add(child.MouseLeave:Connect(function()
			child.hover.Visible = false
		end))
	end

	self.Cleaner:Add(self.Root.userselection.Close.MouseButton1Click:Connect(function()
		self:SetTargetPlayerId(nil, nil)
	end))
	self.Cleaner:Add(self.Root.giftselection.Close.MouseButton1Click:Connect(function()
		self:SetTargetGift(nil, nil, nil)
	end))
	self.Cleaner:Add(self.Root.gift.MouseButton1Click:Connect(function()
		if
			Network.Invoke(
				"ClientGetGiftingValidRequest",
				self.TargetUserId or 0,
				self.GiftName or "N/A",
				self.GiftCategory or "N/A"
			) == Enums.GiftingResult.Success
			and self.GiftCategory
			and self.GiftName
			and self.TargetUserId
		then
			Network.Fire("ClientPromptGiftForUserId", self.GiftName, self.GiftCategory, self.TargetUserId)
			self:SetTargetPlayerId(nil, nil)
			self:SetTargetGift(nil, nil, nil)
		end
	end))
	self.Cleaner:Add(self.Root.Close.MouseButton1Click:Connect(function()
		for _, v2 in Director.GetItemsFromClass(Director.Classes.PopupWindows) do
			v2:HideAll()
		end
	end))

	local function handlePlayer(p)
		if p == Players.LocalPlayer and RunService:IsStudio() == false then
			return
		end

		local userId = p.UserId

		if self.Root.userdropdown.ScrollingFrame:FindFirstChild(p.Name) == nil then
			local clone = self.Root.userdropdown.ScrollingFrame.template:Clone()
			clone.Name = p.Name
			clone.Frame.level.Text = p.Name
			clone.Frame.icon.Image = Players:GetUserThumbnailAsync(
				p.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size60x60
			)
			clone.TextButton.MouseButton1Click:Connect(function()
				self:SetTargetPlayerId(userId, p.Name)
			end)
			clone.Parent = self.Root.userdropdown.ScrollingFrame
		end
	end

	self.Cleaner:Add(Players.PlayerAdded:Connect(handlePlayer))

	for _, v2 in Players:GetPlayers() do
		task.spawn(handlePlayer, v2)
	end

	self.Cleaner:Add(Players.PlayerRemoving:Connect(function(player)
		local child = self.Root.userdropdown.ScrollingFrame:FindFirstChild(player.Name)

		if child then
			child:Destroy()
		end
	end))
	local v2 = ViewportCuller.new(self.Root.giftdropdown.ScrollingFrame)
	self.Cleaner:Add(v2)

	local function clearViewports(icon)
		for _, viewportFrame in icon:GetChildren() do
			if viewportFrame:IsA("ViewportFrame") then
				viewportFrame:Destroy()
			end
		end
	end

	for k, tower in ShopDataV2.Items.Towers do
		if tower.IsOffsale or tower.ProductId == nil then
			continue
		end

		local v3 = Lang.Get(Lang.Strings.AssetInfo.Towers[k].Name)
		local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
		clone.Name = v3
		clone.Frame.level.Text = v3
		clone.Frame.iconbg.icon.Image = ""
		local v4 = k
		clone.TextButton.MouseButton1Click:Connect(function()
			self:SetTargetGift("Tower", v4, v3)
		end)
		clone.Parent = self.Root.giftdropdown.ScrollingFrame
		local v5 = k
		v2:Add(clone, function()
			return GetViewport(v5, "", clone.Frame.iconbg.icon) -- inferred equivalent call
		end, function()
			clearViewports(clone.Frame.iconbg.icon)
		end)
	end

	if _G.PVP_SHOP_ENABLED then
		for k, enemy in ShopDataV2.Items.Enemies do
			if enemy.IsOffsale or enemy.ProductId == nil then
				continue
			end

			local overrideDisplayName = ResourceManager.GetEnemyConfig(k).OverrideDisplayName or k
			local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
			clone.Name = overrideDisplayName
			clone.Frame.level.Text = `Enemy - {overrideDisplayName}`
			clone.Frame.iconbg.icon.Image = ""
			local v3 = k
			clone.TextButton.MouseButton1Click:Connect(function()
				self:SetTargetGift("Enemies", v3, overrideDisplayName)
			end)
			clone.Parent = self.Root.giftdropdown.ScrollingFrame
			local v4 = k
			local v5 = enemy
			v2:Add(clone, function()
				return EnemyViewport.Build(clone.Frame.iconbg.icon, v4, {
					RotationOffset = v5.ViewportRotationOffset,
					Zoom = v5.ViewportZoom
				})
			end, function()
				clearViewports(clone.Frame.iconbg.icon)
			end)
		end
	end

	if not PurchaseHelper.ArePaidRandomItemsRestricted() then
		for k, crate in ShopDataV2.Items.Crates do
			if crate.IsOffsale or crate.ProductId == nil then
				continue
			end

			local v3 = Lang.Get(Lang.Strings.AssetInfo.Crates[k].Name)
			local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
			clone.Name = v3
			clone.Frame.level.Text = v3
			clone.Frame.iconbg.icon.Image = crate.Image
			clone.Frame.iconbg.icon.UIAspectRatioConstraint.AspectRatio = crate.ShopCardOverrideAspectRatio or 1
			local v4 = k
			clone.TextButton.MouseButton1Click:Connect(function()
				self:SetTargetGift("Crate", v4, v3)
			end)
			clone.Parent = self.Root.giftdropdown.ScrollingFrame
		end
	end

	for k, bundle in ShopDataV2.Items.Bundles do
		if bundle.IsOffsale or bundle.ProductId == nil then
			continue
		end

		local v3 = Lang.Get(Lang.Strings.AssetInfo.Bundles[k].Name)
		local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
		clone.Name = v3
		clone.Frame.level.Text = v3
		clone.Frame.iconbg.icon.Image = bundle.Image
		local v4 = k
		clone.TextButton.MouseButton1Click:Connect(function()
			self:SetTargetGift("Bundle", v4, v3)
		end)
		clone.Parent = self.Root.giftdropdown.ScrollingFrame
	end

	for k, powerUp in ShopDataV2.Items.PowerUps do
		if powerUp.IsOffsale or powerUp.ProductId == nil then
			continue
		end

		local quantityForRobux = powerUp.QuantityForRobux or powerUp.Quantity or 1
		local formatted = `x{quantityForRobux} {Lang.Get(Lang.Strings.AssetInfo.PowerUps[k].Name)}`
		local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
		clone.Name = formatted
		clone.Frame.level.Text = formatted
		clone.Frame.iconbg.icon.Image = PowerUpsData[k].NoBGImage
		local v3 = k
		clone.TextButton.MouseButton1Click:Connect(function()
			self:SetTargetGift("PowerUp", `x{quantityForRobux} {v3}`, formatted)
		end)
		clone.Parent = self.Root.giftdropdown.ScrollingFrame
	end

	for k, skin in ShopDataV2.Items.Skins do
		if skin.IsOffsale or skin.ProductId == nil then
			continue
		end

		local v3 = string.split(k, "_")
		local formatted = `{v3[2]} {v3[1]}`
		local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
		clone.Name = formatted
		clone.Frame.level.Text = formatted
		clone.Frame.iconbg.icon.Image = ""
		local v4 = k
		clone.TextButton.MouseButton1Click:Connect(function()
			self:SetTargetGift("Skin", v4, formatted)
		end)
		clone.Parent = self.Root.giftdropdown.ScrollingFrame
		task.spawn(GetViewport, v3[1], v3[2], clone.Frame.iconbg.icon)
	end

	local v3 = {}

	for _, v4 in Shared.GOLD_DEV_ID_TO_AMOUNT_MAP do
		local formatted = `{v4} Gold`
		local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
		clone.Name = formatted
		clone.Frame.level.Text = formatted
		clone.Frame.iconbg.icon.Image = "rbxassetid://14608329033"
		clone.Frame.iconbg.icon.UIAspectRatioConstraint.AspectRatio = 1.525
		clone.TextButton.MouseButton1Click:Connect(function()
			self:SetTargetGift("Gold", formatted, formatted)
		end)
		clone.Parent = self.Root.giftdropdown.ScrollingFrame
		v3[clone] = true
	end

	for _, v4 in Shared.CRYSTALS_DEV_ID_TO_AMOUNT_MAP do
		local formatted = `{v4} Crystals`
		local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
		clone.Name = formatted
		clone.Frame.level.Text = formatted
		clone.Frame.iconbg.icon.Image = "rbxassetid://93938811857380"
		clone.Frame.iconbg.icon.UIAspectRatioConstraint.AspectRatio = 1
		clone.TextButton.MouseButton1Click:Connect(function()
			self:SetTargetGift("Crystals", formatted, formatted)
		end)
		clone.Parent = self.Root.giftdropdown.ScrollingFrame
		v3[clone] = true
	end

	local clone = self.Root.giftdropdown.ScrollingFrame.template:Clone()
	clone.Name = "2X Tokens (1 Hour)"
	clone.Frame.level.Text = "2X Tokens (1 Hour)"
	clone.Frame.iconbg.icon.Image = Shared.DOUBLE_TOKENS_IMAGE
	clone.Frame.iconbg.icon.UIAspectRatioConstraint.AspectRatio = 1
	clone.TextButton.MouseButton1Click:Connect(function()
		self:SetTargetGift("DoubleTokens", "DoubleTokens", "2X Tokens (1 Hour)")
	end)
	clone.Parent = self.Root.giftdropdown.ScrollingFrame

	if _G.BATTLEPASS_GIFTING_ENABLED then
		for k, v4 in BattlePass.GetAllPasses() do
			if not v4.UnlockProductInfo then
				continue
			end

			local formatted = `Battle Pass - {Lang.Get(v4.DisplayName)}`
			local clone2 = self.Root.giftdropdown.ScrollingFrame.template:Clone()
			clone2.Name = formatted
			clone2.Frame.level.Text = formatted
			clone2.Frame.iconbg.icon.Image = `rbxassetid://{v4.CardImage}`
			clone2.Frame.iconbg.icon.ScaleType = Enum.ScaleType.Crop
			local v5 = k
			clone2.TextButton.MouseButton1Click:Connect(function()
				self:SetTargetGift("BattlePass", v5, formatted)
			end)
			clone2.Parent = self.Root.giftdropdown.ScrollingFrame
		end
	end

	local scrollingFrame = self.Root.giftdropdown.ScrollingFrame
	local uiGridStyleLayout = scrollingFrame:FindFirstChildWhichIsA("UIGridStyleLayout")

	if uiGridStyleLayout then
		local v4 = {}

		for _, frame in scrollingFrame:GetChildren() do
			if frame:IsA("Frame") and frame.Name ~= "template" and frame ~= clone then
				table.insert(v4, frame)
			end
		end

		table.sort(v4, function(a, b)
			return a.Name < b.Name
		end)
		local v5 = #v4 + 1

		for i = #v4, 1, -1 do
			if not v3[v4[i]] then
				continue
			end

			v5 = i + 1
			break
		end

		table.insert(v4, v5, clone)

		for k, v6 in v4 do
			v6.LayoutOrder = k
		end

		uiGridStyleLayout.SortOrder = Enum.SortOrder.LayoutOrder
	end
end

function GiftingWindow:SetTargetGift(giftCategory: string?, giftName: string?, text: string?, _: string?)
	self.Root.giftsearch.TextBox.Text = ""
	self.Root.giftdropdown.Visible = false
	self.GiftName = giftName
	self.GiftCategory = giftCategory
	local v2 = Network.Invoke("ClientGetGiftingValidRequest", self.TargetUserId, self.GiftName, self.GiftCategory)

	if v2 == Enums.GiftingResult.Success then
		self.Root.giftselection.Visible = self.GiftName ~= nil

		if self.GiftName then
			task.spawn(function()
				self.Root.giftselection.Frame.itemname.Text = text
				self.Root.giftselection.Frame.itemprice.Text = Lang.Get(Lang.Strings.Shop.BuyWithRobux, " ...")
				local viewportFrame = self.Root.giftselection.Frame.icon:FindFirstChildOfClass("ViewportFrame")

				if viewportFrame then
					viewportFrame:Destroy()
				end

				self.Root.giftselection.Frame.icon.icon.UIAspectRatioConstraint.AspectRatio = 1
				self.Root.giftselection.Frame.icon.icon.ScaleType = Enum.ScaleType.Crop

				if self.GiftCategory == "Tower" then
					self.Root.giftselection.Frame.icon.icon.Image = ""
					task.spawn(GetViewport, giftName, "", self.Root.giftselection.Frame.icon)
				elseif self.GiftCategory == "Enemies" then
					self.Root.giftselection.Frame.icon.icon.Image = ""
					local enemy = ShopDataV2.Items.Enemies[giftName]
					task.spawn(function()
						EnemyViewport.Build(self.Root.giftselection.Frame.icon, giftName, {
							RotationOffset = enemy.ViewportRotationOffset,
							Zoom = enemy.ViewportZoom
						})
					end)
				elseif self.GiftCategory == "Skin" then
					self.Root.giftselection.Frame.icon.icon.Image = ""
					local v3 = string.split(giftName, "_")
					task.spawn(GetViewport, v3[1], v3[2], self.Root.giftselection.Frame.icon)
				elseif self.GiftCategory == "Crate" then
					local crate = ShopDataV2.Items.Crates[giftName]
					self.Root.giftselection.Frame.icon.icon.UIAspectRatioConstraint.AspectRatio = crate.ShopCardOverrideAspectRatio
						or 1
					self.Root.giftselection.Frame.icon.icon.Image = crate.Image
				elseif self.GiftCategory == "Bundle" then
					self.Root.giftselection.Frame.icon.icon.UIAspectRatioConstraint.AspectRatio = 1
					self.Root.giftselection.Frame.icon.icon.Image = ShopDataV2.Items.Bundles[giftName].Image
				elseif self.GiftCategory == "PowerUp" then
					self.Root.giftselection.Frame.icon.icon.UIAspectRatioConstraint.AspectRatio = 1
					local v3 = string.match(giftName, "x%d (%Z+)")
					self.Root.giftselection.Frame.icon.icon.Image = PowerUpsData[v3].NoBGImage
				elseif self.GiftCategory == "Gold" then
					self.Root.giftselection.Frame.icon.icon.UIAspectRatioConstraint.AspectRatio = 1.525
					self.Root.giftselection.Frame.icon.icon.Image = "rbxassetid://14608329033"
				elseif self.GiftCategory == "Crystals" then
					self.Root.giftselection.Frame.icon.icon.UIAspectRatioConstraint.AspectRatio = 1
					self.Root.giftselection.Frame.icon.icon.Image = "rbxassetid://93938811857380"
				elseif self.GiftCategory == "BattlePass" then
					local passData = BattlePass.GetPassData(giftName)
					self.Root.giftselection.Frame.icon.icon.ScaleType = Enum.ScaleType.Crop
					self.Root.giftselection.Frame.icon.icon.Image = `rbxassetid://{passData.CardImage}`
				elseif self.GiftCategory == "DoubleTokens" then
					self.Root.giftselection.Frame.icon.icon.ScaleType = Enum.ScaleType.Fit
					self.Root.giftselection.Frame.icon.icon.Image = Shared.DOUBLE_TOKENS_IMAGE
				end

				local v3 = Network.Invoke("ClientGetGiftingProductIdRequest", self.GiftName, self.GiftCategory)
				local priceInRobux = "?"

				if v3 then
					pcall(function()
						priceInRobux = MarketplaceService:GetProductInfo(v3, Enum.InfoType.Product).PriceInRobux
					end)
				end

				self.Root.giftselection.Frame.itemprice.Text = Lang.Get(Lang.Strings.Shop.BuyWithRobux, ` {priceInRobux}`)
			end)
		end

		self:SetErrorState(nil, self.Root.giftsearch)
	else
		self.Root.giftsearch.TextBox.Text = text or ""
		self.Root.giftselection.Visible = false
		self.GiftName = nil
		self.GiftCategory = nil
		self:SetErrorState(v[v2] or `Unknown error ({tostring(v2)})`, self.Root.giftsearch)
	end
end

function GiftingWindow:SetTargetPlayerId(targetUserId: number?, value: string?)
	self.Root.usersearch.TextBox.Text = ""
	self.Root.userdropdown.Visible = false
	self.TargetUserId = targetUserId
	local v2 = Network.Invoke("ClientGetGiftingValidRequest", self.TargetUserId, self.GiftName, self.GiftCategory)

	if v2 == Enums.GiftingResult.Success then
		self.Root.userselection.Visible = self.TargetUserId ~= nil

		if self.TargetUserId then
			task.spawn(function()
				self.Root.userselection.Frame.icon.Image = Players:GetUserThumbnailAsync(
					targetUserId,
					Enum.ThumbnailType.HeadShot,
					Enum.ThumbnailSize.Size100x100
				)
			end)
			task.spawn(function()
				self.Root.userselection.Frame.displayname.Text = "..."
				self.Root.userselection.Frame.username.Text = "@..."
				local playerByUserId = Players:GetPlayerByUserId(targetUserId)
				local displayName, name

				if playerByUserId == nil then
					local nameFromUserIdAsync = "USER ID: " .. tostring(targetUserId)
					pcall(function()
						nameFromUserIdAsync = Players:GetNameFromUserIdAsync(targetUserId)
					end)
					displayName = nameFromUserIdAsync
					name = nameFromUserIdAsync
				else
					displayName = playerByUserId.DisplayName
					name = playerByUserId.Name
				end

				self.Root.userselection.Frame.displayname.Text = displayName
				self.Root.userselection.Frame.username.Text = "@" .. name
			end)
		end

		self:SetErrorState(nil, self.Root.usersearch)
	else
		self.Root.usersearch.TextBox.Text = value or ""
		self.Root.userselection.Visible = false
		self.TargetUserId = nil
		self:SetErrorState(v[v2] or `Unknown error ({tostring(v2)})`, self.Root.usersearch)
	end
end

function GiftingWindow:UpdateDropdown(p, value: string)
	local v2 = string.lower(value)
	local count = 0

	for _, frame in p.ScrollingFrame:GetChildren() do
		if not (frame.Name ~= "template" and frame:IsA("Frame")) then
			continue
		end

		local visible = value == "" or string.find(string.lower(frame.Name), v2) ~= nil
		frame.Visible = visible

		if visible then
			count += 1
		end
	end

	p.noresults.Visible = count == 0
end

function GiftingWindow:SetErrorState(value: string?, p)
	local gift = self.Root.gift
	self.Error = value ~= nil
	gift.error.Text = value or ""
	gift.ImageColor3 = self.Error and color2 or color
	gift.HoverState.ImageColor3 = self.Error and color2 or color
	gift.ClickState.ImageColor3 = self.Error and color2 or color
	gift.holder.label.TextColor3 = self.Error and color4 or color3

	if p then
		p.error.Visible = self.Error
	end
end

function GiftingWindow:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { GiftingWindow }, Players)
return GiftingWindow