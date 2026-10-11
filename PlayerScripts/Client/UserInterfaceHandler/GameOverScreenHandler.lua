local GameOverScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("WaveTypes"))
local Utilities = require(Common:WaitForChild("Utilities"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local SwagTextClass = require(Common:WaitForChild("SwagTextClass"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local LobbyTypeUtilities = require(Common:WaitForChild("LobbyTypeUtilities"))
local MapUtilities = require(Common:WaitForChild("MapUtilities"))
local RewardMultipliers = require(Common:WaitForChild("RewardMultipliers"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local Data = require(TDX_Shared:WaitForChild("Client"):WaitForChild("Services"):WaitForChild("Data"))
local PlayerClass = require(script.Parent.Parent:WaitForChild("PlayerClass"))
local GameOverRewardsScreenHandler = require(script.Parent:WaitForChild("GameOverRewardsScreenHandler"))
local VIP_GAMEPASS_ID = _G.VIP_GAMEPASS_ID
local color = Color3.fromRGB(125, 125, 125)
local color2 = Color3.fromRGB(255, 255, 255)
local udim = UDim2.new(0.5, 0, -0.5, 0)
local udim2 = UDim2.new(0.5, 0, 0.5, 0)
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local event = NetworkingHandler.GetEvent("RequestTeleportToLobby")
local event2 = NetworkingHandler.GetEvent("GamepassPurchased")
local v = NetworkingHandler.GetFunction("RequestRewind")
local LocalPlayer = Players.LocalPlayer
local gameOverScreen = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("GameOverScreen")
local main = gameOverScreen:WaitForChild("Main")
local rewards = gameOverScreen:WaitForChild("Rewards")
local infoFrame = main:WaitForChild("InfoFrame")
local map = infoFrame:WaitForChild("Map")
local mode = infoFrame:WaitForChild("Mode")
local time = infoFrame:WaitForChild("Time")
local defeatText = main:WaitForChild("DefeatText")
local victoryText = main:WaitForChild("VictoryText")
local endlessText = main:WaitForChild("EndlessText")
local defeatRenders = main:WaitForChild("DefeatRenders")
local victoryRenders = main:WaitForChild("VictoryRenders")
local leftButton = main:WaitForChild("LeftButton")
local rightButton = main:WaitForChild("RightButton")
local centerButton = main:WaitForChild("CenterButton")
local rewardsFrame = main:WaitForChild("RewardsFrame")
local innerFrame = rewardsFrame:WaitForChild("InnerFrame")
local gold = innerFrame:WaitForChild("Gold")
local textLabel = gold:WaitForChild("TextLabel")
local bonusTextLabel = gold:WaitForChild("BonusTextLabel")
local imageLabel = gold:WaitForChild("ImageLabel")
local crystals = innerFrame:WaitForChild("Crystals")
local textLabel2 = crystals:WaitForChild("TextLabel")
local bonusTextLabel2 = crystals:WaitForChild("BonusTextLabel")
local imageLabel2 = crystals:WaitForChild("ImageLabel")
local cookies = innerFrame:WaitForChild("Cookies")
local textLabel3 = cookies:WaitForChild("TextLabel")
local imageLabel3 = cookies:WaitForChild("ImageLabel")
local xp = innerFrame:WaitForChild("XP")
local textLabel4 = xp:WaitForChild("TextLabel")
local bonusTextLabel3 = xp:WaitForChild("BonusTextLabel")
local imageLabel4 = xp:WaitForChild("ImageLabel")
local tokens = innerFrame:WaitForChild("Tokens")
local textLabel5 = tokens:WaitForChild("TextLabel")
local imageLabel5 = tokens:WaitForChild("ImageLabel")
local bonusTextLabel4 = tokens:FindFirstChild("BonusTextLabel") or bonusTextLabel3:Clone()

if bonusTextLabel4.Parent ~= tokens then
	bonusTextLabel4.Visible = false
	bonusTextLabel4.Parent = tokens
end

local vipPrompt = main:WaitForChild("RewardsFrameVIPFrame"):WaitForChild("VIPPrompt")
local noVIP = vipPrompt:WaitForChild("NoVIP")
local buyButton = noVIP:WaitForChild("BuyButton")
local hovered = buyButton:WaitForChild("Hovered")
local vip = vipPrompt:WaitForChild("VIP")
local textLabel6 = vip:WaitForChild("TextLabel")
local miscRewardsFrame = main:WaitForChild("MiscRewardsFrame")
local tower = miscRewardsFrame:WaitForChild("Tower")
tower:WaitForChild("TowerName"):WaitForChild("Text")
tower:WaitForChild("ViewportHolder")
local skin = miscRewardsFrame:WaitForChild("Skin")
skin:WaitForChild("TowerName"):WaitForChild("Text")
skin:WaitForChild("SkinName"):WaitForChild("Text")
skin:WaitForChild("ViewportHolder")
local rewindScreen = gameOverScreen:WaitForChild("RewindScreen")
local content = rewindScreen:WaitForChild("Content")
local text = content:WaitForChild("1"):WaitForChild("Text")
local text2 = content:WaitForChild("2"):WaitForChild("Text")
local text3 = content:WaitForChild("3"):WaitForChild("Text")
local buyButtonRobux = rewindScreen:WaitForChild("BuyButtonRobux")
local buyButtonGold = rewindScreen:WaitForChild("BuyButtonGold")
local textLabel7 = buyButtonRobux:WaitForChild("TextLabel")
local textLabel8 = buyButtonGold:WaitForChild("TextLabel")
local text4 = rewindScreen:WaitForChild("GoldBalance"):WaitForChild("Text")
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local costGold = nil
local costRobux = nil
local v10 = {
	StartNumber = 0,
	EndNumber = 0,
	StartDelay = 0.9,
	FadeInTime = 0.1,
	Duration = 0.75,
	MinimumInterval = 0.04,
	FormatString = "+%d",
	AppendStringOnceComplete = nil,
	TextLabel = textLabel,
	ImageLabels = { imageLabel },
	SoundName = "TypingSound"
}
local v11 = {
	StartNumber = 0,
	EndNumber = 0,
	StartDelay = 1.7,
	FadeInTime = 0.1,
	Duration = 0.75,
	MinimumInterval = 0.04,
	FormatString = "+%d",
	AppendStringOnceComplete = nil,
	TextLabel = textLabel2,
	ImageLabels = { imageLabel2 },
	SoundName = "CrystalsTypingSound"
}
local v12 = {
	StartNumber = 0,
	EndNumber = 0,
	StartDelay = 1.7,
	FadeInTime = 0.1,
	Duration = 0.75,
	MinimumInterval = 0.06,
	FormatString = "+%d",
	AppendStringOnceComplete = nil,
	TextLabel = textLabel3,
	ImageLabels = { imageLabel3 },
	SoundName = "TypingSound"
}
local v13 = {
	StartNumber = 0,
	EndNumber = 0,
	StartDelay = 1.7,
	FadeInTime = 0.1,
	Duration = 0.75,
	MinimumInterval = 0.04,
	FormatString = "+%d",
	TextLabel = textLabel4,
	ImageLabels = { imageLabel4 },
	SoundName = "TypingSound"
}
local v14 = {
	StartNumber = 0,
	EndNumber = 0,
	StartDelay = 3.3,
	FadeInTime = 0.1,
	Duration = 0.75,
	MinimumInterval = 0.04,
	FormatString = "+%d",
	TextLabel = textLabel5,
	ImageLabels = { imageLabel5 },
	SoundName = "TypingSound"
}
local victoryMusicName = nil

local function UpdateVIPVisibility() -- 3 equivalent calls inferred from this helper
	local localPlayerIsVIP = PlayerClass.LocalPlayerIsVIP()
	noVIP.Visible = not localPlayerIsVIP
	vip.Visible = localPlayerIsVIP
end

local function NewEndScreenButtonHandler(instance)
	local v15 = {
		Enabled = true,
		IsHovered = false,
		OnClickedCallback = nil,
		Button = instance,
		HighlightStateImage = instance:FindFirstChild("Highlight"),
		TextLabel = instance:FindFirstChild("Text"),
		Enable = function(self, onClickedCallback)
			self.Enabled = true
			self.OnClickedCallback = onClickedCallback
			self:_UpdateState()
		end,
		Disable = function(self)
			self.Enabled = false
			self:_UpdateState()
		end,
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Clicked = function(self)
			if not self.Enabled then
				SoundHandler.Play("Error")
				return
			end

			SoundHandler.Play("ClickTower")

			if self.OnClickedCallback then
				self.OnClickedCallback()
			end
		end,
		SetText = function(self, text5: string)
			self.TextLabel.Text = text5
		end,
		_UpdateState = function(self)
			self.Button.Visible = self.Enabled

			if self.Enabled and self.IsHovered then
				self.HighlightStateImage.Visible = true
			else
				self.HighlightStateImage.Visible = false
			end

			if self.Enabled then
				self.TextLabel.TextColor3 = color2
			else
				self.TextLabel.TextColor3 = color
			end
		end
	}
	instance.MouseEnter:Connect(function()
		v15:Hovered()
	end)
	instance.MouseLeave:Connect(function()
		v15:Unhovered()
	end)
	instance.Activated:Connect(function()
		v15:Clicked()
	end)
	return v15
end

local function DisableAllButtons() -- 1 equivalent call inferred from this helper
	v2:Disable()
	v3:Disable()
	v4:Disable()
end

local function RequestTeleportToLobby()
	v4:SetText("TELEPORTING...")
	v2:SetText("TELEPORTING...")
	DisableAllButtons() -- inferred equivalent call
	local v15 = event:FireServer()
	task.wait(6)

	if not v15 then
		v4:SetText("TELEPORT FAILED")
		v2:SetText("TELEPORT FAILED")
	end
end

local function ToggleRewindScreen()
	rewindScreen.Visible = not rewindScreen.Visible
end

local function HandleRewindData(lastPassedWave: number, rewindData)
	costGold = rewindData.CostGold
	costRobux = rewindData.CostRobux
	v2:SetText(Lang.Get(Lang.Strings.Game.RewindOpenButton, lastPassedWave))
	Lang.Set(text, Lang.Strings.Game.RewindWave, lastPassedWave)
	Lang.Set(text2, Lang.Strings.Game.RewindCash, rewindData.GainCash)
	Lang.Set(text3, Lang.Strings.Game.RewindHP, rewindData.GainHP)

	if costGold then
		buyButtonGold:SetAttribute("Selected", false)

		if costGold <= 0 then
			Lang.Set(textLabel8, Lang.Strings.Game.RewindGoldFree)
		else
			Lang.Set(textLabel8, Lang.Strings.Game.RewindGoldCost, costGold)
		end
	else
		buyButtonGold:SetAttribute("Selected", true)
		Lang.Set(textLabel8, Lang.Strings.Game.RewindRobuxOnly)
	end

	if not costRobux then
		buyButtonRobux.Visible = false
		return
	end

	Lang.Set(textLabel7, Lang.Strings.Game.RewindRobuxCost, costRobux)
	buyButtonRobux.Visible = true
end

local function GetScreenEndPosition() -- 1 equivalent call inferred from this helper
	return UDim2.new(0.5, -rewards.AbsoluteSize.X / 2, 0.5, 0)
end

local function GetVictoryRenderToShow(p) -- 1 equivalent call inferred from this helper
	local child

	if p.VictoryScreenRenderName then
		child = victoryRenders:FindFirstChild(p.VictoryScreenRenderName)

		if not child then
			warn("Could not find VictoryRender: " .. p.VictoryScreenRenderName)
		end
	end

	return child or victoryRenders:FindFirstChild("Default")
end

local function GetDefeatRenderToShow(p) -- 1 equivalent call inferred from this helper
	local child

	if p.DefeatScreenRenderName then
		child = defeatRenders:FindFirstChild(p.DefeatScreenRenderName)

		if not child then
			warn("Could not find DefeatRender: " .. p.DefeatScreenRenderName)
		end
	end

	return child or defeatRenders:FindFirstChild("Default")
end

local function ShowVictoryRender(waveConfig) -- 1 equivalent call inferred from this helper
	local victoryRenderToShow = GetVictoryRenderToShow(waveConfig) -- inferred equivalent call

	for _, child in pairs(victoryRenders:GetChildren()) do
		child.Visible = child == victoryRenderToShow
	end
end

local function ShowDefeatRender(waveConfig) -- 1 equivalent call inferred from this helper
	local defeatRenderToShow = GetDefeatRenderToShow(waveConfig) -- inferred equivalent call

	for _, child in pairs(defeatRenders:GetChildren()) do
		child.Visible = child == defeatRenderToShow
	end
end

local function GetBonusText(p, p2: string?) -- 2 equivalent calls inferred from this helper
	local v15 = RewardMultipliers.Get(p)

	if v15 == 1 then
		return p2
	end

	local formatted = RewardMultipliers.Format(v15)

	if p2 then
		return `{formatted}! {p2}`
	end

	return `{formatted} {RewardMultipliers.Definitions[p].DisplayName}!`
end

local function ShowBonusText(p, p2, text5: string?) -- 4 equivalent calls inferred from this helper
	if not text5 then
		p.Visible = false
		return
	end

	p.Text = ""
	p.Visible = true
	task.delay(p2.StartDelay + p2.Duration, function()
		p.Text = text5
	end)
end

function GameOverScreenHandler.DisplayScreen(data)
	local name = LocalPlayer.Name
	local difficulty = data.Difficulty
	local lastPassedWave = data.LastPassedWave
	local victory

	if data.IsPVP then
		victory = data.PlayerNameToPVPVictoryMap[name]
	else
		victory = data.Victory or difficulty == Enums.Difficulties.Endless
	end

	local waveConfig = ResourceManager.GetWaveConfig(difficulty)

	if difficulty == Enums.Difficulties.Endless then
		defeatText.Visible = false
		defeatRenders.Visible = false
		victoryText.Visible = false
		victoryRenders.Visible = true
		endlessText.Text = `WAVE {lastPassedWave}`
		endlessText.Visible = true
	else
		defeatText.Visible = not victory
		defeatRenders.Visible = not victory
		victoryText.Visible = victory
		victoryRenders.Visible = victory
		endlessText.Visible = false
	end

	vipPrompt.Visible = false
	rewindScreen.Visible = false

	if waveConfig then
		ShowVictoryRender(waveConfig) -- inferred equivalent call
		ShowDefeatRender(waveConfig) -- inferred equivalent call
	end

	map.Text = string.upper(MapUtilities.GetDisplayName(data.MapName))
	local v15 = mode

	if waveConfig then
		difficulty = waveConfig.DisplayName or difficulty
	end

	v15.Text = string.upper(difficulty)
	time.Text = Utilities.ConvertToTimeStringFull(data.TimeElapsed)
	local canRewind = data.CanRewind
	local rewindData = data.RewindData

	if canRewind then
		HandleRewindData(lastPassedWave, rewindData)
		v4:Disable()
		v3:Enable(RequestTeleportToLobby)
		v2:Enable(ToggleRewindScreen)
	else
		v4:Enable(RequestTeleportToLobby)
		v3:Disable()
		v2:Disable()
	end

	gameOverScreen.Position = udim
	TweenService:Create(gameOverScreen, tweenInfo, { Position = udim2 }):Play()
	gameOverScreen.Visible = true

	if victoryMusicName then
		SoundHandler.Stop(victoryMusicName, 1)
		victoryMusicName = nil
	end

	local lobbyType = workspace:GetAttribute("LobbyType")
	local v16 = lobbyType and LobbyTypeUtilities.GetLobbyTypeData(lobbyType)

	if victory then
		if waveConfig.NoVictoryMusic then
			victoryMusicName = nil
		elseif waveConfig.VictoryMusicName then
			victoryMusicName = waveConfig.VictoryMusicName
		elseif v16 and v16.VictoryScreenMusicName then
			victoryMusicName = v16.VictoryScreenMusicName
		else
			victoryMusicName = "VictoryMusic"
		end
	elseif waveConfig.DefeatMusicName then
		victoryMusicName = waveConfig.DefeatMusicName
	elseif v16 and v16.DefeatScreenMusicName then
		victoryMusicName = v16.DefeatScreenMusicName
	else
		victoryMusicName = "DefeatMusic"
	end

	if victoryMusicName then
		SoundHandler.Play(victoryMusicName)
	end

	local v17 = data.PlayerNameToBaseGoldMap[name] or 0
	local endNumber = data.PlayerNameToGoldMap[name] or 0
	local v18 = data.PlayerNameToBaseCrystalsMap[name] or 0
	local endNumber2 = data.PlayerNameToCrystalsMap[name] or 0
	local endNumber3 = data.PlayerNameToCookiesMap[name] or 0
	local endNumber4 = data.PlayerNameToXPMap[name] or 0
	local endNumber5 = data.PlayerNameToTokensMap[name] or 0
	rewardsFrame.Visible = true
	local total = 0.9
	gold.Visible = endNumber > 0 or endNumber2 == 0

	if gold.Visible then
		v10.StartDelay = total
		v10.EndNumber = endNumber
		v5 = SwagTextClass.New(v10)
		total += 0.8
	end

	crystals.Visible = endNumber2 > 0

	if crystals.Visible then
		v11.StartDelay = total
		v11.EndNumber = endNumber2
		v6 = SwagTextClass.New(v11)
		total += 0.8
	end

	cookies.Visible = endNumber3 > 0

	if cookies.Visible then
		v12.StartDelay = total
		v12.EndNumber = endNumber3
		v7 = SwagTextClass.New(v12)
		total += 0.8
	end

	v13.StartDelay = total
	v13.EndNumber = endNumber4
	v8 = SwagTextClass.New(v13)
	local startDelay = total + 0.8
	tokens.Visible = endNumber5 > 0

	if tokens.Visible then
		v14.StartDelay = startDelay
		v14.EndNumber = endNumber5
		v9 = SwagTextClass.New(v14)
		startDelay += 0.8
	end

	local v19 = math.round(100 * endNumber / v17) - 100
	local v20

	if v19 > 0 then
		v20 = string.format("(%d+%d%%)", v17, v19)
	else
		v20 = false
	end

	local v21 = math.round(100 * endNumber2 / v18) - 100
	local v22

	if v21 > 0 then
		v22 = string.format("(%d+%d%%)", v18, v21)
	else
		v22 = false
	end

	ShowBonusText(bonusTextLabel, v10, GetBonusText("Gold", v20 or nil)) -- inferred equivalent call
	ShowBonusText(bonusTextLabel2, v11, GetBonusText("Crystals", v22 or nil)) -- inferred equivalent call
	local xp2 = RewardMultipliers.Get("XP")
	local v23

	if xp2 ~= 1 then
		v23 = `{RewardMultipliers.Format(xp2)} {RewardMultipliers.Definitions.XP.DisplayName}!`
	end

	ShowBonusText(bonusTextLabel3, v13, v23) -- inferred equivalent call
	local tokens2 = RewardMultipliers.Get("Tokens")
	local v24

	if tokens2 ~= 1 then
		v24 = `{RewardMultipliers.Format(tokens2)} {RewardMultipliers.Definitions.Tokens.DisplayName}!`
	end

	ShowBonusText(bonusTextLabel4, v14, v24) -- inferred equivalent call
	local v25 = math.floor(data.PlayerNameBonusXPFromVIPMap[name] or 0)

	if PlayerClass.LocalPlayerIsVIP() and v25 then
		textLabel6.Text = `YOU EARNED +{v25} MORE XP FROM VIP!`
	end

	UpdateVIPVisibility() -- inferred equivalent call
	task.delay(v13.StartDelay + v13.Duration + 0.25, function()
		vipPrompt.Visible = gameOverScreen.Visible
	end)
	task.spawn(function()
		if GameOverRewardsScreenHandler.DisplayScreen(2.5, 1.2, data) then
			task.delay(2.5, function()
				if not gameOverScreen.Visible then
					return
				end

				TweenService:Create(gameOverScreen, tweenInfo2, {
					Position = GetScreenEndPosition() -- inferred equivalent call
				}):Play()
			end)
		end
	end)
end

function GameOverScreenHandler.HideScreen()
	GameOverRewardsScreenHandler.HideScreen()
	gameOverScreen.Visible = false

	if victoryMusicName then
		SoundHandler.Stop(victoryMusicName, 3)
		victoryMusicName = nil
	end
end

function GameOverScreenHandler.Update(p: number)
	if v5 then
		v5:Run(p)
	end

	if v6 then
		v6:Run(p)
	end

	if v7 then
		v7:Run(p)
	end

	if v8 then
		v8:Run(p)
	end

	if v9 then
		v9:Run(p)
	end
end

v2 = NewEndScreenButtonHandler(leftButton)
v3 = NewEndScreenButtonHandler(rightButton)
v4 = NewEndScreenButtonHandler(centerButton)
textLabel.Text = "+0"
textLabel2.Text = "+0"
textLabel3.Text = "+0"
textLabel4.Text = "+0"
textLabel5.Text = "+0"
GameOverScreenHandler.HideScreen()
UpdateVIPVisibility() -- inferred equivalent call
buyButton.MouseEnter:Connect(function()
	hovered.ImageTransparency = 0
end)
buyButton.MouseLeave:Connect(function()
	hovered.ImageTransparency = 1
end)
buyButton.Activated:Connect(function()
	SoundHandler.Play("ShopSelectOption")
	MarketplaceService:PromptGamePassPurchase(LocalPlayer, VIP_GAMEPASS_ID)
end)
event2:AttachCallback(function(p: string, p2: number)
	if p ~= LocalPlayer.Name or p2 ~= VIP_GAMEPASS_ID then
		return
	end

	textLabel6.Text = "YOU WILL EARN MORE XP FROM VIP NEXT GAME!"
	UpdateVIPVisibility() -- inferred equivalent call
	SoundHandler.Play("GamepassPurchaseSuccess")
end)
Data.Updated:Connect(function(p: string)
	local gold2 = p == "Gold" and Data.Get("Gold")

	if gold2 then
		Lang.Set(text4, Lang.Strings.Game.RewindGoldBalance, gold2)
	end
end)

local function RewindServerError() -- 3 equivalent calls inferred from this helper
	local gold2 = Data.Get("Gold")
	SoundHandler.Play("Error")
	task.spawn(function()
		Lang.Set(text4, Lang.Strings.Game.RewindServerError)
		task.wait(3)
		Lang.Set(text4, Lang.Strings.Game.RewindGoldBalance, gold2 or 0)
	end)
end

local flag = false

local function RequestRewind(flag2: boolean)
	if flag then
		return
	end

	flag = true
	local success, result = pcall(function()
		return v:InvokeServer(flag2)
	end)
	flag = false

	if not (success and result) then
		RewindServerError() -- inferred equivalent call
	end
end

buyButtonGold.Activated:Connect(function()
	if not costGold then
		return
	end

	local gold2 = Data.Get("Gold")

	if gold2 and not (gold2 < costGold) then
		if flag then
			return
		end

		flag = true
		local v15
		v15 = false
		local success, result = pcall(function()
			return v:InvokeServer(v15)
		end)
		flag = false

		if not (success and result) then
			RewindServerError() -- inferred equivalent call
		end
	else
		SoundHandler.Play("Error")
		task.spawn(function()
			Lang.Set(text4, Lang.Strings.Game.RewindInsufficientGold)
			task.wait(3)
			Lang.Set(text4, Lang.Strings.Game.RewindGoldBalance, gold2 or 0)
		end)
	end
end)
buyButtonRobux.Activated:Connect(function()
	if flag then
		return
	end

	flag = true
	local v15
	v15 = true
	local success, result = pcall(function()
		return v:InvokeServer(v15)
	end)
	flag = false

	if not (success and result) then
		RewindServerError() -- inferred equivalent call
	end
end)
return GameOverScreenHandler