local TowerUIHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Types"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local QueryType = require(Common:WaitForChild("QueryType"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local TowerUtilities = require(Common:WaitForChild("TowerUtilities"))
local Keybinds = require(Common:WaitForChild("Keybinds"))
local Lang = require(TDX_Shared.Modules.Lang)
local UpgradePathClass = require(script:WaitForChild("UpgradePathClass"))
local AbilityButtonClass = require(script:WaitForChild("AbilityButtonClass"))
local StatsDisplayHandler = require(script:WaitForChild("StatsDisplayHandler"))
local AttributeHoverHandler = require(script:WaitForChild("AttributeHoverHandler"))
local SPLASH_RADIUS_TO_TRANSFER_TO_AIR = _G.SPLASH_RADIUS_TO_TRANSFER_TO_AIR
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(215, 215, 215)
local color3 = Color3.fromRGB(105, 105, 105)
local color4 = Color3.fromRGB(255, 255, 255)
local color5 = Color3.fromRGB(255, 255, 255)
local color6 = Color3.fromRGB(203, 160, 255)
local udim = UDim2.new(0.5, 0, 0.5, 0)
local udim2 = UDim2.new(1, 0, 1, 0)
local event = NetworkingHandler.GetEvent("SellTower")
local event2 = BindableHandler.GetEvent("UseAbility")
local event3 = BindableHandler.GetEvent("HotkeySellTower")
local event4 = BindableHandler.GetEvent("HotkeyChangeQueryModeLeft")
local event5 = BindableHandler.GetEvent("HotkeyChangeQueryModeRight")
local event6 = BindableHandler.GetEvent("RefreshTowerStatsDisplay")
local event7 = BindableHandler.GetEvent("UpgradeShopChangedForPlayer")
local towerUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TowerUI")
local background_TwoPath = towerUI:WaitForChild("Background_TwoPath")
local background_OnePath = towerUI:WaitForChild("Background_OnePath")
local sellButtonFrame = towerUI:WaitForChild("SellButtonFrame")
local minorStatsFrame = towerUI:WaitForChild("MinorStatsFrame")
local modeFrame = towerUI:WaitForChild("ModeFrame")
local towerImageFrame = towerUI:WaitForChild("TowerImageFrame")
local towerNameText = towerUI:WaitForChild("TowerNameText")
local ownerText = towerUI:WaitForChild("OwnerText")
local sellAmountText = sellButtonFrame:WaitForChild("SellAmountText")
local sellButton = sellButtonFrame:WaitForChild("SellButton")
local sellButtonText = sellButtonFrame:WaitForChild("SellButtonText")
local sellButtonImage = sellButtonFrame:WaitForChild("SellButtonImage")
local costText = minorStatsFrame:WaitForChild("CostText")
local damageIcon = minorStatsFrame:WaitForChild("DamageIcon")
local primaryStatIcon = minorStatsFrame:WaitForChild("PrimaryStatIcon")
local damageText = minorStatsFrame:WaitForChild("DamageText")
local modeText = modeFrame:WaitForChild("ModeText")
local modeLeftArrow = modeFrame:WaitForChild("ModeLeftArrow")
local modeRightArrow = modeFrame:WaitForChild("ModeRightArrow")
local towerImage = towerImageFrame:WaitForChild("TowerImage")
local imageLabel = towerImage:WaitForChild("ImageLabel")
local imageLabelOld = towerImage:WaitForChild("ImageLabelOld")
local attributes = towerImage:WaitForChild("Attributes")
local detection = attributes:WaitForChild("Detection")
local airTargeting = attributes:WaitForChild("AirTargeting")
local noGroundTargeting = attributes:WaitForChild("NoGroundTargeting")
local splashTransfer = attributes:WaitForChild("SplashTransfer")
local stunImmunity = attributes:WaitForChild("StunImmunity")
local rebuildingFrame = towerImageFrame:WaitForChild("RebuildingFrame")
local frame = rebuildingFrame:WaitForChild("Frame")
local juice = frame:WaitForChild("Bar"):WaitForChild("JuiceHolder"):WaitForChild("Juice")
local timeText = frame:WaitForChild("TimeText")
local rebuildsLeftFrame = towerImageFrame:WaitForChild("RebuildsLeftFrame")
local text = rebuildsLeftFrame:FindFirstChild("Frame"):WaitForChild("Text")
local ability1 = towerUI:WaitForChild("Ability1")
local ability2 = towerUI:WaitForChild("Ability2")
local ability3 = towerUI:WaitForChild("Ability3")
local ability4 = towerUI:WaitForChild("Ability4")
local onePathPosition = sellButtonFrame:GetAttribute("OnePathPosition")
local twoPathPosition = sellButtonFrame:GetAttribute("TwoPathPosition")
local v = {}
local v2 = { detection, airTargeting, noGroundTargeting, splashTransfer, stunImmunity }
local v3 = {
	[detection] = "Stealth detection",
	[airTargeting] = "Can target air enemies",
	[noGroundTargeting] = "Cannot target ground enemies",
	[splashTransfer] = "Splash damage hits air and ground enemies",
	[stunImmunity] = "Stun immunity"
}
local v4 = nil
local v5 = nil
local v6 = true
local v7 = false
local v8 = nil
local v9 = nil

local function GetQueryModeText()
	local levelStats = v4.LevelHandler:GetLevelStats()

	if levelStats.HealAmount then
		return "CLOSEST"
	end

	if levelStats.TargetRandomLocationOnPath then
		return "PATH"
	end

	local customQueryOptions = v4.CustomQueryOptions

	if not customQueryOptions then
		return string.upper(QueryType.IndexToQueryType(v4.QueryTypeIndex))
	end

	local customQueryOption = customQueryOptions[v4.QueryTypeIndex + 1]

	if customQueryOption == "FirstWithAbility" then
		return string.upper("Elite")
	end

	return string.upper(customQueryOption)
end

local function TrySellCurrentTower()
	if not v4 or v8 then
		return
	end

	if not v4.OwnedByLocalPlayer then
		SoundHandler.Play("Error")
		return
	end

	event:FireServer(v4.Hash)
	SoundHandler.Play("SellTower")
end

local function UpdateVisibleButtons(ownedByLocalPlayer: boolean)
	local levelStats = v4.LevelHandler:GetLevelStats()

	if ownedByLocalPlayer then
		sellButton.Active = true
		sellButton.AutoButtonColor = true
		sellButtonText.Text = "SELL"
	else
		sellButton.Active = false
		sellButton.AutoButtonColor = false
		sellButtonText.Text = "-"
	end

	local customQueryOptions = v4.CustomQueryOptions
	local v10 = not (levelStats.HealAmount or levelStats.TargetRandomLocationOnPath)
		and (not customQueryOptions or #customQueryOptions ~= 1)
		and ownedByLocalPlayer
	modeText.Text = GetQueryModeText()
	modeLeftArrow.Visible = v10 and ownedByLocalPlayer
	modeRightArrow.Visible = v10 and ownedByLocalPlayer
end

local function GetIcon(object)
	local levelHandler = object.LevelHandler
	local levelStats = levelHandler:GetLevelStats()

	if object.SkinName == "" then
		return levelStats.Icon
	end

	local viewTowerSkinInternalData = ResourceManager.ViewTowerSkinInternalData(object.Type, object.SkinName)
	local icons = viewTowerSkinInternalData and viewTowerSkinInternalData:FindFirstChild("Icons")

	if not icons then
		return levelStats.Icon
	end

	local v10 = not levelHandler and 0 or levelHandler:GetPath() or 0
	local overallLevel = levelHandler and levelHandler:GetOverallLevel() or 0
	local v11

	if v10 == 0 then
		v11 = tostring(overallLevel)
	else
		v11 = `Path{v10}_{overallLevel}`
	end

	local attribute = icons:GetAttribute(v11)

	if attribute and attribute ~= "" then
		return attribute
	end

	return levelStats.Icon
end

local function GetViewport(p, udim3: UDim2?, kind: string, skinName: string, levelOnPath: number?, levelOnPath2: number?) -- 1 equivalent call inferred from this helper
	local viewport = TowerUtilities.GetViewport(p, kind, skinName, nil, levelOnPath, levelOnPath2, 0.95, true)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim2
	viewport.Position = udim
	return viewport
end

local function UpdateRebuildingFrame(data)
	local rebuildTime = data.RebuildTime
	local rebuildTimeRemaining = data.RebuildTimeRemaining
	local v10 = rebuildTimeRemaining > 0
	local rebuildsLeft = data.RebuildsLeft

	if rebuildsLeft then
		Lang.Set(text, Lang.Strings.Game.RebuildsLeft, rebuildsLeft)
		rebuildsLeftFrame.Visible = true
	else
		rebuildsLeftFrame.Visible = false
	end

	if v10 then
		local v11 = rebuildTimeRemaining / rebuildTime
		juice.Size = UDim2.new(1 - v11, 0, 1, 0)

		if rebuildTimeRemaining >= 1 then
			timeText.Text = math.round(rebuildTimeRemaining)
		else
			timeText.Text = string.format("%.1f", rebuildTimeRemaining)
		end

		imageLabel.ImageColor3 = color3
		imageLabelOld.ImageColor3 = color3
		rebuildingFrame.Visible = true
	else
		imageLabel.ImageColor3 = color4
		imageLabelOld.ImageColor3 = color4
		rebuildingFrame.Visible = false
	end
end

function TowerUIHandler.Show(object)
	local levelHandler = object.LevelHandler
	local levelStats = levelHandler:GetLevelStats()
	local onePathOnly = levelHandler:GetUpgradePathData().OnePathOnly
	background_TwoPath.Visible = not onePathOnly
	background_OnePath.Visible = onePathOnly
	sellButtonFrame.Position = onePathOnly and onePathPosition or twoPathPosition
	towerNameText.Text = string.upper(object.Type)
	ownerText.Text = string.upper(object.OwnerName)
	detection.Visible = levelStats.StealthDetection or object.BuffHandler:GetStatMultipliers().StealthDetection
	airTargeting.Visible = levelStats.CanTargetAir
	noGroundTargeting.Visible = levelStats.IgnoreGround
	local v10 = splashTransfer
	local splashAlwaysHitAirAndGround = not levelStats.NoAirToGroundSplashTransfer

	if splashAlwaysHitAirAndGround then
		splashAlwaysHitAirAndGround = levelStats.SplashAlwaysHitAirAndGround

		if not splashAlwaysHitAirAndGround then
			splashAlwaysHitAirAndGround = levelStats.IsSplash

			if splashAlwaysHitAirAndGround then
				splashAlwaysHitAirAndGround = SPLASH_RADIUS_TO_TRANSFER_TO_AIR <= levelStats.SplashRadius
			end
		end
	end

	v10.Visible = splashAlwaysHitAirAndGround
	stunImmunity.Visible = levelStats.StunImmunity
	GetIcon(object)
	local v11 = not levelHandler and 0 or levelHandler:GetPath() or 0
	local v12 = not levelHandler and 0 or levelHandler:GetOverallLevel() or 0
	local formatted = `{object.Type}_{object.SkinName or ""}_{v11}_{v12}`

	if v5 and v5:GetAttribute("UniqueId") ~= formatted then
		v5:Destroy()
		v5 = nil
	end

	if not v5 then
		imageLabelOld.Visible = false
		imageLabel.Visible = false
		local levelOnPath = levelHandler:GetLevelOnPath(1)
		local levelOnPath2 = levelHandler:GetLevelOnPath(2)
		v5 = GetViewport(towerImage, UDim2.new(1, 0, 1, 0), object.Type, object.SkinName, levelOnPath, levelOnPath2) -- inferred equivalent call
		v5:SetAttribute("UniqueId", formatted)
		v5:SetAttribute("IsTowerUIViewport", true)
	end

	UpdateRebuildingFrame(object)
	local isConverted = object:IsConverted()
	local sellReturnRate = TowerUtilities.GetSellReturnRate(isConverted, object.BuffHandler:GetSellback())

	if isConverted then
		sellAmountText.TextColor3 = color6
	else
		sellAmountText.TextColor3 = color5
	end

	costText.Text = "$" .. tostring((math.floor(object.TotalCost)))
	sellAmountText.Text = "$" .. tostring((math.floor(sellReturnRate * object.TotalCost)))
	v4 = object
	UpgradePathClass.Show(object)
	StatsDisplayHandler.Show(object)

	if object.Config.PrimaryMinorStat then
		damageIcon.Visible = false
		primaryStatIcon.Visible = true
		damageText.Text = object.Config.PrimaryMinorStat.FormatString:format(object[object.Config.PrimaryMinorStat.Key])
		primaryStatIcon.Image = object.Config.PrimaryMinorStat.Icon
	else
		damageIcon.Visible = true
		primaryStatIcon.Visible = false
		damageText.Text = tostring((math.round(v4.DamageDealt)))
	end

	for _, v13 in pairs(v) do
		v13:TowerChanged(object)
	end

	UpdateVisibleButtons(object.OwnedByLocalPlayer)
	v6 = false
end

function TowerUIHandler.Hide()
	for _, v10 in pairs(v) do
		v10:TowerDeselected()
	end

	for _, v10 in pairs(v2) do
		AttributeHoverHandler.Unhovered(v10)
	end

	v6 = true
	v4 = nil
end

function TowerUIHandler.Update()
	if v6 or v7 then
		towerUI.Visible = false
	else
		towerUI.Visible = true
	end

	if v4 then
		if v4.Config.PrimaryMinorStat then
			damageText.Text = v4.Config.PrimaryMinorStat.FormatString:format(v4[v4.Config.PrimaryMinorStat.Key])
		else
			damageText.Text = tostring((math.round(v4.DamageDealt)))
		end

		modeText.Text = GetQueryModeText()

		for _, v10 in pairs(v) do
			v10:Run()
		end

		UpdateRebuildingFrame(v4)
	end

	StatsDisplayHandler.Update()
end

function TowerUIHandler.GetCurrentTower()
	return v4
end

function TowerUIHandler.Enable()
	v7 = false
end

function TowerUIHandler.Disable()
	v7 = true
end

function TowerUIHandler.SetTutorialMode(flag: boolean?)
	v8 = flag
	v9 = false
	UpgradePathClass.SetTutorialMode(flag)
end

function TowerUIHandler.EnableTutorialFreebuild()
	v9 = true
	UpgradePathClass.EnableTutorialFreebuild()
end

function TowerUIHandler.SetTutorialForceUpgrade(vector: Vector3?, p: number?, p2: number?, p3: number?)
	UpgradePathClass.SetTutorialForceUpgrade(vector, p, p2, p3)
end

function TowerUIHandler.FPSModeEnabled()
	for _, v10 in pairs(v) do
		v10:_MouseLeft()
	end
end

towerUI.Visible = false
Keybinds.BindLabel(towerUI:WaitForChild("Path1Button"):WaitForChild("Hotkey"), "UpgradeTowerPath1")
Keybinds.BindLabel(towerUI:WaitForChild("Path2Button"):WaitForChild("Hotkey"), "UpgradeTowerPath2")

for i, v10 in ipairs({ ability1, ability2, ability3, ability4 }) do
	Keybinds.BindLabel(v10:WaitForChild("Hotkey"), `UseAbility{i}`)
end

v = {
	AbilityButtonClass.New(ability1),
	AbilityButtonClass.New(ability2),
	AbilityButtonClass.New(ability3),
	AbilityButtonClass.New(ability4)
}
event2:AttachCallback(function(p: number)
	if not p then
		warn("No index provided for ability")
	elseif v4 then
		v[p]:Activated()
	end
end)
event6:AttachCallback(function(p: number)
	if v4 and v4.Hash == p then
		detection.Visible = v4.LevelHandler:GetLevelStats().StealthDetection
			or v4.BuffHandler:GetStatMultipliers().StealthDetection
		StatsDisplayHandler.Show(v4)
	end
end)
event7:AttachCallback(function(p: string, p2: string?, _: string?)
	if v4 and v4.OwnerPlayerWrapperKey == p and v4.Type == p2 then
		for _, v10 in pairs(v) do
			v10:TowerChanged(v4)
		end
	end
end)
UpgradePathClass.SetUpPathFrames()
sellButton.Activated:Connect(function()
	if not v4 or v8 then
		return
	end

	if not v4.OwnedByLocalPlayer then
		SoundHandler.Play("Error")
		return
	end

	event:FireServer(v4.Hash)
	SoundHandler.Play("SellTower")
end)
sellButton.MouseEnter:Connect(function()
	if v8 then
		return
	end

	if v4 and v4.OwnedByLocalPlayer then
		sellButtonImage.ImageColor3 = color2
	end
end)
sellButton.MouseLeave:Connect(function()
	sellButtonImage.ImageColor3 = color
end)
sellButtonImage.ImageColor3 = color

local function QueryTypeLeftButtonActivated()
	if v8 and not v9 then
		return
	end

	if v4 and v4.OwnedByLocalPlayer then
		v4:DecrementQueryType()
		SoundHandler.Play("ClickTower")
	end
end

local function QueryTypeRightButtonActivated()
	if v8 and not v9 then
		return
	end

	if v4 and v4.OwnedByLocalPlayer then
		v4:IncrementQueryType()
		SoundHandler.Play("ClickTower")
	end
end

event4:AttachCallback(function()
	if v8 and not v9 then
		return
	end

	if v4 and v4.OwnedByLocalPlayer then
		v4:DecrementQueryType()
		SoundHandler.Play("ClickTower")
	end
end)
event5:AttachCallback(function()
	if v8 and not v9 then
		return
	end

	if v4 and v4.OwnedByLocalPlayer then
		v4:IncrementQueryType()
		SoundHandler.Play("ClickTower")
	end
end)
modeLeftArrow.Activated:Connect(function()
	if v8 and not v9 then
		return
	end

	if v4 and v4.OwnedByLocalPlayer then
		v4:DecrementQueryType()
		SoundHandler.Play("ClickTower")
	end
end)
modeRightArrow.Activated:Connect(function()
	if v8 and not v9 then
		return
	end

	if v4 and v4.OwnedByLocalPlayer then
		v4:IncrementQueryType()
		SoundHandler.Play("ClickTower")
	end
end)
modeLeftArrow.MouseEnter:Connect(function()
	if v8 and not v9 then
		return
	end

	modeLeftArrow.ImageColor3 = color2
end)
modeRightArrow.MouseEnter:Connect(function()
	if v8 and not v9 then
		return
	end

	modeRightArrow.ImageColor3 = color2
end)
modeLeftArrow.MouseLeave:Connect(function()
	modeLeftArrow.ImageColor3 = color
end)
modeRightArrow.MouseLeave:Connect(function()
	modeRightArrow.ImageColor3 = color
end)
modeRightArrow.ImageColor3 = color
modeLeftArrow.ImageColor3 = color
event3:AttachCallback(function()
	if not v4 or v8 then
		return
	end

	if not v4.OwnedByLocalPlayer then
		SoundHandler.Play("Error")
		return
	end

	event:FireServer(v4.Hash)
	SoundHandler.Play("SellTower")
end)

for _, v10 in pairs(v2) do
	local v11 = v3[v10]
	local v12 = v10
	v10.MouseEnter:Connect(function()
		AttributeHoverHandler.Hovered(v12, v11)
	end)
	local v13 = v10
	v10.MouseLeave:Connect(function()
		AttributeHoverHandler.Unhovered(v13)
	end)
end

return TowerUIHandler