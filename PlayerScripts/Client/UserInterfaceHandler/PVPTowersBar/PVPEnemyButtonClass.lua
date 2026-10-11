local PVPEnemyButtonClass = {}
PVPEnemyButtonClass.__index = PVPEnemyButtonClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local EnemyViewport = require(common:WaitForChild("EnemyViewport"))
local Keybinds = require(common:WaitForChild("Keybinds"))
local PlayerClass = require(script.Parent.Parent.Parent:WaitForChild("PlayerClass"))
local PVPInitialStatsDisplayHandler = require(script.Parent:WaitForChild("PVPInitialStatsDisplayHandler"))
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local udim = UDim2.new(1, 0, 1, 0)
local udim2 = UDim2.new(1, 10, 1, 10)
local udim3 = UDim2.new(1, 10, 1, 10)
local udim4 = UDim2.new(0.5, 0, 1.05, 0)
local udim5 = UDim2.new(0.5, 0, 1.1, 0)
local udim6 = UDim2.new(0.5, 0, 1.1, 0)
local color = Color3.fromRGB(0, 255, 0)
local color2 = Color3.fromRGB(255, 0, 0)
local v = { Size = UDim2.new(1.05, 0, 1.15, 0), Position = UDim2.new(0.5, 0, 0.475, 0) }
local event = BindableHandler.GetEvent("RequestSendPVPEnemy")
local event2 = BindableHandler.GetEvent("PVPEnemyLoadoutChangedWithAdmin")
local event3 = BindableHandler.GetEvent("TogglePVPAutoSend")
local v2 = NetworkingHandler.GetFunction("AdminLoadoutChanged")
local color3 = Color3.fromRGB(255, 187, 255)

function PVPEnemyButtonClass.New(p: number, parent, instance)
	local clone = instance:Clone()
	local button = clone:FindFirstChild("Button")
	local mainFrame = clone:FindFirstChild("MainFrame")
	local number = mainFrame:FindFirstChild("Number")
	local auto = mainFrame:FindFirstChild("Auto")
	local backgroundEnabled = mainFrame:FindFirstChild("BackgroundEnabled")
	local backgroundDisabled = mainFrame:FindFirstChild("BackgroundDisabled")
	local lockIcon = backgroundDisabled and backgroundDisabled:FindFirstChild("LockIcon")
	local categories = mainFrame:FindFirstChild("Categories")
	local category = categories and categories:FindFirstChild("Category")
	local subcategory = categories and categories:FindFirstChild("Subcategory")
	local bottomRows = mainFrame:FindFirstChild("BottomRows")
	local buildDurationRow = bottomRows and bottomRows:FindFirstChild("BuildDurationRow")
	local time = buildDurationRow and buildDurationRow:FindFirstChild("Time")
	local sendEcoRow = bottomRows and bottomRows:FindFirstChild("SendEcoRow")
	local costFrame = clone:FindFirstChild("CostFrame")
	local backgroundEnabled2 = costFrame:FindFirstChild("BackgroundEnabled")
	local backgroundDisabled2 = costFrame:FindFirstChild("BackgroundDisabled")
	local costText = backgroundEnabled2 and backgroundEnabled2:FindFirstChild("CostText")
	local waveText = backgroundDisabled2 and backgroundDisabled2:FindFirstChild("WaveText")
	local tutorialGuide = clone:FindFirstChild("TutorialGuide")

	if tutorialGuide then
		tutorialGuide:SetAttribute("TutorialElementId", "PVPEnemyBarButton" .. p)
	end

	local newEnemyTextBox = clone:FindFirstChild("NewEnemyTextBox", true)
		or clone:FindFirstChildWhichIsA("TextBox", true)

	if number then
		if p > 10 then
			number.Text = ""
		else
			Keybinds.BindLabel(number, `SelectTower{p}`)
		end
	end

	if costText then
		costText.Text = "$0"
	end

	if buildDurationRow then
		buildDurationRow.Visible = false
	end

	if auto then
		auto.Visible = false
	end

	if sendEcoRow then
		sendEcoRow.Visible = false
	end

	clone.Parent = parent
	button.SelectionOrder = p - 100
	local v3 = {
		Index = p,
		Hovered = false,
		Clicked = false,
		Enabled = true,
		Locked = false,
		BuildDuration = 0,
		SendEco = 0,
		EnemyFrame = clone,
		EnemyButton = button,
		MainFrame = mainFrame,
		MainBackgroundEnabled = backgroundEnabled,
		MainBackgroundDisabled = backgroundDisabled,
		LockIcon = lockIcon,
		AutoLabel = auto,
		HoldGeneration = 0,
		SuppressNextActivate = false,
		CategoriesFrame = categories,
		CategoryIcon = category,
		SubcategoryIcon = subcategory,
		BuildDurationRow = buildDurationRow,
		TimeLabel = time,
		SendEcoRow = sendEcoRow,
		CostFrame = costFrame,
		CostBackgroundEnabled = backgroundEnabled2,
		CostBackgroundDisabled = backgroundDisabled2,
		CostLabel = costText,
		WaveLabel = waveText,
		TutorialGuide = tutorialGuide,
		EnemyName = nil,
		UnlockWave = 0,
		SendCost = 0,
		IsBoss = false,
		Viewport = nil
	}
	setmetatable(v3, PVPEnemyButtonClass)
	button.Activated:Connect(function()
		v3:MouseButton1Clicked()
	end)
	button.MouseButton1Down:Connect(function()
		v3:MouseButton1Down()
	end)
	button.MouseButton1Up:Connect(function()
		v3:MouseButton1Up()
	end)
	button.MouseEnter:Connect(function()
		v3:MouseEnter()
	end)
	button.MouseLeave:Connect(function()
		v3:MouseLeave()
	end)
	button.SelectionGained:Connect(function()
		v3:MouseEnter()
	end)
	button.SelectionLost:Connect(function()
		v3:MouseLeave()
	end)

	if newEnemyTextBox then
		newEnemyTextBox.Visible = false
		button.MouseButton2Click:Connect(function()
			if not PlayerClass.LocalPlayerHasAdminPanelAccess() then
				return
			end

			newEnemyTextBox.BackgroundColor3 = color3
			newEnemyTextBox.PlaceholderText = "Enter enemy name"
			newEnemyTextBox.Visible = not newEnemyTextBox.Visible

			if newEnemyTextBox.Visible then
				newEnemyTextBox:CaptureFocus()
			else
				newEnemyTextBox:ReleaseFocus()
			end
		end)
		newEnemyTextBox.FocusLost:Connect(function(flag: boolean)
			if not PlayerClass.LocalPlayerHasAdminPanelAccess() then
				return
			end

			newEnemyTextBox.Visible = false

			if not flag then
				return
			end

			local text = newEnemyTextBox.Text

			if text == "" then
				return
			end

			v2:InvokeServer("Enemy", text)
			event2:Fire(v3.Index, text)
		end)
	end

	v3:RefreshLockedVisuals()
	v3:StateChanged()
	return v3
end

function PVPEnemyButtonClass:StateChanged()
	local mainFrame = self.MainFrame
	local costFrame = self.CostFrame

	if self.Clicked then
		TweenService:Create(mainFrame, tweenInfo2, { Size = udim3 }):Play()
		TweenService:Create(costFrame, tweenInfo2, { Position = udim6 }):Play()
	elseif self.Hovered then
		TweenService:Create(mainFrame, tweenInfo2, { Size = udim2 }):Play()
		TweenService:Create(costFrame, tweenInfo2, { Position = udim5 }):Play()
	else
		TweenService:Create(mainFrame, tweenInfo, { Size = udim }):Play()
		TweenService:Create(costFrame, tweenInfo, { Position = udim4 }):Play()
	end
end

function PVPEnemyButtonClass:RefreshLockedVisuals()
	if self.MainBackgroundEnabled then
		self.MainBackgroundEnabled.Visible = not self.Locked
	end

	if self.MainBackgroundDisabled then
		self.MainBackgroundDisabled.Visible = self.Locked
	end

	if self.CostBackgroundEnabled then
		self.CostBackgroundEnabled.Visible = not self.Locked
	end

	if self.CostBackgroundDisabled then
		self.CostBackgroundDisabled.Visible = self.Locked
	end

	if self.LockIcon then
		self.LockIcon.Visible = self.Locked
	end
end

function PVPEnemyButtonClass:PlayClickedAnimation()
	local mainFrame = self.MainFrame
	local costFrame = self.CostFrame
	local tween = TweenService:Create(mainFrame, tweenInfo2, { Size = udim3 })
	tween.Completed:Connect(function(p)
		if p == Enum.PlaybackState.Completed then
			self:StateChanged()
		end
	end)
	tween:Play()
	TweenService:Create(costFrame, tweenInfo2, { Position = udim6 }):Play()
end

function PVPEnemyButtonClass:MouseButton1Clicked()
	if self.SuppressNextActivate then
		self.SuppressNextActivate = false
	elseif self.Enabled and self.EnemyName then
		event:Fire(self.Index, self.EnemyName)
	end
end

function PVPEnemyButtonClass:MouseButton1Down()
	if not self.Enabled or self.Locked then
		return
	end

	self.Clicked = true
	self:StateChanged()
	self.HoldGeneration += 1
	local holdGeneration = self.HoldGeneration
	task.delay(0.8, function()
		if self.Clicked and self.HoldGeneration == holdGeneration and self.EnemyName then
			self.SuppressNextActivate = true
			self:PlayClickedAnimation()
			event3:Fire(self.Index)
		end
	end)
end

function PVPEnemyButtonClass:MouseButton1Up()
	if self.Enabled and not self.Locked then
		self.Clicked = false
		self:StateChanged()
	end
end

function PVPEnemyButtonClass:MouseEnter()
	if not self.Enabled then
		return
	end

	self.Hovered = true
	self:StateChanged()
	PVPInitialStatsDisplayHandler.Show({ EnemyName = self.EnemyName, Anchor = self.EnemyFrame })
end

function PVPEnemyButtonClass:MouseLeave()
	self.Clicked = false
	self.Hovered = false
	self.SuppressNextActivate = false
	self:StateChanged()
	PVPInitialStatsDisplayHandler.Hide()
end

function PVPEnemyButtonClass.SetAutoSendVisual(p, visible: boolean)
	if p.AutoLabel then
		p.AutoLabel.Visible = visible
	end
end

function PVPEnemyButtonClass:SetLocked(locked: boolean, p: number?)
	self.Locked = locked

	if locked and self.WaveLabel then
		self.WaveLabel.Text = p and "Wave " .. tostring(p) or "Locked"
	end

	self:RefreshLockedVisuals()
end

function PVPEnemyButtonClass.FormatBuildSeconds(p: number, p2: number)
	local v3 = 10 ^ p2
	return (tostring(math.ceil(p * v3 - 1e-9) / v3))
end

function PVPEnemyButtonClass:SetBuildDuration(p: number)
	self.BuildDuration = math.max(0, p)

	if self.BuildDurationRow then
		self.BuildDurationRow.Visible = self.BuildDuration > 0
	end

	if self.TimeLabel and self.BuildDuration > 0 then
		self.TimeLabel.Text = PVPEnemyButtonClass.FormatBuildSeconds(self.BuildDuration, 2)
	end
end

function PVPEnemyButtonClass.StyleSendEcoRow(instance, p: number)
	local visible = p >= 0
	local eco = instance:FindFirstChild("Eco")

	if eco then
		eco.Text = tostring((math.abs(p)))
		eco.TextColor3 = visible and color or color2
	end

	local triangleIconFrame = instance:FindFirstChild("TriangleIconFrame")
	local triangleIconPositive = triangleIconFrame and triangleIconFrame:FindFirstChild("TriangleIconPositive")
	local triangleIconNegative = triangleIconFrame and triangleIconFrame:FindFirstChild("TriangleIconNegative")

	if triangleIconPositive then
		triangleIconPositive.Visible = visible
	end

	if triangleIconNegative then
		triangleIconNegative.Visible = not visible
	end
end

function PVPEnemyButtonClass:SetSendEco(sendEco: number)
	self.SendEco = sendEco

	if self.SendEcoRow then
		self.SendEcoRow.Visible = true
		PVPEnemyButtonClass.StyleSendEcoRow(self.SendEcoRow, sendEco)
	end
end

function PVPEnemyButtonClass:RefreshCategories()
	if self.CategoriesFrame then
		self.CategoriesFrame.Visible = false
	end
end

function PVPEnemyButtonClass:SetEnemy(p: string, value: number?)
	local enemyConfig = ResourceManager.FindEnemyConfig(p)

	if not enemyConfig then
		self:Disable()
		return
	end

	self.Viewport = EnemyViewport.Build(self.MainFrame, p, v)
	self.EnemyFrame.Name = p
	self.EnemyFrame.Visible = true
	self.EnemyName = p
	self.UnlockWave = enemyConfig.UnlockWave or 0
	self.SendCost = enemyConfig.SendCost or 0
	self.IsBoss = (enemyConfig.IsBoss or enemyConfig.IsMiniBoss) == true
	self:SetBuildDuration(enemyConfig.BuildDuration or 0)
	self:SetSendEco(enemyConfig.SendEco or 0)
	self:RefreshCategories()
	self:RefreshCost()
	self.Enabled = true
	self:RefreshLockState(value or 0)
	self:StateChanged()
end

function PVPEnemyButtonClass:RefreshLockState(p: number)
	if not self.EnemyName then
		return
	end

	local unlockWave = self.UnlockWave or 0
	self:SetLocked(p < unlockWave, unlockWave)
end

function PVPEnemyButtonClass:RefreshCost()
	if not self.EnemyName then
		return
	end

	if self.CostLabel then
		self.CostLabel.Text = "$" .. tostring((math.ceil(self.SendCost or 0)))
	end
end

function PVPEnemyButtonClass.GetSendCost(p)
	return p.SendCost or 0
end

function PVPEnemyButtonClass:Disable()
	if self.Viewport then
		self.Viewport:Destroy()
		self.Viewport = nil
	end

	self.Enabled = false
	self.EnemyName = nil
	self.EnemyFrame.Visible = false
end

return PVPEnemyButtonClass