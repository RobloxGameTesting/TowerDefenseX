local UpgradePathClass = {}
UpgradePathClass.__index = UpgradePathClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local parent = script.Parent
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local parent2 = script.Parent.Parent.Parent
local gameClass = parent2:WaitForChild("GameClass")
local PlayerClass = require(parent2:WaitForChild("PlayerClass"))
local UpgradeHoverHandler = require(script.Parent:WaitForChild("UpgradeHoverHandler"))
local StatsDisplayHandler = require(script.Parent:WaitForChild("StatsDisplayHandler"))
local MaxButtonClass = require(script.Parent:WaitForChild("MaxButtonClass"))
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(225, 225, 225)
local event = NetworkingHandler.GetEvent("TowerUpgradeRequest")
local event2 = BindableHandler.GetEvent("CashChanged")
local event3 = BindableHandler.GetEvent("HotkeyUpgradeTower")
local event4 = BindableHandler.GetEvent("NoCashError")
local event5 = BindableHandler.GetEvent("ErrorPrompt")
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local v = nil
local v2 = nil

local function GetTowerUIHandler() -- 3 equivalent calls inferred from this helper
	if not v then
		local module = require(parent)
		v = module
	end

	return v
end

local function GetGameClass() -- 1 equivalent call inferred from this helper
	if not v2 then
		local module = require(gameClass)
		v2 = module
	end

	return v2
end

local towerUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TowerUI")
local path1Button = towerUI:WaitForChild("Path1Button")
local path2Button = towerUI:WaitForChild("Path2Button")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil

local function NewTickHandler(ticks)
	local count = 0
	local images = {}

	for _, image in pairs(ticks:GetChildren()) do
		if not image:IsA("ImageLabel") then
			continue
		end

		count += 1
		images[count] = image
		image.LayoutOrder = count
		image.Image = "rbxassetid://10386176353"
	end

	return {
		Ticks = images,
		Update = function(p, p2)
			for i = 1, #p.Ticks do
				if i <= p2 then
					p.Ticks[i].Image = "rbxassetid://10386176449"
				else
					p.Ticks[i].Image = "rbxassetid://10386176353"
				end
			end
		end,
		Empty = function(self)
			for i = 1, #self.Ticks do
				self.Ticks[i].Image = "rbxassetid://10386176353"
			end
		end,
		Hovered = function(self, _) end,
		Unhovered = function(self, _) end
	}
end

function UpgradePathClass._New(instance, path: number)
	local background = instance:WaitForChild("Background")
	local upgradeImage = instance:WaitForChild("UpgradeImage")
	local costText = instance:WaitForChild("CostText")
	local descriptionText = instance:WaitForChild("DescriptionText")
	local descriptionBackground = instance:WaitForChild("DescriptionBackground")
	local lockedOverlay = instance:WaitForChild("LockedOverlay")
	local hoverUIScale = instance:WaitForChild("HoverUIScale")
	local upgradeImageBackground = instance:WaitForChild("UpgradeImageBackground")
	local plusIcon = instance:WaitForChild("PlusIcon")
	local realButton = instance:WaitForChild("RealButton")
	local maxButton = MaxButtonClass.New(instance:WaitForChild("MaxButton"), path)
	local tutorialGuide = instance:FindFirstChild("TutorialGuide")
	tutorialGuide:SetAttribute("TutorialElementId", "TowerUpgrade" .. path)
	local uiAspectRatioConstraint = upgradeImage:FindFirstChildOfClass("UIAspectRatioConstraint")
	realButton.SelectionOrder = path - 1000
	local v11 = {
		TowerName = nil,
		Path = path,
		Enabled = true,
		MaxLevelReached = false,
		OwnedByLocalPlayer = false,
		Hovered = false,
		OnePathOnly = false,
		OnePathPosition = instance:GetAttribute("OnePathPosition"),
		TwoPathPosition = instance:GetAttribute("TwoPathPosition"),
		TickHandler = NewTickHandler(instance:WaitForChild("Ticks")),
		UpgradeButton = instance,
		ButtonBackground = background,
		UpgradeImage = upgradeImage,
		CostText = costText,
		DescriptionText = descriptionText,
		DescriptionBackground = descriptionBackground,
		LockedOverlay = lockedOverlay,
		HoverUIScale = hoverUIScale,
		UpgradeImageBackground = upgradeImageBackground,
		PlusIcon = plusIcon,
		RealButton = realButton,
		MaxButton = maxButton,
		UpgradeImageAspectRatio = uiAspectRatioConstraint,
		TutorialGuide = tutorialGuide,
		TutorialArrow = tutorialGuide:FindFirstChild("Arrow"),
		TutorialArrowGlow = tutorialGuide:FindFirstChild("ArrowGlow")
	}
	setmetatable(v11, UpgradePathClass)
	realButton.Activated:Connect(function()
		v11:UpgradePressed()
	end)
	realButton.MouseEnter:Connect(function()
		v11:UpgradeHovered()
	end)
	realButton.MouseLeave:Connect(function()
		v11:UpgradeUnhovered()
	end)
	realButton.SelectionGained:Connect(function()
		v11:UpgradeHovered()
	end)
	realButton.SelectionLost:Connect(function()
		v11:UpgradeUnhovered()
	end)
	maxButton.Button.Activated:Connect(function()
		v11:UpgradePressed(true)
	end)
	event2:AttachCallback(function()
		maxButton:Update(GetTowerUIHandler().GetCurrentTower()) -- inferred equivalent call
	end)
	local total = 0
	RunService.Heartbeat:Connect(function(dt: number)
		if not v5 then
			return
		end

		total += dt

		if tutorialGuide.Visible then
			v11.TutorialArrowGlow.ImageTransparency = math.sin(total * 3 * 3.141592653589793)
		else
			total = 0
		end

		if v11:TutorialCheck() then
			v11.TutorialArrowGlow.Visible = true
			v11.TutorialArrow.Visible = true
		else
			v11.TutorialArrowGlow.Visible = false
			v11.TutorialArrow.Visible = false
		end
	end)
	return v11
end

function UpgradePathClass.SetTutorialMode(flag: boolean?)
	v5 = flag
	v6 = false
end

function UpgradePathClass.EnableTutorialFreebuild()
	v6 = true
end

function UpgradePathClass.SetTutorialForceUpgrade(vector: Vector3?, p: number?, p2: number?, p3: number?)
	v7 = vector
	v8 = p
	v9 = p2
	v10 = p3
end

function UpgradePathClass:SetEnabled(enabled: boolean)
	self.Enabled = enabled
	self.LockedOverlay.Visible = not enabled
	self.PlusIcon.Visible = enabled and not self.MaxLevelReached and self.OwnedByLocalPlayer
	self.RealButton.Selectable = enabled and not self.MaxLevelReached
end

function UpgradePathClass:Update(object)
	local levelHandler = object.LevelHandler
	local levelOnPath = levelHandler:GetLevelOnPath(self.Path)
	local maxLevel = levelHandler:GetMaxLevel()
	local path = levelHandler:GetPath()
	local pathLockLevel = levelHandler:GetPathLockLevel()
	local upgradePathData = levelHandler:GetUpgradePathData()
	local onePathOnly = upgradePathData.OnePathOnly
	self.TowerName = object.Type
	local path1Data

	if upgradePathData.OnePathOnly or self.Path == 1 then
		path1Data = upgradePathData.Path1Data
	else
		path1Data = upgradePathData.Path2Data
	end

	local upgradeButton = self.UpgradeButton

	if onePathOnly then
		upgradeButton.Visible = self.Path == 1

		if self.OnePathPosition then
			upgradeButton.Position = self.OnePathPosition
		end
	else
		upgradeButton.Visible = true

		if self.TwoPathPosition then
			upgradeButton.Position = self.TwoPathPosition
		end
	end

	self.OnePathOnly = onePathOnly
	self.OwnedByLocalPlayer = object.OwnedByLocalPlayer

	if self.OwnedByLocalPlayer then
		self.PlusIcon.ImageTransparency = 0
	else
		self.PlusIcon.ImageTransparency = 1
	end

	local function SetAspectRatio(flag: boolean?) -- 4 equivalent calls inferred from this helper
		if flag then
			self.UpgradeImageAspectRatio.AspectRatio = 1.777
		else
			self.UpgradeImageAspectRatio.AspectRatio = 1.333
		end
	end

	if levelOnPath == maxLevel and self.Path == path then
		local v11 = path1Data[levelOnPath]

		if v11.UpgradeIconUseLegacySize then
			SetAspectRatio(true) -- inferred equivalent call
		else
			SetAspectRatio(false) -- inferred equivalent call
		end

		self.CostText.Text = "MAX"
		self.UpgradeImage.Image = v11.UpgradeIcon
		self.DescriptionText.Text = "MAX"
		self.MaxLevelReached = true
	else
		local v11 = path1Data[levelOnPath + 1]
		local discount = object.BuffHandler:GetDiscount()
		local towerCostMultiplier = GetGameClass().GetTowerCostMultiplier(self.TowerName) -- inferred equivalent call
		local levelUpgradeCost = levelHandler:GetLevelUpgradeCost(
			self.Path,
			1,
			discount,
			towerCostMultiplier,
			object:GetDynamicPriceScalingData()
		)

		if v11.UpgradeIconUseLegacySize then
			SetAspectRatio(true) -- inferred equivalent call
		else
			SetAspectRatio(false) -- inferred equivalent call
		end

		self.CostText.Text = "$" .. tostring((math.ceil(levelUpgradeCost)))
		self.UpgradeImage.Image = v11.UpgradeIcon
		self.DescriptionText.Text = string.upper(v11.Description)
		self.MaxLevelReached = false
	end

	if levelOnPath == 0 then
		self:SetEnabled(true)
		self.TickHandler:Empty()
	else
		if path == 0 or self.Path == path or levelOnPath < pathLockLevel - 1 then
			self:SetEnabled(true)
		else
			self:SetEnabled(false)
		end

		self.TickHandler:Update(levelOnPath)
	end

	if self.Hovered and (not self.Enabled or self.MaxLevelReached) then
		self:UpgradeUnhovered()
	end

	if self.Hovered then
		UpgradeHoverHandler.UpgradeHovered(self.Path, self.UpgradeButton)
	end

	UpgradeHoverHandler.SetCurrentLevelHandler(levelHandler, object.Type, object.Config)
	self.MaxButton:Update(object)
end

function UpgradePathClass:TutorialCheck()
	local currentTower = GetTowerUIHandler().GetCurrentTower() -- inferred equivalent call

	if not currentTower then
		return
	end

	local levelOnPath = currentTower.LevelHandler:GetLevelOnPath(self.Path)

	if not v5 or v6 then
		return true
	end

	local v11 = false

	if self.Path == 1 then
		v11 = not v9 or (v9 <= levelOnPath or false)
	elseif self.Path == 2 then
		v11 = not v10 or (v10 <= levelOnPath or false)
	end

	if v7 then
		local magnitude = (currentTower:GetPosition() - v7).Magnitude
		v11 = v8 < magnitude or v11
	end

	return not v11
end

function UpgradePathClass:UpgradePressed(flag: boolean)
	local currentTower = GetTowerUIHandler().GetCurrentTower() -- inferred equivalent call

	if not currentTower or self.OnePathOnly and self.Path == 2 then
		return
	end

	local abilityHandler = currentTower.AbilityHandler
	local levelHandler = currentTower.LevelHandler

	if not self.OwnedByLocalPlayer then
		event5:Fire("You can't control this tower!")
		return
	end

	if not self.Enabled then
		event5:Fire("Path locked!")
		return
	end

	if self.MaxLevelReached then
		event5:Fire("Maximum level reached!")
		return
	end

	if currentTower:IsRebuilding() then
		event5:Fire("Tower is rebuilding!")
		return
	end

	if currentTower:IsReviving() then
		event5:Fire("Tower is reviving!")
		return
	end

	if abilityHandler and not abilityHandler:CanUpgrade() then
		event5:Fire("Cannot upgrade while using ability!")
		return
	end

	if not self:TutorialCheck() then
		event5:Fire("Cannot upgrade this right now!")
		return
	end

	local discount = currentTower.BuffHandler:GetDiscount()
	local module = require(gameClass)
	local towerCostMultiplier = module.GetTowerCostMultiplier(self.TowerName)
	local levelOnPath = levelHandler:GetLevelOnPath(self.Path)
	local v11 = not flag and 1
		or math.max(
			1,
			levelHandler:GetLevelAttainableWithCash(
				self.Path,
				localPlayerWrapper.Stats:GetCash(),
				discount,
				towerCostMultiplier,
				currentTower:GetDynamicPriceScalingData()
			) - levelOnPath
		)
	local levelUpgradeCost = levelHandler:GetLevelUpgradeCost(
		self.Path,
		v11,
		discount,
		towerCostMultiplier,
		currentTower:GetDynamicPriceScalingData()
	)

	if localPlayerWrapper.Stats:HasCash(levelUpgradeCost) then
		SoundHandler.Play("UpgradeTower")

		if currentTower then
			event:FireServer(currentTower.Hash, self.Path, v11)

			if flag and not self.OnePathOnly and levelOnPath + v11 == levelHandler:GetMaxLevel() then
				local otherPath = levelHandler:GetOtherPath(self.Path)
				local levelOnPath2 = levelHandler:GetLevelOnPath(otherPath)
				local v12 = localPlayerWrapper.Stats:GetCash() - levelUpgradeCost
				local v13 = math.min(
					levelHandler:GetPathLockLevel() - levelOnPath2 - 1,
					levelHandler:GetLevelAttainableWithCash(
						otherPath,
						v12,
						discount,
						towerCostMultiplier,
						currentTower:GetDynamicPriceScalingData()
					) - levelOnPath2
				)

				if v13 > 0 then
					event:FireServer(currentTower.Hash, otherPath, v13)
				end
			end
		end
	else
		local v12 = levelUpgradeCost - localPlayerWrapper.Stats:GetCash()
		event5:Fire(`You need ${math.ceil(v12)} more cash!`)
		event4:Fire()
	end
end

function UpgradePathClass:UpgradeHovered()
	if self.OnePathOnly and self.Path == 2 then
		return
	end

	if self.Enabled and not self.MaxLevelReached and self.OwnedByLocalPlayer then
		UpgradeHoverHandler.UpgradeHovered(self.Path, self.UpgradeButton)
		self.TickHandler:Hovered(self.CurrentLevel)
		self.UpgradeImageBackground.Image = "rbxassetid://11990398987"
		self.ButtonBackground.ImageColor3 = color
		self.DescriptionBackground.ImageColor3 = color
		self.PlusIcon.Image = "rbxassetid://15344491224"
	end

	self.Hovered = true
	StatsDisplayHandler.Update()
end

function UpgradePathClass:UpgradeUnhovered()
	UpgradeHoverHandler.UpgradeUnhovered(self.UpgradeButton)
	self.TickHandler:Unhovered(self.CurrentLevel)
	self.UpgradeImageBackground.Image = "rbxassetid://10719216703"
	self.ButtonBackground.ImageColor3 = color2
	self.DescriptionBackground.ImageColor3 = color2
	self.PlusIcon.Image = "rbxassetid://15344491300"
	self.Hovered = false
	StatsDisplayHandler.Update()
end

function UpgradePathClass.SetUpPathFrames()
	v3 = UpgradePathClass._New(path1Button, 1)
	v4 = UpgradePathClass._New(path2Button, 2)
end

function UpgradePathClass.Show(p)
	v3:Update(p)
	v4:Update(p)
end

event3:AttachCallback(function(p: number, flag: boolean)
	if not p then
		warn("Path not provided to HotkeyUpgradeTowerEvent")
		return
	end

	local v11 = p == 1 and v3 or v4

	if v11 then
		v11:UpgradePressed(flag)
	end
end)
return UpgradePathClass