local RunService = game:GetService("RunService")
local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(TDX_Shared.Common.SoundHandler)
local Util = require(TDX_Shared.Modules.Util)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Director = require(TDX_Shared.Modules.Director)
local ShopDataV2 = require(game.ReplicatedStorage.Modules.ShopDataV2)
local Shared = require(TDX_Shared.Modules.Shared)
local Lang = require(TDX_Shared.Modules.Lang)
local TowerUtilities = require(Common:WaitForChild("TowerUtilities"))
local BuyButton = require(script.Parent.BuyButton)
local SplitBuyButton = require(script.Parent.SplitBuyButton)
local Data = require(TDX_Shared.Client.Services.Data)
require(game.ReplicatedFirst.Util.UIHelper)
local PurchaseHelper = require(game.ReplicatedFirst.Util.PurchaseHelper)
local ClientUtil = require(game.ReplicatedFirst.Util.ClientUtil)
local Signal = require(TDX_Shared.Modules.Signal)
local Crates = require(TDX_Shared.Modules.Crates)
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
local EmoteUtilities = require(TDX_Shared.Modules.EmoteUtilities)
local EmoteVariants = require(TDX_Shared.Modules.EmoteVariants)
local EnemyViewport = require(TDX_Shared.Common.EnemyViewport)
local ResourceManager = require(TDX_Shared.Common.ResourceManager)
local ItemDiscountClient = require(game.ReplicatedFirst.Client.ItemDiscountClient)
local Network = require(game.ReplicatedFirst.Client.Network)
local color = Color3.fromHex("b4fe00")
local udim = UDim2.new(1.05, 0, 1.15, 0)
local udim2 = UDim2.new(0.5, 0, 0.625, 0)

local function SetViewport(p: string, p2: string, p3, udim3: UDim2?, flag: boolean?)
	local viewport = TowerUtilities.GetViewport(p3, p, p2, nil, nil, nil, nil, nil, nil, flag)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

local function SetEmoteViewport(itemName: string, icon)
	if EmoteAnimationsV2[itemName] then
		local clone = game.ReplicatedStorage.LobbyResources.emotevp:Clone()
		clone.Visible = true
		local baseCharacter = EmoteUtilities.CloneBaseCharacter()
		EmoteUtilities.SetupViewport(
			clone,
			baseCharacter,
			EmoteAnimationsV2[EmoteVariants.Resolve(itemName, baseCharacter)]
		)
		clone.Parent = icon
	end
end

local function DestroyViewports(p)
	for _, viewportFrame in p.Root.Icon:GetChildren() do
		if viewportFrame:IsA("ViewportFrame") then
			viewportFrame:Destroy()
		end
	end

	for _, viewportFrame in p.Root.Icon2:GetChildren() do
		if viewportFrame:IsA("ViewportFrame") then
			viewportFrame:Destroy()
		end
	end
end

local function SetAnimationsPausedForRoot(folder, animationsPaused: boolean)
	for _, animator in folder:GetDescendants() do
		if not animator:IsA("Animator") then
			continue
		end

		for _, v in animator:GetPlayingAnimationTracks() do
			v:AdjustSpeed(animationsPaused and 0 or 1)
		end
	end
end

local function CreateViewport(state)
	local category = state.Category
	local itemName = state.ItemName
	local v = ShopDataV2.Items[category][itemName]
	local animateViewport = state.Root:GetAttribute("AnimateViewport") ~= false
	local v2 = not animateViewport and state.Root:GetAttribute("IdleAnimateViewport") == true
	local v3 = animateViewport or v2
	state.ViewportGeneration += 1
	local viewportGeneration = state.ViewportGeneration

	if state.Root.Visible and state.ViewportEnabled then
		DestroyViewports(state)
		task.defer(function()
			if
				not state.Root.Visible
				or not state.ViewportEnabled
				or state.ViewportGeneration ~= viewportGeneration
				or state.Category ~= category
				or state.ItemName ~= itemName
			then
				return
			end

			DestroyViewports(state)
			local v4 = nil

			if category == "Towers" then
				local icon = state.Root.Icon
				v4 = TowerUtilities.GetViewport(icon, itemName, "", nil, nil, nil, nil, nil, nil, v3)
				v4.ZIndex = 3
				v4.Size = udim
				v4.Position = udim2
			elseif category == "Skins" then
				local v5, v6 = unpack(string.split(itemName, "_"))
				local icon = state.Root.Icon
				v4 = TowerUtilities.GetViewport(icon, v5, v6, nil, nil, nil, nil, nil, nil, v3)
				v4.ZIndex = 3
				v4.Size = udim
				v4.Position = udim2
			elseif category == "Emotes" then
				SetEmoteViewport(itemName, state.Root.Icon)
			elseif category == "Enemies" then
				EnemyViewport.Build(state.Root.Icon2, itemName, {
					RotationOffset = v.ViewportRotationOffset,
					PositionOffset = v.ViewportPositionOffset,
					Zoom = v.ViewportZoom
				})
			end

			if v4 then
				if
					state.ViewportGeneration == viewportGeneration
					and state.Root.Visible
					and state.ViewportEnabled
					and state.Category == category
					and state.ItemName == itemName
				then
					if v2 then
						SetAnimationsPausedForRoot(v4, state.AnimationsPaused)
					end
				else
					v4:Destroy()
				end
			end
		end)
	end
end

local function UpdateItemImage(instance)
	local v = ShopDataV2.Items[instance.Category][instance.ItemName]
	instance.Root.Icon.Image = ""
	instance.Root.Icon2.Image = ""
	DestroyViewports(instance)

	if
		instance.Category == "Towers"
		or instance.Category == "Skins"
		or instance.Category == "Emotes"
		or instance.Category == "Enemies"
	then
		if instance.Root.Visible and instance.ViewportEnabled then
			CreateViewport(instance)
		end
	elseif instance.Category == "PowerUps" then
		instance.Root.Icon2.Image = v.Image
	elseif v.Image then
		instance.Root.Icon.Image = v.Image
	end
end

local function UpdateButtons(instance)
	debug.profilebegin("ItemBox.UpdateButtons()")
	local buttons = instance.Root.Buttons

	for _, guiBase in buttons:GetChildren() do
		if guiBase:IsA("GuiBase") then
			guiBase.Visible = false
		end
	end

	if instance.Category == nil then
		return
	end

	local v = ShopDataV2.Items[instance.Category][instance.ItemName]
	local currency = v.Currency or "Gold"
	local xpToLevelAndProgress = Util.XPToLevelAndProgress(Data.Get("XP"))
	local ownsItem = ClientUtil.OwnsItem(instance.Category, instance.ItemName)
	local isItemEquipped = ClientUtil.IsItemEquipped(instance.Category, instance.ItemName)
	instance.IsOwned = ownsItem == true
	local purchaseMode = PurchaseHelper.GetPurchaseMode(instance.Category, instance.ItemName)
	local v2 = ItemDiscountClient.GetPriceWithDiscount({
			Type = instance.Category,
			Name = instance.ItemName
		})
		or v.Price

	if ownsItem and (instance.Category ~= "PowerUps" or instance.IsInventory) then
		instance:ClearTags()

		if instance.IsInventory then
			buttons.Unequip.Visible = isItemEquipped
			buttons.Unequip.Button.Contents.Label.Text = instance.Category == "Skins" and "Remove skin" or "Unequip"
			buttons.Interact.Visible = not isItemEquipped
			buttons.Interact.Button.Contents.Label.Text = instance.Category == "Skins" and "Apply skin" or "Equip"

			if
				instance.IsInventory
				and instance.Category == "Towers"
				and ResourceManager.GetTowerConfig(instance.ItemName).BannedInPVP
				and _G.PVP_SHOP_ENABLED
			then
				instance:AddTag("BannedInPVP")
			end
		else
			buttons.Inactive.Visible = true

			if instance.Category == "Crates" then
				buttons.Inactive.Button.Holder.Label.Text = "Complete"
				buttons.Inactive.Button.Holder.Icon.Visible = true
				buttons.Inactive.Button.Holder.Icon.Image = "rbxassetid://98977086061542"
			else
				instance:AddTag("Owned")
				buttons.Inactive.Button.Holder.Label.Text = "Owned"
				buttons.Inactive.Button.Holder.Icon.Visible = false
			end
		end
	elseif instance.Category == "Crates" and (Data.Get("FreeCrates")[instance.ItemName] or 0) > 0 then
		buttons.Interact.Visible = true
		buttons.Interact.Button.Contents.Label.Text = "Spin"
	elseif v.IsOffsale then
		if v.IsOffsale then
			buttons.Inactive.Visible = true
			buttons.Inactive.Button.Holder.Label.Text = "Offsale"
			buttons.Inactive.Button.Holder.Icon.Visible = false
		else
			warn("Unsupported state!")
		end
	elseif purchaseMode == "FromCrate" then
		local text

		if v.FromCrate then
			text = Lang.Get(Lang.Strings.AssetInfo.Crates[v.FromCrate].Name)
		else
			text = Lang.Get(Lang.Strings.AssetInfo.Bundles[v.FromBundle].Name)
		end

		buttons.GoToCrate.Visible = true
		buttons.GoToCrate.Button.Contents.CrateName.Text = text
	elseif purchaseMode == "RobuxOnly" then
		Director.GetClassObjectYields(buttons.Buy, BuyButton):SetRobuxPrice(v.PriceInRobux)
		buttons.Buy.Visible = true
	elseif purchaseMode == "CurrencyOnly" then
		Director.GetClassObjectYields(buttons.Buy, BuyButton):SetCurrencyPrice(currency, v2)
		buttons.Buy.Visible = true
	elseif purchaseMode == "Both" then
		buttons.BuySplit.Visible = true
		local classObjectYields = Director.GetClassObjectYields(buttons.BuySplit, SplitBuyButton)

		if instance.Category == "PowerUps" then
			if v.PriceInRobux then
				classObjectYields:SetRobuxPrice(v.PriceInRobux)
				classObjectYields:SetRobuxLabel(`Buy {v.QuantityForRobux or 1}`)
			end

			classObjectYields:SetCurrencyPrice(currency, v.Price)
			classObjectYields:SetCurrencyLabel(`Buy {v.Quantity or 1}`)
		else
			classObjectYields:SetRobuxPrice(v.PriceInRobux)
			classObjectYields:SetCurrencyPrice(currency, v2)

			if xpToLevelAndProgress < v.MinLevel then
				classObjectYields:SetCurrencyLocked(`Level {v.MinLevel}`)
			else
				classObjectYields:ClearCurrencyLocked()
			end
		end
	end

	if v.PVPOnly then
		instance:AddTag("PVP")
	end

	if v.PVPOnly and instance.Category == "PowerUps" then
		local regularPowerUpConfig = ResourceManager.GetRegularPowerUpConfig(instance.ItemName)
		instance.Root.PVPPowerUpCategory.Visible = true
		instance.Root.PVPPowerUpCategory.ImageColor3 = Shared.POWERUP_CATEGORY_COLORS[regularPowerUpConfig.Category]
		instance.Root.PVPPowerUpCategory.Image = Shared.POWERUP_CATEGORY_ICONS[regularPowerUpConfig.Category]
	else
		instance.Root.PVPPowerUpCategory.Visible = false
	end

	local pvpEnemyWaveUnlock = instance.Root.PVPEnemyWaveUnlock

	if instance.Category == "Enemies" then
		local enemyConfig = ResourceManager.GetEnemyConfig(instance.ItemName)

		if enemyConfig and enemyConfig.UnlockWave then
			pvpEnemyWaveUnlock.TextLabel.Text = tostring(enemyConfig.UnlockWave)
			pvpEnemyWaveUnlock.Visible = true
		else
			pvpEnemyWaveUnlock.Visible = false
		end
	else
		pvpEnemyWaveUnlock.Visible = false
	end

	debug.profileend()
end

local function SetupEvents(instance)
	local v = ShopDataV2.Items[instance.Category][instance.ItemName]

	if not v.IsOffsale then
		local purchaseMode = PurchaseHelper.GetPurchaseMode(instance.Category, instance.ItemName)

		if v.ProductId and v.ProductId ~= 0 then
			instance.Cleaner:Add(instance.Root.Buttons.Buy.Button.Activated:Connect(function()
				if
					instance.Category == "Crates"
					and PurchaseHelper.IsCratePurchaseRestricted(true, instance.ItemName, true)
				then
					return
				end

				PurchaseHelper.PromptPurchaseWithRobux(instance.Category, instance.ItemName)
			end))
			instance.Cleaner:Add(instance.Root.Buttons.BuySplit.Left.Activated:Connect(function()
				if
					instance.Category == "Crates"
					and PurchaseHelper.IsCratePurchaseRestricted(true, instance.ItemName, true)
				then
					return
				end

				PurchaseHelper.PromptPurchaseWithRobux(instance.Category, instance.ItemName)
			end))
		end

		if purchaseMode ~= "RobuxOnly" then
			local right = purchaseMode == "Both" and instance.Root.Buttons.BuySplit.Right
				or instance.Root.Buttons.Buy.Button

			if instance.Category == "Towers" then
				instance.Cleaner:Add(right.Activated:Connect(function()
					PurchaseHelper.PromptTowerPurchase(instance.ItemName)
				end))
			elseif instance.Category == "Crates" then
				instance.Cleaner:Add(right.Activated:Connect(function()
					PurchaseHelper.PromptPurchaseCrate(instance.ItemName)
				end))
			elseif instance.Category == "PowerUps" then
				instance.Cleaner:Add(right.Activated:Connect(function()
					PurchaseHelper.PromptPowerUpPurchase(instance.ItemName)
				end))
			elseif instance.Category == "NameTagEffects" then
				instance.Cleaner:Add(right.Activated:Connect(function()
					PurchaseHelper.PromptNameTagEffectPurchase(instance.ItemName)
				end))
			elseif instance.Category == "Skins" then
				instance.Cleaner:Add(right.Activated:Connect(function()
					PurchaseHelper.PromptSkinPurchase(instance.ItemName)
				end))
			elseif instance.Category == "Emotes" then
				instance.Cleaner:Add(right.Activated:Connect(function()
					PurchaseHelper.PromptEmotePurchase(instance.ItemName)
				end))
			elseif instance.Category == "Enemies" then
				instance.Cleaner:Add(right.Activated:Connect(function()
					PurchaseHelper.PromptEnemyPurchase(instance.ItemName)
				end))
			end
		end

		instance.Cleaner:Add(ItemDiscountClient.DiscountsChanged:Connect(function()
			if not RunService:IsStudio() then
				instance:Update(false)
			end
		end))
	end

	instance.Cleaner:Add(instance.Root.Buttons.Interact.Button.Activated:Connect(function()
		if instance.Category == "Crates" then
			Network.Invoke("ClientOpenFreeCrateRequest", instance.ItemName)
		elseif ClientUtil.EquipItem(instance.Category, instance.ItemName) then
			SoundHandler.Play("Equip")
		end
	end))
	instance.Cleaner:Add(instance.Root.Buttons.Unequip.Button.Activated:Connect(function()
		if ClientUtil.UnequipItem(instance.Category, instance.ItemName) then
			SoundHandler.Play("Unequip")
		end
	end))
	instance.Cleaner:Add(instance.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		instance.ViewportGeneration += 1

		if instance.Root.Visible then
			if instance.ViewportEnabled then
				CreateViewport(instance)
			end
		else
			DestroyViewports(instance)
		end
	end))

	if not instance.Root:GetAttribute("DisableSelfUpdates") then
		instance.Cleaner:Add(Data.Updated:Connect(function(p)
			if p == "Loadout" then
				if instance.Category == "Towers" then
					instance:Update(false)
				end
			elseif p == "TowerSkins" then
				if instance.Category == "Skins" then
					instance:Update(false)
				end
			elseif
				p == "Inventory"
				or p == "XP"
				or p == "PowerUpsLoadout"
				or p == "NameTagEffect"
				or p == "Emotes"
				or p == "EnemiesLoadout"
			then
				instance:Update(false)
			end
		end))
	end
end

local ItemBox = { ClassName = script.Name, ClassModule = script }
ItemBox.__index = ItemBox

function ItemBox.new(root)
	local object = setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		InstanceCleaner = Cleaner.new(),
		Activated = Signal.new(),
		ViewportEnabled = true,
		ViewportGeneration = 0,
		AnimationsPaused = false
	}, ItemBox)
	object.InstanceCleaner:Add(function()
		object.Activated:DisconnectAll()
	end)
	return object
end

function ItemBox:Init()
	self.IsInventory = self.Root:GetAttribute("IsInventory") or false
	self:SetItem(self.Root:GetAttribute("Category"), self.Root:GetAttribute("ItemName"))
	self.InstanceCleaner:Add(self.Root.TextButton.Activated:Connect(function()
		self.Activated:Fire()
	end))
	self.InstanceCleaner:Add(self.Root.TextButton:GetPropertyChangedSignal("GuiState"):Connect(function()
		self.Root.BorderHover.Visible = self.Root.TextButton.GuiState ~= Enum.GuiState.Idle
	end))
end

function ItemBox:Update(flag: boolean)
	debug.profilebegin("ItemBox.Update()")

	if self.Category == nil then
		warn(`Category attribute is nil for {self.Root:GetFullName()}`)
		return
	end

	if self.ItemName == nil then
		warn(`ItemName attribute is nil for {self.Root:GetFullName()}`)
	end

	local v = ShopDataV2.Items[self.Category][self.ItemName]
	local itemName = self.ItemName
	local category = self.Category

	if flag then
		self.Cleaner:Clean()
		local v2 = color

		if v.Currency then
			v2 = Shared.CURRENCY_COLORS[v.Currency]
		end

		self.Root.Name = itemName
		self.Root.SkinName.Visible = false
		self.Root.Rarity.Visible = false
		self.Root.Count.Visible = false
		self.Rarity = nil

		if self.Category == "Skins" then
			local text, displayName = unpack(string.split(itemName, "_"))
			local skinData = Crates.GetSkinData(itemName)
			self.Root.ItemName.Text = text
			self.Root.SkinName.Visible = true
			local skinName = self.Root.SkinName

			if skinData then
				displayName = skinData.DisplayName or displayName
			end

			skinName.Text = string.upper(displayName)
			v2 = Shared.RARITY_COLORS[skinData.Rarity]
			self.Root.Rarity.Visible = true
			self.Root.Rarity.Text = skinData.Rarity
			self.Root.Rarity.TextColor3 = v2
			self.Rarity = skinData.Rarity
		elseif self.Category == "Enemies" then
			self.Root.ItemName.Text = ResourceManager.GetEnemyConfig(self.ItemName).OverrideDisplayName or itemName
		else
			self.Root.ItemName.Text = Lang.Get(Lang.Strings.AssetInfo[category][itemName].Name)
		end

		self.Root.Border.ImageColor3 = v2
		self.Root.BorderHover.ImageColor3 = v2
	end

	if self.Category == "PowerUps" then
		self.Root.Count.Visible = true
		self.Root.Count.Label.Text = Data.Get("Inventory").PowerUps[itemName] or 0
	elseif self.Category == "Crates" then
		local text = Data.Get("FreeCrates")[itemName] or 0
		self.Root.Count.Visible = text > 0
		self.Root.Count.Label.Text = text
	end

	self:ClearTags()

	if v.New then
		self:AddTag("New")
	end

	if v.LimitedTime then
		self:AddTag("Limited")
	end

	if v.OnSale or ItemDiscountClient.IsDiscounted({ Type = category, Name = itemName }) then
		self:AddTag("Sale")
	end

	if flag then
		UpdateItemImage(self)
		SetupEvents(self)
	end

	UpdateButtons(self)
	debug.profileend()
end

function ItemBox:SetItem(category: string, itemName: string)
	if category == nil and itemName == nil then
		self:Clear()
		return
	end

	if not ShopDataV2.Items[category] then
		warn(`Category {category} does not exist`)
		return
	end

	if not ShopDataV2.Items[category][itemName] then
		warn(`Item {itemName} in category {category} does not exist`)
		return
	end

	self.ViewportGeneration += 1
	self.Category = category
	self.ItemName = itemName
	self:Update(true)
end

function ItemBox:SetViewportEnabled(viewportEnabled: boolean)
	if self.ViewportEnabled == viewportEnabled then
		return
	end

	self.ViewportGeneration += 1
	self.ViewportEnabled = viewportEnabled

	if not viewportEnabled then
		DestroyViewports(self)
	elseif self.Root.Visible and self.Category and self.ItemName then
		CreateViewport(self)
	end
end

function ItemBox:SetAnimationsPaused(animationsPaused: boolean)
	if self.AnimationsPaused == animationsPaused then
		return
	end

	self.AnimationsPaused = animationsPaused
	SetAnimationsPausedForRoot(self.Root.Icon, animationsPaused)
	SetAnimationsPausedForRoot(self.Root.Icon2, animationsPaused)
end

function ItemBox:AddTag(childName: string)
	local child = game.ReplicatedStorage.LobbyResources.GuiTemplates.Tags:FindFirstChild(childName)

	if child then
		local clone = child:Clone()
		clone.Parent = self.Root.Tags
	else
		warn(`Tag {childName} does not exist`)
	end
end

function ItemBox:ClearTags()
	for _, guiObject in self.Root.Tags:GetChildren() do
		if guiObject:IsA("GuiObject") then
			guiObject:Destroy()
		end
	end
end

function ItemBox.SetHeight(p, udim3: UDim)
	p.Root.Size = UDim2.new(p.Root.Size.X, udim3)
end

function ItemBox:Clear()
	self.ViewportGeneration += 1
	self.Category = nil
	self.ItemName = nil
	DestroyViewports(self)
end

function ItemBox:Destroy()
	self.ViewportGeneration += 1
	DestroyViewports(self)
	self.Cleaner:Clean()
	self.InstanceCleaner:Clean()
end

Director.Register(script.Name, { ItemBox }, game.Players)
return ItemBox