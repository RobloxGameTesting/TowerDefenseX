local PVPGameInfoHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("WaveTypes"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local TeamUtilities = require(Common:WaitForChild("TeamUtilities"))
local Utilities = require(Common:WaitForChild("Utilities"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local Shared = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Shared"))
local PVPEconomyConfig = require(Common:WaitForChild("PVPEconomyConfig"))
local GameClass = require(script.Parent.Parent.Parent:WaitForChild("GameClass"))
require(script.Parent:WaitForChild("GameInfoHandlerTypes"))
local PVPLivesBarClass = require(script.Parent:WaitForChild("PVPLivesBarClass"))
local PVPBarShakeClass = require(script.Parent:WaitForChild("PVPBarShakeClass"))
local PVPEntranceClass = require(script.Parent:WaitForChild("PVPEntranceClass"))
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(255, 80, 80)
local isStudio = RunService:IsStudio()
local DEV_FALLBACK_USER_ID = _G.DEV_FALLBACK_USER_ID
local PVP_STARTING_CASH_ECO = _G.PVP_STARTING_CASH_ECO
local event = BindableHandler.GetEvent("WaveChanged")
local event2 = BindableHandler.GetEvent("TimeLeftChanged")
local LocalPlayer = Players.LocalPlayer
local pvp = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("GameInfoBar"):WaitForChild("PVP")
local default = pvp:WaitForChild("Default")
local wave = default:WaitForChild("Wave")
local waveText = wave:WaitForChild("WaveText")
local timeLeft = default:WaitForChild("TimeLeft")
local timeLeftText = timeLeft:WaitForChild("TimeLeftText")
local mapVoting = default:WaitForChild("MapVoting")
local friendlyBar = pvp:WaitForChild("FriendlyBar")
local name = friendlyBar:WaitForChild("Name")
local content = friendlyBar:WaitForChild("Portrait"):WaitForChild("Content")
local userPortrait = content:WaitForChild("UserPortrait")
local levelFrame = content:WaitForChild("LevelFrame")
local hpText = levelFrame:WaitForChild("HPText")
local badge = content:WaitForChild("Badge")
local enemyBar = pvp:WaitForChild("EnemyBar")
local name2 = enemyBar:WaitForChild("Name")
local content2 = enemyBar:WaitForChild("Portrait"):WaitForChild("Content")
local userPortrait2 = content2:WaitForChild("UserPortrait")
local levelFrame2 = content2:WaitForChild("LevelFrame")
local hpText2 = levelFrame2:WaitForChild("HPText")
local badge2 = content2:WaitForChild("Badge")
local text = friendlyBar:WaitForChild("CashPerSecondFrame"):WaitForChild("Text")
local flag = false
local state = nil
local waveNumber = nil
local timeLeft2 = 0
local v = 0
local lives = nil
local totalLives = nil
local lives2 = nil
local totalLives2 = nil
local v2 = nil
local v3 = nil

local function RefreshCashPerSecondText()
	local pvpCashPerTick = workspace:GetAttribute("PVPCashPerTick")

	if typeof(pvpCashPerTick) ~= "number" then
		pvpCashPerTick = PVP_STARTING_CASH_ECO
	end

	local pvpSendEcoDelta = LocalPlayer:GetAttribute("PVPSendEcoDelta")
	text.Text = `${math.max(pvpCashPerTick + (typeof(pvpSendEcoDelta) ~= "number" and 0 or pvpSendEcoDelta), 0)}/{PVPEconomyConfig.TickInterval}s`
end

local function GetPlayerHeadshotImage(p: number?)
	if isStudio and (not p or p <= 0) then
		p = DEV_FALLBACK_USER_ID
	end

	if p and not (p <= 0) then
		return `rbxthumb://type=AvatarHeadShot&id={p}&w=150&h=150`
	end

	return ""
end

local function GetOpponentPlayer()
	local localPlayerTeamIndex = TeamUtilities.GetLocalPlayerTeamIndex()
	local v4 = nil
	local v5 = nil

	for _, v6 in Players:GetPlayers() do
		local pvpTeamIndex = v6:GetAttribute("PVPTeamIndex")

		if not (typeof(pvpTeamIndex) == "number" and pvpTeamIndex ~= localPlayerTeamIndex and (not v4 or not v5 or pvpTeamIndex < v5 or pvpTeamIndex == v5 and v6.Name < v4.Name)) then
			continue
		end

		v5 = pvpTeamIndex
		v4 = v6
	end

	return v4
end

local function RefreshPortraitForPlayer(player, userPortrait3, name3, levelFrame3, hpText3, badge3, flag2: boolean?)
	local disconnectedIcon = userPortrait3:FindFirstChild("DisconnectedIcon")

	if disconnectedIcon then
		disconnectedIcon.Visible = player ~= nil and flag2 == true
	end

	if player then
		local userId = player.UserId

		if isStudio and (not userId or userId <= 0) then
			userId = DEV_FALLBACK_USER_ID
		end

		userPortrait3.Image = (not userId or userId <= 0) and ""
			or `rbxthumb://type=AvatarHeadShot&id={userId}&w=150&h=150`
		userPortrait3.ImageTransparency = flag2 and 0.75 or 0
		local text2

		if flag2 then
			text2 = `{player.DisplayName} (D/C)`
		else
			text2 = player.DisplayName
		end

		name3.Text = text2
		local playerLevel = player:GetAttribute("PlayerLevel")

		if typeof(playerLevel) == "number" then
			levelFrame3.Visible = true
			hpText3.Text = `LVL {playerLevel}`
			badge3.Image = Shared.RANK_IMAGES[math.clamp(playerLevel, 1, #Shared.RANK_IMAGES)]
			badge3.Visible = true
		else
			levelFrame3.Visible = false
			badge3.Visible = false
		end
	else
		userPortrait3.Image = ""
		userPortrait3.ImageTransparency = 0
		name3.Text = "-"
		levelFrame3.Visible = false
		badge3.Visible = false
	end
end

local connections = {}
local v4 = nil
local function RefreshPortraits()
	for _, connection in connections do
		connection:Disconnect()
	end

	table.clear(connections)
	local opponentPlayer = GetOpponentPlayer()
	local v5 = false

	if opponentPlayer then
		v4 = opponentPlayer
	elseif v4 then
		opponentPlayer = v4
		v5 = true
	end

	RefreshPortraitForPlayer(LocalPlayer, userPortrait, name, levelFrame, hpText, badge, false)
	RefreshPortraitForPlayer(opponentPlayer, userPortrait2, name2, levelFrame2, hpText2, badge2, v5)
	table.insert(connections, LocalPlayer:GetAttributeChangedSignal("PlayerLevel"):Connect(RefreshPortraits))

	if opponentPlayer and not v5 then
		table.insert(connections, opponentPlayer:GetAttributeChangedSignal("PlayerLevel"):Connect(RefreshPortraits))
	end
end

local function RefreshWaveText() -- 2 equivalent calls inferred from this helper
	if waveNumber then
		Lang.Set(waveText, Lang.Strings.Game.WaveTop, (tostring(waveNumber)))
	else
		waveText.Text = "-"
	end
end

local v5 = PVPLivesBarClass.New(friendlyBar, false)
local v6 = PVPLivesBarClass.New(enemyBar, true)
local v7 = PVPBarShakeClass.New(friendlyBar)
local v8 = PVPBarShakeClass.New(enemyBar)
local v9 = PVPEntranceClass.New({
	FriendlyBar = friendlyBar,
	EnemyBar = enemyBar,
	FriendlyPortrait = content,
	EnemyPortrait = content2,
	FriendlyNameText = name,
	EnemyNameText = name2
})

local function RefreshTeamColors()
	v5:SetTeamIndex(TeamUtilities.GetLocalPlayerTeamIndex())
	local v10 = v2

	if not v10 then
		local opponentPlayer = GetOpponentPlayer()
		local pvpTeamIndex = opponentPlayer and opponentPlayer:GetAttribute("PVPTeamIndex")

		if typeof(pvpTeamIndex) == "number" then
			v10 = pvpTeamIndex
		end
	end

	v6:SetTeamIndex(v10)
end

local function RefreshOpponentDisplay() -- 3 equivalent calls inferred from this helper
	RefreshPortraits()
	RefreshTeamColors()
end

local function RefreshFriendlyLives() -- 2 equivalent calls inferred from this helper
	v5:Refresh(lives, totalLives)
end

local function RefreshEnemyLives() -- 2 equivalent calls inferred from this helper
	v6:Refresh(lives2, totalLives2)
end

local v10 = false

local function TryPlayEntrance() -- 1 equivalent call inferred from this helper
	if flag and friendlyBar.Visible and not v10 then
		v10 = true
		v9:Play()
	end
end

function PVPGameInfoHandler:Initialize(_, p)
	if flag then
		self:Remove()
	end

	if not p then
		warn("PVPGameInfoHandler:Initialize called without a valid GameInfoFrame")
		return false
	end

	pvp.Visible = true
	flag = true
	local currentGame = GameClass.GetCurrentGame()

	if not state and currentGame then
		state = currentGame.State
	end

	if state then
		PVPGameInfoHandler:SetState(state)
	end

	if currentGame then
		if waveNumber == nil then
			waveNumber = currentGame.WaveNumber
		end

		if currentGame.TeamDataTable and not v3 then
			PVPGameInfoHandler:UpdateLivesBar(currentGame.TeamDataTable)
		end

		if currentGame.TimeLeft and timeLeft2 == 0 then
			timeLeft2 = currentGame.TimeLeft
		end
	end

	RefreshOpponentDisplay() -- inferred equivalent call
	RefreshWaveText() -- inferred equivalent call
	RefreshFriendlyLives() -- inferred equivalent call
	RefreshEnemyLives() -- inferred equivalent call
	RefreshCashPerSecondText()
	PVPGameInfoHandler:Update(0, 0)

	if state == Enums.GameStates.Running and flag and friendlyBar.Visible and not v10 then
		v10 = true
		v9:Play()
	end

	return true
end

function PVPGameInfoHandler:Remove()
	if not flag then
		return
	end

	pvp.Visible = false
	flag = false
	v10 = false
	v4 = nil
end

function PVPGameInfoHandler:SetState(p: string)
	local v11 = state
	state = p

	if not flag then
		return
	end

	local visible = p == Enums.GameStates.MapVoting
	mapVoting.Visible = visible
	wave.Visible = not visible
	friendlyBar.Visible = not visible
	enemyBar.Visible = not visible

	if p == Enums.GameStates.Running and v11 ~= Enums.GameStates.Running then
		TryPlayEntrance() -- inferred equivalent call
	elseif visible then
		v10 = false
	end
end

function PVPGameInfoHandler:UpdateLivesBar(items, p: number?)
	v3 = items
	local localPlayerTeamIndex = TeamUtilities.GetLocalPlayerTeamIndex()
	local v11 = lives
	local v12 = lives2
	local item = items[localPlayerTeamIndex]
	lives = item and item.Lives
	totalLives = item and item.TotalLives
	local v13 = nil

	for k in pairs(items) do
		if k ~= localPlayerTeamIndex and (not v13 or k < v13) then
			v13 = k
		end
	end

	local v14 = v13 and items[v13]
	lives2 = v14 and v14.Lives
	totalLives2 = v14 and v14.TotalLives
	v2 = v13

	if not flag then
		return
	end

	RefreshTeamColors()

	if p ~= nil and (p == localPlayerTeamIndex or p == v13) then
		local v15 = p == localPlayerTeamIndex

		if not v15 then
			v11 = v12
		end

		local v16

		if v15 then
			v16 = lives
		else
			v16 = lives2
		end

		local v17

		if v15 then
			v17 = totalLives
		else
			v17 = totalLives2
		end

		if v11 and v16 and v16 < v11 and v17 and v17 > 0 then
			local v18 = v16 <= 0 and 1 or (v11 - v16) / v17

			if v15 then
				v7:Trigger(v18)
			else
				v8:Trigger(v18)
			end
		end
	end

	RefreshFriendlyLives() -- inferred equivalent call
	RefreshEnemyLives() -- inferred equivalent call
end

function PVPGameInfoHandler:Update(p: number, p2: number)
	if not flag then
		return
	end

	v5:Step()
	v6:Step()
	v7:Step(p)
	v8:Step(p)

	if
		state == Enums.GameStates.MapVoting
		or state == Enums.GameStates.DifficultyVoting
		or state == Enums.GameStates.LoadoutSelection
	then
		timeLeft2 = math.max(0, timeLeft2 - p)
	else
		timeLeft2 = math.max(0, timeLeft2 - p2)
	end

	if timeLeft2 <= 5 then
		if timeLeft2 % 1 > 0.5 then
			timeLeftText.TextColor3 = color2
		else
			timeLeftText.TextColor3 = color
		end

		local v11 = math.floor(timeLeft2)

		if v11 ~= v then
			v = v11
			SoundHandler.Play("TimerTick")
		end
	else
		timeLeftText.TextColor3 = color
	end

	if timeLeft2 > 3600 then
		timeLeftText.Text = "inf"
	else
		timeLeftText.Text = Utilities.ConvertToTimeString(timeLeft2)
	end

	if timeLeft then
		timeLeft.Visible = true
	end
end

event:AttachCallback(function(p: number)
	waveNumber = p

	if flag then
		RefreshWaveText() -- inferred equivalent call
	end
end)
event2:AttachCallback(function(p: number)
	if p then
		timeLeft2 = p

		if flag then
			PVPGameInfoHandler:Update(0, 0)
		end
	else
		timeLeft2 = 0

		if flag and timeLeftText then
			timeLeftText.TextColor3 = color
			timeLeftText.Text = "-"
		end
	end
end)
LocalPlayer:GetAttributeChangedSignal("PVPTeamIndex"):Connect(function()
	RefreshOpponentDisplay() -- inferred equivalent call

	if v3 then
		PVPGameInfoHandler:UpdateLivesBar(v3)
	end
end)
Players.PlayerAdded:Connect(function(player)
	RefreshOpponentDisplay() -- inferred equivalent call
	player:GetAttributeChangedSignal("PVPTeamIndex"):Connect(RefreshOpponentDisplay)
end)

for _, v11 in Players:GetPlayers() do
	if v11 ~= LocalPlayer then
		v11:GetAttributeChangedSignal("PVPTeamIndex"):Connect(RefreshOpponentDisplay)
	end
end

Players.PlayerRemoving:Connect(function()
	task.defer(RefreshOpponentDisplay)
end)
workspace:GetAttributeChangedSignal("PVPCashPerTick"):Connect(function()
	if flag then
		RefreshCashPerSecondText()
	end
end)
LocalPlayer:GetAttributeChangedSignal("PVPSendEcoDelta"):Connect(function()
	if flag then
		RefreshCashPerSecondText()
	end
end)
return PVPGameInfoHandler