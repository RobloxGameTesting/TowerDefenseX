local AbilityButtonClass = {}
AbilityButtonClass.__index = AbilityButtonClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local AbilityInfoHandler = require(script.Parent:WaitForChild("AbilityInfoHandler"))
local udim = UDim2.new(0, 70, 0, 70)
local udim2 = UDim2.new(0, 87, 0, 87)
local event = BindableHandler.GetEvent("ErrorPrompt")
local count = 0

function AbilityButtonClass.New(instance)
	count += 1
	local button = instance:WaitForChild("Button")
	local background = instance:WaitForChild("Background")
	local cooldownText = instance:WaitForChild("CooldownText")
	local image = instance:WaitForChild("Image")
	local info = instance:WaitForChild("Info")
	button.SelectionOrder = -500
	local v = {
		ButtonIndex = count,
		AbilityFrame = instance,
		PhysicalButton = button,
		Background = background,
		CooldownText = cooldownText,
		Image = image,
		InfoButton = info,
		Viewport = nil,
		CurrentTower = nil,
		CurrentAbilityConfig = nil,
		CanUseAbility = false,
		NoShowInfo = false
	}
	setmetatable(v, AbilityButtonClass)
	button.Activated:Connect(function()
		v:Activated()
	end)
	button.MouseEnter:Connect(function()
		v:_MouseEntered()
	end)
	button.MouseLeave:Connect(function()
		v:_MouseLeft()
	end)
	info.MouseEnter:Connect(function()
		v:_InfoMouseEntered()
	end)
	info.MouseLeave:Connect(function()
		v:_InfoMouseLeft()
	end)
	info.SelectionGained:Connect(function()
		v:_InfoMouseEntered()
	end)
	info.SelectionLost:Connect(function()
		v:_InfoMouseLeft()
	end)
	return v
end

function AbilityButtonClass:TowerChanged(currentTower)
	self.CurrentAbility = nil

	if not currentTower.OwnedByLocalPlayer then
		self:_Hide()
		return
	end

	local abilityFromIndex = currentTower:GetAbilityFromIndex(self.ButtonIndex)
	self.CurrentTower = currentTower
	self.CurrentAbility = abilityFromIndex

	if not (abilityFromIndex and abilityFromIndex:CanManuallyUse()) then
		self:_Hide()
		return
	end

	local config = abilityFromIndex.Config

	if config.FullSizeIcon then
		self.Image.Size = udim2
	else
		self.Image.Size = udim
	end

	AbilityInfoHandler.AbilityChanged(self.ButtonIndex, config, currentTower)
	self.NoShowInfo = config.NoShowInfo
	self.InfoButton.Visible = not self.NoShowInfo and AbilityInfoHandler.AtLeastOneActiveItem(self.ButtonIndex)

	if config.IconIsViewport then
		self:_CleanupCurrentViewport()
		self.Viewport = ResourceManager.GetTowerAbilityViewport(config.Icon)

		if self.Viewport then
			self.Viewport.Position = self.Image.Position
			self.Viewport.Size = self.Image.Size
			self.Viewport.AnchorPoint = self.Image.AnchorPoint
			self.Viewport.ZIndex = self.Image.ZIndex + 1
			self.Viewport.Parent = self.AbilityFrame
			self.Viewport.Visible = true
		else
			warn("Viewport missing for " .. config.Name)
		end

		self.Image.Visible = false
	else
		self:_CleanupCurrentViewport()
		self.Image.Image = config.Icon
		self.Image.Visible = true
	end

	self:Run()
	self:_Show()
end

function AbilityButtonClass:_CleanupCurrentViewport()
	if self.Viewport then
		self.Viewport:Destroy()
		self.Viewport = nil
	end
end

function AbilityButtonClass:_SetViewportTransparency(imageTransparency: number)
	if self.Viewport then
		self.Viewport.ImageTransparency = imageTransparency
	end
end

function AbilityButtonClass:TowerDeselected()
	self.CurrentTowerHash = nil
	self.CurrentAbility = nil
end

function AbilityButtonClass:Run()
	local currentAbility = self.CurrentAbility

	if currentAbility then
		local cooldownRemaining = currentAbility:GetCooldownRemaining()
		local stunned = currentAbility:GetStunned()
		local disabled = currentAbility:GetDisabled()
		local converted = currentAbility:GetConverted()
		local towerRebuilding = currentAbility:GetTowerRebuilding()

		if cooldownRemaining > 0 then
			self.CanUseAbility = false
			self.Image.ImageTransparency = 0.6
			self.CooldownText.Text = tostring((math.round(cooldownRemaining)))
			self.CooldownText.Visible = true
			self:_SetViewportTransparency(0.6)
		elseif stunned or disabled or converted or towerRebuilding then
			self.CanUseAbility = false
			self.Image.ImageTransparency = 0.6
			self.CooldownText.Text = "-"
			self.CooldownText.Visible = true
			self:_SetViewportTransparency(0.6)
		else
			self.CanUseAbility = true
			self.Image.ImageTransparency = 0
			self.CooldownText.Visible = false
			self:_SetViewportTransparency(0)
		end
	end
end

function AbilityButtonClass:Activated()
	local currentAbility = self.CurrentAbility

	if not (currentAbility and currentAbility:CanManuallyUse()) then
		return
	end

	if self.CurrentTower and self.CanUseAbility then
		self.CurrentTower:UseAbility(self.ButtonIndex)
		SoundHandler.Play("ClickTower")
	elseif currentAbility:GetStunned() then
		event:Fire("Cannot use while stunned!")
	elseif currentAbility:GetDisabled() then
		event:Fire("Cannot use while disabled!")
	elseif currentAbility:GetConverted() then
		event:Fire("Cannot use while converted!")
	elseif currentAbility:GetTowerRebuilding() then
		event:Fire("Cannot use while rebuilding!")
	else
		event:Fire("Ability cooling down!")
	end
end

function AbilityButtonClass:_MouseEntered()
	self.Background.Image = "rbxassetid://11373771597"
end

function AbilityButtonClass:_MouseLeft()
	self.Background.Image = "rbxassetid://11373771662"
end

function AbilityButtonClass:_Show()
	self.AbilityFrame.Visible = true
end

function AbilityButtonClass:_Hide()
	self.AbilityFrame.Visible = false
end

function AbilityButtonClass:_InfoMouseEntered()
	if not self.NoShowInfo then
		AbilityInfoHandler.Show(self.ButtonIndex)
	end
end

function AbilityButtonClass:_InfoMouseLeft()
	if not self.NoShowInfo then
		AbilityInfoHandler.Hide(self.ButtonIndex)
	end
end

return AbilityButtonClass