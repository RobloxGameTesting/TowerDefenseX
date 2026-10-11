local BarButtonClass = {}
BarButtonClass.__index = BarButtonClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
require(Common:WaitForChild("SkinHandler"))
local TowerUtilities = require(Common:WaitForChild("TowerUtilities"))
local Keybinds = require(Common:WaitForChild("Keybinds"))
local SkinData = TDX_Shared:WaitForChild("SkinData")
local SkinUtilities = require(SkinData:WaitForChild("SkinUtilities"))
local InitialStatsDisplayHandler = require(script.Parent:WaitForChild("InitialStatsDisplayHandler"))
local parent = script.Parent.Parent.Parent
local gameClass = parent:WaitForChild("GameClass")
local PlayerClass = require(parent:WaitForChild("PlayerClass"))
local Data = require(TDX_Shared.Client.Services.Data)
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local udim = UDim2.new(1, 0, 1, 0)
local udim2 = UDim2.new(1, 10, 1, 10)
local udim3 = UDim2.new(1, 10, 1, 10)
local udim4 = UDim2.new(0.5, 0, 1.05, 0)
local udim5 = UDim2.new(0.5, 0, 1.1, 0)
local udim6 = UDim2.new(0.5, 0, 1.1, 0)
local color = Color3.fromRGB(240, 240, 240)
local color2 = Color3.fromRGB(255, 255, 255)
local color3 = Color3.fromRGB(188, 188, 188)
local udim7 = UDim2.new(1.05, 0, 1.15, 0)
local udim8 = UDim2.new(0.5, 0, 0.475, 0)
local v = NetworkingHandler.GetFunction("AdminSetSkin")
local v2 = NetworkingHandler.GetFunction("AdminLoadoutChanged")
local event = BindableHandler.GetEvent("StartTowerPlacement")
local event2 = BindableHandler.GetEvent("RefreshTowersBar")
local event3 = BindableHandler.GetEvent("LoadoutChangedWithAdmin")
local towersBar = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BottomBar"):WaitForChild("TowersBar")
local towerTemplate = towersBar:WaitForChild("TowerTemplate")
local flag = true
local v3 = nil
local v4 = nil
local v5 = nil

function BarButtonClass.New(p: number, p2, p3)
	local clone = (p3 or towerTemplate):Clone()
	local button = clone:FindFirstChild("Button")
	local mainFrame = clone:FindFirstChild("MainFrame")
	local number = mainFrame:FindFirstChild("Number")
	local background = mainFrame:FindFirstChild("Background")
	local costFrame = clone:FindFirstChild("CostFrame")
	local costText = costFrame:FindFirstChild("CostText")
	local background2 = costFrame:FindFirstChild("Background")
	local newTowerTextBox = clone:FindFirstChild("NewTowerTextBox")
	local tutorialGuide = clone:FindFirstChild("TutorialGuide")
	tutorialGuide:SetAttribute("TutorialElementId", "TowerBarButton" .. p)

	if p > 10 then
		number.Text = ""
	else
		Keybinds.BindLabel(number, `SelectTower{p}`)
	end

	costText.Text = "$" .. 0
	clone.Parent = p2 or towersBar
	button.SelectionOrder = p - 100
	local v6 = {
		Index = p,
		Hovered = false,
		Clicked = false,
		Selected = false,
		Enabled = true,
		TowerFrame = clone,
		TowerButton = button,
		MainFrame = mainFrame,
		MainFrameBackground = background,
		CostFrame = costFrame,
		CostFrameBackground = background2,
		CostLabel = costText,
		TowerName = nil,
		Viewport = nil,
		TutorialGuide = tutorialGuide,
		TutorialArrow = tutorialGuide:FindFirstChild("Arrow"),
		TutorialArrowGlow = tutorialGuide:FindFirstChild("ArrowGlow"),
		TutorialBorder = tutorialGuide:FindFirstChild("Border")
	}
	setmetatable(v6, BarButtonClass)
	button.Activated:Connect(function()
		v6:MouseButton1Clicked()
	end)
	button.MouseButton1Down:Connect(function()
		v6:MouseButton1Down()
	end)
	button.MouseButton1Up:Connect(function()
		v6:MouseButton1Up()
	end)
	button.MouseEnter:Connect(function()
		v6:MouseEnter()
	end)
	button.MouseLeave:Connect(function()
		v6:MouseLeave()
	end)
	button.SelectionGained:Connect(function()
		v6:MouseEnter()
	end)
	button.SelectionLost:Connect(function()
		v6:MouseLeave()
	end)
	button.MouseButton2Click:Connect(function()
		if not PlayerClass.LocalPlayerHasAdminPanelAccess() then
			return
		end

		local v7 = not flag
		flag = true
		newTowerTextBox.BackgroundColor3 = Color3.fromRGB(148, 255, 147)
		newTowerTextBox.PlaceholderText = "Enter tower name"
		newTowerTextBox.Visible = v7 or not newTowerTextBox.Visible

		if newTowerTextBox.Visible then
			newTowerTextBox:CaptureFocus()
		else
			newTowerTextBox:ReleaseFocus()
		end
	end)
	button.MouseWheelBackward:Connect(function()
		if not PlayerClass.LocalPlayerHasAdminPanelAccess() then
			return
		end

		local v7 = flag
		flag = false
		newTowerTextBox.BackgroundColor3 = Color3.fromRGB(255, 200, 137)
		newTowerTextBox.PlaceholderText = "Enter skin name"
		newTowerTextBox.Visible = v7 or not newTowerTextBox.Visible

		if newTowerTextBox.Visible then
			newTowerTextBox:CaptureFocus()
		else
			newTowerTextBox:ReleaseFocus()
		end
	end)
	newTowerTextBox.FocusLost:Connect(function(flag2: boolean)
		if not PlayerClass.LocalPlayerHasAdminPanelAccess() then
			return
		end

		newTowerTextBox.Visible = false

		if not (flag2 and newTowerTextBox.Text ~= "") then
			return
		end

		if flag then
			local text = newTowerTextBox.Text

			if text ~= "" then
				v2:InvokeServer("Tower", text)
				v6:SetTower(text)
				event3:Fire(v6.Index, v6.TowerName)
			end
		else
			local towerName = v6.TowerName
			local text = newTowerTextBox.Text
			local v7 = text == " " and "" or text

			if SkinUtilities.ValidateTowerSkinCombination(towerName, v7) then
				v:InvokeServer(towerName, v7)
				event2:Fire(towerName)
			end
		end
	end)
	local total = 0
	RunService.Heartbeat:Connect(function(dt: number)
		if not v3 then
			return
		end

		total += dt

		if tutorialGuide.Visible then
			v6.TutorialArrowGlow.ImageTransparency = math.sin(total * 3 * 3.141592653589793)
		else
			total = 0
		end
	end)
	v6:StateChanged()
	v6:Deselect()
	return v6
end

function BarButtonClass.SetTutorialMode(flag2: boolean?)
	v3 = flag2
	v4 = false
end

function BarButtonClass.EnableTutorialFreebuild()
	v4 = true
end

function BarButtonClass.SetTutorialForceIndex(p: number?)
	v5 = p
end

function BarButtonClass:CheckIsEnabledForTutorial()
	if v3 and not v4 then
		if v5 then
			return self.Index == v5
		end

		return false
	else
		return true
	end
end

function BarButtonClass:MouseButton1Clicked()
	if self.Enabled and self:CheckIsEnabledForTutorial() and self.TowerName then
		event:Fire(self.Index, self.TowerName)
	end
end

function BarButtonClass:MouseButton1Down()
	if self.Enabled and self:CheckIsEnabledForTutorial() then
		self.Clicked = true
		self:StateChanged()
	end
end

function BarButtonClass:MouseButton1Up()
	if self.Enabled and self:CheckIsEnabledForTutorial() then
		self.Clicked = false
		self:StateChanged()
	end
end

function BarButtonClass:MouseEnter()
	if not (self.Enabled and self:CheckIsEnabledForTutorial()) then
		return
	end

	self.Hovered = true
	self:StateChanged()
	InitialStatsDisplayHandler.Show(self)
end

function BarButtonClass:MouseLeave()
	self.Clicked = false
	self.Hovered = false
	self:StateChanged()
	InitialStatsDisplayHandler.Hide()
end

function BarButtonClass:StateChanged()
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

	self:SelectedStateChanged()
end

function BarButtonClass:SelectedStateChanged()
	local costFrameBackground = self.CostFrameBackground

	if self.Selected then
		costFrameBackground.ImageColor3 = color3
	elseif self.Hovered then
		costFrameBackground.ImageColor3 = color2
	else
		costFrameBackground.ImageColor3 = color
	end

	self.TutorialArrow.Visible = not self.Selected
	self.TutorialArrowGlow.Visible = not self.Selected
	self.TutorialBorder.Visible = not self.Selected
end

function BarButtonClass:PlayClickedAnimation()
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

function BarButtonClass:Select()
	self.Selected = true
	self:SelectedStateChanged()

	if RunService:IsStudio() and self.Viewport then
		self.Viewport:SetAttribute("CaptureSelectedAt", os.clock())
	end
end

function BarButtonClass:Deselect()
	self.Selected = false
	self:SelectedStateChanged()
end

function BarButtonClass.IsSelected(p)
	return p.Selected
end

function BarButtonClass.GetTower(p)
	return p.TowerName
end

function BarButtonClass:SetTower(p: string)
	if self.Viewport then
		self.Viewport:Destroy()
	end

	local v6

	if p == "" then
		v6 = false
	else
		v6 = ResourceManager.GetTowerConfig(p)
	end

	if not v6 then
		self:Disable()
		return
	end

	local v7 = Data.Get("TowerSkins")[p]
	self.Viewport = TowerUtilities.GetViewport(self.MainFrame, p, v7, nil, nil, nil, nil, nil, true)
	self.TowerFrame.Name = p
	self.TowerName = p

	if self.Viewport then
		self.Viewport.Size = udim7
		self.Viewport.Position = udim8
		self.Viewport.ZIndex = 3
	else
		warn("No viewport found for tower: " .. p)
	end

	self:RefreshCost()
	self.CostFrame.Visible = true
	self.Enabled = true
	self:StateChanged()
	self:Deselect()
end

function BarButtonClass:RefreshCost()
	local towerName = self.TowerName or ""
	local v6

	if towerName == "" then
		v6 = false
	else
		v6 = ResourceManager.GetTowerConfig(towerName)
	end

	if not v6 then
		self:Disable()
		return
	end

	local cost = v6.UpgradePathData.BaseLevelData.Cost
	local module = require(gameClass)
	local v7 = cost * module.GetTowerCostMultiplier(towerName)
	self.CostLabel.Text = "$" .. tostring((math.ceil(v7)))
end

function BarButtonClass:Disable()
	if self.Viewport then
		self.Viewport:Destroy()
	end

	self.CostFrame.Visible = false
	self.Enabled = false
end

return BarButtonClass