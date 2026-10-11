local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Lang = require(game.ReplicatedStorage.TDX_Shared.Modules.Lang)
local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Crates = require(game.ReplicatedStorage.TDX_Shared.Modules.Crates)
local Shared = require(game.ReplicatedStorage.TDX_Shared.Modules.Shared)
local Network = require(game.ReplicatedFirst.Client.Network)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local v = { Common = true, Uncommon = true, Epic = true, Legendary = true }
local v2 = { common = "Common", uncommon = "Uncommon", epic = "Epic", legendary = "Legendary" }
local SkinExchange = { ClassName = script.Name, ClassModule = script }
SkinExchange.__index = SkinExchange

local function updateSkinCard(state, p)
	local v3

	if p then
		v3 = Data.Get("Inventory").Skins[p]
	end

	state.empty.Visible = p == nil or v3 == nil

	if p and v3 then
		local skinData = Crates.GetSkinData(v3)
		local v4 = string.split(v3, "_")
		local v5 = v4[1]
		local text = v4[2]
		state.tower.Text = Lang.Get(Lang.Strings.AssetInfo.Towers[v5].Name)
		state.skin.Text = text
		state.rarity.Text = skinData.Rarity
		state.ImageColor3 = Shared.RARITY_COLORS[skinData.Rarity]
		state.img.Image = skinData.Image
		state.img.clr.Visible = skinData.Color
		state.img.texture.Visible = skinData.TextureImageId

		if skinData.Color then
			state.img.clr.BackgroundColor3 = skinData.Color
		end

		if skinData.TextureImageId then
			state.img.texture.Image = skinData.TextureImageId
		end
	end
end

function SkinExchange.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		Selected = {},
		SearchResults = {},
		Page = 1,
		MaxPages = 1,
		SearchQuery = "",
		CurrentlySelling = ""
	}, SkinExchange))
end

function SkinExchange:PromptLegendarySell(currentlySelling: string)
	local v3 = string.split(Data.Get("Inventory").Skins[currentlySelling], "_")
	self.CurrentlySelling = currentlySelling
	self.Root.prompt.TextLabel.Text = Lang.Get(Lang.Strings.Shop.SellConfirm, v3[2] .. " " .. v3[1], 1500)
	self.Root.prompt.Visible = true
end

function SkinExchange:Init()
	local root = self.Root

	for _, button in root.selected:GetChildren() do
		if not button:IsA("ImageButton") then
			continue
		end

		local v3 = button
		self.Cleaner:Add(button.MouseButton1Click:Connect(function()
			local name = tonumber(v3.Name)

			if self.Selected[name] then
				table.remove(self.Selected, name)
				self:UpdateSelected()
				self:Search(self.SearchQuery)
			end
		end))
	end

	for _, button in root.skins:GetChildren() do
		if not button:IsA("ImageButton") then
			continue
		end

		local v3 = button
		self.Cleaner:Add(button.MouseButton1Click:Connect(function()
			local name = tonumber(v3.Name)
			local searchResult = self.SearchResults[name + 12 * (self.Page - 1)]
			local selectedRarity = self:GetSelectedRarity()
			local skinData = Crates.GetSkinData(Data.Get("Inventory").Skins[searchResult])

			if skinData == nil then
				return
			end

			local rarity = skinData.Rarity

			if rarity == "Legendary" then
				self:PromptLegendarySell(searchResult)
			elseif
				searchResult
				and #self.Selected < 6
				and not table.find(self.Selected, searchResult)
				and (selectedRarity == nil or rarity == selectedRarity)
			then
				table.insert(self.Selected, searchResult)
				self:UpdateSelected()
				self:Search(self.SearchQuery)
			end
		end))
	end

	self.Cleaner:Add(self.Root.prompt.yes.MouseButton1Click:Connect(function()
		self.Root.prompt.Visible = false
		Network.Fire("ClientSellSkinRequest", self.CurrentlySelling)
		self.CurrentlySelling = ""
	end))
	self.Cleaner:Add(root.pages.right.MouseButton1Click:Connect(function()
		if self.Page == self.MaxPages then
			return
		end

		self:ShowPage(self.Page + 1)
	end))
	self.Cleaner:Add(root.pages.left.MouseButton1Click:Connect(function()
		if self.Page == 1 then
			return
		end

		self:ShowPage(self.Page - 1)
	end))
	self.Cleaner:Add(root.search.box.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		self.SearchQuery = root.search.box.TextBox.Text
		self:Search(self.SearchQuery)
	end))
	self.Cleaner:Add(root.exchange.MouseButton1Click:Connect(function()
		local v3, v4 = Network.Invoke("ClientTradeUpRequest", self.Selected)

		if v3 then
			table.clear(self.Selected)
			self.Root.Visible = false

			for _, v5 in Director.GetItemsFromClass(Director.Classes.CrateSpin) do
				v5:ShowUnboxed(Crates.GetSkinData(v4), true)
				break
			end

			self:UpdateSelected()
			self.Page = 1
			self:Search(self.SearchQuery)
			self.Root.Visible = true
		end
	end))
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Inventory" then
			self:UpdateSelected()
			self.Page = 1
			self:Search(self.SearchQuery)
		end
	end))
	self:Search("")
end

function SkinExchange:GetSelectedRarity()
	for _, v3 in self.Selected do
		local skinData = Crates.GetSkinData(Data.Get("Inventory").Skins[v3])

		if skinData ~= nil then
			return skinData.Rarity
		end
	end
end

function SkinExchange:GetSelectedCrateName()
	for _, v3 in self.Selected do
		local skinData = Crates.GetSkinData(Data.Get("Inventory").Skins[v3])

		if skinData ~= nil then
			return skinData.CrateName
		end
	end
end

function SkinExchange:UpdateSelected()
	for i = 1, 6 do
		updateSkinCard(self.Root.selected:FindFirstChild(i), self.Selected[i])
	end

	self.Root.exchange.Visible = #self.Selected == 6
end

function SkinExchange:ShowPage(value: number)
	local page = math.clamp(value, 1, self.MaxPages)
	self.Page = page
	local v3 = (page - 1) * 12

	for i = 1, 12 do
		local searchResult = self.SearchResults[v3 + i]
		updateSkinCard(self.Root.skins:FindFirstChild(i), searchResult)
	end

	self.Root.pages.page.label.Text = page .. "/" .. self.MaxPages
end

function SkinExchange:Search(value: string)
	local v3 = string.lower(value)
	local skins = Data.Get("Inventory").Skins
	local selectedRarity = self:GetSelectedRarity()
	local selectedCrateName = self:GetSelectedCrateName()
	local v4 = {}
	local searchResults = {}
	local v5 = {}

	for k, skin in skins do
		if table.find(self.Selected, k) then
			continue
		end

		local v6 = v4[k]

		if not v6 then
			v6 = Crates.GetSkinData(skin)
			v4[k] = v6
		end

		local v7

		if v3 == "" then
			v7 = true
		elseif v2[v3] then
			v7 = v6 and v6.Rarity == v2[v3]
		else
			v7 = string.match(string.lower(skin), v3)
		end

		if not (v7 and v6 and v[v6.Rarity] and (selectedRarity == nil or v6.Rarity == selectedRarity)) then
			continue
		end

		if
			Crates.GetCrateData(v6.CrateName).NoDupes
			or not (selectedCrateName == nil or v6.CrateName == selectedCrateName)
		then
			continue
		end

		table.insert(searchResults, k)
		table.insert(v5, { skin, k })
	end

	table.sort(v5, function(a, b)
		return a[1] < b[1]
	end)
	local v6 = {}

	for k, v7 in v5 do
		v6[v7[2]] = k
	end

	table.sort(searchResults, function(a, b)
		return -v6[a] + table.find(Shared.RARITY_ORDER, v4[a].Rarity) * 1000 > -v6[b] + table.find(Shared.RARITY_ORDER, v4[b].Rarity) * 1000
	end)
	self.MaxPages = math.max(1, (math.ceil(#searchResults / 12)))
	self.SearchResults = searchResults
	self:ShowPage(self.Page)
end

function SkinExchange.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { SkinExchange }, LocalPlayer)
return SkinExchange