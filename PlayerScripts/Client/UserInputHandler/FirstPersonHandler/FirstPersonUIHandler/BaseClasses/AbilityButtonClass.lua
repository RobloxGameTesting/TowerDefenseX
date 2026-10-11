local AbilityButtonClass = {}
AbilityButtonClass.__index = AbilityButtonClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local Keybinds = require(common:WaitForChild("Keybinds"))
local event = BindableHandler.GetEvent("DirectControlUseAbility")

function AbilityButtonClass.New(p: number, button, configData)
	local bar = button.Bar
	local hotkeyHolder = button.HotkeyHolder
	local hotkey = hotkeyHolder.Hotkey
	local v = {
		Index = p,
		Button = button,
		BarJuice = bar,
		ConfigData = configData,
		CurrentAbility = nil,
		Enabled = false,
		Using = false,
		CoolingDown = false
	}

	if p == 1 then
		Keybinds.BindLabel(hotkey, "DirectControlAbility", hotkeyHolder)
	end

	setmetatable(v, AbilityButtonClass)
	v:_UpdateState()
	button.Activated:Connect(function()
		event:Fire(p)
	end)
	return v
end

function AbilityButtonClass:SetAbility(currentAbility)
	if currentAbility then
		self.Enabled = true
	else
		self.Enabled = false
	end

	self.CurrentAbility = currentAbility
	self:_UpdateState()
end

function AbilityButtonClass:SetUsing(using: boolean)
	if using ~= self.Using then
		self.Using = using
		self:_UpdateState()
	end
end

function AbilityButtonClass:SetCoolingDown(coolingDown: boolean)
	if coolingDown ~= self.CoolingDown then
		self.CoolingDown = coolingDown
		self:_UpdateState()
	end
end

function AbilityButtonClass:_UpdateState()
	local button = self.Button
	local barJuice = self.BarJuice
	button.Visible = self.Enabled
	local configData = self.ConfigData

	if configData then
		if self.Using then
			if configData.UsingColor then
				barJuice.BackgroundColor3 = configData.UsingColor
			end

			if configData.UsingTransparency then
				barJuice.BackgroundTransparency = configData.UsingTransparency
			end
		elseif self.CoolingDown then
			if configData.CooldownColor then
				barJuice.BackgroundColor3 = configData.CooldownColor
			end

			if configData.CooldownTransparency then
				barJuice.BackgroundTransparency = configData.CooldownTransparency
			end
		else
			if configData.AvailableColor then
				barJuice.BackgroundColor3 = configData.AvailableColor
			end

			if configData.AvailableTransparency then
				barJuice.BackgroundTransparency = configData.AvailableTransparency
			end
		end
	end
end

function AbilityButtonClass:Run(_: number)
	local barJuice = self.BarJuice
	local currentAbility = self.CurrentAbility

	if currentAbility then
		local beingUsed = currentAbility:BeingUsed()
		local cooldownRemaining = currentAbility:GetCooldownRemaining()
		local totalCooldown = currentAbility:GetTotalCooldown()

		if beingUsed or not (cooldownRemaining > 0) then
			barJuice.Size = UDim2.new(1, 0, 1, 0)
		else
			barJuice.Size = UDim2.new(1 - cooldownRemaining / totalCooldown, 0, 1, 0)
		end

		self:SetUsing(beingUsed)
		self:SetCoolingDown(cooldownRemaining > 0)
	end
end

return AbilityButtonClass