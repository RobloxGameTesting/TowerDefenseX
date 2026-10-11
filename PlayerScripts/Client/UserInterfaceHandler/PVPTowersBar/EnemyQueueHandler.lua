local EnemyQueueHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local EnemyViewport = require(common:WaitForChild("EnemyViewport"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local GameClass = script.Parent.Parent.Parent:WaitForChild("GameClass")
local v = nil

local function GetGameClass() -- 1 equivalent call inferred from this helper
	if not v then
		local module = require(GameClass)
		v = module
	end

	return v
end

local PVPInitialStatsDisplayHandler = require(script.Parent:WaitForChild("PVPInitialStatsDisplayHandler"))
local PVPEnemyButtonClass = require(script.Parent:WaitForChild("PVPEnemyButtonClass"))
local ScaleJuiceClass = require(script.Parent:WaitForChild("ScaleJuiceClass"))
local udim = UDim2.new(1, 0, 1, 0)
local tweenInfo = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.45)
local tweenInfo3 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v2 = {}
local PVP_ENEMY_QUEUE_MAX_SIZE = _G.PVP_ENEMY_QUEUE_MAX_SIZE
local v3 = nil
local v4 = nil
local v5 = nil
local time = nil
local udim2 = UDim.new(0.2, 0)
local clones = {}
local heartbeatConnection = nil
local v6 = nil
local size = udim
local udim3 = UDim2.new(1, 0, 1, 0)
local v7 = nil
local v8 = ScaleJuiceClass.New(tweenInfo3)
local v9 = false
local flag = false

local function ConsumeQueueTemplates(instance)
	local v10 = nil

	for _, canvasGroup in ipairs(instance:GetChildren()) do
		if not (canvasGroup.Name == "EnemyQueueTemplate" and canvasGroup:IsA("CanvasGroup")) then
			continue
		end

		v10 = v10 or canvasGroup:Clone()
		canvasGroup:Destroy()
	end

	return v10
end

local function GetSlotContent(instance) -- 3 equivalent calls inferred from this helper
	return (instance:FindFirstChild("EnemyQueueTemplateContent"))
end

local function RefreshDisplay()
	local v10 = v4
	local parent = v3

	if not (v10 and parent) then
		return
	end

	local v11 = v7
	local v12 = not (v11 and parent.AbsoluteSize.Y > 0) and 2 or v11.AbsoluteSize.Y / parent.AbsoluteSize.Y
	local udim4 = UDim2.new(udim3.X.Scale * v12, udim3.X.Offset * v12, udim3.Y.Scale * v12, udim3.Y.Offset * v12)

	for i, v13 in ipairs(v2) do
		local clone = clones[i]

		if not clone then
			clone = v10:Clone()
			clone.Parent = parent
			clones[i] = clone
			local v14 = i
			local anchor = clone
			clone.MouseEnter:Connect(function()
				local v15 = v2[v14]

				if not v15 then
					return
				end

				PVPInitialStatsDisplayHandler.Show({ EnemyName = v15.EnemyName, Anchor = anchor })
			end)
			clone.MouseLeave:Connect(function()
				PVPInitialStatsDisplayHandler.Hide()
			end)
		end

		local visible = clone.Visible
		clone.Visible = true
		clone.Name = v13.EnemyName
		local size2

		if i == 1 then
			size2 = udim4
		else
			size2 = udim3
		end

		clone.Size = size2
		EnemyViewport.Build(GetSlotContent(clone) or clone, v13.EnemyName) -- inferred equivalent call

		if not visible then
			v8:Play(clone, 0.6)
		end
	end

	for i = #v2 + 1, #clones do
		clones[i].Visible = false
	end
end

local function ShowSendEcoNotification(p: string)
	local v10 = v6
	local v11 = clones[1]
	local v12 = v3
	local parent = v12 and v12.Parent

	if not (v10 and v11 and parent) then
		return
	end

	local enemyConfig = ResourceManager.FindEnemyConfig(p)
	local sendEco = enemyConfig and enemyConfig.SendEco or 0

	if sendEco == 0 then
		return
	end

	SoundHandler.Play(sendEco > 0 and "PVPEcoIncrease" or "PVPEcoDecrease")
	local clone = v10:Clone()
	PVPEnemyButtonClass.StyleSendEcoRow(clone, sendEco)
	local uiListLayout = clone:FindFirstChildWhichIsA("UIListLayout")

	if uiListLayout then
		uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	end

	local uiPadding = clone:FindFirstChildWhichIsA("UIPadding")

	if uiPadding then
		uiPadding.PaddingRight = UDim.new(0.175, uiPadding.PaddingRight.Offset)
	end

	if parent.AbsoluteSize.X <= 0 then
		return
	end

	local y = v12.AbsoluteSize.Y
	local y2 = v12.AbsoluteSize.Y
	local v13 = v11.AbsolutePosition.X + v11.AbsoluteSize.X / 2 - parent.AbsolutePosition.X
	local v14 = not v5 and 0 or v5.AbsoluteSize.Y + 4
	local v15 = v11.AbsolutePosition.Y - parent.AbsolutePosition.Y - 4 - v14
	local absoluteSize = parent.AbsoluteSize
	clone.AnchorPoint = Vector2.new(0.5, 1)
	clone.Size = UDim2.fromScale(3.5 * y / absoluteSize.X, 1.5 * y2 / absoluteSize.Y)
	clone.Position = UDim2.fromScale(v13 / absoluteSize.X, v15 / absoluteSize.Y)
	clone.ZIndex = 10
	clone.Visible = true
	clone.Parent = parent
	TweenService:Create(clone, tweenInfo, {
		Position = UDim2.fromScale(v13 / absoluteSize.X, (v15 - 1.3 * y2) / absoluteSize.Y)
	}):Play()

	for _, guiObject in ipairs(clone:GetDescendants()) do
		if guiObject:IsA("TextLabel") then
			TweenService:Create(guiObject, tweenInfo2, { TextTransparency = 1 }):Play()
		elseif guiObject:IsA("ImageLabel") then
			TweenService:Create(guiObject, tweenInfo2, { ImageTransparency = 1 }):Play()
		end
	end

	task.delay(1.2, function()
		clone:Destroy()
	end)
end

local function RefreshBuildDurationChip()
	local v10 = v5

	if not v10 then
		return
	end

	local v11 = v2[1]

	if not v11 then
		v10.Visible = false
		return
	end

	local v12 = math.max(0, v11.BuildTimeRemaining) + math.max(0, v11.CooldownTimeRemaining or 0)
	v10.Visible = v12 > 0

	if time and v12 > 0 then
		time.Text = PVPEnemyButtonClass.FormatBuildSeconds(v12, 1)
	end

	local v13 = clones[1]
	local parent = v10.Parent

	if v10.Visible and v13 and parent and parent.AbsoluteSize.X > 0 then
		local v14 = v13.AbsolutePosition.X + v13.AbsoluteSize.X / 2 - parent.AbsolutePosition.X
		local v15 = v13.AbsolutePosition.Y - parent.AbsolutePosition.Y - 4
		v10.AnchorPoint = Vector2.new(0.5, 1)
		v10.Position = UDim2.fromScale(v14 / parent.AbsoluteSize.X, v15 / parent.AbsoluteSize.Y)
		v10.Size = UDim2.new(v13.AbsoluteSize.X / parent.AbsoluteSize.X, 0, udim2.Scale, udim2.Offset)
	end
end

local function TickJuiceBars()
	for i, v10 in ipairs(v2) do
		local v11 = clones[i]

		if not (v11 and v11.Visible) then
			continue
		end

		local slotContent = GetSlotContent(v11) -- inferred equivalent call
		local juice = slotContent and slotContent:FindFirstChild("Juice")

		if not juice then
			continue
		end

		local v12 = (v10.BuildDuration or 0) + (v10.BuildCooldown or 0)

		if v12 <= 0 then
			juice.Size = UDim2.new(size.X.Scale, size.X.Offset, 0, 0)
		else
			local v13 = math.clamp(
				(v12 - (math.max(0, v10.BuildTimeRemaining) + math.max(0, v10.CooldownTimeRemaining or 0))) / v12,
				0,
				1
			)
			juice.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale * (1 - v13), size.Y.Offset * (1 - v13))
		end
	end
end

local function StartHeartbeat() -- 1 equivalent call inferred from this helper
	if heartbeatConnection then
		return
	end

	heartbeatConnection = RunService.Heartbeat:Connect(function(dt: number)
		if #v2 == 0 then
			if heartbeatConnection then
				heartbeatConnection:Disconnect()
				heartbeatConnection = nil
			end
		else
			local currentGame = GetGameClass().GetCurrentGame() -- inferred equivalent call
			local finalSpeedMultiplier = currentGame and currentGame:GetFinalSpeedMultiplier() or 1
			local v10 = v2[1]
			local v11 = dt * finalSpeedMultiplier
			local v12 = math.min(v10.BuildTimeRemaining, v11)
			v10.BuildTimeRemaining -= v12
			local v13 = v11 - v12

			if v13 > 0 then
				v10.CooldownTimeRemaining = math.max(0, (v10.CooldownTimeRemaining or 0) - v13)
			end

			TickJuiceBars()
			RefreshBuildDurationChip()
		end
	end)
end

function EnemyQueueHandler.Initialize(p, p2, instance, p3)
	if flag then
		return
	end

	flag = true
	v3 = p
	v6 = p2
	v5 = instance
	v7 = p3

	if instance then
		time = instance:FindFirstChild("Time")
		udim2 = instance.Size.Y
		instance.Visible = false
	end

	v4 = ConsumeQueueTemplates(p)

	if not v4 then
		warn(`EnemyQueueHandler: {p.Name} has no EnemyQueueTemplate children`)
		return
	end

	local slotContent = GetSlotContent(v4) -- inferred equivalent call
	local juice = slotContent and slotContent:FindFirstChild("Juice")

	if juice then
		size = juice.Size
	end

	udim3 = v4.Size
	NetworkingHandler.GetEvent("UpdatePVPSendQueue"):AttachCallback(function(options, p4: number?)
		local v10 = #v2
		v2 = options or {}
		PVP_ENEMY_QUEUE_MAX_SIZE = p4 or _G.PVP_ENEMY_QUEUE_MAX_SIZE
		RefreshDisplay()
		RefreshBuildDurationChip()
		StartHeartbeat() -- inferred equivalent call

		if #v2 > 0 and #v2 < v10 then
			v8:Play(clones[1], 1.12)

			if v5 then
				v8:Play(v5, 1.12)
			end
		end

		local v11 = v2[1]

		if not (v11 and v11.Sent) then
			v9 = false
		end

		if v11 and v11.Sent and not v9 then
			task.defer(ShowSendEcoNotification, v11.EnemyName)
			v9 = true
		end
	end)
end

function EnemyQueueHandler.IsFull()
	local v10 = #v2
	return PVP_ENEMY_QUEUE_MAX_SIZE <= v10
end

function EnemyQueueHandler.CountByName(p: string)
	local count = 0

	for _, v10 in ipairs(v2) do
		if v10.EnemyName == p then
			count += 1
		end
	end

	return count
end

return EnemyQueueHandler