local SpawnTimersDisplayHandler = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local EnemyViewport = require(common:WaitForChild("EnemyViewport"))
local TroopDetailsUtilities = require(script.Parent:WaitForChild("TroopDetailsUtilities"))
local RobotoMono = Enum.Font.RobotoMono
local v = {
	RowTextSize = 16,
	RowHeight = 19,
	HeaderTextSize = 13,
	HeaderHeight = 15,
	TagTextSize = 13,
	TagHeight = 19
}
local v2 = {
	RowTextSize = 18,
	RowHeight = 22,
	HeaderTextSize = 14,
	HeaderHeight = 16,
	TagTextSize = 15,
	TagHeight = 22
}
local color = Color3.fromRGB(155, 255, 89)
local color2 = Color3.fromRGB(255, 193, 77)
local color3 = Color3.fromRGB(170, 170, 170)
local color4 = Color3.fromRGB(140, 203, 255)
local color5 = Color3.fromRGB(175, 175, 175)
local color6 = Color3.new(1, 1, 1)
local color7 = Color3.new(0, 0, 0)
local interface = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface")
local towerUI = interface:WaitForChild("TowerUI")
local currentStats = towerUI:WaitForChild("CurrentStats")
local upgradeHover = towerUI:WaitForChild("UpgradeHover")
local background = currentStats:WaitForChild("Background")
local text = currentStats:WaitForChild("ContentFrame"):WaitForChild("ItemTemplate"):WaitForChild("Text")
local textSize = text.TextSize
local frame = Instance.new("Frame")
frame.Name = "SpawnTimers"
frame.BackgroundTransparency = 1
frame.AnchorPoint = Vector2.new(0, 0)
frame.Visible = false
frame.ZIndex = currentStats.ZIndex
frame.Parent = towerUI
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.FillDirection = Enum.FillDirection.Vertical
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 10)
uiListLayout.Parent = frame
local v3 = {}
local v4 = {}
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = 0
local v9 = false
local v10 = 0
local v11 = nil
local v12 = nil
local v13 = nil
local now = os.clock()

local function IsTouchOnly() -- 2 equivalent calls inferred from this helper
	return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

local function GetTextWidth(p: string, p2: number) -- 15 equivalent calls inferred from this helper
	return (math.ceil(TextService:GetTextSize(p, p2, RobotoMono, Vector2.new(10000, 10000)).X))
end

local function NewTextLabel(name: string, parent)
	local clone = text:Clone()
	clone.Name = name
	clone.Text = ""
	clone.AnchorPoint = Vector2.new(0, 0.5)
	clone.Position = UDim2.new(0, 0, 0.5, 0)
	clone.Size = UDim2.fromScale(1, 1)
	clone.TextXAlignment = Enum.TextXAlignment.Left
	clone.TextYAlignment = Enum.TextYAlignment.Center
	clone.Parent = parent
	return clone
end

local function NewFrame(name: string, parent, zIndex: number) -- 20 equivalent calls inferred from this helper
	local frame2 = Instance.new("Frame")
	frame2.Name = name
	frame2.BackgroundTransparency = 1
	frame2.BorderSizePixel = 0
	frame2.ZIndex = zIndex
	frame2.Parent = parent
	return frame2
end

local function NewPortrait(parent, p: number, zIndex: number)
	local parent2 = NewFrame("Portrait", parent, zIndex) -- inferred equivalent call
	parent2.Size = UDim2.fromOffset(p, p)
	parent2.BackgroundColor3 = Color3.new(0, 0, 0)
	parent2.BackgroundTransparency = 0.65
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 4)
	uiCorner.Parent = parent2
	return parent2
end

local function NewBar(parent, zIndex: number)
	local track = NewFrame("BarTrack", parent, zIndex) -- inferred equivalent call
	track.Size = UDim2.fromScale(1, 1)
	track.BackgroundColor3 = Color3.new(1, 1, 1)
	track.BackgroundTransparency = 0.86
	track.ClipsDescendants = true
	local timeLabel = NewTextLabel("TimeText", track)
	timeLabel.Position = UDim2.new(0, 8, 0.5, 0)
	timeLabel.Size = UDim2.new(1, -16, 1, 0)
	timeLabel.TextColor3 = color6
	timeLabel.ZIndex = zIndex + 1
	local v14 = NewFrame("Fill", track, zIndex + 2) -- inferred equivalent call
	v14.Size = UDim2.fromScale(0, 1)
	v14.BackgroundColor3 = color
	v14.BackgroundTransparency = 0
	v14.ClipsDescendants = true
	local clone = timeLabel:Clone()
	clone.Name = "FillTimeText"
	clone.TextColor3 = color7
	clone.ZIndex = zIndex + 3
	clone.Parent = v14

	for _, parent2 in ipairs({ track, v14 }) do
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 3)
		uiCorner.Parent = parent2
	end

	return { Track = track, Fill = v14, TimeLabel = timeLabel, FillTimeLabel = clone }
end

local function NewPinIcon(parent, zIndex: number)
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "PinIcon"
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = "rbxassetid://115045591386247"
	imageLabel.ImageColor3 = color
	imageLabel.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel.Size = UDim2.fromOffset(16, 16)
	imageLabel.ZIndex = zIndex
	imageLabel.Visible = false
	imageLabel.Parent = parent
	return imageLabel
end

local function NewSpring() -- 2 equivalent calls inferred from this helper
	return { Position = 0, Velocity = 0, Target = 0 }
end

local function StepSpring(spring, p: number)
	if spring.Position - spring.Target == 0 and spring.Velocity == 0 then
		return
	end

	local v14 = math.max(1, (math.ceil(p / (1 / 240))))
	local v15 = p / v14

	for _ = 1, v14 do
		local v16 = -696.3992865408651 * (spring.Position - spring.Target) - 41.16743013264065 * spring.Velocity
		spring.Velocity += v16 * v15
		spring.Position += spring.Velocity * v15
	end

	if math.abs(spring.Position - spring.Target) < 0.5 and math.abs(spring.Velocity) < 4 then
		spring.Position = spring.Target
		spring.Velocity = 0
	end
end

local function GetDisplayedExtra(spring) -- 2 equivalent calls inferred from this helper
	return (math.max(0, (math.round(spring.Position))))
end

local function GetDetailsStyle() -- 2 equivalent calls inferred from this helper
	if IsTouchOnly() then -- inferred equivalent call
		return v2
	end

	return v
end

local function GetDetailsColumns(list, p)
	local headerTextSize = p.HeaderTextSize
	local rowTextSize = p.RowTextSize
	local textWidth = GetTextWidth("ATTACK", headerTextSize) -- inferred equivalent call
	local textWidth2 = GetTextWidth("DAMAGE", headerTextSize) -- inferred equivalent call
	local v14 = math.max(80, GetTextWidth("EVERY", headerTextSize)) -- inferred equivalent call

	for _, v15 in ipairs(list) do
		textWidth = math.max(textWidth, GetTextWidth(v15.Name, rowTextSize)) -- inferred equivalent call
		textWidth2 = math.max(textWidth2, GetTextWidth(v15.DamageText, rowTextSize)) -- inferred equivalent call
		v14 = math.max(v14, GetTextWidth(v15.EveryText, rowTextSize)) -- inferred equivalent call
	end

	return textWidth, textWidth2, v14
end

local function GetDetailsMinWidth(detailRows) -- 2 equivalent calls inferred from this helper
	local v14, v15, v16 = GetDetailsColumns(detailRows, GetDetailsStyle()) -- inferred equivalent call
	return v14 + v15 + v16 + 40
end

local function NewDetailsLabel(name: string, instance, text2: string, textSize2: number, p: number, p2: number, p3: number, p4: number)
	local newTextLabel = NewTextLabel(name, instance)
	newTextLabel.AnchorPoint = Vector2.new(0, 0)
	newTextLabel.Position = UDim2.fromOffset(p, p2)
	newTextLabel.Size = UDim2.fromOffset(p3, p4)
	newTextLabel.TextSize = textSize2
	newTextLabel.Text = text2
	return newTextLabel
end

local function BuildDetails(detailsFrame, list, p: number)
	for _, child in ipairs(detailsFrame:GetChildren()) do
		child:Destroy()
	end

	if #list == 0 then
		return 0
	end

	local zIndex = detailsFrame.ZIndex
	local detailsStyle = GetDetailsStyle() -- inferred equivalent call
	local rowHeight = detailsStyle.RowHeight
	local tagHeight = detailsStyle.TagHeight
	local _, v14, v15 = GetDetailsColumns(list, detailsStyle)
	local v16 = p - v15
	local v17 = v16 - 20 - v14
	local v18 = v17 - 20
	local newFrame = NewFrame("Separator", detailsFrame, zIndex) -- inferred equivalent call
	newFrame.Size = UDim2.new(1, 0, 0, 1)
	newFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	newFrame.BackgroundTransparency = 0.88
	local v19 = 10

	for _, v20 in ipairs({
		{ "ATTACK", 0, v18 },
		{ "DAMAGE", v17, v14 },
		{ "EVERY", v16, v15 }
	}) do
		local newDetailsLabel = NewDetailsLabel(
			"Header",
			detailsFrame,
			v20[1],
			detailsStyle.HeaderTextSize,
			v20[2],
			v19,
			v20[3],
			detailsStyle.HeaderHeight
		)
		newDetailsLabel.TextTransparency = 0.55
	end

	local v20 = v19 + (detailsStyle.HeaderHeight + 8)

	for i, v21 in ipairs(list) do
		local rowTextSize = detailsStyle.RowTextSize
		NewDetailsLabel("Name", detailsFrame, v21.Name, rowTextSize, 0, v20, v18, rowHeight)
		NewDetailsLabel("Damage", detailsFrame, v21.DamageText, rowTextSize, v17, v20, v14, rowHeight)
		local newDetailsLabel = NewDetailsLabel(
			"Every",
			detailsFrame,
			v21.EveryText,
			rowTextSize,
			v16,
			v20,
			v15,
			rowHeight
		)
		newDetailsLabel.TextTransparency = 0.35
		v20 += rowHeight

		if #v21.Tags > 0 then
			local v22 = v20 + 5
			local total = 0

			for _, tag in ipairs(v21.Tags) do
				local v23 = GetTextWidth(tag.Text, detailsStyle.TagTextSize) + 12 -- inferred equivalent call

				if total > 0 and p < total + v23 then
					v22 += tagHeight + 4
					total = 0
				end

				local v24

				if tag.Kind == "Summon" then
					v24 = color4
				elseif tag.Kind == "Limit" then
					v24 = color5
				else
					v24 = color
				end

				local parent = NewFrame("Tag", detailsFrame, zIndex) -- inferred equivalent call
				parent.Position = UDim2.fromOffset(total, v22)
				parent.Size = UDim2.fromOffset(v23, tagHeight)
				local uiCorner = Instance.new("UICorner")
				uiCorner.CornerRadius = UDim.new(0, 3)
				uiCorner.Parent = parent
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Color = v24
				uiStroke.Transparency = 0.4
				uiStroke.Thickness = 1
				uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				uiStroke.Parent = parent
				local newTextLabel = NewTextLabel("TagText", parent)
				newTextLabel.Text = tag.Text
				newTextLabel.TextSize = detailsStyle.TagTextSize
				newTextLabel.TextColor3 = v24
				newTextLabel.TextXAlignment = Enum.TextXAlignment.Center
				total += v23 + 4
			end

			v20 = v22 + tagHeight
		end

		if i < #list then
			v20 += 8
		end
	end

	local v21 = v20 + 1
	detailsFrame.Size = UDim2.new(detailsFrame.Size.X.Scale, detailsFrame.Size.X.Offset, 0, v21)
	return v21
end

local function NewFullCard()
	local slot = NewFrame("SpawnTimerCard", frame, 1) -- inferred equivalent call
	slot.Size = UDim2.new(0, 0, 0, 118)
	local parent = NewFrame("Card", slot, 1) -- inferred equivalent call
	parent.Size = UDim2.fromScale(1, 1)
	parent.ClipsDescendants = true
	parent.Active = true
	local clone = background:Clone()
	clone.Parent = parent
	local parent2 = NewFrame("ContentFrame", parent, clone.ZIndex + 1) -- inferred equivalent call
	parent2.Position = UDim2.fromOffset(16, 16)
	parent2.Size = UDim2.new(1, -32, 1, -32)
	local portraitFrame = NewPortrait(parent2, 86, parent2.ZIndex)
	local parent3 = NewFrame("Rows", parent2, parent2.ZIndex) -- inferred equivalent call
	parent3.Position = UDim2.fromOffset(102, 0)
	parent3.Size = UDim2.new(1, -102, 0, 86)
	local parent4 = NewFrame("NameRow", parent3, parent2.ZIndex) -- inferred equivalent call
	parent4.Size = UDim2.new(1, 0, 0, 18)
	local nameLabel = NewTextLabel("NameText", parent4)
	local pinIcon = NewPinIcon(parent4, parent2.ZIndex)
	local aliveLabel = NewTextLabel("AliveText", parent4)
	aliveLabel.AnchorPoint = Vector2.new(1, 0.5)
	aliveLabel.Position = UDim2.new(1, 0, 0.5, 0)
	aliveLabel.TextXAlignment = Enum.TextXAlignment.Right
	aliveLabel.TextTransparency = 0.35
	local parent5 = NewFrame("BarRow", parent3, parent2.ZIndex) -- inferred equivalent call
	parent5.Position = UDim2.fromOffset(0, 32)
	parent5.Size = UDim2.new(1, 0, 0, 22)
	local newBar = NewBar(parent5, parent2.ZIndex)
	local parent6 = NewFrame("StatsRow", parent3, parent2.ZIndex) -- inferred equivalent call
	parent6.Position = UDim2.fromOffset(0, 68)
	parent6.Size = UDim2.new(1, 0, 0, 18)
	local statsLabel = NewTextLabel("StatsText", parent6)
	statsLabel.TextSize = 15
	statsLabel.TextTransparency = 0.35
	local detailsFrame = NewFrame("Details", parent2, parent2.ZIndex) -- inferred equivalent call
	detailsFrame.Position = UDim2.fromOffset(0, 98)
	detailsFrame.Size = UDim2.new(1, 0, 0, 0)
	return {
		Entry = nil,
		PortraitFrame = portraitFrame,
		ViewportKey = nil,
		NameLabel = nameLabel,
		AliveLabel = aliveLabel,
		BarFill = newBar.Fill,
		TimeLabel = newBar.TimeLabel,
		FillTimeLabel = newBar.FillTimeLabel,
		StatsLabel = statsLabel,
		ShortAliveText = false,
		PinIcon = pinIcon,
		Slot = slot,
		DetailsFrame = detailsFrame,
		ExpandedExtra = 0,
		Spring = NewSpring(), -- inferred equivalent call
		ApplyExtra = function(p: number)
			slot.Size = UDim2.new(0, slot.Size.X.Offset, 0, p + 118)
		end
	}
end

local function NewCompactRow(layoutOrder: number)
	local slot = NewFrame("SpawnTimerRow", v6, 1) -- inferred equivalent call
	slot.LayoutOrder = layoutOrder
	slot.Size = UDim2.new(1, 0, 0, 36)
	slot.ClipsDescendants = true
	local parent = NewFrame("ExtraContent", slot, 1) -- inferred equivalent call
	parent.Position = UDim2.fromOffset(48, 40)
	parent.Size = UDim2.new(1, -48, 1, 0)
	local statsLabel = NewTextLabel("StatsText", parent)
	statsLabel.AnchorPoint = Vector2.new(0, 0)
	statsLabel.Position = UDim2.fromOffset(0, 0)
	statsLabel.Size = UDim2.new(1, 0, 0, 18)
	statsLabel.TextSize = 15
	statsLabel.TextTransparency = 0.35
	local detailsFrame = NewFrame("Details", parent, parent.ZIndex) -- inferred equivalent call
	detailsFrame.Position = UDim2.fromOffset(0, 30)
	detailsFrame.Size = UDim2.new(1, 0, 0, 0)
	local parent2 = NewFrame("MainRow", slot, 1) -- inferred equivalent call
	parent2.Size = UDim2.new(1, 0, 0, 36)
	local portraitFrame = NewPortrait(parent2, 36, parent2.ZIndex)
	local nameLabel = NewTextLabel("NameText", parent2)
	nameLabel.Position = UDim2.new(0, 48, 0.5, 0)
	local pinIcon = NewPinIcon(parent2, parent2.ZIndex)
	local parent3 = NewFrame("BarHolder", parent2, parent2.ZIndex) -- inferred equivalent call
	parent3.Name = "BarHolder"
	parent3.AnchorPoint = Vector2.new(0, 0.5)
	local newBar = NewBar(parent3, parent2.ZIndex)
	local aliveLabel = NewTextLabel("AliveText", parent2)
	aliveLabel.AnchorPoint = Vector2.new(1, 0.5)
	aliveLabel.Position = UDim2.new(1, 0, 0.5, 0)
	aliveLabel.TextXAlignment = Enum.TextXAlignment.Right
	aliveLabel.TextSize = 15
	aliveLabel.TextTransparency = 0.35
	return {
		Entry = nil,
		PortraitFrame = portraitFrame,
		ViewportKey = nil,
		NameLabel = nameLabel,
		AliveLabel = aliveLabel,
		BarFill = newBar.Fill,
		TimeLabel = newBar.TimeLabel,
		FillTimeLabel = newBar.FillTimeLabel,
		StatsLabel = statsLabel,
		ShortAliveText = true,
		PinIcon = pinIcon,
		Slot = slot,
		DetailsFrame = detailsFrame,
		ExpandedExtra = 0,
		Spring = NewSpring(), -- inferred equivalent call
		ApplyExtra = function(p: number)
			slot.Size = UDim2.new(1, 0, 0, p + 36)
		end
	}
end

local function EnsureCompactCard()
	if v5 then
		return
	end

	local parent = NewFrame("SpawnTimersCompactCard", frame, 1) -- inferred equivalent call
	parent.Visible = false
	parent.Active = true
	local clone = background:Clone()
	clone.Parent = parent
	local parent2 = NewFrame("ContentFrame", parent, clone.ZIndex + 1) -- inferred equivalent call
	parent2.Position = UDim2.fromOffset(16, 16)
	parent2.Size = UDim2.new(1, -32, 1, -32)
	local uiListLayout2 = Instance.new("UIListLayout")
	uiListLayout2.FillDirection = Enum.FillDirection.Vertical
	uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout2.Padding = UDim.new(0, 10)
	uiListLayout2.Parent = parent2
	v5 = parent
	v6 = parent2
end

local function UpdateViewport(state, pathEntityType: string, skinName: string?)
	local formatted = `{pathEntityType}|{skinName or ""}`

	if state.ViewportKey == formatted then
		return
	end

	state.ViewportKey = formatted
	EnemyViewport.BuildPathEntity(state.PortraitFrame, pathEntityType, skinName, {
		ZIndex = state.PortraitFrame.ZIndex + 1
	})
end

local function GetAliveReserveText(p, flag: boolean) -- 1 equivalent call inferred from this helper
	if p.MaximumCount then
		local formatted = `{p.MaximumCount}/{p.MaximumCount}`
		return flag and formatted or `{formatted} ALIVE`
	end

	if flag then
		return "99"
	end

	return "99 ALIVE"
end

local function SetTimeText(data, text2: string) -- 2 equivalent calls inferred from this helper
	data.TimeLabel.Text = text2
	data.FillTimeLabel.Text = text2
end

local function UpdateTimerView(data)
	local entry = data.Entry
	local spawnTimer = v7 and v7:GetSpawnTimer(entry.PathEntityType)

	if spawnTimer then
		local maximumCount = spawnTimer.MaximumCount
		local v14

		if maximumCount == nil then
			v14 = false
		else
			v14 = maximumCount <= spawnTimer.AliveCount
		end

		local v15 = maximumCount and `{spawnTimer.AliveCount}/{maximumCount}` or tostring(spawnTimer.AliveCount)
		data.AliveLabel.Text = data.ShortAliveText and v15 or `{v15} ALIVE`
		data.AliveLabel.TextColor3 = v14 and color2 or color6
		local v16 = math.max(spawnTimer.Interval, 0.01)
		local v17 = math.clamp(1 - spawnTimer.TimeToNextSpawn / v16, 0, 1)
		local backgroundColor, v18

		if v7.SpawnTimersPaused then
			backgroundColor = color3
			v18 = "PAUSED"
		elseif v14 then
			local timeToNextSpawn = math.ceil(spawnTimer.TimeToNextSpawn)
			v18 = timeToNextSpawn > 0 and `{timeToNextSpawn}S` or "FULL"
			backgroundColor = color2
		elseif spawnTimer.MidBurst then
			backgroundColor = color
			v17 = 1
			v18 = "DEPLOYING"
		else
			v18 = `{math.max(0, (math.ceil(spawnTimer.TimeToNextSpawn)))}S`
			backgroundColor = color
		end

		data.BarFill.Size = UDim2.fromScale(v17, 1)
		data.BarFill.BackgroundColor3 = backgroundColor
		SetTimeText(data, v18) -- inferred equivalent call
	else
		data.AliveLabel.Text = ""
		data.BarFill.Size = UDim2.fromScale(0, 1)
		SetTimeText(data, "--") -- inferred equivalent call
	end
end

local function ResetExpansion(p) -- 6 equivalent calls inferred from this helper
	p.Spring.Position = 0
	p.Spring.Velocity = 0
	p.Spring.Target = 0
	p.ApplyExtra(0)
end

local function ShowFullCards(p, list)
	local v14 = 0
	local v15 = 160
	local v16 = 0

	for _, v17 in ipairs(list) do
		v14 = math.max(
			v14,
			GetTextWidth( -- inferred equivalent call
				not v17.MaximumCount and "99 ALIVE" or `{`{v17.MaximumCount}/{v17.MaximumCount}`} ALIVE`,
				textSize
			)
		)
	end

	for _, v17 in ipairs(list) do
		local v18 = GetTextWidth(v17.DisplayName, textSize) + 7 + 16 + 24 + v14 -- inferred equivalent call
		v15 = math.max(v15, v18, GetTextWidth(v17.StatsText, 15)) -- inferred equivalent call

		if not TroopDetailsUtilities.HasDetails(v17.DetailRows) then
			continue
		end

		local detailRows = v17.DetailRows
		v16 = math.max(v16, GetDetailsMinWidth(detailRows)) -- inferred equivalent call
	end

	local v17 = math.max(v15, 306, v16 - 102)
	v10 = v17 + 134
	local v18 = v17 + 102

	for i, entry in ipairs(list) do
		local v19 = v3[i]

		if not v19 then
			v19 = NewFullCard()
			v3[i] = v19
		end

		v19.Entry = entry
		v19.Slot.LayoutOrder = i
		v19.Slot.Size = UDim2.new(0, v10, 0, GetDisplayedExtra(v19.Spring) + 118) -- inferred equivalent call
		v19.Slot.Visible = true
		v19.NameLabel.Text = entry.DisplayName
		v19.NameLabel.Size = UDim2.new(1, -(v14 + 24), 1, 0)
		local pinIcon = v19.PinIcon
		pinIcon.Position = UDim2.new(0, GetTextWidth(entry.DisplayName, textSize) + 7, 0.5, 0) -- inferred equivalent call
		v19.AliveLabel.Size = UDim2.new(0, v14, 1, 0)
		v19.FillTimeLabel.Size = UDim2.new(0, v17 - 16, 1, 0)
		v19.StatsLabel.Text = entry.StatsText

		if TroopDetailsUtilities.HasDetails(entry.DetailRows) then
			v19.ExpandedExtra = BuildDetails(v19.DetailsFrame, entry.DetailRows, v18) + 12
		else
			BuildDetails(v19.DetailsFrame, {}, v18)
			v19.ExpandedExtra = 0
		end

		UpdateViewport(v19, entry.PathEntityType, p.SkinName)
		UpdateTimerView(v19)
	end

	for i = #list + 1, #v3 do
		v3[i].Entry = nil
		v3[i].Slot.Visible = false
		ResetExpansion(v3[i]) -- inferred equivalent call
	end
end

local function ShowCompactCard(p, list)
	EnsureCompactCard()
	local v14 = 0
	local v15 = 0
	local v16 = 0
	local v17 = 0

	for _, v18 in ipairs(list) do
		v14 = math.max(v14, GetTextWidth(v18.DisplayName, textSize)) -- inferred equivalent call
		v15 = math.max(v15, GetTextWidth(GetAliveReserveText(v18, true), 15)) -- inferred equivalent call
		v16 = math.max(v16, GetTextWidth(v18.StatsText, 15)) -- inferred equivalent call

		if not TroopDetailsUtilities.HasDetails(v18.DetailRows) then
			continue
		end

		local detailRows = v18.DetailRows
		v17 = math.max(v17, GetDetailsMinWidth(detailRows)) -- inferred equivalent call
	end

	local v18 = v14 + 48 + 7 + 16 + 12
	local v19 = math.max(v18 + 160 + 12 + v15, v16 + 48, v17 + 48, 408)
	local v20 = v19 - v18 - 12 - v15
	local v21 = v19 - 48
	v10 = v19 + 32

	for i, entry in ipairs(list) do
		local v22 = v4[i]

		if not v22 then
			v22 = NewCompactRow(i)
			v4[i] = v22
		end

		local barHolder = v22.Slot:FindFirstChild("MainRow"):FindFirstChild("BarHolder")
		v22.Entry = entry
		v22.Slot.Visible = true
		v22.NameLabel.Text = entry.DisplayName
		v22.NameLabel.Size = UDim2.new(0, v14, 1, 0)
		local pinIcon = v22.PinIcon
		pinIcon.Position = UDim2.new(0, GetTextWidth(entry.DisplayName, textSize) + 48 + 7, 0.5, 0) -- inferred equivalent call
		barHolder.Position = UDim2.new(0, v18, 0.5, 0)
		barHolder.Size = UDim2.fromOffset(v20, 22)
		v22.FillTimeLabel.Size = UDim2.new(0, v20 - 16, 1, 0)
		v22.AliveLabel.Size = UDim2.new(0, v15, 1, 0)
		v22.StatsLabel.Text = entry.StatsText
		local total = 28

		if TroopDetailsUtilities.HasDetails(entry.DetailRows) then
			total += BuildDetails(v22.DetailsFrame, entry.DetailRows, v21) + 12
		else
			BuildDetails(v22.DetailsFrame, {}, v21)
		end

		v22.ExpandedExtra = total
		UpdateViewport(v22, entry.PathEntityType, p.SkinName)
		UpdateTimerView(v22)
	end

	for i = #list + 1, #v4 do
		v4[i].Entry = nil
		v4[i].Slot.Visible = false
		ResetExpansion(v4[i]) -- inferred equivalent call
	end

	local v22 = v5
	v22.Size = UDim2.fromOffset(v10, v22.Size.Y.Offset)
	v22.Visible = true
end

local function GetActiveViews() -- 2 equivalent calls inferred from this helper
	local v14 = v9 and v4 or v3
	local result = {}

	for i = 1, v8 do
		table.insert(result, v14[i])
	end

	return result
end

local function GetMousePosition() -- 1 equivalent call inferred from this helper
	local mouseLocation = UserInputService:GetMouseLocation()

	if not interface.IgnoreGuiInset then
		mouseLocation -= GuiService:GetGuiInset()
	end

	return mouseLocation
end

local function GetInputPosition(input) -- 2 equivalent calls inferred from this helper
	local vector = Vector2.new(input.Position.X, input.Position.Y)

	if interface.IgnoreGuiInset then
		vector += GuiService:GetGuiInset()
	end

	return vector
end

local function IsOver(slot, point: Vector2) -- 1 equivalent call inferred from this helper
	local absolutePosition = slot.AbsolutePosition
	local v14 = absolutePosition + slot.AbsoluteSize
	return point.X >= absolutePosition.X and point.X <= v14.X and point.Y >= absolutePosition.Y and point.Y <= v14.Y
end

local function CloseAll() -- 2 equivalent calls inferred from this helper
	v11 = nil
	v12 = nil
	v13 = nil
end

local function GetSettledViewAt(list, p, point: Vector2)
	local slot = list[1].Slot
	local v14 = slot.AbsoluteSize.Y / slot.Size.Y.Offset
	local v15 = v9 and 36 or 118
	local v16 = 10
	local x = slot.AbsolutePosition.X
	local v17 = x + slot.AbsoluteSize.X
	local y = slot.AbsolutePosition.Y

	if point.X < x or v17 < point.X or point.Y < y then
		return nil, false
	end

	for _, v18 in ipairs(list) do
		local v19 = y + v14 * (v15 + (v18 ~= p and v18 ~= v12 and 0 or v18.ExpandedExtra or 0))

		if point.Y <= v19 then
			return y <= point.Y and v18 or nil, true
		else
			y = v19 + v14 * v16
		end
	end

	return nil, false
end

local function UpdateHoverOpenView(list)
	if IsTouchOnly() then -- inferred equivalent call
		v11 = nil
		return
	end

	if v11 and not table.find(list, v11) then
		v11 = nil
	end

	local mousePosition = GetMousePosition() -- inferred equivalent call
	local v14, v15 = GetSettledViewAt(list, v11, mousePosition)

	if v13 and v14 ~= v13 then
		v13 = nil
	end

	if v14 then
		if v14 == v11 then
			return
		end

		if v14 == v12 or v14 == v13 then
			v11 = nil
		elseif GetSettledViewAt(list, v14, mousePosition) == v14 then
			v11 = v14
		else
			v11 = nil
		end
	elseif not v15 then
		v11 = nil
	end
end

local function UpdateExpansion(list, p: number)
	UpdateHoverOpenView(list)

	for _, v14 in ipairs(list) do
		local spring = v14.Spring
		spring.Target = v14 ~= v11 and v14 ~= v12 and 0 or v14.ExpandedExtra or 0
		v14.PinIcon.Visible = v14 == v12
		StepSpring(spring, p)
		v14.ApplyExtra(GetDisplayedExtra(spring)) -- inferred equivalent call
	end
end

local function GetClosedStackHeight() -- 2 equivalent calls inferred from this helper
	if v9 then
		return v8 * 36 + 32 + math.max(0, v8 - 1) * 10
	end

	return v8 * 118 + math.max(0, v8 - 1) * 10
end

local function GetStackTopY() -- 2 equivalent calls inferred from this helper
	if currentStats.Visible then
		local position = currentStats.Position
		local size = currentStats.Size
		return position.Y.Offset + (1 - currentStats.AnchorPoint.Y) * size.Y.Offset + 10
	else
		return (math.max(150, 272 - GetClosedStackHeight() / 2)) -- inferred equivalent call
	end
end

local function IsInUpgradeHoverWay(list)
	if not upgradeHover.Visible then
		return false
	end

	local v14 = upgradeHover.Position.Y.Offset - upgradeHover.AnchorPoint.Y * upgradeHover.Size.Y.Offset
	local v15 = v14 + upgradeHover.Size.Y.Offset
	local stackTopY = GetStackTopY() -- inferred equivalent call
	local v16 = stackTopY + GetClosedStackHeight() -- inferred equivalent call

	if v12 and table.find(list, v12) then
		v16 += v12.ExpandedExtra
	end

	return v14 < v16 + 10 and stackTopY - 10 < v15
end

local function UpdateStackSize(list)
	local total = 0

	for _, v14 in ipairs(list) do
		total += v14.Slot.Size.Y.Offset
	end

	if not v9 then
		return total + math.max(0, v8 - 1) * 10
	end

	local v14 = total + 32 + math.max(0, v8 - 1) * 10
	v5.Size = UDim2.fromOffset(v10, v14)
	return v14
end

local function UpdatePosition(p: number) -- 1 equivalent call inferred from this helper
	frame.Position = UDim2.new(1, 0, 0, GetStackTopY()) -- inferred equivalent call
	frame.Size = UDim2.new(0, v10, 0, p)
end

function SpawnTimersDisplayHandler.Show(p, list)
	if p ~= v7 then
		CloseAll() -- inferred equivalent call

		for _, v14 in ipairs(v3) do
			ResetExpansion(v14) -- inferred equivalent call
		end

		for _, v14 in ipairs(v4) do
			ResetExpansion(v14) -- inferred equivalent call
		end
	end

	v7 = p
	v8 = #list
	v9 = v8 >= 5

	if v9 then
		ShowFullCards(p, {})
		ShowCompactCard(p, list)
	else
		if v5 then
			v5.Visible = false
		end

		ShowFullCards(p, list)
	end

	SpawnTimersDisplayHandler.Update()
end

function SpawnTimersDisplayHandler.Update()
	local now2 = os.clock()
	local v14 = math.min(now2 - now, 0.05)
	now = now2
	frame.Visible = v8 > 0

	if not frame.Visible then
		return
	end

	local activeViews = GetActiveViews() -- inferred equivalent call

	if towerUI.Visible then
		if IsInUpgradeHoverWay(activeViews) then
			frame.Visible = false
			v11 = nil

			for _, v15 in ipairs(activeViews) do
				if v15 ~= v12 and v15.Spring.Position ~= 0 then
					ResetExpansion(v15) -- inferred equivalent call
				end
			end
		else
			UpdateExpansion(activeViews, v14)
			UpdatePosition(UpdateStackSize(activeViews)) -- inferred equivalent call

			for _, v15 in ipairs(activeViews) do
				UpdateTimerView(v15)
			end
		end
	else
		CloseAll() -- inferred equivalent call

		for _, v15 in ipairs(activeViews) do
			if v15.Spring.Position ~= 0 then
				ResetExpansion(v15) -- inferred equivalent call
			end
		end
	end
end

local function GetViewAt(point: Vector2)
	if not (frame.Visible and towerUI.Visible) then
		return nil
	end

	local activeViews = GetActiveViews() -- inferred equivalent call

	for _, v14 in ipairs(activeViews) do
		if IsOver(v14.Slot, point) then -- inferred equivalent call
			return v14
		end
	end

	return nil
end

local function CanStartPin(p, flag: boolean)
	return flag or p == v11 or p == v12 or p == v13
end

local function HandlePinClick(point: Vector2, view, onCard: boolean) -- 1 equivalent call inferred from this helper
	local viewAt = GetViewAt(point)

	if viewAt then
		if viewAt ~= view then
			return
		end

		if v12 == viewAt then
			v12 = nil
			v13 = viewAt
		else
			v12 = viewAt
		end

		v11 = nil
	elseif not onCard then
		v12 = nil
	end
end

local v14 = {}

local function GetPressKey(input) -- 2 equivalent calls inferred from this helper
	if input.UserInputType == Enum.UserInputType.Touch then
		return input
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		return Enum.UserInputType.MouseButton1
	end

	return nil
end

UserInputService.InputBegan:Connect(function(input)
	local pressKey = GetPressKey(input) -- inferred equivalent call

	if pressKey then
		local position = GetInputPosition(input) -- inferred equivalent call
		local viewAt = GetViewAt(position)
		local v15 = input.UserInputType == Enum.UserInputType.Touch
		local v16 = v14
		local v17 = { Position = position, Time = os.clock(), View = 0, OnCard = 0 }
		local view

		if viewAt then
			view = (v15 or viewAt == v11 or viewAt == v12 or viewAt == v13) and viewAt or nil
		end

		v17.View = view
		v17.OnCard = viewAt ~= nil
		v16[pressKey] = v17
	end
end)
UserInputService.InputEnded:Connect(function(input)
	local pressKey = GetPressKey(input) -- inferred equivalent call

	if not pressKey then
		return
	end

	local v15 = v14[pressKey]
	v14[pressKey] = nil

	if not v15 or os.clock() - v15.Time > 0.35 then
		return
	end

	local inputPosition = GetInputPosition(input) -- inferred equivalent call

	if (inputPosition - v15.Position).Magnitude <= 12 then
		HandlePinClick(inputPosition, v15.View, v15.OnCard) -- inferred equivalent call
	end
end)
return SpawnTimersDisplayHandler