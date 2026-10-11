local AbilityHotbarItemClass = {}
AbilityHotbarItemClass.__index = AbilityHotbarItemClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("AbilityTypes"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local UserInputHandler = script.Parent.Parent.Parent:WaitForChild("UserInputHandler")
local udim = UDim2.new(0.7, 0, 0.7, 0)
local udim2 = UDim2.new(0.83, 0, 0.83, 0)
local event = BindableHandler.GetEvent("ErrorPrompt")

function AbilityHotbarItemClass.New(zIndex: number, flag: boolean, data, parent)
	local template = parent:FindFirstChild("Template")
	template.Visible = false
	local clone = template:Clone()
	clone.Name = "Level" .. zIndex
	clone.LayoutOrder = -zIndex
	clone.ZIndex = zIndex
	clone.Parent = parent
	clone.Visible = true
	local button = clone:FindFirstChild("Button")
	local image = clone:FindFirstChild("Image")
	local border = clone:FindFirstChild("Border")
	local background = clone:FindFirstChild("Background")
	local cooldownText = clone:FindFirstChild("CooldownText")
	local cooldownTextSide = clone:FindFirstChild("CooldownTextSide")
	local level = clone:FindFirstChild("Level")
	local v = {
		Button = button,
		Frame = clone,
		Image = image,
		Border = border,
		Background = background,
		CooldownText = cooldownText,
		CooldownTextSide = cooldownTextSide,
		LevelText = level,
		AmountText = clone:FindFirstChild("Amount"),
		CooldownBar = clone:FindFirstChild("CooldownBar"):WaitForChild("Bar"),
		IsHighestLevel = true,
		Viewport = nil,
		AbilityConfig = data.Config,
		AvailableCount = data.AvailableCount,
		ClosestTower = data.ClosestTower,
		ClosestAbility = data.ClosestAbility,
		IsCoolingDown = false,
		IsStunned = false,
		IsDisabled = false,
		IsConverted = false,
		IsRebuilding = false,
		IsHovered = false
	}
	local config = data.Config
	image.Size = data.Config.FullSizeIcon and udim2 or udim

	if config.IconIsViewport then
		local towerAbilityViewport = ResourceManager.GetTowerAbilityViewport(config.Icon)

		if towerAbilityViewport then
			towerAbilityViewport.Position = image.Position
			towerAbilityViewport.Size = image.Size
			towerAbilityViewport.AnchorPoint = image.AnchorPoint
			towerAbilityViewport.ZIndex = image.ZIndex + 1
			towerAbilityViewport.Parent = clone
			towerAbilityViewport.Visible = true
			v.Viewport = towerAbilityViewport
		else
			warn("Viewport missing for " .. config.Name)
		end

		image.Visible = false
	else
		image.Image = data.Config.Icon
	end

	if flag then
		if zIndex >= 4 then
			warn("Ability level is too high: " .. zIndex)
		elseif zIndex == 3 then
			level.Text = "III"
		elseif zIndex == 2 then
			level.Text = "II"
		else
			level.Text = "I"
		end

		level.Visible = true
	else
		level.Visible = false
	end

	button.Activated:Connect(function()
		v:Activated()
	end)
	button.MouseEnter:Connect(function()
		v:Hovered()
	end)
	button.MouseLeave:Connect(function()
		v:Unhovered()
	end)
	return (setmetatable(v, AbilityHotbarItemClass))
end

function AbilityHotbarItemClass:SetIsHighestLevel(isHighestLevel: boolean)
	self.IsHighestLevel = isHighestLevel

	if self.IsHighestLevel then
		self.Button.Size = UDim2.new(1, 0, 1, 0)
	else
		self.Button.Size = UDim2.new(0.45, 0, 1, 0)
	end
end

function AbilityHotbarItemClass:_ShouldSelectTower()
	local abilityConfig = self.AbilityConfig
	return abilityConfig.IsManualAimRetarget
		or abilityConfig.IsManualAimAtPath
		or abilityConfig.IsManualAimAtGround
		or abilityConfig.IsManualAimAtGroundDirectional
		or abilityConfig.IsManualAimAtTower
		or abilityConfig.IsManualRotation
		or abilityConfig.IsManualRelocation
end

function AbilityHotbarItemClass:Activated()
	if self.AvailableCount > 0 then
		SoundHandler.Play("ClickTower")

		if self:_ShouldSelectTower() then
			local module = require(UserInputHandler)
			module.SelectTower(self.ClosestTower, false, false, true)
		end

		self.ClosestAbility:Use()
	elseif self.IsStunned then
		event:Fire("Cannot use while stunned!")
	elseif self.IsDisabled then
		event:Fire("Cannot use while disabled!")
	elseif self.IsConverted then
		event:Fire("Cannot use while converted!")
	elseif self.IsRebuilding then
		event:Fire("Cannot use while rebuilding!")
	else
		event:Fire("Ability cooling down!")
	end
end

function AbilityHotbarItemClass:Hovered()
	self.IsHovered = true
end

function AbilityHotbarItemClass:Unhovered()
	self.IsHovered = false
end

function AbilityHotbarItemClass:Update(data)
	local config = data.Config
	self.IsCoolingDown = data.CooldownRemaining > 0
	self.IsStunned = data.IsStunned
	self.IsDisabled = data.IsDisabled
	self.IsConverted = data.IsConverted
	self.IsRebuilding = data.IsRebuilding
	self.AvailableCount = data.AvailableCount
	self.ClosestTower = data.ClosestTower
	self.ClosestAbility = data.ClosestAbility

	if data.AvailableCount > 0 then
		self.Border.Image = "rbxassetid://98302328697675"
		self.Background.Image = self.IsHovered and "rbxassetid://133699167137171" or "rbxassetid://119931623298813"
	else
		self.Border.Image = "rbxassetid://112746035969864"
		self.Background.Image = "rbxassetid://80170980308174"
	end

	if data.AvailableCount > 0 then
		self.AmountText.Text = data.AvailableCount

		if data.AvailableCount > 1 then
			self.AmountText.Visible = true
		else
			self.AmountText.Visible = false
		end

		self.CooldownText.Visible = false
		self.CooldownTextSide.Visible = false
		self.CooldownBar.Visible = false
		self.Image.ImageTransparency = 0

		if self.Viewport then
			self.Viewport.ImageTransparency = 0
		end
	else
		self.AmountText.Visible = false

		if self.IsCoolingDown then
			self.CooldownText.Text = tostring((math.round(data.CooldownRemaining)))
			self.CooldownTextSide.Text = tostring((math.round(data.CooldownRemaining)))
		else
			self.CooldownText.Text = "-"
			self.CooldownTextSide.Text = "-"
		end

		self.CooldownText.Visible = self.IsHighestLevel
		self.CooldownTextSide.Visible = not self.IsHighestLevel
		self.CooldownBar.Size = UDim2.new(1, 0, math.clamp(data.CooldownRemaining / config.Cooldown, 0, 1), 0)
		self.CooldownBar.Visible = true
		self.Image.ImageTransparency = 0.6

		if self.Viewport then
			self.Viewport.ImageTransparency = 0.6
		end
	end
end

function AbilityHotbarItemClass:Destroy()
	self.Frame:Destroy()
end

return AbilityHotbarItemClass