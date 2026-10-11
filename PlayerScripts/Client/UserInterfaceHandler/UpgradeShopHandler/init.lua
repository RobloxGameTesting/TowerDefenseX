local UpgradeShopHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local PlayerClass = require(script.Parent.Parent:WaitForChild("PlayerClass"))
local UpgradeShopTabButtonClass = require(script:WaitForChild("UpgradeShopTabButtonClass"))
local UpgradeShopCardClass = require(script:WaitForChild("UpgradeShopCardClass"))
local event = NetworkingHandler.GetEvent("UpgradeShopRefundAllRequest")
local event2 = BindableHandler.GetEvent("UpgradeShopCreditsChanged")
local event3 = BindableHandler.GetEvent("UpgradeShopChangedForPlayer")
local event4 = BindableHandler.GetEvent("ScreenSizeChanged")
local event5 = BindableHandler.GetEvent("SetDifficulty")
local event6 = BindableHandler.GetEvent("OpenUpgradeShop")
local upgradeShopDataHandler = nil
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local button = PlayerGui:WaitForChild("LowPriorityInterface"):WaitForChild("LeftButtons"):WaitForChild("UpgradeShopButton"):WaitForChild("Button")
local upgradeShopScreen = PlayerGui:WaitForChild("Interface"):WaitForChild("UpgradeShopScreen")
local textLabel = upgradeShopScreen.CreditsButton:WaitForChild("TextLabel")
local refundButton = upgradeShopScreen.InnerFrame.LeftFrame.RefundButton
local template = upgradeShopScreen.TopBarFrame.InnerFrame.Template
local template2 = upgradeShopScreen.InnerFrame.RightFrame.Template
local template3 = upgradeShopScreen.InnerFrame.LeftFrame.CurrentUpgradesFrame.Inner:WaitForChild("Template")
local v = {}
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local clones = {}
local v6 = nil
local WaitingForFirstPlaye = Enums.GameStates.WaitingForFirstPlaye
local upgradeShopEnabled = false
local flag = false

local function UpdateUpgradeShopButtonState() -- 2 equivalent calls inferred from this helper
	if WaitingForFirstPlaye == Enums.GameStates.Running and upgradeShopEnabled then
		flag = true
	else
		flag = false
		UpgradeShopHandler.Hide()
	end

	button.Visible = flag
end

local function CreateUpgradeCards(p: number, p2: string)
	local towerConfig = ResourceManager.GetTowerConfig(p2)
	local towerUpgradeShopData = towerConfig and towerConfig.TowerUpgradeShopData

	if not towerUpgradeShopData then
		return
	end

	for _, v7 in pairs(towerUpgradeShopData) do
		local v8 = UpgradeShopCardClass.New(template2, p, p2, v7)
		table.insert(v5, v8)
	end
end

local function UpdateUpgradeCardForTowerAndUpgradeType(p: string, p2: string?)
	for _, v7 in pairs(v5) do
		if v7:Matches(p, p2) then
			v7:UpdateState()
		end
	end
end

local function UpdateAllUpgradeCards() -- 1 equivalent call inferred from this helper
	for _, v7 in pairs(v5) do
		v7:UpdateState()
	end
end

local function UpdateCurrentUpgradesDisplay()
	for _, v7 in pairs(clones) do
		v7.Visible = false
	end

	if not v6 then
		return
	end

	local v7 = upgradeShopDataHandler:GetCurrentData()[v6]

	if not v7 then
		return
	end

	local count = 0

	for k, v8 in pairs(v7) do
		if v8.Level <= 0 then
			continue
		end

		local upgradeShopTypeData = TowerUpgradeShopUtilities.GetUpgradeShopTypeData(k)

		if not upgradeShopTypeData then
			continue
		end

		count += 1
		local clone = clones[count]

		if not clone then
			clone = template3:Clone()
			clone.Parent = template3.Parent
			clones[count] = clone
		end

		local textLabel = clone:FindFirstChild("TextLabel")
		textLabel.Text = TowerUpgradeShopUtilities.GetUpgradeString(upgradeShopTypeData, v8.Amount)
		clone.LayoutOrder = upgradeShopTypeData.SortOrder
		clone.Visible = true
	end
end

local function SelectTabAtIndex(p: number)
	v6 = v[p]

	if not v6 then
		return
	end

	if not v3[v6] then
		CreateUpgradeCards(p, v6)
		v3[v6] = true
	end

	for k, v7 in pairs(v4) do
		v7:ToggleSelected(k == p)
	end

	for _, v7 in pairs(v5) do
		v7:ToggleVisibleAtIndex(p)
	end

	UpdateCurrentUpgradesDisplay()
end

local function UpdateCreditsDisplay(p: number) -- 2 equivalent calls inferred from this helper
	textLabel.Text = string.format("%d Credits", p)
end

local function SyncTabTextSize()
	if not upgradeShopScreen.Visible then
		return
	end

	local textLabels = {}
	local v7 = {}

	for _, v8 in pairs(v4) do
		local textLabel2, v9 = v8:GetTextLabel()
		v9.MaxTextSize = 100
		table.insert(textLabels, textLabel2)
		table.insert(v7, v9)
	end

	local v8 = textLabels[1]
	local text = v8.Text
	v8.Text = Enums.Towers.WarMachineFactory
	local maxTextSize = math.max(14, v8.TextBounds.Y / 2)
	v8.Text = text

	for _, v9 in pairs(v7) do
		v9.MaxTextSize = maxTextSize
	end
end

function UpgradeShopHandler.Initialize(p)
	v = p
	v2 = {}
	v3 = {}

	for k, v7 in pairs(v) do
		v2[v7] = k
	end

	for _, v7 in pairs(v4) do
		v7:Destroy()
	end

	for _, v7 in pairs(v5) do
		v7:Destroy()
	end

	table.clear(v4)
	table.clear(v5)
	local count = 0
	local v7 = 1e999

	for k, v8 in pairs(v) do
		count += 1

		if count > 6 then
			break
		end

		if k < v7 then
			v7 = k
		end

		v4[k] = UpgradeShopTabButtonClass.New(template, k, v8, SelectTabAtIndex)
	end

	if count > 0 then
		SelectTabAtIndex(v7)
	end

	SyncTabTextSize()
end

function UpgradeShopHandler.Update(_: number) end

function UpgradeShopHandler.SetState(p: string)
	WaitingForFirstPlaye = p
	UpdateUpgradeShopButtonState() -- inferred equivalent call
end

function UpgradeShopHandler.Toggle()
	upgradeShopScreen.Visible = not upgradeShopScreen.Visible
	SyncTabTextSize()
end

function UpgradeShopHandler.Hide()
	upgradeShopScreen.Visible = false
end

local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
upgradeShopDataHandler = localPlayerWrapper:GetUpgradeShopDataHandler()
upgradeShopScreen.Visible = false
template.Visible = false
template2.Visible = false
template3.Visible = false
UpdateCreditsDisplay(upgradeShopDataHandler:GetCredits()) -- inferred equivalent call
UpdateCurrentUpgradesDisplay()
refundButton.Activated:Connect(function()
	SoundHandler.Play("UpgradeShopReset")

	if v6 then
		event:FireServer(v6)
	end
end)
button.Activated:Connect(function()
	if flag then
		UpgradeShopHandler.Toggle()
	end
end)
event6:AttachCallback(function(flag2: boolean)
	if flag then
		if flag2 then
			SoundHandler.Play("ClickUp")
		else
			SoundHandler.Play("ClickDown")
			UpgradeShopHandler.Toggle()
		end
	end
end)
event5:AttachCallback(function(p: string)
	local waveConfig = ResourceManager.GetWaveConfig(p)
	upgradeShopEnabled = waveConfig and waveConfig.UpgradeShopEnabled or false
	UpdateUpgradeShopButtonState() -- inferred equivalent call
end)
event4:AttachCallback(function()
	SyncTabTextSize()
end)
event2:AttachCallback(function(p: number)
	UpdateCreditsDisplay(p) -- inferred equivalent call
end)
event3:AttachCallback(function(p: string, p2: string?, p3: string?)
	if not (localPlayerWrapper and p == localPlayerWrapper:GetPlayerWrapperKey()) then
		return
	end

	if p2 then
		UpdateUpgradeCardForTowerAndUpgradeType(p2, p3)
	else
		UpdateAllUpgradeCards() -- inferred equivalent call
	end

	UpdateCurrentUpgradesDisplay()
end)
return UpgradeShopHandler