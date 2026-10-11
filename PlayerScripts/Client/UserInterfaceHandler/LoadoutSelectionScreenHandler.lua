local LoadoutSelectionScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("WaveTypes"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local TowerUtilities = require(Common:WaitForChild("TowerUtilities"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local Data = require(TDX_Shared:WaitForChild("Client"):WaitForChild("Services"):WaitForChild("Data"))
local PlayerClass = require(script.Parent.Parent:WaitForChild("PlayerClass"))
local VIP_GAMEPASS_ID = _G.VIP_GAMEPASS_ID
local color = Color3.fromHex("FF9D35")
local udim = UDim2.new(0.5, 0, 0.5, 0)
local udim2 = UDim2.new(0.5, 0, 1.5, 0)
local udim3 = UDim2.new(0.5, 0, -0.55, -36)
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenInfo3 = TweenInfo.new(0)
local event = NetworkingHandler.GetEvent("LoadoutSelectionChanged")
local event2 = NetworkingHandler.GetEvent("GamepassPurchased")
local LocalPlayer = Players.LocalPlayer
local loadoutSelectionScreen = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("LoadoutSelectionScreen")
local top = loadoutSelectionScreen:WaitForChild("Top")
local inner = loadoutSelectionScreen:WaitForChild("Bottom"):WaitForChild("Inner")
local template = inner:WaitForChild("Template")
local skip = top:WaitForChild("Skip")
local title = top:WaitForChild("Title")
local subtitle = top:WaitForChild("Subtitle")
local skipPenalty = top:WaitForChild("SkipPenalty")
local v = {}
local v2 = nil
local v3 = {}
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = true
local localPlayerIsVIP = PlayerClass.LocalPlayerIsVIP()

local function Color3ToRGBText(color2: Color3) -- 1 equivalent call inferred from this helper
	return string.format(
		"%d,%d,%d",
		math.round(color2.R * 255),
		math.round(color2.G * 255),
		(math.round(color2.B * 255))
	)
end

local function SelectButton(p, flag: boolean?)
	if not flag and v4 == p then
		return
	end

	if p and p.VIPOnly then
		v5 = p

		if not localPlayerIsVIP then
			SoundHandler.Play("ShopSelectOption")
			MarketplaceService:PromptGamePassPurchase(LocalPlayer, VIP_GAMEPASS_ID)
			return
		end
	end

	for _, v8 in pairs(v3) do
		v8:Deselect()
	end

	v4 = p

	if not v4 then
		return
	end

	v4:Select()

	if flag then
		v4 = nil
		return
	end

	SoundHandler.Play("ClickTower")
	event:FireServer(p.Index)
end

local function NewLoadoutCard(i: number, loadoutSelectionConfig)
	local clone = template:Clone()
	clone.Parent = inner
	clone.Name = "LoadoutCard" .. i
	local backgroundDefault = clone:FindFirstChild("BackgroundDefault")
	local backgroundSelected = clone:FindFirstChild("BackgroundSelected")
	local icon = clone:FindFirstChild("Icon")
	local title2 = clone:FindFirstChild("Title")
	local description = clone:FindFirstChild("Description")
	local button = clone:FindFirstChild("Button")
	local textLabel = button:FindFirstChild("TextLabel")
	local default = button:FindFirstChild("Default")
	local hovered = button:FindFirstChild("Hovered")
	local selected = button:FindFirstChild("Selected")
	local vipDefault = button:FindFirstChild("VIPDefault")
	local vipHovered = button:FindFirstChild("VIPHovered")
	local v8 = { default, hovered, selected, vipDefault, vipHovered }
	local connections = {}

	local function HideAllOtherButtonBackgrounds(p) -- 5 equivalent calls inferred from this helper
		for _, v9 in pairs(v8) do
			v9.Visible = v9 == p
		end
	end

	local v9 = {
		Index = i,
		VIPOnly = loadoutSelectionConfig.VIPOnly,
		Hovered = false,
		Selected = false,
		MouseEnter = function(self)
			self.Hovered = true
			self:_UpdateState()
		end,
		MouseLeave = function(self)
			self.Hovered = false
			self:_UpdateState()
		end,
		Deselect = function(self)
			self.Selected = false
			self:_UpdateState()
		end,
		Select = function(self)
			self.Selected = true
			self:_UpdateState()
		end,
		_UpdateState = function(self)
			if localPlayerIsVIP or not self.VIPOnly then
				if self.Selected then
					HideAllOtherButtonBackgrounds(selected) -- inferred equivalent call
				elseif self.Hovered then
					HideAllOtherButtonBackgrounds(hovered) -- inferred equivalent call
				else
					HideAllOtherButtonBackgrounds(default) -- inferred equivalent call
				end

				if self.Selected then
					textLabel.Text = "SELECTED"
				else
					textLabel.Text = "SELECT"
				end
			else
				if self.Hovered then
					HideAllOtherButtonBackgrounds(vipHovered) -- inferred equivalent call
				else
					HideAllOtherButtonBackgrounds(vipDefault) -- inferred equivalent call
				end

				textLabel.Text = "BUY VIP"
			end

			if self.Selected then
				backgroundDefault.Visible = false
				backgroundSelected.Visible = true
			else
				backgroundDefault.Visible = true
				backgroundSelected.Visible = false
			end
		end,
		Destroy = function(self)
			for _, connection in pairs(connections) do
				connection:Disconnect()
			end

			clone:Destroy()
		end
	}
	table.insert(connections, button.Activated:Connect(function()
		SelectButton(v9)
	end))
	table.insert(connections, button.MouseEnter:Connect(function()
		v9:MouseEnter()
	end))
	table.insert(connections, button.MouseLeave:Connect(function()
		v9:MouseLeave()
	end))
	icon.Image = loadoutSelectionConfig.IconId
	local text = string.upper(Lang.Get(loadoutSelectionConfig.Title))

	if loadoutSelectionConfig.VIPOnly then
		title2.Text = `<font color="rgb({Color3ToRGBText(color)})">VIP ONLY:</font>  {text}` -- inferred equivalent call
		icon.ImageColor3 = color
	else
		title2.Text = text
		icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end

	description.Text = Lang.Get(loadoutSelectionConfig.Description)
	local towerSkins = Data.Get("TowerSkins")
	local towers = clone:FindFirstChild("Towers")
	local template2 = towers:FindFirstChild("Template")
	template2.Visible = false

	local function NewViewport(layoutOrder: number, tower: string)
		local clone2 = template2:Clone()
		clone2.Parent = towers
		local holder = clone2:FindFirstChild("Holder")
		local towerSkin = towerSkins[tower]
		ResourceManager.ExpectTowerSkin(tower, towerSkin)
		local viewport = TowerUtilities.GetViewport(holder, tower, towerSkin)
		viewport.Size = UDim2.new(1.05, 0, 1.15, 0)
		viewport.Position = UDim2.new(0.5, 0, 0.475, 0)
		clone2.Name = tostring(layoutOrder) .. tower
		clone2.LayoutOrder = layoutOrder
		clone2.Visible = true
	end

	for j, tower in ipairs(loadoutSelectionConfig.Towers) do
		if tower ~= "" then
			NewViewport(j, tower)
		end
	end

	clone.Visible = true
	return v9
end

local function NewSkipButton(skip2, noSkip: boolean?)
	local default = skip2:FindFirstChild("Default")
	local hovered = skip2:FindFirstChild("Hovered")
	local selected = skip2:FindFirstChild("Selected")
	local textLabel = skip2:FindFirstChild("TextLabel")
	local connections = {}
	local v8 = {
		Index = 0,
		Hovered = false,
		Selected = false,
		MouseEnter = function(self)
			self.Hovered = true
			self:_UpdateState()
		end,
		MouseLeave = function(self)
			self.Hovered = false
			self:_UpdateState()
		end,
		Deselect = function(self)
			self.Selected = false
			self:_UpdateState()
		end,
		Select = function(self)
			self.Selected = true
			self:_UpdateState()
		end,
		_UpdateState = function(self)
			if self.Selected then
				default.Visible = false
				hovered.Visible = false
				selected.Visible = true
			else
				if self.Hovered then
					default.Visible = false
					hovered.Visible = true
				else
					default.Visible = true
					hovered.Visible = false
				end

				selected.Visible = false
			end

			if self.Selected then
				textLabel.Text = "SKIP SELECTED"
				textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			else
				textLabel.Text = "SKIP & USE OWN LOADOUT"
				textLabel.TextColor3 = Color3.fromRGB(180, 255, 0)
			end
		end,
		Destroy = function(self)
			for _, connection in pairs(connections) do
				connection:Disconnect()
			end
		end
	}
	table.insert(connections, skip2.Activated:Connect(function()
		if noSkip then
			return
		end

		SelectButton(v8)
	end))
	table.insert(connections, skip2.MouseEnter:Connect(function()
		v8:MouseEnter()
	end))
	table.insert(connections, skip2.MouseLeave:Connect(function()
		v8:MouseLeave()
	end))
	skip2.Visible = not noSkip
	return v8
end

local function Initialize(loadoutSelectionData)
	for _, v8 in pairs(v3) do
		v8:Destroy()
	end

	v3 = {}
	v2 = NewSkipButton(skip, loadoutSelectionData.NoSkip)
	table.insert(v3, v2)

	for i, loadoutSelectionConfig in ipairs(loadoutSelectionData.LoadoutSelectionConfigs) do
		v[i] = NewLoadoutCard(i, loadoutSelectionConfig)
		table.insert(v3, v[i])
	end

	if loadoutSelectionData.TitleOverride then
		title.Text = Lang.Get(loadoutSelectionData.TitleOverride)
	end

	if loadoutSelectionData.SubtitleOverride then
		subtitle.Text = Lang.Get(loadoutSelectionData.SubtitleOverride)
	end

	local skipPenaltyPercentage = loadoutSelectionData.SkipPenaltyPercentage

	if skipPenaltyPercentage and not loadoutSelectionData.NoSkip then
		skipPenalty.Text = Lang.Get(
			Lang.Strings.Game.LoadoutSelectionSubtitles.SkipPenalty,
			(math.round(100 * skipPenaltyPercentage))
		)
		skipPenalty.Visible = true
		subtitle.Visible = false
	else
		skipPenalty.Visible = false
		subtitle.Visible = true
	end
end

function LoadoutSelectionScreenHandler.ShowScreen(p: string, flag: boolean?)
	local loadoutSelectionData = ResourceManager.GetWaveConfig(p).LoadoutSelectionData

	if not loadoutSelectionData then
		warn("LoadoutSelectionData not found for difficulty: " .. p)
		return
	end

	if p ~= v6 then
		Initialize(loadoutSelectionData)
		v6 = p
	end

	localPlayerIsVIP = PlayerClass.LocalPlayerIsVIP()

	for _, v8 in pairs(v) do
		v8:_UpdateState()
	end

	if loadoutSelectionData.NoSkip or loadoutSelectionData.SkipPenaltyPercentage then
		SelectButton(v[1], true)
	elseif v4 ~= nil then
		for _, v8 in pairs(v3) do
			v8:Deselect()
		end

		v4 = nil

		if v4 then
			v4:Select()
			SoundHandler.Play("ClickTower")
			event:FireServer((nil).Index)
		end
	end

	loadoutSelectionScreen.Position = udim2
	loadoutSelectionScreen.Visible = true
	v7 = false

	if flag then
		TweenService:Create(loadoutSelectionScreen, tweenInfo, { Position = udim }):Play()
	else
		TweenService:Create(loadoutSelectionScreen, tweenInfo3, { Position = udim }):Play()
	end
end

function LoadoutSelectionScreenHandler.HideScreen(flag: boolean?)
	if flag then
		local tween = TweenService:Create(loadoutSelectionScreen, tweenInfo2, { Position = udim3 })
		tween.Completed:Connect(function(p)
			if p == Enum.PlaybackState.Completed and v7 then
				loadoutSelectionScreen.Visible = false
			end
		end)
		tween:Play()
	else
		TweenService:Create(loadoutSelectionScreen, tweenInfo3, { Position = udim3 }):Play()
		loadoutSelectionScreen.Visible = false
	end

	v7 = true
end

template.Visible = false
event2:AttachCallback(function(p: string, p2: number)
	if p ~= LocalPlayer.Name or p2 ~= VIP_GAMEPASS_ID then
		return
	end

	localPlayerIsVIP = PlayerClass.LocalPlayerIsVIP()

	for _, v8 in pairs(v) do
		v8:_UpdateState()
	end

	if localPlayerIsVIP and v5 then
		SelectButton(v5)
	end
end)
return LoadoutSelectionScreenHandler