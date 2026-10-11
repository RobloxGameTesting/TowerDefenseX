local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local Utilities = require(Common:WaitForChild("Utilities"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local ColorUtilities = require(Common:WaitForChild("ColorUtilities"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local TeamUtilities = require(Common:WaitForChild("TeamUtilities"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local Director = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Director"))
local Data = require(TDX_Shared.Client.Services.Data)
local Advisors = require(TDX_Shared.Modules.Advisors)
require(script:WaitForChild("GameInfoHandlerTypes"))
local PVPBossBarJuiceClass = require(script:WaitForChild("PVPBossBarJuiceClass"))
local DEV_DISABLE_DIALOGUE = RunService:IsStudio() and _G.DEV_DISABLE_DIALOGUE
local udim = UDim2.new(0.5, 0, 0, -GuiService:GetGuiInset().Y)
local udim2 = UDim2.new(0.5, 0, -0.015, -GuiService:GetGuiInset().Y)
local udim3 = UDim2.new(0.5, 0, -0.3, -GuiService:GetGuiInset().Y)
local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(255, 80, 80)
local event = NetworkingHandler.GetEvent("WaveCashBonus")
local event2 = BindableHandler.GetEvent("WaveChanged")
local event3 = BindableHandler.GetEvent("TimeLeftChanged")
local event4 = BindableHandler.GetEvent("LivesChanged")
local event5 = BindableHandler.GetEvent("SetDifficulty")
local event6 = BindableHandler.GetEvent("BossActiveUpdate")
local event7 = BindableHandler.GetEvent("MessagePrompt")
local interface = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface")
local gameInfoBar = interface:WaitForChild("GameInfoBar")
local topAreaQueueFrame = interface:WaitForChild("TopAreaQueueFrame")
local default = gameInfoBar:WaitForChild("Default")
local wave = default:WaitForChild("Wave")
local timeLeft = default:WaitForChild("TimeLeft")
local livesBar = default:WaitForChild("LivesBar")
local mapVoting = default:WaitForChild("MapVoting")
local waveText = wave:WaitForChild("WaveText")
local timeLeftText = timeLeft:WaitForChild("TimeLeftText")
local livesText = livesBar:WaitForChild("LivesText")
local bar = livesBar:WaitForChild("BarParent"):WaitForChild("Bar")
local children = {}
local texts = {}
local bars = {}
local shieldBars = {}
local GameInfoHandler = {}

for i = 1, 3 do
	local child = topAreaQueueFrame:WaitForChild("BossInfo" .. i)
	local barParent = child:WaitForChild("BarParent")
	children[i] = child
	texts[i] = child:WaitForChild("Text")
	bars[i] = barParent:WaitForChild("Bar")
	shieldBars[i] = barParent:WaitForChild("ShieldBar")
end

local v = PVPBossBarJuiceClass.New()

local function CalibratePVPBossInfoFrame(instance, folder)
	local y = folder.AbsolutePosition.Y
	local y2 = folder.AbsoluteSize.Y

	if y2 <= 0 then
		return
	end

	local v2 = 0
	local v3 = 1

	for _, guiObject in ipairs(folder:GetDescendants()) do
		if not guiObject:IsA("GuiObject") then
			continue
		end

		local v4 = (guiObject.AbsolutePosition.Y - y) / y2
		local v5 = v4 + guiObject.AbsoluteSize.Y / y2
		v2 = math.min(v2, v4)
		v3 = math.max(v3, v5)
	end

	local v4 = v3 - v2 + 0.05
	local uiAspectRatioConstraint = instance:FindFirstChildWhichIsA("UIAspectRatioConstraint")

	if uiAspectRatioConstraint then
		uiAspectRatioConstraint.AspectRatio /= v4
	end

	local uiSizeConstraint = instance:FindFirstChildWhichIsA("UISizeConstraint")

	if uiSizeConstraint then
		uiSizeConstraint.MinSize = Vector2.new(
			uiSizeConstraint.MinSize.X,
			(math.round(uiSizeConstraint.MinSize.Y * v4))
		)
	end

	folder.Size = UDim2.new(1, 0, 1 / v4, 0)
	folder.Position = UDim2.new(0.5, 0, -v2 / v4, 0)
end

local children2 = {}
local juices = {}
local juiceDecorations = {}
local shieldBars2 = {}
local v2 = {}
local names = {}
local hpTexts = {}
local senderTexts = {}
local headshotImages = {}
local senderTexts2 = {}

for i = 1, 3 do
	local child = topAreaQueueFrame:WaitForChild("PVPBossInfo" .. i)
	children2[i] = child
	local content = child and child:FindFirstChild("Content")

	if not content then
		continue
	end

	local barParent = content:FindFirstChild("BarParent")

	if barParent then
		local juiceFrame = barParent:FindFirstChild("JuiceFrame")

		if juiceFrame then
			juices[i] = juiceFrame:FindFirstChild("Juice")
			juiceDecorations[i] = juiceFrame:FindFirstChild("JuiceDecoration")
		end

		local shieldBar = barParent:FindFirstChild("ShieldBar")
		shieldBars2[i] = shieldBar

		if shieldBar then
			v2[i] = shieldBar.Size.Y
		end

		names[i] = barParent:FindFirstChild("Name")
		local hpFrame = barParent:FindFirstChild("HPFrame")

		if hpFrame then
			hpTexts[i] = hpFrame:FindFirstChild("HPText")
		end
	end

	local senderFrame = content:FindFirstChild("SenderFrame")

	if senderFrame then
		senderTexts[i] = senderFrame:FindFirstChild("SenderText")
	end

	local headshotImage = content:FindFirstChild("HeadshotImage")
	headshotImages[i] = headshotImage
	local bossTag = headshotImage and headshotImage:FindFirstChild("BossTag")

	if bossTag then
		senderTexts2[i] = bossTag:FindFirstChild("SenderText")
	end

	if barParent then
		local juiceFrame = barParent:FindFirstChild("JuiceFrame")
		local juice = juiceFrame and juiceFrame:FindFirstChild("Juice")

		if juiceFrame and juice then
			v:RegisterSlot(i, {
				Frame = child,
				Content = content,
				BarParent = barParent,
				JuiceFrame = juiceFrame,
				Juice = juice,
				HeadshotImage = headshotImages[i]
			})
		end
	end

	task.defer(CalibratePVPBossInfoFrame, child, content)
end

local v3 = 10
local v4 = v3
local v5 = v3
local flag = true
local v6 = {}
local v7 = {}
local v8 = 1
local v9 = {}
local v10 = {}
local v11 = nil
local v12 = nil
local hideWaveTimerIfInfiniteTime = false
local v13 = nil
local v14 = nil

local function HandleCustomGameInfoHandler(waveConfig)
	local v15 = false
	local customGameInfoHandlerName = waveConfig.CustomGameInfoHandlerName

	if customGameInfoHandlerName then
		local child = script:FindFirstChild(customGameInfoHandlerName .. "GameInfoHandler")

		if child then
			local module = require(child)
			v14 = module
			v15 = v14:Initialize(waveConfig, (gameInfoBar:FindFirstChild(customGameInfoHandlerName))) and true or false
		end
	end

	if v15 then
		if waveConfig.HideDefaultGameInfo then
			default.Visible = false
		end
	else
		if v14 then
			v14:Remove()
			v14 = nil
		end

		default.Visible = true
	end
end

local function UpdateLivesBar(p, p2: number?)
	if v14 then
		v14:UpdateLivesBar(p, p2)
		return
	end

	local v15 = p[TeamUtilities.GetLocalPlayerTeamIndex()]
	local lives = v15 and v15.Lives
	local totalLives = v15 and v15.TotalLives

	if not lives then
		return
	end

	local v16 = math.min(1, lives / totalLives)
	local livesBarColor = ColorUtilities.GetLivesBarColor(lives, totalLives)
	TweenService:Create(bar, tweenInfo2, { Size = UDim2.new(v16, 0, 1, 0) }):Play()
	bar.BackgroundColor3 = livesBarColor
	livesText.Text = tostring((math.ceil(lives))) .. " HP"
end

local function GetSenderAvatarImage(senderUserId: number?) -- 1 equivalent call inferred from this helper
	if senderUserId and not (senderUserId <= 0) then
		return `rbxthumb://type=AvatarHeadShot&id={senderUserId}&w=100&h=100`
	end

	return ""
end

local function UpdateBossBars()
	local count = 0
	local v15 = 0
	local v16 = 0

	for _, v17 in ipairs(v10) do
		if count >= 3 then
			break
		end

		local v18 = v17.SenderName ~= nil

		if v18 and v15 >= 2 then
			continue
		end

		local v19 = v15 + 1

		if v18 then
			if children2[v19] == nil or names[v19] == nil or hpTexts[v19] == nil then
				v18 = false
			else
				v18 = juices[v19] ~= nil
			end
		end

		if v18 then
			v15 = v19
		else
			v19 = v16 + 1

			if children[v19] == nil then
				continue
			else
				v16 = v19
			end
		end

		count += 1
		local v20

		if v18 then
			v20 = children2[v19]
		else
			v20 = children[v19]
		end

		local v21

		if v18 then
			v21 = juices[v19]
		else
			v21 = bars[v19]
		end

		local v22

		if v18 then
			v22 = shieldBars2[v19]
		else
			v22 = shieldBars[v19]
		end

		v20.LayoutOrder = count
		local displayName = string.upper(v17.DisplayName)
		local v23 = math.max(
			v17:Alive() and not v17.PreventDeathUntilAbilityExecuted and 1 or 0,
			v17.HealthHandler:GetHealth()
		)
		local maxHealth = v17.HealthHandler:GetMaxHealth()
		local v24 = math.clamp(v23 / maxHealth, 0, 1)
		local bossHPBarColor = v17.BossHPBarColor or ColorUtilities.GetHealthbarColor(v23, maxHealth, v17.Cloned)

		if v17.HealthHandler:IsShieldActive() then
			local v25 = math.clamp(
				math.max(v17:Alive() and 1 or 0, v17.HealthHandler:GetShield()) / v17.HealthHandler:GetMaxShield(),
				0,
				1
			)

			if v22 then
				local v26

				if v18 and v2[v19] then
					v26 = v2[v19]
				else
					v26 = UDim.new(0.5, 0)
				end

				TweenService:Create(v22, tweenInfo2, {
					Size = UDim2.new(UDim.new(v25, 0), v26)
				}):Play()
				v22.Visible = true
			end
		elseif v22 then
			v22.Visible = false
		end

		local formatNumberWithCommas = Utilities.FormatNumberWithCommas(v23)
		local formatNumberWithCommas2 = Utilities.FormatNumberWithCommas(maxHealth)

		if v21 then
			if v18 then
				local v25 = juiceDecorations[v19]
				local v26 = not v25 and 0 or v25.Size.X.Scale
				TweenService:Create(v21, tweenInfo2, {
					Size = UDim2.new(math.max(v24 - v26, 0), 0, 1, 0)
				}):Play()

				if v25 then
					v25.Visible = v24 > 0
				end
			else
				TweenService:Create(v21, tweenInfo2, { Size = UDim2.new(v24, 0, 1, 0) }):Play()
				v21.BackgroundColor3 = bossHPBarColor
			end
		end

		if v18 then
			local v25 = names[v19]

			if v25 then
				v25.Text = displayName
			end

			local v26 = hpTexts[v19]

			if v26 then
				v26.Text = formatNumberWithCommas .. "/" .. formatNumberWithCommas2 .. " HP"
			end

			local v27 = senderTexts[v19]

			if v27 then
				v27.Text = `SENT BY {string.upper(v17.SenderName)}`
			end

			local v28 = headshotImages[v19]

			if v28 then
				local headshotImage = v17.HeadshotImage

				if not headshotImage then
					headshotImage = GetSenderAvatarImage(v17.SenderUserId) -- inferred equivalent call
				end

				v28.Image = headshotImage
			end

			local v29 = senderTexts2[v19]

			if v29 then
				v29.Text = v17.IsMiniBoss and "MINIBOSS" or "BOSS"
			end

			v:ShowSlot(v19, v17, v24)
		else
			local v25 = texts[v19]

			if v25 then
				v25.Text = displayName .. ": " .. formatNumberWithCommas .. "/" .. formatNumberWithCommas2 .. " HP"
			end
		end

		v20.Visible = true
	end

	for i = v15 + 1, 3 do
		local v17 = children2[i]

		if v17 then
			v:HideSlot(i, v17)
		end
	end

	for i = v16 + 1, 3 do
		local v17 = children[i]

		if v17 then
			v17.Visible = false
		end
	end
end

function GameInfoHandler.RefreshBossInfo()
	v10 = {}

	for k, _ in pairs(v6) do
		if
			k.HealthHandler:GetHealth() <= 0
			or k:IsInStasis()
			or TeamUtilities.GetLocalPlayerTeamIndex() ~= k.PVPTeamIndex
		then
			continue
		end

		table.insert(v10, k)
	end

	for k in pairs(v9) do
		if TeamUtilities.GetLocalPlayerTeamIndex() == k.PVPTeamIndex then
			table.insert(v10, k)
		end
	end

	table.sort(v10, function(a, b)
		local v15 = a.BossMusicPriorityMultiplier * a.HealthHandler:GetMaxHealth()
		local v16 = b.BossMusicPriorityMultiplier * b.HealthHandler:GetMaxHealth()

		if v15 == v16 then
			return (v7[a] or 0) < (v7[b] or 0)
		end

		return v16 < v15
	end)
	local v15 = v10[1]
	local bossMusicName = nil

	if not flag then
		for _, v16 in ipairs(v10) do
			if not v16.BossMusicName or v9[v16] then
				continue
			end

			if (v16.BossMusicDelayRemaining or 0) <= 0 then
				bossMusicName = v16.BossMusicName
			end

			break
		end
	end

	if bossMusicName ~= v11 then
		local v16 = v11

		if v16 then
			SoundHandler.Stop(v16, 3)
		end

		if bossMusicName then
			SoundHandler.Play(bossMusicName)
		end

		v11 = bossMusicName
	end

	event6:Fire(v15 ~= nil)
end

function GameInfoHandler.Update(p: number, p2: number, flag2: boolean?)
	if
		v12 == Enums.GameStates.MapVoting
		or v12 == Enums.GameStates.DifficultyVoting
		or v12 == Enums.GameStates.LoadoutSelection
	then
		v3 = math.max(0, v3 - p)
	else
		v3 = math.max(0, v3 - p2)
	end

	if v3 <= 5 then
		if v3 % 1 > 0.5 then
			timeLeftText.TextColor3 = color2
		else
			timeLeftText.TextColor3 = color
		end

		v5 = math.floor(v3)

		if v5 ~= v4 then
			v4 = v5

			if not (flag or flag2) then
				SoundHandler.Play("TimerTick")
			end
		end
	else
		timeLeftText.TextColor3 = color
	end

	if v3 > 3600 then
		timeLeftText.Text = "inf"
		timeLeft.Visible = not hideWaveTimerIfInfiniteTime
	else
		timeLeftText.Text = Utilities.ConvertToTimeString(v3)
		timeLeft.Visible = true
	end

	UpdateBossBars()

	if v14 then
		v14:Update(p, p2)
	end
end

local function CancelDialogue() -- 3 equivalent calls inferred from this helper
	for _, v15 in Director.GetItemsFromClass(Director.Classes.DialogueBox) do
		v15:Cancel()
	end
end

function GameInfoHandler:SetState()
	local v15 = v12
	v12 = self

	if v15 == Enums.GameStates.Running and self ~= Enums.GameStates.Running then
		CancelDialogue() -- inferred equivalent call
	end

	local visible = self == Enums.GameStates.MapVoting
	mapVoting.Visible = visible
	livesBar.Visible = not visible
	wave.Visible = not visible

	if not flag and v15 == Enums.GameStates.MapVoting and not visible then
		gameInfoBar.Position = udim3
		TweenService:Create(gameInfoBar, tweenInfo, { Position = udim }):Play()
	end

	if v14 and v14.SetState then
		v14:SetState(self)
	end
end

function GameInfoHandler.AddBoss(p)
	v6[p] = true

	if not v7[p] then
		v7[p] = v8
		v8 += 1
	end

	GameInfoHandler.RefreshBossInfo()
end

function GameInfoHandler.RemoveBoss(p, flag2: boolean?)
	v6[p] = nil
	v:NotifyBossRemoved(p, flag2)

	if flag2 and p.SenderName then
		v9[p] = true
		task.delay(0.4, function()
			v9[p] = nil
			v7[p] = nil
			GameInfoHandler.RefreshBossInfo()
		end)
	else
		v7[p] = nil
	end

	GameInfoHandler.RefreshBossInfo()
end

function GameInfoHandler.Enable(flag2: boolean?)
	local v15 = flag

	if flag then
		if flag2 then
			gameInfoBar.Position = udim3

			if v12 == Enums.GameStates.MapVoting then
				TweenService:Create(gameInfoBar, tweenInfo, { Position = udim2 }):Play()
			else
				TweenService:Create(gameInfoBar, tweenInfo, { Position = udim }):Play()
			end
		else
			gameInfoBar.Position = udim
		end
	end

	flag = false
	gameInfoBar.Visible = true

	if v15 then
		GameInfoHandler.RefreshBossInfo()
	end
end

function GameInfoHandler.Disable(flag2: boolean?)
	if flag2 then
		TweenService:Create(gameInfoBar, tweenInfo, { Position = udim3 }):Play()
	else
		gameInfoBar.Visible = false
	end

	flag = true
	GameInfoHandler.RefreshBossInfo()
end

gameInfoBar.Position = udim
local v15 = -1
local v16 = nil

local function CheckShouldPlayDialogue() -- 1 equivalent call inferred from this helper
	if DEV_DISABLE_DIALOGUE then
		return false
	end

	if Data.Get("Settings").Dialogue then
		return true
	end

	return false
end

local function HandleDialogueV1(p: number)
	local v17 = Lang.Get(Lang.Strings.Game.Dialogue[v16]["Wave" .. tostring(p)])

	if v17 then
		local advisor = workspace:GetAttribute("Advisor") or "Default"
		local v18 = Lang.Get(Lang.Strings.AdvisorNames[advisor])
		local advisor2 = Advisors[advisor]
		local waveOverrides = advisor2.WaveOverrides
		local ratio = advisor2.Ratio
		local image = advisor2.Image
		local pitch = advisor2.Pitch

		if waveOverrides then
			image = waveOverrides[p] or image
		end

		if not v18 then
			warn(`Advisor name for {advisor} not found in Lang.Strings.AdvisorNames`)
		end

		for _, v19 in Director.GetItemsFromClass(Director.Classes.DialogueBox) do
			v19:RunDialogue(v17, v18, ratio, image, pitch)
		end
	end
end

local function HandleDialogueV2(p: number)
	for _, v17 in Director.GetItemsFromClass(Director.Classes.DialogueBox) do
		v17:RunSequence(tostring(v16) .. "Wave" .. tostring(p), tostring(v16), p, true)
	end
end

event2:AttachCallback(function(p: number, flag2: boolean, flag3: boolean?)
	if p then
		if flag2 then
			CancelDialogue() -- inferred equivalent call
		end

		Lang.Set(waveText, Lang.Strings.Game.WaveTop, (tostring(p)))

		if v15 ~= p and flag3 and v16 and not flag2 and CheckShouldPlayDialogue() then -- inferred equivalent call
			if v13 and v13.HasDialogueSequenceData then
				HandleDialogueV2(p)
			else
				HandleDialogueV1(p)
			end
		end

		v15 = p
	else
		waveText.Text = "-"
		CancelDialogue() -- inferred equivalent call
	end
end)
event5:AttachCallback(function(p: string)
	v16 = p
	local waveConfig = ResourceManager.GetWaveConfig(p)

	if waveConfig then
		local v17 = Lang.Get(Lang.Strings.Game.DifficultySelected, waveConfig.DisplayName or v16)
		hideWaveTimerIfInfiniteTime = waveConfig.HideWaveTimerIfInfiniteTime
		v13 = waveConfig
		event7:Fire(v17, 10)
		HandleCustomGameInfoHandler(waveConfig)
	end
end)
event3:AttachCallback(function(p: number)
	if p then
		v3 = p
		GameInfoHandler.Update(0, 0, true)
	else
		timeLeftText.TextColor3 = color
		timeLeftText.Text = "-"
	end
end)
event4:AttachCallback(function(p, p2: number?)
	local v17 = p[TeamUtilities.GetLocalPlayerTeamIndex()]

	if not (v17 and v17.Lives) then
		bar.Size = UDim2.new(1, 0, 1, 0)
		bar.BackgroundColor3 = ColorUtilities.GetLivesBarColor(1, 1)
		livesText.Text = "-"
	end

	UpdateLivesBar(p, p2)
end)
event:AttachCallback(function(p: number)
	if p <= 0 then
		return
	end

	event7:Fire(Lang.Get(Lang.Strings.Game.WaveBonus, (tostring((math.floor(p))))), 5, true)
end)

for _, v17 in pairs(children) do
	v17.Visible = false
end

for _, v17 in pairs(children2) do
	v17.Visible = false
end

for _, frame in pairs(gameInfoBar:GetChildren()) do
	if frame:IsA("Frame") then
		frame.Visible = frame.Name == "Default"
	end
end

return GameInfoHandler