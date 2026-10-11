local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local ScaleDataSettings = require(script:WaitForChild("ScaleDataSettings"))
local isCoreGame = workspace:GetAttribute("IsCoreGame")
local isLobby = workspace:GetAttribute("IsLobby")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v = {}
local v2 = {}
local forScaling = nil
local v3 = nil
local now = 0

local function InitializeElement(state)
	local element = state.Element
	local size = element.Size

	if not state.UseNewScalingMethod then
		local elementUIScale = state.ElementUIScale

		if size.X.Scale ~= 0 or size.Y.Scale ~= 0 then
			elementUIScale.Scale = 1
			element.Size = UDim2.new(0, element.AbsoluteSize.X, 0, element.AbsoluteSize.Y)
		end
	end

	state._InitialPosition = element.Position
	state._DefaultSize = size
	state._Initialized = true
end

local function GetPositionForScaleData(p, p2) -- 3 equivalent calls inferred from this helper
	if p2.AdjustedPosition then
		return p2.AdjustedPosition
	end

	return p.DefaultPosition
end

local function ApplyScaleData(point: Vector2, state, currentScaleDataIndex: number)
	local element = state.Element
	local elementUIScale = state.ElementUIScale
	local v4 = state.ScaleData[currentScaleDataIndex]

	if not state._Initialized then
		InitializeElement(state)
	end

	elementUIScale.Scale = math.min(
		point.X * v4.ElementMaximumWidth / element.Size.X.Offset,
		point.Y * v4.ElementMaximumHeight / element.Size.Y.Offset
	)

	if state.AdjustPosition then
		element.Position = GetPositionForScaleData(state, v4) -- inferred equivalent call
	end

	state._CurrentScaleDataIndex = currentScaleDataIndex
end

local function ApplyScaleData_NewMethod(point: Vector2, state, currentScaleDataIndex: number)
	local element = state.Element
	local v4 = state.ScaleData[currentScaleDataIndex]

	if not state._Initialized then
		InitializeElement(state)
	end

	local defaultSize = state._DefaultSize
	local x = point.X
	local y = point.Y
	local v5 = defaultSize.X.Scale * x + defaultSize.X.Offset
	local v6 = defaultSize.Y.Scale * y + defaultSize.Y.Offset
	local v7 = point.X * v4.ElementMaximumWidth / v5
	local v8 = point.Y * v4.ElementMaximumHeight / v6
	element.Size = UDim2.new(
		v7 * defaultSize.X.Scale,
		v7 * defaultSize.X.Offset,
		v8 * defaultSize.Y.Scale,
		v8 * defaultSize.Y.Offset
	)

	if state.AdjustPosition then
		element.Position = GetPositionForScaleData(state, v4) -- inferred equivalent call
	end

	state._CurrentScaleDataIndex = currentScaleDataIndex
end

local function GetScaleDataIndexForScreenSize(point: Vector2, p)
	local x = point.X
	local y = point.Y
	local v4 = p.ScaleData[1]
	local v5 = 1

	for i, v6 in ipairs(p.ScaleData) do
		if i == 1 then
			continue
		end

		if v4.MaximumScreenWidth <= x or v4.MaximumScreenHeight <= y then
			v5 = i
			v4 = v6
		else
			break
		end
	end

	local _ = p.Element.Name == "BottomBar"
	return v5
end

local function ScreenSizeChanged(absoluteSize: Vector2)
	for _, v4 in pairs(v) do
		local currentScaleDataIndex = GetScaleDataIndexForScreenSize(absoluteSize, v4)

		if not currentScaleDataIndex then
			continue
		end

		if v4.UseNewScalingMethod then
			ApplyScaleData_NewMethod(absoluteSize, v4, currentScaleDataIndex)
		else
			ApplyScaleData(absoluteSize, v4, currentScaleDataIndex)
		end
	end
end

local function RenderSteppedUpdate() end

local function CustomScreenSizeChanged(_: Vector2) end

local function ScaleScrollingFrameWithGridLayout(instance, uiGridLayout, p: number, p2: number, p3: number, value: number?)
	local count = 0

	for _, guiObject in pairs(instance:GetChildren()) do
		if not ((guiObject:IsA("ImageButton") or guiObject:IsA("Frame")) and guiObject.Visible) then
			continue
		end

		count += 1
	end

	local v4 = math.ceil(count / p3)
	local v5 = v4 * p2
	local v6 = math.min(v5 / v4, 1 / v4)
	local v7 = math.max(1, v5)
	uiGridLayout.CellPadding = UDim2.new(value or 0, 0, 0, 0)
	uiGridLayout.CellSize = UDim2.new(p, 0, v6, 0)
	instance.CanvasSize = UDim2.new(0, 0, v7, 0)
	instance.ScrollingEnabled = v7 > 1
end

local ScalingHandler = {
	HasScaleData = function(p)
		return v2[p] ~= nil
	end,
	GetPositionForElement = function(p)
		local v4 = v2[p]

		if not v4 then
			warn("No scale data table for element " .. p.Name)
			return
		end

		local currentScaleDataIndex = v4._CurrentScaleDataIndex or 1
		local v5 = v4.ScaleData[currentScaleDataIndex]

		if not v4.AdjustPosition then
			return v4._InitialPosition
		end

		return GetPositionForScaleData(v4, v5) -- inferred equivalent call
	end
}

if isLobby then
	local emotes = PlayerGui:WaitForChild("Emotes")
	local gui = PlayerGui:WaitForChild("GUI")
	forScaling = PlayerGui:WaitForChild("ForScaling")
	local settings = gui:WaitForChild("Settings")
	local towersBar = gui:WaitForChild("TowersBar")
	local foodBar = gui:WaitForChild("FoodBar")
	local stats = gui:WaitForChild("Stats")
	local shop = gui:WaitForChild("Shop")
	local items = shop:WaitForChild("Items")
	local skinSelect = gui:WaitForChild("SkinSelect")
	local skinSelect2 = skinSelect:WaitForChild("SkinSelect")
	local currencyDisplay = gui:WaitForChild("CurrencyDisplay")
	local playButtons = gui:WaitForChild("PlayButtons")
	local achievements = gui:WaitForChild("Achievements")
	local v4 = { Element = settings, ScaleData = ScaleDataSettings.Settings }
	local v5 = {
		Element = shop,
		AdjustPosition = true,
		DefaultPosition = UDim2.new(0.5, 0, 0.475, 0),
		ScaleData = ScaleDataSettings.LobbyShop
	}
	v = {
		v4,
		{
			Element = gui:WaitForChild("GoldShop"),
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.475, 0),
			ScaleData = ScaleDataSettings.GoldShop
		},
		{
			Element = gui:WaitForChild("CrystalsShop"),
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.475, 0),
			ScaleData = ScaleDataSettings.GoldShop
		},
		{
			Element = gui:WaitForChild("MagicShop"),
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.5, 0),
			ScaleData = ScaleDataSettings.MagicShop
		},
		v5,
		{
			Element = towersBar,
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.985, 0),
			ScaleData = ScaleDataSettings.LobbyTowersBar
		},
		{
			Element = foodBar,
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.985, 0),
			ScaleData = ScaleDataSettings.LobbyTowersBar
		},
		{ Element = currencyDisplay, ScaleData = ScaleDataSettings.LobbyGoldDisplay },
		{ Element = playButtons, ScaleData = ScaleDataSettings.LobbyPlayButtons },
		{ Element = stats, ScaleData = ScaleDataSettings.LobbyStats },
		{ Element = gui:WaitForChild("Sidebar"), ScaleData = ScaleDataSettings.LobbySidebar },
		{
			Element = gui:WaitForChild("BattlePassButtonHolder"),
			ScaleData = ScaleDataSettings.LobbySidebar
		},
		{
			Element = gui:WaitForChild("DailyRewards"),
			ScaleData = ScaleDataSettings.LobbyDailyRewards
		},
		{ Element = gui:WaitForChild("Codes"), ScaleData = ScaleDataSettings.LobbyCodes },
		{ Element = achievements, ScaleData = ScaleDataSettings.LobbyAchievements },
		{ Element = gui:WaitForChild("XPLevel"), ScaleData = ScaleDataSettings.LobbyXPLevel },
		{
			Element = gui:WaitForChild("CrateSpin"):WaitForChild("ImageLabel"),
			ScaleData = ScaleDataSettings.LobbyCrateSpin
		},
		{
			Element = gui:WaitForChild("CrateSpin"):WaitForChild("Unboxed"),
			ScaleData = ScaleDataSettings.LobbyCrateUnboxed
		},
		{
			Element = gui:WaitForChild("Leave"),
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.7, 0),
			ScaleData = ScaleDataSettings.LobbyLeave
		},
		{ Element = skinSelect, ScaleData = ScaleDataSettings.LobbySkinSelect },
		{
			Element = gui:WaitForChild("VIPPurchaseScreen"),
			ScaleData = ScaleDataSettings.VIPPurchaseScreen
		},
		{
			Element = gui:WaitForChild("StarterPack"),
			ScaleData = ScaleDataSettings.StarterpackScreen
		},
		{ Element = gui:WaitForChild("Rejoin"), ScaleData = ScaleDataSettings.RejoinScreen },
		{
			Element = gui:WaitForChild("DonationScreen"),
			ScaleData = ScaleDataSettings.DonationScreen
		},
		{
			Element = gui:WaitForChild("SkinExchange"),
			ScaleData = ScaleDataSettings.SkinExchange
		},
		{ Element = gui:WaitForChild("EmoteEquip"), ScaleData = ScaleDataSettings.EmoteEquip },
		{
			Element = gui:WaitForChild("Announcements"),
			ScaleData = ScaleDataSettings.Announcements,
			UseNewScalingMethod = true
		},
		{ Element = gui:WaitForChild("BattlePass"), ScaleData = ScaleDataSettings.BattlePass },
		{ Element = gui:WaitForChild("Quests"), ScaleData = ScaleDataSettings.Quests },
		{ Element = gui:WaitForChild("Loadout"), ScaleData = ScaleDataSettings.LobbyLoadout },
		{ Element = gui:WaitForChild("Vending"), ScaleData = ScaleDataSettings.LobbyVendingUI },
		{ Element = emotes:WaitForChild("Frame"), ScaleData = ScaleDataSettings.EmoteWheel },
		{
			Element = gui:WaitForChild("V2"),
			ScaleData = ScaleDataSettings.V2Screen,
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.5, 0),
			UseNewScalingMethod = true
		},
		{
			Element = gui:WaitForChild("V2ButtonHolder"),
			ScaleData = ScaleDataSettings.V2ButtonHolder
		},
		{
			Element = gui:WaitForChild("PartyMinimised"),
			ScaleData = ScaleDataSettings.PartyMinimised,
			UseNewScalingMethod = true
		},
		{
			Element = gui:WaitForChild("PartyNotif"),
			ScaleData = ScaleDataSettings.PartyMinimised,
			UseNewScalingMethod = true
		},
		{
			Element = gui:WaitForChild("PartyMain"),
			ScaleData = ScaleDataSettings.PartyMain,
			UseNewScalingMethod = true
		},
		{
			Element = gui:WaitForChild("FourthOfJulyEventShop"),
			ScaleData = ScaleDataSettings.FourthOfJulyEventShop,
			UseNewScalingMethod = false
		}
	}

	if _G.PVP_SHOP_ENABLED then
		local v6 = {
			Element = gui:WaitForChild("PVP"),
			ScaleData = ScaleDataSettings.PVP,
			UseNewScalingMethod = false
		}
		table.insert(v, v6)
	end

	if _G.SHOP_V3_ENABLED then
		local v6 = {
			Element = gui:WaitForChild("V3"),
			ScaleData = ScaleDataSettings.V3Screen,
			UseNewScalingMethod = false
		}
		table.insert(v, v6)
	end

	for _, frame in pairs(gui:WaitForChild("NotificationHandler"):GetChildren()) do
		if not frame:IsA("Frame") then
			continue
		end

		local v6 = {
			Element = frame,
			ScaleData = ScaleDataSettings.SmallNotification,
			UseNewScalingMethod = true
		}
		table.insert(v, v6)
	end

	local function UpdateStatsPosition() -- 1 equivalent call inferred from this helper
		local element = towersBar
		local v6 = element.AbsolutePosition.X + element.AbsoluteSize.X
		stats.Position = UDim2.new(0.01, v6, 0.985, 0)
	end

	local function UpdateCurrencyDisplayPosition()
		local y = towersBar.AbsolutePosition.Y
		currencyDisplay.Position = UDim2.new(0.5, 0, -0.008, y + GuiService:GetGuiInset().Y)
		playButtons.Position = UDim2.new(0.5, 0, -0.008, y - currencyDisplay.AbsoluteSize.Y + 45)
	end

	local function UpdateShopScrollingFrames(point: Vector2)
		local y = point.Y

		for _, scrollingFrame in pairs(items:GetChildren()) do
			if not scrollingFrame:IsA("ScrollingFrame") then
				continue
			end

			local uiGridLayout = scrollingFrame:FindFirstChildOfClass("UIGridLayout")
			local v6, v7, v8, v9

			if scrollingFrame.Name == "Towers" then
				local v10 = y >= 700
				v6 = v10 and 0.25 or 0.3
				v7 = v10 and 0.35 or 0.42
				v8 = v10 and 4 or 3
				v9 = 0
			else
				v6 = 0.45
				v7 = 0.58
				v8 = 2
				v9 = 0.03
			end

			ScaleScrollingFrameWithGridLayout(scrollingFrame, uiGridLayout, v6, v7, v8, v9)
		end

		for _, scrollingFrame in pairs(skinSelect2:GetChildren()) do
			if scrollingFrame:IsA("ScrollingFrame") then
				ScaleScrollingFrameWithGridLayout(
					scrollingFrame,
					scrollingFrame:FindFirstChildOfClass("UIGridLayout"),
					0.333,
					0.52,
					3
				)
			end
		end
	end

	local function UpdateAchievementsScrollingFrame(point: Vector2)
		local y = point.Y
		local mainList = achievements:FindFirstChild("Frame") and achievements.Frame:FindFirstChild("MainList")

		for _, v6 in { mainList, mainList.Parent.MapList } do
			ScaleScrollingFrameWithGridLayout(v6, v6:FindFirstChildOfClass("UIGridLayout"), 1, 0.2, 1)

			for _, frame in pairs(v6:GetChildren()) do
				if not frame:IsA("Frame") then
					continue
				end

				local inner = frame:FindFirstChild("Inner")

				if not inner then
					continue
				end

				local title = inner:FindFirstChild("title")
				local description = inner:FindFirstChild("description")
				local uiTextSizeConstraint = title and title:FindFirstChildOfClass("UITextSizeConstraint")

				if uiTextSizeConstraint then
					if y <= 450 then
						uiTextSizeConstraint.MaxTextSize = 15
					elseif y <= 575 then
						uiTextSizeConstraint.MaxTextSize = 17
					elseif y <= 700 then
						uiTextSizeConstraint.MaxTextSize = 19
					elseif y <= 1000 then
						uiTextSizeConstraint.MaxTextSize = 21
					else
						uiTextSizeConstraint.MaxTextSize = 24
					end
				end

				if not description then
					continue
				end

				local uiTextSizeConstraint2 = description:FindFirstChildOfClass("UITextSizeConstraint")

				if not uiTextSizeConstraint2 then
					continue
				end

				if y <= 450 then
					uiTextSizeConstraint2.MaxTextSize = 11
				elseif y <= 575 then
					uiTextSizeConstraint2.MaxTextSize = 12
				elseif y <= 700 then
					uiTextSizeConstraint2.MaxTextSize = 13
				elseif y <= 1000 then
					uiTextSizeConstraint2.MaxTextSize = 14
				else
					uiTextSizeConstraint2.MaxTextSize = 16
				end
			end
		end
	end

	CustomScreenSizeChanged = function(point: Vector2)
		UpdateShopScrollingFrames(point)
		UpdateAchievementsScrollingFrame(point)
	end

	RenderSteppedUpdate = function()
		UpdateStatsPosition() -- inferred equivalent call
		UpdateCurrencyDisplayPosition()
	end
elseif isCoreGame then
	local emotes = PlayerGui:WaitForChild("Emotes")
	forScaling = PlayerGui:WaitForChild("Interface")
	local lowPriorityInterface = PlayerGui:WaitForChild("LowPriorityInterface")
	local bottomBar = forScaling:WaitForChild("BottomBar")
	local towersBar = bottomBar:WaitForChild("TowersBar")
	local pvpTowersBar = bottomBar:WaitForChild("PVPTowersBar")
	local tabs = pvpTowersBar:WaitForChild("Tabs")
	local touchPlacementButtons = bottomBar:WaitForChild("TouchPlacementButtons")
	local hint = touchPlacementButtons:WaitForChild("Hint")
	local dialogueBoxBounds = forScaling:FindFirstChild("DialogueBoxBounds")
	local gameInfoBar = forScaling:WaitForChild("GameInfoBar")
	local default = gameInfoBar:WaitForChild("Default")
	local pvp = gameInfoBar:WaitForChild("PVP")
	local friendlyBar = pvp:WaitForChild("FriendlyBar")
	local cashPerSecondFrame = friendlyBar:WaitForChild("CashPerSecondFrame")
	local wave = default:WaitForChild("Wave")
	local timeLeft = default:WaitForChild("TimeLeft")
	local topAreaQueueFrame = forScaling:WaitForChild("TopAreaQueueFrame")
	local settings = forScaling:WaitForChild("Settings")
	local leftButtons = lowPriorityInterface:WaitForChild("LeftButtons")
	v = {
		{
			Element = forScaling:WaitForChild("TowerUI"),
			ElementUsesOffsetScale = true,
			ScaleData = ScaleDataSettings.TowerUI
		},
		{
			Element = forScaling:WaitForChild("BottomBar"),
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.5, 0, 0.97, 0),
			ScaleData = ScaleDataSettings.BottomBar
		},
		{
			Element = forScaling:WaitForChild("DialogueBoxBounds"),
			ScaleData = ScaleDataSettings.DialogueBoxBounds
		},
		{
			Element = forScaling:WaitForChild("GameInfoBar"),
			ScaleData = ScaleDataSettings.GameInfoBar
		},
		{
			Element = forScaling:WaitForChild("TopAreaQueueFrame"),
			ScaleData = ScaleDataSettings.TopAreaQueueFrame
		},
		{
			Element = forScaling:WaitForChild("CutsceneScreen"):WaitForChild("TopAreaQueueFrame"),
			ScaleData = ScaleDataSettings.TopAreaQueueFrame
		},
		{
			Element = forScaling:WaitForChild("MapVotingScreen"),
			ScaleData = ScaleDataSettings.MapVotingScreen,
			UseNewScalingMethod = true
		},
		{
			Element = forScaling:WaitForChild("DifficultyVoteScreen"),
			ScaleData = ScaleDataSettings.DifficultyVoteScreen
		},
		{
			Element = forScaling:WaitForChild("DifficultyVoteScreenV2"),
			ScaleData = ScaleDataSettings.DifficultyVoteScreenV2
		},
		{
			Element = forScaling:WaitForChild("GameOverScreen"):WaitForChild("Main"),
			ScaleData = ScaleDataSettings.GameOverScreen
		},
		{
			Element = forScaling:WaitForChild("GameOverScreen"):WaitForChild("Rewards"),
			ScaleData = ScaleDataSettings.GameOverScreenRewards
		},
		{
			Element = forScaling:WaitForChild("Tooltips"):WaitForChild("EnemyHover"),
			ScaleData = ScaleDataSettings.EnemyHover
		},
		{
			Element = forScaling:WaitForChild("Tooltips"):WaitForChild("PathEntityHover"),
			ScaleData = ScaleDataSettings.PathEntityHover
		},
		{
			Element = forScaling:WaitForChild("Tooltips"):WaitForChild("TowerHover"),
			ScaleData = ScaleDataSettings.TowerHover
		},
		{
			Element = forScaling:WaitForChild("Tooltips"):WaitForChild("AdminHoverPanel"),
			ScaleData = ScaleDataSettings.AdminHover,
			UseNewScalingMethod = true
		},
		{
			Element = leftButtons,
			ScaleData = ScaleDataSettings.LeftButtons,
			UseNewScalingMethod = true
		},
		{ Element = settings, ScaleData = ScaleDataSettings.Settings },
		{
			Element = forScaling:WaitForChild("SpeedChangeScreen"),
			ScaleData = ScaleDataSettings.VIPPurchaseScreen
		},
		{
			Element = forScaling:WaitForChild("GameOverScreen"):WaitForChild("RewindScreen"),
			ScaleData = ScaleDataSettings.RewindScreen
		},
		{
			Element = forScaling:WaitForChild("GameOverScreen"):WaitForChild("TopNotification"),
			ScaleData = ScaleDataSettings.CoreGameTopNotification
		},
		{ Element = emotes:WaitForChild("Frame"), ScaleData = ScaleDataSettings.EmoteWheel },
		{
			Element = forScaling:WaitForChild("BottomLeftButtons"),
			ScaleData = ScaleDataSettings.BottomLeftButtons
		},
		{
			Element = forScaling:WaitForChild("LoadoutSelectionScreen"),
			ScaleData = ScaleDataSettings.LoadoutSelectionScreen
		},
		{
			Element = forScaling:WaitForChild("UpgradeShopScreen"),
			ScaleData = ScaleDataSettings.UpgradeShopScreen,
			UseNewScalingMethod = true
		},
		{
			Element = forScaling:WaitForChild("AbilityHotbar"),
			AdjustPosition = true,
			DefaultPosition = UDim2.new(0.01, 0, 0.385, 0),
			ScaleData = ScaleDataSettings.AbilityHotbar,
			UseNewScalingMethod = true
		},
		{
			Element = forScaling:WaitForChild("MapOverrideScreen"),
			ScaleData = ScaleDataSettings.MapOverrideScreen,
			UseNewScalingMethod = true
		}
	}
	local frames = PlayerGui:WaitForChild("FirstPersonInterface"):WaitForChild("FirstPersonScreen"):WaitForChild("Frames")
	local combatDroneBase = frames:WaitForChild("CombatDroneBase")
	local innerFrame = frames:WaitForChild("CombatDroneP2"):WaitForChild("InnerFrame")
	local v4 = {
		{
			Element = combatDroneBase:WaitForChild("AltitudeMeter"),
			ScaleData = ScaleDataSettings.CombatDroneAltitudeMeter,
			UseNewScalingMethod = true
		},
		{
			Element = innerFrame:WaitForChild("AltitudeMeter"),
			ScaleData = ScaleDataSettings.CombatDroneAltitudeMeter,
			UseNewScalingMethod = true
		},
		{
			Element = combatDroneBase:WaitForChild("DirectionMeter"),
			ScaleData = ScaleDataSettings.CombatDroneDirectionMeter,
			UseNewScalingMethod = true
		},
		{
			Element = innerFrame:WaitForChild("DirectionMeter"),
			ScaleData = ScaleDataSettings.CombatDroneDirectionMeter,
			UseNewScalingMethod = true
		},
		{
			Element = combatDroneBase:WaitForChild("Zoom"),
			ScaleData = ScaleDataSettings.CombatDroneZoom,
			UseNewScalingMethod = true
		},
		{
			Element = innerFrame:WaitForChild("Zoom"),
			ScaleData = ScaleDataSettings.CombatDroneZoom,
			UseNewScalingMethod = true
		},
		{
			Element = combatDroneBase:WaitForChild("WeaponInfo"),
			ScaleData = ScaleDataSettings.CombatDroneWeaponInfo,
			UseNewScalingMethod = true
		},
		{
			Element = innerFrame:WaitForChild("WeaponInfo"),
			ScaleData = ScaleDataSettings.CombatDroneWeaponInfo,
			UseNewScalingMethod = true
		},
		{
			Element = combatDroneBase:WaitForChild("Buttons"),
			ScaleData = ScaleDataSettings.CombatDroneButtons,
			UseNewScalingMethod = true
		},
		{
			Element = innerFrame:WaitForChild("Buttons"),
			ScaleData = ScaleDataSettings.CombatDroneButtons,
			UseNewScalingMethod = true
		}
	}

	for _, v5 in pairs(v4) do
		table.insert(v, v5)
	end

	local function UpdateDialogueBoxBoundsPosition()
		local visible = pvpTowersBar.Visible
		local visible2 = hint.Visible
		local v5

		if visible then
			touchPlacementButtons.Position = UDim2.new(0.5, 0, -0.65, 0)
			v5 = tabs
		else
			touchPlacementButtons.Position = UDim2.new(0.5, 0, -0.1, 0)
			v5 = towersBar
		end

		if visible2 then
			v5 = hint
		end

		local y = v5.AbsolutePosition.Y
		dialogueBoxBounds.Position = UDim2.new(0.5, 0, -0.02, y)
	end

	local v5 = nil

	local function UpdateTopAreaQueueFramePosition()
		local v6

		if workspace:GetAttribute("IsPVP") then
			local v7

			if friendlyBar.Position.X.Offset == 0 then
				v7 = friendlyBar.Position.Y.Offset == 0
			else
				v7 = false
			end

			if v7 or not v5 then
				v5 = cashPerSecondFrame.AbsolutePosition.Y + cashPerSecondFrame.AbsoluteSize.Y - pvp.AbsolutePosition.Y
			end

			v6 = pvp.AbsolutePosition.Y + v5
		else
			local v7 = timeLeft.Visible and timeLeft or wave
			v6 = v7.AbsolutePosition.Y + v7.AbsoluteSize.Y
		end

		topAreaQueueFrame.Position = UDim2.new(0.5, 0, 0, v6)
	end

	RenderSteppedUpdate = function()
		UpdateDialogueBoxBoundsPosition()
		UpdateTopAreaQueueFramePosition()
	end
end

function ScalingHandler.ManualTriggerScreenSizeChanged()
	CustomScreenSizeChanged(v3 or forScaling.AbsoluteSize)
end

for _, v4 in pairs(v) do
	if v2[v4.Element] then
		warn("Duplicate scale data table for element " .. v4.Element.Name)
	end

	v2[v4.Element] = v4

	if v4.ElementUIScale or v4.UseNewScalingMethod then
		continue
	end

	v4.ElementUIScale = v4.Element:FindFirstChildOfClass("UIScale")

	if not v4.ElementUIScale then
		warn("No UI scale found for element " .. v4.Element.Name)
	end
end

RunService.RenderStepped:Connect(function()
	if os.clock() - now >= 0.5 then
		now = os.clock()
		local absoluteSize = forScaling.AbsoluteSize

		if absoluteSize and v3 ~= absoluteSize then
			v3 = absoluteSize
			ScreenSizeChanged(absoluteSize)
			CustomScreenSizeChanged(absoluteSize)
		end
	end

	RenderSteppedUpdate()
end)
return ScalingHandler