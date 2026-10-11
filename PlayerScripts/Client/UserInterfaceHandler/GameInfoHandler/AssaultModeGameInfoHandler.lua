local AssaultModeGameInfoHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("WaveTypes"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local GameClass = script.Parent.Parent.Parent:WaitForChild("GameClass")
require(GameClass:WaitForChild("MapEntityClass"))
require(script.Parent:WaitForChild("GameInfoHandlerTypes"))
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local color = Color3.fromRGB(155, 155, 155)
local color2 = Color3.fromRGB(255, 255, 255)
local color3 = Color3.fromRGB(197, 72, 72)
local color4 = Color3.fromRGB(188, 7, 7)
local v = nil
local flag = false
local v2 = nil
local juice = nil
local juice2 = nil
local shieldJuice = nil
local icon = nil
local iconHP = nil
local v3 = {}
local v4 = nil
local v5 = nil

local function UpdateEnemyBaseHealthBar()
	local northforgeEnemyBaseLives = workspace:GetAttribute("NorthforgeEnemyBaseLives")
	local northforgeEnemyBaseTotalLives = workspace:GetAttribute("NorthforgeEnemyBaseTotalLives")
	local v6

	if northforgeEnemyBaseLives == v4 then
		v6 = false
	else
		v4 = northforgeEnemyBaseLives
		v6 = true
	end

	if northforgeEnemyBaseTotalLives ~= v5 then
		v5 = northforgeEnemyBaseTotalLives
		v6 = true
	end

	if v6 and v4 and v5 then
		if v4 <= 1 then
			TweenService:Create(juice2, tweenInfo, { Size = UDim2.new(v4, 0, 1, 0) }):Play()
			TweenService:Create(shieldJuice, tweenInfo, { Size = UDim2.new(0, 0, 0.5, 0) }):Play()
			icon.Visible = false
			iconHP.Visible = true
		else
			local v7 = math.clamp((v4 - 1) / (v5 - 1), 0, 1)
			juice2.Size = UDim2.new(1, 0, 1, 0)
			TweenService:Create(shieldJuice, tweenInfo, { Size = UDim2.new(v7, 0, 0.5, 0) }):Play()
			icon.Visible = true
			iconHP.Visible = false
		end
	end
end

local function GenerateCaptureIndexToBaseMap()
	local bases = v2:FindFirstChild("Bases")

	if not bases then
		warn("AssaultModeGameInfoHandler: Could not find Bases frame in GameInfoFrame")
		return
	end

	for _, child in pairs(bases:GetChildren()) do
		local name = tonumber(child.Name)

		if name then
			v3[name] = {
				Captured = false,
				Capturing = false,
				CapturePercentage = 0,
				Frame = child,
				UIStroke = child:FindFirstChildOfClass("UIStroke"),
				TimeUntilCaptureProgressSound = 0
			}
		else
			warn("Base " .. child.Name .. " is not a valid capture index number")
		end
	end
end

function AssaultModeGameInfoHandler:Initialize(_, p)
	if workspace:GetAttribute("MapName") ~= Enums.Maps.Northforge then
		return false
	end

	if not v then
		v = NetworkingHandler.GetEvent("NorthforgeFlagStateChanged")
		v:AttachCallback(function(p2: number, captured: boolean, capturing: boolean, capturePercentage: number)
			if not flag then
				return
			end

			local v6 = v3[p2]

			if not v6 then
				return
			end

			if captured and not v6.Captured then
				SoundHandler.Play("AssaultModeCaptureComplete")
			end

			v6.Captured = captured
			v6.Capturing = capturing
			v6.CapturePercentage = capturePercentage
		end)
	end

	if flag then
		self:Remove()
	end

	if not p then
		warn("AssaultModeGameInfoHandler:Initialize called without a valid GameInfoFrame")
		return false
	end

	flag = true
	v2 = p
	v2.Visible = true
	juice = v2.FriendlyBar.Juice
	juice2 = v2.EnemyBar.Juice
	shieldJuice = v2.EnemyBar.ShieldJuice
	icon = v2.EnemyBar.Icon
	iconHP = v2.EnemyBar.IconHP
	self:UpdateLivesBar()
	UpdateEnemyBaseHealthBar()
	GenerateCaptureIndexToBaseMap()
	return true
end

function AssaultModeGameInfoHandler:Remove()
	if not flag then
		return
	end

	if v2 then
		v2.Visible = false
		v2 = nil
	end

	table.clear(v3)
	flag = false
end

function AssaultModeGameInfoHandler:UpdateLivesBar(p)
	if not flag then
		return
	end

	local v6 = p and p[TeamUtilities.GetLocalPlayerTeamIndex()]
	local lives = v6 and v6.Lives
	local totalLives = v6 and v6.TotalLives

	if not lives then
		juice.Size = UDim2.new(1, 0, 1, 0)
		return
	end

	local v7 = math.min(1, lives / totalLives)
	TweenService:Create(juice, tweenInfo, { Size = UDim2.new(v7, 0, 1, 0) }):Play()
end

function AssaultModeGameInfoHandler.Update(_, p: number, _: number)
	if not flag then
		return
	end

	UpdateEnemyBaseHealthBar()

	for _, v6 in pairs(v3) do
		if v6.Captured then
			v6.Frame.BackgroundColor3 = color3
			v6.UIStroke.Color = color4
		elseif v6.Capturing then
			if os.clock() % 0.8 < 0.4 then
				v6.Frame.BackgroundColor3 = color
				v6.UIStroke.Color = color2
			else
				v6.Frame.BackgroundColor3 = color3
				v6.UIStroke.Color = color4
			end

			v6.TimeUntilCaptureProgressSound -= p

			if v6.TimeUntilCaptureProgressSound <= 0 then
				SoundHandler.Play("AssaultModeCaptureProgress")
				v6.TimeUntilCaptureProgressSound = 2.2
			end
		else
			v6.Frame.BackgroundColor3 = color
			v6.UIStroke.Color = color2
		end
	end
end

return AssaultModeGameInfoHandler