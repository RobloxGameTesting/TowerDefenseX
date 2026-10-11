local TopNotificationHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Utilities"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local MapUtilities = require(Common:WaitForChild("MapUtilities"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local Shared = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Shared"))
local udim = UDim2.new(0.5, 0, 0.01, -GuiService:GetGuiInset().Y)
local udim2 = UDim2.new(0.5, 0, -0.15, -GuiService:GetGuiInset().Y)
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local topNotification = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("GameOverScreen"):WaitForChild("TopNotification")
local medalImage = topNotification.Medal.MedalImage
local centerText = topNotification.CenterText
local bottomText = topNotification.BottomText
local flag = true

function TopNotificationHandler.Display(data)
	local difficulty = data.Difficulty
	local waveConfig = ResourceManager.GetWaveConfig(difficulty)
	local displayName

	if waveConfig then
		displayName = waveConfig.DisplayName or difficulty
	else
		displayName = difficulty
	end

	local displayName2 = MapUtilities.GetDisplayName(data.MapName)
	local v = data.PlayerNameToFirstMapAndDifficultyWinMap[LocalPlayer.Name]
	local v2 = math.round(100 * data.FirstMapAndDifficultyWinBonus)

	if not v then
		return
	end

	centerText.Text = Lang.Get(Lang.Strings.Game.FirstWinNotificationCenterText, displayName, displayName2)
	bottomText.Text = Lang.Get(Lang.Strings.Game.FirstWinNotificationBottomText, v2)
	medalImage.Image = Shared.MEDALS_LIST[difficulty] and Shared.MEDALS_LIST[difficulty][true] or ""

	if flag then
		topNotification.Position = udim2
		task.delay(1, function()
			TweenService:Create(topNotification, tweenInfo, { Position = udim }):Play()
		end)
	end

	flag = false
	topNotification.Visible = true
end

function TopNotificationHandler.Disable()
	topNotification.Position = udim2
	topNotification.Visible = false
	flag = true
end

topNotification.Position = udim2
return TopNotificationHandler