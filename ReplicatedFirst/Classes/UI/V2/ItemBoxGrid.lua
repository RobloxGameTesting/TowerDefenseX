game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
TDX_Shared:WaitForChild("Common")
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Director = require(TDX_Shared.Modules.Director)
local ItemBox = require(game.ReplicatedFirst.Classes.UI.V2.ItemBox)
local BuyButton = require(script.Parent.BuyButton)
local SplitBuyButton = require(script.Parent.SplitBuyButton)
local FilterBar = require(script.Parent.FilterBar)
local ShopDataV2 = require(game.ReplicatedStorage.Modules.ShopDataV2)
local ClientUtil = require(game.ReplicatedFirst.Util.ClientUtil)
local Data = require(TDX_Shared.Client.Services.Data)
local Shared = require(TDX_Shared.Modules.Shared)
local Crates = require(TDX_Shared.Modules.Crates)
local VirtualScrolling = require(TDX_Shared.Modules.VirtualScrolling)
local ViewportCuller = require(game.ReplicatedFirst.Util.ViewportCuller)
local v = {}
local v2 = {
	UseVirtualScrolling = true,
	VirtualScrollingBufferRows = 1,
	VirtualScrollingMaxBindsPerFrame = 4,
	VirtualScrollingPreloadSlots = 8,
	VirtualScrollingAnimateViewports = true,
	VirtualScrollingIdleAnimations = true,
	VirtualScrollingDeferViewportsWhileScrolling = true,
	VirtualScrollingViewportIdleDelay = 0.1,
	VirtualScrollingMaxViewportBuildsPerFrame = 2,
	VirtualScrollingViewportPreloadRows = 1,
	VirtualScrollingViewportMotionBuildInterval = 0.075
}
local v3 = { Towers = true, Skins = true, Emotes = true, Enemies = true }

for k, v4 in Shared.RARITY_ORDER do
	v[v4] = -k
end

local function IsSingleGridModeRequired(p) -- 1 equivalent call inferred from this helper
	return p.SearchText ~= nil or p.Sort ~= "Default"
end

local function GetRarityOrder(p: string, p2: string, rarity: string?) -- 2 equivalent calls inferred from this helper
	if rarity == nil and p == "Skins" then
		local skinData = Crates.GetSkinData(p2)

		if skinData then
			rarity = skinData.Rarity
		else
			rarity = nil
		end
	end

	if rarity then
		return v[rarity]
	end

	return nil
end

local function IsItemVisible(category: string, value: string, p, isInventory: boolean?, p2, flag: boolean, flag2: boolean?, flag3: boolean?)
	local v4 = p2.SearchText == nil or value:lower():find(p2.SearchText, 1, true) ~= nil

	if flag3 == nil then
		flag3 = ClientUtil.OwnsItem(category, value)
	end

	if category == "PowerUps" and not isInventory then
		flag3 = false
	end

	local v5 = p2.Toggles.Owned and true or not flag3
	local v6 = p2.Toggles.Offsale and true or not p.IsOffsale or flag3
	local v7 = p2.Toggles.Unowned and true or flag3
	local v8 = (p2.Toggles.CrateSkins or category ~= "Skins") and true or p.FromCrate == nil

	if isInventory then
		return v4 and v7
	end

	if not v4 then
		return v4
	end

	if v5 then
		return v6 and v8
	elseif flag2 == true then
		return flag and v6 and v8
	else
		return false
	end
end

local function IsItemEligible(k: string, p, callback, flag: boolean?) -- 2 equivalent calls inferred from this helper
	return not (callback and not callback(k)) and ((p.HideInShop ~= true or flag) and true or false)
end

local function CollectEligibleItems(item, callback, isInventory: boolean?)
	local result = {}

	for k, item2 in item do
		if IsItemEligible(k, item2, callback, isInventory) then -- inferred equivalent call
			table.insert(result, { Name = k, Data = item2 })
		end
	end

	return result
end

local function CloneValue(inventory)
	if type(inventory) ~= "table" then
		return inventory
	end

	local result = {}

	for k, item in inventory do
		result[k] = CloneValue(item)
	end

	return result
end

local function AreValuesEqual(items, items2)
	if items == items2 then
		return true
	end

	if type(items) ~= "table" or type(items2) ~= "table" then
		return false
	end

	for k, item in items do
		if not AreValuesEqual(item, items2[k]) then
			return false
		end
	end

	for k in items2 do
		if items[k] == nil then
			return false
		end
	end

	return true
end

local function CloneFilterOptions(data) -- 1 equivalent call inferred from this helper
	return { SearchText = data.SearchText, Sort = data.Sort, Toggles = table.clone(data.Toggles) }
end

local function AreFilterOptionsEqual(data, lastVirtualFilterOptions) -- 1 equivalent call inferred from this helper
	return lastVirtualFilterOptions ~= nil
		and data.SearchText == lastVirtualFilterOptions.SearchText
		and data.Sort == lastVirtualFilterOptions.Sort
		and AreValuesEqual(data.Toggles, lastVirtualFilterOptions.Toggles)
end

local function IsGuiHierarchyVisible(parent)
	while parent do
		if parent:IsA("GuiObject") and not parent.Visible then
			return false
		end

		if parent:IsA("LayerCollector") then
			return parent.Enabled
		else
			parent = parent.Parent
		end
	end

	return false
end

local function DoesGuiIntersectViewport(k, p) -- 1 equivalent call inferred from this helper
	local absolutePosition = k.AbsolutePosition
	local absoluteSize = k.AbsoluteSize
	local absolutePosition2 = p.AbsolutePosition
	local absoluteWindowSize = p.AbsoluteWindowSize
	return absolutePosition.X < absolutePosition2.X + absoluteWindowSize.X
		and absolutePosition.X + absoluteSize.X > absolutePosition2.X
		and absolutePosition.Y < absolutePosition2.Y + absoluteWindowSize.Y
		and absolutePosition.Y + absoluteSize.Y > absolutePosition2.Y
end

local function DoesGuiHorizontallyIntersectViewport(k, p) -- 1 equivalent call inferred from this helper
	local absolutePosition = k.AbsolutePosition
	local absoluteSize = k.AbsoluteSize
	local absolutePosition2 = p.AbsolutePosition
	local absoluteWindowSize = p.AbsoluteWindowSize
	return absolutePosition.X < absolutePosition2.X + absoluteWindowSize.X
		and absolutePosition.X + absoluteSize.X > absolutePosition2.X
end

local ItemBoxGrid = { ClassName = "ItemBoxGrid", ClassModule = script }
ItemBoxGrid.__index = ItemBoxGrid

function ItemBoxGrid.ConfigureVirtualScrolling(instance, virtualScrollingFitColumns: boolean)
	local clone = table.clone(v2)
	clone.VirtualScrollingFitColumns = virtualScrollingFitColumns

	for attributeName, v4 in clone do
		if instance:GetAttribute(attributeName) == nil then
			instance:SetAttribute(attributeName, v4)
		end
	end
end

function ItemBoxGrid.new(root)
	return (setmetatable({
		Root = root,
		ItemBoxes = {},
		SortModes = {},
		ActivatedCallback = nil,
		_disableCategories = false,
		_singleGridModeEnabled = false,
		_numSections = 0,
		_sections = {},
		_virtualModeEnabled = false,
		_virtualModeDecided = false,
		_itemDescriptors = {},
		_previousFilteredSet = {},
		_virtualItemsDirty = true,
		_lastVirtualFilterOptions = nil,
		_lastVirtualInventory = nil,
		_slotItemBoxes = {},
		_slotBindGenerations = {},
		_slotButtonsResolved = {},
		_activeSlots = {},
		_virtualViewportHydrationEnabled = false,
		_virtualScroller = nil,
		_viewportCuller = nil,
		_cleaner = Cleaner.new()
	}, ItemBoxGrid))
end

function ItemBoxGrid:Init()
	self.OverrideGridCellSize = self.Root:GetAttribute("OverrideGridCellSize")
	self.OverrideCellPadding = self.Root:GetAttribute("OverrideGridCellPadding")
	self.IsInventory = self.Root:GetAttribute("IsInventory")
	self.FilterBar = Director.GetClassObjectYields(self.Root.Filters, FilterBar)
	self.FilterBar.OnFilterOptionsChanged:Connect(function(p)
		self:_OnFilterOptionsChanged(p)
	end)
	self.AllContainer = game.ReplicatedStorage.LobbyResources.GuiTemplates.ItemBoxGridSectionTemplate:Clone()
	self.AllContainer.Header.Visible = false
	self.AllContainer.Parent = self.Root.ScrollingFrame
	self.AllContainer.Visible = false
	self.AllContainer.Name = "All"

	if self.OverrideGridCellSize ~= nil then
		self.AllContainer.Grid.UIGridLayout.CellSize = self.OverrideGridCellSize
	end

	if self.OverrideCellPadding ~= nil then
		self.AllContainer.Grid.UIGridLayout.CellPadding = self.OverrideCellPadding
	end
end

function ItemBoxGrid:Update(flag: boolean?, flag2: boolean?)
	if self._virtualModeEnabled then
		for k in self._activeSlots do
			self._slotItemBoxes[k]:Update(false)
		end

		if flag then
			self:_UpdateVirtualItems(self.FilterBar:GetCurrentOptions(), flag2)
		end
	else
		for _, itemBox in self.ItemBoxes do
			if itemBox.Root.Visible == true then
				itemBox:Update()
			end

			if flag then
				self:_UpdateItemBoxVisiblility(itemBox, self.FilterBar:GetCurrentOptions(), flag2)
			end
		end
	end
end

function ItemBoxGrid:AddItemsFromShopData(p: string, callback, activatedCallback)
	local item = ShopDataV2.Items[p]
	local v4 = ShopDataV2.PageMeta[p]
	local v5 = nil

	if self._virtualModeDecided then
		if self._virtualModeEnabled then
			v5 = CollectEligibleItems(item, callback, self.IsInventory)
		end
	else
		if self.Root:GetAttribute("UseVirtualScrolling") == true then
			v5 = CollectEligibleItems(item, callback, self.IsInventory)
		end

		self._virtualModeEnabled = self:_CanUseVirtualScrolling(v5)
		self._virtualModeDecided = true
	end

	if self._virtualModeEnabled then
		self.ActivatedCallback = activatedCallback
	end

	local function addEligibleItem(p2, p3)
		local subcategory = p3.Subcategory or "Default"
		local v6 = Shared.ITEM_SUBCATEGORY_ICONS[subcategory]
		local v7 = Shared.ITEM_SUBCATEGORY_COLORS[subcategory]
		local v8 = Shared.ITEM_SUBCATEGORY_TICKS[subcategory]

		if not self._sections[subcategory] then
			self:AddSection(subcategory, v7 or Color3.new(1, 1, 1), v6, v8)
		end

		local v9 = self:AddItem(subcategory, p, p2)

		if activatedCallback and v9 then
			activatedCallback(v9)
		end
	end

	if v5 then
		for _, v6 in v5 do
			addEligibleItem(v6.Name, v6.Data)
		end
	else
		for k, v6 in item do
			if IsItemEligible(k, v6, callback, self.IsInventory) then -- inferred equivalent call
				addEligibleItem(k, v6)
			end
		end
	end

	for k, sortOrder in v4.SortOrders do
		self:AddSortMode(k, sortOrder, v4.SortOrdering[k])
	end

	if self.FilterBar.SortDropdown ~= nil then
		self.FilterBar.SortDropdown:SetSelectedItem("Default")
	end

	if self._numSections == 1 then
		self._disableCategories = true
		self:_EnableSingleGridMode()
	end

	if self._virtualModeEnabled then
		self:_BindVirtualScroller()
	end

	self:_OnFilterOptionsChanged(self.FilterBar:GetCurrentOptions())
end

function ItemBoxGrid:AddItem(section: string, category: string, name: string)
	if not self._sections[section] then
		error(`Section {section} does not exist`)
	end

	if self._virtualModeEnabled then
		local itemDescriptors = self._itemDescriptors
		local v4 = {
			Category = category,
			Name = name,
			Data = ShopDataV2.Items[category][name],
			Rarity = GetRarityOrder(category, name, nil) -- inferred equivalent call
		}
		table.insert(itemDescriptors, v4)
		self._virtualItemsDirty = true
		return nil
	else
		local clone = game.ReplicatedStorage.LobbyResources.GuiTemplates.ItemBox:Clone()
		clone.Parent = self._sections[section].Grid
		clone.Visible = false
		clone:SetAttribute("Section", section)
		clone:SetAttribute("IsInventory", self.IsInventory)
		clone:SetAttribute("DisableSelfUpdates", true)
		clone:AddTag("ItemBox")
		local classObjectYields = Director.GetClassObjectYields(clone, ItemBox)
		table.insert(self.ItemBoxes, classObjectYields)

		if v3[category] then
			if not self._viewportCuller then
				self._viewportCuller = ViewportCuller.new(self.Root.ScrollingFrame)
			end

			classObjectYields:SetViewportEnabled(false)
			self._viewportCuller:Add(clone, function()
				classObjectYields:SetViewportEnabled(true)
				return nil
			end, function()
				classObjectYields:SetViewportEnabled(false)
			end)
		end

		classObjectYields:SetItem(category, name)
		self:_UpdateItemBoxVisiblility(classObjectYields, self.FilterBar:GetCurrentOptions())
		self:_UpdateSectionVisibility(section)
		return classObjectYields
	end
end

function ItemBoxGrid:AddSection(p: string, color: Color3, value: string?, p2: number?)
	if self._sections[p] then
		error(`Section {p} already exists`)
	end

	local clone = game.ReplicatedStorage.LobbyResources.GuiTemplates.ItemBoxGridSectionTemplate:Clone()
	clone.Header.Label.Text = p
	clone.Header.Label.TextColor3 = color
	clone.Header.Icon.Visible = value ~= nil
	clone.Header.Icon.Image = value or ""
	clone.Header.Icon.ImageColor3 = color

	if not value and p2 then
		clone.Header.Icon.Visible = false
		clone.Header.Ticks.Visible = true

		for i = 1, p2 do
			local child = clone.Header.Ticks:FindFirstChild((tostring(i)))

			if child then
				child.BackgroundColor3 = color
			end
		end
	end

	clone.Visible = false
	clone.LayoutOrder = Shared.ITEM_SUBCATEGORY_ORDER[p] or self._numSections
	clone.Name = p
	clone.Parent = self.Root.ScrollingFrame

	if self.OverrideGridCellSize ~= nil then
		clone.Grid.UIGridLayout.CellSize = self.OverrideGridCellSize
	end

	if self.OverrideCellPadding ~= nil then
		clone.Grid.UIGridLayout.CellPadding = self.OverrideCellPadding
	end

	self._numSections += 1
	self._sections[p] = clone
end

function ItemBoxGrid:AddSortMode(p: string, p2, p3: number?)
	assert(p2, `Sort function is nil for {p}`)
	self.SortModes[p] = p2

	if self._virtualModeEnabled then
		self._virtualItemsDirty = true
	end

	if self.FilterBar.SortDropdown ~= nil then
		self.FilterBar.SortDropdown:AddItem(p, p3)
	end
end

function ItemBoxGrid:DisableCategories()
	self._disableCategories = true
	self:_EnableSingleGridMode()
end

function ItemBoxGrid:Destroy()
	for _, slotItemBox in self._slotItemBoxes do
		slotItemBox:Destroy()
	end

	if self._virtualScroller then
		self._virtualScroller.Destroy()
		self._virtualScroller = nil
	end

	if self._viewportCuller then
		self._viewportCuller:Destroy()
		self._viewportCuller = nil
	end

	table.clear(self._slotItemBoxes)
	table.clear(self._slotBindGenerations)
	table.clear(self._slotButtonsResolved)
	table.clear(self._activeSlots)
	self.ItemBoxes = {}
	self._cleaner:Clean()
	self._virtualModeEnabled = false
	self._virtualModeDecided = false
	self._virtualViewportHydrationEnabled = false
	self._itemDescriptors = {}
	self._previousFilteredSet = {}
	self._virtualItemsDirty = true
	self._lastVirtualFilterOptions = nil
	self._lastVirtualInventory = nil
	self.ActivatedCallback = nil
end

function ItemBoxGrid:_OnFilterOptionsChanged(p)
	if self._virtualModeEnabled then
		self:_UpdateVirtualItems(p)
		return
	end

	if self._disableCategories or IsSingleGridModeRequired(p) then -- inferred equivalent call
		self:_EnableSingleGridMode()
	else
		self:_DisableSingleGridMode()
	end

	local v4 = {}

	for _, itemBox in self.ItemBoxes do
		local v5 = ShopDataV2.Items[itemBox.Category][itemBox.ItemName]
		local rarity = GetRarityOrder(itemBox.Category, itemBox.ItemName, itemBox.Rarity) -- inferred equivalent call
		table.insert(v4, { Box = itemBox, Name = itemBox.ItemName, Data = v5, Rarity = rarity })
	end

	table.sort(v4, self.SortModes[p.Sort])

	for k, v5 in v4 do
		v5.Box.Root.LayoutOrder = k
	end

	for _, itemBox in self.ItemBoxes do
		self:_UpdateItemBoxVisiblility(itemBox, p)
	end

	for k, _ in self._sections do
		self:_UpdateSectionVisibility(k)
	end
end

function ItemBoxGrid:_EnableSingleGridMode()
	if self._virtualModeEnabled or self._singleGridModeEnabled then
		return
	end

	self._singleGridModeEnabled = true

	for _, section in self._sections do
		section.Visible = false
	end

	for _, itemBox in self.ItemBoxes do
		itemBox.Root.Parent = self.AllContainer.Grid
	end

	self.AllContainer.Visible = true
end

function ItemBoxGrid:_DisableSingleGridMode()
	if self._virtualModeEnabled or not self._singleGridModeEnabled then
		return
	end

	self._singleGridModeEnabled = false

	for _, section in self._sections do
		section.Visible = true
	end

	for _, itemBox in self.ItemBoxes do
		itemBox.Root.Parent = self._sections[itemBox.Root:GetAttribute("Section")].Grid
	end

	self.AllContainer.Visible = false
end

function ItemBoxGrid:_UpdateItemBoxVisiblility(object, p, flag: boolean?)
	local v4 = ShopDataV2.Items[object.Category][object.ItemName]
	local visible = object.Root.Visible
	local visible2 = IsItemVisible(object.Category, object.ItemName, v4, self.IsInventory, p, visible, flag)
	object.Root.Visible = visible2

	if visible2 and not visible then
		object:Update(false)
	end
end

function ItemBoxGrid:_UpdateSectionVisibility(p: string)
	if self._virtualModeEnabled then
		return
	end

	local section = self._sections[p]

	if self._singleGridModeEnabled then
		return
	end

	local count = 0

	for _, frame in section.Grid:GetChildren() do
		if frame:IsA("Frame") and frame.Visible then
			count += 1
		end
	end

	section.Visible = count > 0
end

function ItemBoxGrid:_CanUseVirtualScrolling(items)
	if self.Root:GetAttribute("UseVirtualScrolling") ~= true then
		return false
	end

	if self._disableCategories then
		return true
	end

	local v4 = {}

	for k in self._sections do
		v4[k] = true
	end

	for _, item in items do
		v4[item.Data.Subcategory or "Default"] = true
	end

	local count = 0

	for _ in v4 do
		count += 1
	end

	if count > 1 then
		warn(`Virtual scrolling disabled for {self.Root:GetFullName()}: found {count} sections`)
	end

	return count == 1
end

function ItemBoxGrid:_DisableActiveVirtualViewports()
	for k in self._activeSlots do
		local slotItemBox = self._slotItemBoxes[k]

		if slotItemBox then
			slotItemBox:SetViewportEnabled(false)
		end
	end
end

function ItemBoxGrid:_BindVirtualViewportHydration(p: number, p2: number, p3: number, p4: number, flag: boolean)
	if self._virtualViewportHydrationEnabled then
		return
	end

	self._virtualViewportHydrationEnabled = true
	local scrollingFrame = self.Root.ScrollingFrame
	local canvasPosition = scrollingFrame.CanvasPosition
	local v4 = -1e999
	local v5 = -1e999
	local v6 = 1
	local v7 = {}
	local v8 = {}
	local v9 = {}
	local v10 = {}
	local activeSlots = {}
	local v11 = {}
	local v12 = {}
	self._cleaner:Add(RunService.PreRender:Connect(function()
		debug.profilebegin("VirtualScrolling::ViewportHydration")
		local now = os.clock()
		local canvasPosition2 = scrollingFrame.CanvasPosition

		if canvasPosition2 ~= canvasPosition then
			local v13 = canvasPosition2.Y - canvasPosition.Y
			canvasPosition = canvasPosition2
			v4 = now

			if math.abs(v13) > 0.01 then
				v6 = v13 > 0 and 1 or -1
			end
		end

		if IsGuiHierarchyVisible(scrollingFrame) then
			table.clear(v7)
			table.clear(v8)
			table.clear(v9)
			table.clear(v10)
			table.clear(activeSlots)
			local y = scrollingFrame.AbsolutePosition.Y
			local v13 = y + scrollingFrame.AbsoluteWindowSize.Y

			for k, activeSlot in self._activeSlots do
				local slotItemBox = self._slotItemBoxes[k]

				if slotItemBox and k.Visible then
					activeSlots[k] = activeSlot

					if DoesGuiIntersectViewport(k, scrollingFrame) then -- inferred equivalent call
						table.insert(v7, k)
						v10[k] = true
					elseif DoesGuiHorizontallyIntersectViewport(k, scrollingFrame) then -- inferred equivalent call
						local y2 = k.AbsolutePosition.Y
						local v14 = y2 + k.AbsoluteSize.Y
						local v15

						if v6 > 0 then
							v15 = v13 - 1 <= y2
						else
							v15 = v14 <= y + 1
						end

						if v15 then
							table.insert(v8, k)
						else
							slotItemBox:SetViewportEnabled(false)
						end
					else
						slotItemBox:SetViewportEnabled(false)
					end
				elseif slotItemBox then
					slotItemBox:SetViewportEnabled(false)
				end
			end

			table.sort(v8, function(a, b)
				local absolutePosition = a.AbsolutePosition
				local absolutePosition2 = b.AbsolutePosition

				if math.abs(absolutePosition.Y - absolutePosition2.Y) <= 1 then
					return absolutePosition.X < absolutePosition2.X
				end

				if v6 > 0 then
					return absolutePosition.Y < absolutePosition2.Y
				end

				return absolutePosition.Y > absolutePosition2.Y
			end)
			local v14 = nil
			local count = 0

			for _, v15 in v8 do
				local y2 = v15.AbsolutePosition.Y

				if v14 == nil or math.abs(y2 - v14) > 1 then
					count += 1
					v14 = y2
				end

				local slotItemBox = self._slotItemBoxes[v15]

				if count <= p3 then
					table.insert(v9, v15)
					v10[v15] = true
				elseif slotItemBox then
					slotItemBox:SetViewportEnabled(false)
				end
			end

			for k in v11 do
				if v10[k] then
					continue
				end

				v11[k] = nil
				v12[k] = nil
			end

			for k in v10 do
				local v15 = activeSlots[k]

				if v11[k] == v15 then
					continue
				end

				v11[k] = v15
				v12[k] = now
			end

			local v15 = now - v4 < p
			table.sort(v7, function(a, b)
				local absolutePosition = a.AbsolutePosition
				local absolutePosition2 = b.AbsolutePosition

				if math.abs(absolutePosition.Y - absolutePosition2.Y) <= 1 then
					return absolutePosition.X < absolutePosition2.X
				end

				if not v15 then
					return absolutePosition.Y < absolutePosition2.Y
				end

				if v6 > 0 then
					return absolutePosition.Y > absolutePosition2.Y
				end

				return absolutePosition.Y < absolutePosition2.Y
			end)
			local v16 = p2

			if v15 then
				if p4 > 0 then
					v16 = p4 <= now - v5 and 1 or 0
				else
					v16 = 0
				end
			end

			local count2 = 0
			local v17 = math.min(p, p4)

			local function hydrateSlot(p5)
				if v16 <= count2 then
					return
				end

				local slotItemBox = self._slotItemBoxes[p5]
				local v18 = not v15

				if not v18 then
					if v12[p5] == nil then
						v18 = false
					else
						v18 = v17 <= now - v12[p5]
					end
				end

				if
					v10[p5]
					and self._activeSlots[p5] == activeSlots[p5]
					and slotItemBox
					and not slotItemBox.ViewportEnabled
					and p5.Visible
					and v18
					and IsGuiHierarchyVisible(scrollingFrame)
				then
					slotItemBox:SetViewportEnabled(true)
					count2 += 1
				end
			end

			for _, v18 in v7 do
				hydrateSlot(v18)

				if v16 <= count2 then
					break
				end
			end

			if count2 < v16 then
				for _, v18 in v9 do
					hydrateSlot(v18)

					if v16 <= count2 then
						break
					end
				end
			end

			if v15 and count2 > 0 then
				v5 = now
			end

			if flag then
				for _, v18 in v7 do
					local slotItemBox = self._slotItemBoxes[v18]

					if slotItemBox and slotItemBox.ViewportEnabled and slotItemBox.AnimationsPaused ~= v15 then
						slotItemBox:SetAnimationsPaused(v15)
					end
				end

				for _, v18 in v9 do
					local slotItemBox = self._slotItemBoxes[v18]

					if not slotItemBox or not slotItemBox.ViewportEnabled or slotItemBox.AnimationsPaused then
						continue
					end

					slotItemBox:SetAnimationsPaused(true)
				end
			end
		else
			self:_DisableActiveVirtualViewports()
			table.clear(v11)
			table.clear(v12)
		end

		debug.profileend()
	end))
end

function ItemBoxGrid:_BindVirtualScroller()
	if self._virtualScroller then
		return
	end

	self._virtualItemsDirty = true
	self._lastVirtualFilterOptions = nil
	self._lastVirtualInventory = nil
	self.AllContainer.Visible = false

	for _, section in self._sections do
		section.Visible = false
	end

	local bottomPadding = self.Root.ScrollingFrame:FindFirstChild("BottomPadding")

	if bottomPadding and bottomPadding:IsA("GuiObject") then
		bottomPadding.Visible = false
	end

	local virtualScrollingBufferRows = self.Root:GetAttribute("VirtualScrollingBufferRows")
	local virtualScrollingMaxBindsPerFrame = self.Root:GetAttribute("VirtualScrollingMaxBindsPerFrame")
	local virtualScrollingPreloadSlots = self.Root:GetAttribute("VirtualScrollingPreloadSlots")
	local virtualScrollingFitColumns = self.Root:GetAttribute("VirtualScrollingFitColumns")
	local virtualScrollingAnimateViewports = self.Root:GetAttribute("VirtualScrollingAnimateViewports")
	local virtualScrollingIdleAnimations = self.Root:GetAttribute("VirtualScrollingIdleAnimations")
	local virtualScrollingDeferViewportsWhileScrolling = self.Root:GetAttribute("VirtualScrollingDeferViewportsWhileScrolling")
	local virtualScrollingViewportIdleDelay = self.Root:GetAttribute("VirtualScrollingViewportIdleDelay")
	local virtualScrollingMaxViewportBuildsPerFrame = self.Root:GetAttribute("VirtualScrollingMaxViewportBuildsPerFrame")
	local virtualScrollingViewportPreloadRows = self.Root:GetAttribute("VirtualScrollingViewportPreloadRows")
	local virtualScrollingViewportMotionBuildInterval = self.Root:GetAttribute("VirtualScrollingViewportMotionBuildInterval")
	local fitColumnsToMaxCells = virtualScrollingFitColumns == true
	local v4 = type(virtualScrollingAnimateViewports) ~= "boolean" or virtualScrollingAnimateViewports
	local v5 = virtualScrollingIdleAnimations == true
	local v6 = not v4 and v5
	local v7 = virtualScrollingDeferViewportsWhileScrolling == true
	local v8 = type(virtualScrollingViewportIdleDelay) ~= "number" and 0.1
		or math.max(0, virtualScrollingViewportIdleDelay)
	local v9 = type(virtualScrollingMaxViewportBuildsPerFrame) ~= "number" and 2
		or math.max(1, (math.floor(virtualScrollingMaxViewportBuildsPerFrame)))
	local v10 = type(virtualScrollingViewportPreloadRows) ~= "number" and 1
		or math.max(0, (math.floor(virtualScrollingViewportPreloadRows)))
	local v11 = type(virtualScrollingViewportMotionBuildInterval) ~= "number" and 0.075
		or math.max(0, virtualScrollingViewportMotionBuildInterval)

	local function initializeItemBox(object, p)
		if v7 then
			object:SetViewportEnabled(false)
		end

		object:Init()
		object:SetItem(p.Category, p.Name)

		if self.ActivatedCallback then
			self.ActivatedCallback(object)
		end
	end

	local v12 = {
		Container = self.Root.ScrollingFrame,
		Template = game.ReplicatedStorage.LobbyResources.GuiTemplates.ItemBox,
		GridLayout = self.AllContainer.Grid.UIGridLayout,
		ItemIdentifier = function(p)
			return p.Name
		end,
		BufferRows = type(virtualScrollingBufferRows) ~= "number" and 1 or virtualScrollingBufferRows,
		MaxBindsPerFrame = 0,
		PreloadSlots = 0,
		FitColumnsToMaxCells = 0,
		Constructor = 0
	}

	if type(virtualScrollingMaxBindsPerFrame) ~= "number" then
		virtualScrollingMaxBindsPerFrame = nil
	end

	v12.MaxBindsPerFrame = virtualScrollingMaxBindsPerFrame

	if type(virtualScrollingPreloadSlots) ~= "number" then
		virtualScrollingPreloadSlots = nil
	end

	v12.PreloadSlots = virtualScrollingPreloadSlots
	v12.FitColumnsToMaxCells = fitColumnsToMaxCells

	function v12.Constructor(p, instance)
		local v13 = (self._slotBindGenerations[instance] or 0) + 1
		self._slotBindGenerations[instance] = v13

		if not self._slotButtonsResolved[instance] then
			Director.GetClassObjectYields(instance.Buttons.Buy, BuyButton)
			Director.GetClassObjectYields(instance.Buttons.BuySplit, SplitBuyButton)

			if self._slotBindGenerations[instance] ~= v13 then
				return nil
			end

			self._slotButtonsResolved[instance] = true
		end

		local slotItemBox = self._slotItemBoxes[instance]

		if slotItemBox then
			if v7 then
				slotItemBox:SetViewportEnabled(false)
			end

			slotItemBox:SetItem(p.Category, p.Name)

			if not v7 then
				slotItemBox:SetViewportEnabled((IsGuiHierarchyVisible(self.Root.ScrollingFrame)))
			end
		else
			instance:SetAttribute("DisableSelfUpdates", true)
			instance:SetAttribute("IsInventory", self.IsInventory)
			instance:SetAttribute("AnimateViewport", v4)
			instance:SetAttribute("IdleAnimateViewport", v5)
			local v14 = ItemBox.new(instance)
			self._slotItemBoxes[instance] = v14
			local success, result = pcall(initializeItemBox, v14, p)

			if not success then
				pcall(v14.Destroy, v14)

				if self._slotItemBoxes[instance] == v14 then
					self._slotItemBoxes[instance] = nil
				end

				error(result, 0)
			end
		end

		if self._slotBindGenerations[instance] ~= v13 then
			return nil
		end

		self._activeSlots[instance] = v13
		return function()
			if self._activeSlots[instance] == v13 then
				self._activeSlots[instance] = nil
			end
		end
	end

	self._virtualScroller = VirtualScrolling(v12)

	if v7 then
		self:_BindVirtualViewportHydration(v8, v9, v10, v11, v6)
	else
		self:_BindVirtualViewportVisibility()
	end
end

function ItemBoxGrid:_BindVirtualViewportVisibility()
	local scrollingFrame = self.Root.ScrollingFrame
	local v4 = true
	self._cleaner:Add(RunService.Heartbeat:Connect(function()
		local guiHierarchyVisible = IsGuiHierarchyVisible(scrollingFrame)

		if guiHierarchyVisible then
			if not v4 then
				for k in self._activeSlots do
					local slotItemBox = self._slotItemBoxes[k]

					if slotItemBox then
						slotItemBox:SetViewportEnabled(true)
					end
				end
			end
		else
			self:_DisableActiveVirtualViewports()
		end

		v4 = guiHierarchyVisible
	end))
end

function ItemBoxGrid:_UpdateVirtualItems(data, flag: boolean?)
	if not self._virtualScroller then
		return
	end

	local inventory = Data.Get("Inventory")

	if
		flag ~= true
		and not self._virtualItemsDirty
		and AreFilterOptionsEqual(data, self._lastVirtualFilterOptions) -- inferred equivalent call
		and AreValuesEqual(inventory, self._lastVirtualInventory)
	then
		return
	end

	local itemDescriptors = {}
	local previousFilteredSet = {}
	local v4 = nil

	for _, itemDescriptor in self._itemDescriptors do
		if itemDescriptor.Category ~= "Skins" then
			continue
		end

		v4 = ClientUtil.GetOwnedSkinsSet()
		break
	end

	for _, itemDescriptor in self._itemDescriptors do
		local v5 = self._previousFilteredSet[itemDescriptor.Name] == true
		local v6

		if itemDescriptor.Category == "Skins" then
			if v4 == nil then
				v6 = false
			else
				v6 = v4[itemDescriptor.Name] == true
			end
		end

		if not IsItemVisible(
			itemDescriptor.Category,
			itemDescriptor.Name,
			itemDescriptor.Data,
			self.IsInventory,
			data,
			v5,
			flag,
			v6
		) then
			continue
		end

		table.insert(itemDescriptors, itemDescriptor)
		previousFilteredSet[itemDescriptor.Name] = true
	end

	table.sort(itemDescriptors, self.SortModes[data.Sort])
	self._previousFilteredSet = previousFilteredSet
	self._virtualScroller.SetItems(itemDescriptors)

	if flag == true then
		self._virtualItemsDirty = true
		return
	end

	self._virtualItemsDirty = false
	self._lastVirtualFilterOptions = CloneFilterOptions(data) -- inferred equivalent call
	self._lastVirtualInventory = CloneValue(inventory)
end

Director.Register(ItemBoxGrid.ClassName, { ItemBoxGrid }, Players)
return ItemBoxGrid