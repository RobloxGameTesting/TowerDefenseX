local SeizureWarningHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local GameStates = Enums.GameStates
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local interface = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface")
local v = nil
local v2 = {}
local flag = false
local v3 = {}
local v4 = nil
local count = 0

local function GetTransparencyProperties(instance)
	local v5 = {}

	if instance:IsA("GuiObject") then
		table.insert(v5, "BackgroundTransparency")
	end

	if instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox") then
		table.insert(v5, "TextTransparency")
		table.insert(v5, "TextStrokeTransparency")
	end

	if instance:IsA("ImageLabel") or instance:IsA("ImageButton") then
		table.insert(v5, "ImageTransparency")
	end

	if instance:IsA("UIStroke") then
		table.insert(v5, "Transparency")
	end

	return v5
end

local function CollectFadeTargets(folder)
	local result = {}

	local function Collect(instance)
		for _, property in ipairs((GetTransparencyProperties(instance))) do
			table.insert(result, {
				Instance = instance,
				Property = property,
				OriginalValue = instance[property]
			})
		end
	end

	Collect(folder)

	for _, descendant in pairs(folder:GetDescendants()) do
		Collect(descendant)
	end

	return result
end

local function SetFullyTransparent() -- 1 equivalent call inferred from this helper
	for _, v5 in ipairs(v2) do
		v5.Instance[v5.Property] = 1
	end
end

local function RestoreTransparencies() -- 1 equivalent call inferred from this helper
	for _, v5 in ipairs(v2) do
		v5.Instance[v5.Property] = v5.OriginalValue
	end
end

local function PlayFade(flag2: boolean, tweenInfo3)
	v3 = {}

	for _, v5 in ipairs(v2) do
		local v6 = not flag2 and 1 or v5.OriginalValue
		local v7 = TweenService:Create(v5.Instance, tweenInfo3, { [v5.Property] = v6 })
		v7:Play()
		table.insert(v3, v7)
	end
end

local function CancelFades()
	for _, v5 in ipairs(v3) do
		v5:Cancel()
	end

	v3 = {}
end

local function GetSeizureWarningFrame()
	if flag then
		return v
	end

	flag = true
	local seizureWarning = interface:WaitForChild("SeizureWarning", 10)

	if not seizureWarning then
		warn("SeizureWarningHandler: no SeizureWarning frame under Interface - warning will not be shown")
		return nil
	end

	v = seizureWarning
	v2 = CollectFadeTargets(seizureWarning)
	seizureWarning.Visible = false
	return seizureWarning
end

local function GetBlackBackdrop()
	if v4 then
		return v4
	end

	local v5 = 1

	for _, guiObject in pairs(interface:GetDescendants()) do
		if guiObject:IsA("GuiObject") then
			v5 = math.min(v5, guiObject.ZIndex)
		end
	end

	local frame = Instance.new("Frame")
	frame.Name = "SeizureWarningBlackBackdrop"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = UDim2.fromScale(2, 2)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0
	frame.BorderSizePixel = 0
	frame.ZIndex = v5 - 1
	frame.Visible = false
	frame.Parent = interface
	v4 = frame
	return frame
end

local function SetBlackBackdropVisible(flag2: boolean) -- 3 equivalent calls inferred from this helper
	if flag2 then
		local getBlackBackdrop = GetBlackBackdrop()
		getBlackBackdrop.Visible = true
	elseif v4 then
		v4.Visible = false
	end
end

local function HideWarning(flag2: boolean?) -- 2 equivalent calls inferred from this helper
	count += 1
	CancelFades()

	if v then
		v.Visible = false
	end

	if not flag2 and v4 then
		v4.Visible = false
	end

	RestoreTransparencies() -- inferred equivalent call
end

local function ShowWarning(p: number, fadeToBlack: boolean) -- 1 equivalent call inferred from this helper
	if not (p <= 0.5) then
		task.spawn(function()
			count += 1
			local v5 = count
			local lastTime = os.clock()
			local seizureWarning

			if flag then
				seizureWarning = v
			else
				flag = true
				seizureWarning = interface:WaitForChild("SeizureWarning", 10)

				if seizureWarning then
					v = seizureWarning
					v2 = CollectFadeTargets(seizureWarning)
					seizureWarning.Visible = false
				else
					warn("SeizureWarningHandler: no SeizureWarning frame under Interface - warning will not be shown")
					seizureWarning = nil
				end
			end

			if not seizureWarning or count ~= v5 then
				return
			end

			SetFullyTransparent() -- inferred equivalent call
			seizureWarning.Visible = true
			PlayFade(true, tweenInfo)
			task.wait((math.max(0, p - 0.5 - (os.clock() - lastTime))))

			if count ~= v5 then
				return
			end

			if fadeToBlack then
				SetBlackBackdropVisible(true) -- inferred equivalent call
			end

			PlayFade(false, tweenInfo2)
			task.wait(0.5)

			if count ~= v5 then
				return
			end

			HideWarning(true) -- inferred equivalent call
		end)
		return
	end

	if fadeToBlack then
		SetBlackBackdropVisible(true) -- inferred equivalent call
		return
	end

	SetBlackBackdropVisible(false) -- inferred equivalent call
end

function SeizureWarningHandler.Initialize()
	if flag then
		return
	end

	flag = true
	local seizureWarning = interface:WaitForChild("SeizureWarning", 10)

	if not seizureWarning then
		warn("SeizureWarningHandler: no SeizureWarning frame under Interface - warning will not be shown")
		return
	end

	v = seizureWarning
	v2 = CollectFadeTargets(seizureWarning)
	seizureWarning.Visible = false
end

function SeizureWarningHandler.SetState(p: string, data)
	if p == GameStates.SeizureWarning then
		ShowWarning(data.TimeLeft - Utilities.GetTimeOffset(data.ServerTime), data.FadeToBlack) -- inferred equivalent call
	else
		HideWarning(false) -- inferred equivalent call
	end
end

return SeizureWarningHandler