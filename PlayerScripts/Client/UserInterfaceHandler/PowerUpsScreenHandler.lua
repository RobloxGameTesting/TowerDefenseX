local PowerUpsScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
game:GetService("GuiService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
local Enums = require(Common:WaitForChild("Enums"))
local Utilities = require(Common:WaitForChild("Utilities"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local PowerUpsData = require(Common:WaitForChild("PowerUpsData"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local PowerUpsConfigHandler = require(Common.Resources.Misc.PowerUpsConfigHandler)
local ScalingCardClass = require(Common:WaitForChild("ScalingCardClass"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Shared"))
local Data = require(TDX_Shared.Client.Services.Data)
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local parent = script.Parent.Parent
local userInputHandler = parent:WaitForChild("UserInputHandler")
local gameClass = parent:WaitForChild("GameClass")
local v = nil

local function GetGameClass()
	if not v then
		local module = require(gameClass)
		v = module
	end

	return v
end

local isStudio = RunService:IsStudio()
local DEV_UNLIMITED_POWERUPS = _G.DEV_UNLIMITED_POWERUPS
local MAP_DIFFICULTIES_WITH_DISABLED_POWERUPS = _G.MAP_DIFFICULTIES_WITH_DISABLED_POWERUPS
local udim = UDim2.new(0.5, 0, 0.19, 0)
local udim2 = UDim2.new(1.8, 0, 0.19, 0)
local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0)
local color = Color3.fromRGB(236, 236, 236)
local color2 = Color3.fromRGB(255, 255, 255)
local color3 = Color3.fromRGB(112, 112, 112)
local color4 = Color3.fromRGB(117, 212, 0)
local color5 = Color3.fromRGB(180, 255, 0)
local color6 = Color3.fromRGB(59, 108, 0)
local color7 = Color3.new(1, 0, 0)
local udim3 = UDim2.new(1, 0, 0.72, 0)
local udim4 = UDim2.new(1, 0, 0.5, 0)
local udim5 = UDim2.new(0.5, 0, 0.47, 0)
local udim6 = UDim2.new(0.5, 0, 0.37, 0)
local udim7 = UDim2.new(0.06, 0, 0.04, 0)
local udim8 = UDim2.new(0.06, 0, 0.055, 0)
local udim9 = UDim2.new(0.47, 0, 0.293, 0)
local udim10 = UDim2.new(0.47, 0, 0.444, 0)
local v2 = NetworkingHandler.GetFunction("RequestUsePowerUp")
local event = BindableHandler.GetEvent("ErrorPrompt")
local event2 = BindableHandler.GetEvent("SetDifficulty")
local event3 = BindableHandler.GetEvent("SetMapDifficulty")
local event4 = BindableHandler.GetEvent("BossCountChanged")
local event5 = BindableHandler.GetEvent("PowerUpStatsChanged")
local event6 = BindableHandler.GetEvent("PowerUpConfigsChanged")
local event7 = BindableHandler.GetEvent("WaveChanged")
local LocalPlayer = Players.LocalPlayer
local leftButtons = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LowPriorityInterface"):WaitForChild("LeftButtons")
local powerUps = leftButtons:WaitForChild("PowerUps")
local toggleButton = powerUps:WaitForChild("ToggleButton")
local main = powerUps:WaitForChild("Main")
local inner = main:WaitForChild("Inner")
local uiGridLayout = inner:FindFirstChildOfClass("UIGridLayout")
local tooltip = powerUps:WaitForChild("Main"):WaitForChild("Tooltip")
local powerUpsPVP = leftButtons:WaitForChild("PowerUpsPVP")
local main2 = powerUpsPVP:WaitForChild("Main")
local inner2 = main2:WaitForChild("Inner")
local disabledOffensive = inner2:WaitForChild("DisabledOffensive")
local disabledDefensive = inner2:WaitForChild("DisabledDefensive")
local tooltip2 = main2:WaitForChild("Tooltip")
local position = powerUpsPVP.Position
local udim11 = UDim2.new(udim2.X.Scale, udim2.X.Offset, position.Y.Scale, position.Y.Offset)
local flag = false
local flag2 = false

local function LoadAssetTemplates(assets)
	return {
		Icon = assets:WaitForChild("Icon"),
		Border = assets:WaitForChild("Border"),
		CountText = assets:WaitForChild("CountText"),
		UsesRemainingText = assets:WaitForChild("UsesRemainingText"),
		InfiniteIcon = assets:WaitForChild("InfiniteIcon"),
		LockIcon = assets:WaitForChild("LockIcon"),
		CooldownFillGroup = assets:WaitForChild("CooldownFillGroup")
	}
end

local loadAssetTemplates = LoadAssetTemplates(main:WaitForChild("Assets"))
local loadAssetTemplates2 = LoadAssetTemplates(main2:WaitForChild("Assets"))
local v3 = {}
local v4 = {}
local flag3 = false
local Easy = Enums.Difficulties.Easy
local easy = Enums.MapDifficulties.Easy
local v5 = 0
local v6 = 0
local v7 = ScalingCardClass.New(tooltip, 5, { leftButtons:WaitForChild("UIScale"), tooltip:WaitForChild("UIScale") })
local v8 = ScalingCardClass.New(tooltip2, 5, { leftButtons:WaitForChild("UIScale"), tooltip2:WaitForChild("UIScale") })

local function PowerUpsDisabledForMapDifficulty() -- 2 equivalent calls inferred from this helper
	return table.find(MAP_DIFFICULTIES_WITH_DISABLED_POWERUPS, easy)
end

local function PowerUpsDisabledForDifficulty() -- 2 equivalent calls inferred from this helper
	return ResourceManager.GetWaveConfig(Easy).PowerUpsDisabled
end

local function UpdateEnabled() -- 2 equivalent calls inferred from this helper
	main.Visible = not (PowerUpsDisabledForMapDifficulty() or PowerUpsDisabledForDifficulty()) -- inferred equivalent call
end

local function PlayRandomSound(soundsFolder) -- 1 equivalent call inferred from this helper
	local children = soundsFolder:GetChildren()

	if #children == 0 then
		return
	end

	children[math.random(1, #children)]:Play()
end

local function ShowPromptForErrorType(p: string)
	if p == Enums.PowerUpErrors.GameNotRunning then
		event:Fire("Game is not running!", 4)
	elseif p == Enums.PowerUpErrors.DisabledForMapDifficulty then
		event:Fire("Power-ups disabled on this map!", 4)
	elseif p == Enums.PowerUpErrors.Unknown then
		event:Fire("Unknown error!", 4)
	elseif p == Enums.PowerUpErrors.NotOwned then
		event:Fire("Unknown error!", 4)
	elseif p == Enums.PowerUpErrors.AirspaceFull then
		event:Fire("Airspace full!", 4)
	elseif p == Enums.PowerUpErrors.CooldownActive then
		event:Fire("Cooldown active!", 4)
	elseif p == Enums.PowerUpErrors.NoAirspace then
		event:Fire("No airspace!", 4)
	elseif p == Enums.PowerUpErrors.MaximumActive then
		event:Fire("Maximum active!", 4)
	elseif p == Enums.PowerUpErrors.Disabled then
		event:Fire("This power-up is disabled!", 4)
	elseif p == Enums.PowerUpErrors.NoUsesRemaining then
		event:Fire("No uses remaining!", 4)
	elseif p == Enums.PowerUpErrors.NoBosses then
		event:Fire("Can only be used on bosses!", 4)
	elseif p == Enums.PowerUpErrors.WaveRequirementNotReached then
		event:Fire("Cannot be used on this wave!", 4)
	elseif p == Enums.PowerUpErrors.AlreadyActive then
		event:Fire("Already active!", 4)
	else
		warn(`PowerUpsScreenHandler: unknown error type: {p}`)
	end
end

local function NewPowerUpButton(button, data, object, flag4: boolean?)
	local name = button.Name

	if not Enums.PowerUps[name] then
		warn(`{name} is not a valid PowerUp`)
		return
	end

	local v9 = PowerUpsData[name]

	if not v9 then
		warn(`{name} is missing data in PowerUpsData`)
		return
	end

	local useMethod = button:GetAttribute("UseMethod")

	if not useMethod then
		warn("PowerUpButton is missing UseMethod attribute")
		return
	end

	if not Enums.PowerUpUseMethods[useMethod] then
		warn(`{useMethod} is not a valid UseMethod`)
		return
	end

	local sounds = button:FindFirstChild("Sounds")

	if sounds then
		for _, child in pairs(sounds:GetChildren()) do
			GameSoundHandler.AddSoundToSoundGroup(child, "SFX")
		end
	end

	local clone = data.Icon:Clone()
	clone.Image = v9.MiniImage
	clone.Parent = button
	clone.Visible = true
	local clone2 = data.Border:Clone()
	clone2.Parent = button
	clone2.Visible = true
	local clone3 = data.CountText:Clone()
	clone3.Parent = button
	clone3.Visible = true
	local clone4 = data.UsesRemainingText:Clone()
	clone4.Parent = button
	clone4.Visible = false
	local clone5 = data.InfiniteIcon:Clone()
	clone5.Parent = button
	clone5.Visible = false
	local clone6 = data.LockIcon:Clone()
	clone6.Parent = button
	clone6.Visible = false
	local clone7 = data.CooldownFillGroup:Clone()
	clone7.Parent = button
	clone7.Visible = false
	local cooldownFill = clone7:FindFirstChild("CooldownFill")
	local v10 = {
		Name = name,
		DisplayName = Lang.Get(Lang.Strings.AssetInfo.PowerUps[name].Name):upper(),
		Description = Lang.Get(Lang.Strings.AssetInfo.PowerUps[name].Description):upper(),
		UseMethod = useMethod,
		Count = 0,
		NumUsed = 0,
		Cooldown = 0,
		CooldownRemaining = 0,
		Hovered = false,
		InLoadout = true,
		SoundsFolder = sounds,
		Icon = clone,
		Border = clone2,
		CountText = clone3,
		UsesRemainingText = clone4,
		InfiniteIcon = clone5,
		LockIcon = clone6,
		CooldownFillGroup = clone7,
		CooldownFill = cooldownFill,
		ImageButton = button,
		ButtonDisabled = button:GetAttribute("Disabled"),
		ManualGroundRadius = button:GetAttribute("ManualGroundRadius") or 5,
		IsPVP = flag4 == true,
		GetName = function(self)
			return self.Name
		end,
		SetInLoadout = function(self, layoutOrder: number?)
			if layoutOrder then
				self.ImageButton.LayoutOrder = layoutOrder
			end

			self.InLoadout = layoutOrder ~= nil
			self:_UpdateState()
		end,
		IsLocked = function(self)
			local config = PowerUpsConfigHandler.GetConfig(self.Name)

			if not config then
				return false
			end

			if config.Disabled == true then
				return true, Enums.PowerUpErrors.Disabled
			end

			if config.MinWave ~= nil and v5 < config.MinWave then
				return true, Enums.PowerUpErrors.WaveRequirementNotReached
			end

			if config.BossOnly == true and v6 == 0 then
				return true, Enums.PowerUpErrors.NoBosses
			end

			return false
		end,
		IsDisabled = function(self)
			local isLocked, v10 = self:IsLocked()

			if isLocked then
				return isLocked, v10
			end

			if not isStudio and self.MaxUses ~= nil and self.NumUsed >= self.MaxUses then
				return true, Enums.PowerUpErrors.NoUsesRemaining
			end

			if self.CooldownRemaining > 0 then
				return true, Enums.PowerUpErrors.CooldownActive
			end

			return not self.InLoadout or self.ButtonDisabled or self.Count <= 0
		end,
		CountChanged = function(self, count: number)
			self.Count = count
			self:_UpdateState()
		end,
		OnUsageStatsChanged = function(self, numUsed: number)
			local v10 = self.NumUsed < numUsed
			self.NumUsed = numUsed

			if v10 and self.Cooldown > 0 then
				self.CooldownRemaining = self.Cooldown
			end

			self:_UpdateState()
		end,
		OnConfigChanged = function(self)
			local config = PowerUpsConfigHandler.GetConfig(self.Name)

			if not config then
				return
			end

			self.MaxUses = config.MaxUses
			self.Cooldown = config.Cooldown or 0
			self:_UpdateState()
		end,
		Activated = function(self)
			local isDisabled, v10 = self:IsDisabled()

			if isDisabled then
				SoundHandler.Play("Error")

				if self.ButtonDisabled then
					event:Fire("Abilility is WIP!", 4)
				elseif self.Count <= 0 then
					event:Fire("You don't have any of this powerup! Buy some in the lobby!", 4)
				elseif v10 then
					ShowPromptForErrorType(v10)
				end
			else
				if self.IsPVP then
					local config = PowerUpsConfigHandler.GetConfig(self.Name)

					if config and config.Category == Enums.PowerUpCategories.Defensive then
						SoundHandler.Play("PVPDefensivePowerUpActivated")
					end
				end

				if self.UseMethod == Enums.PowerUpUseMethods.Instant then
					self:TryUse()
				elseif self.UseMethod == Enums.PowerUpUseMethods.ManualGround then
					local module = require(userInputHandler)
					module.BeginManualAimGroundPowerUp(self, self.ManualGroundRadius)
				elseif self.UseMethod == Enums.PowerUpUseMethods.ManualGroundDirectional then
					local config = PowerUpsConfigHandler.GetConfig(self.Name)
					local module = require(userInputHandler)
					module.BeginManualAimGroundDirectionalPowerUp(self, config.StrikeZoneLength, config.StrikeZoneWidth)
				else
					if self.UseMethod ~= Enums.PowerUpUseMethods.ManualPath then
						print("NOT IMPLEMENTED")
						return
					end

					local module = require(userInputHandler)
					module.BeginManualAimPathPowerUp(self)
				end
			end
		end,
		TryUse = function(self, ...)
			if self:IsDisabled() then
				return
			end

			local v10, v11 = v2:InvokeServer(self.Name, ...)

			if v10 then
				if self.SoundsFolder then
					PlayRandomSound(self.SoundsFolder) -- inferred equivalent call
				end
			else
				ShowPromptForErrorType(v11)
			end
		end,
		MouseEntered = function(self)
			self.Hovered = true
			self:_UpdateState()
			self:_ShowTooltip()
		end,
		MouseLeft = function(self)
			self.Hovered = false
			self:_UpdateState()
		end,
		_TickCooldown = function(self, p: number)
			if self.CooldownRemaining <= 0 then
				return false
			end

			self.CooldownRemaining = math.max(0, self.CooldownRemaining - p)

			if self.CooldownRemaining <= 0 then
				self:_UpdateState()
				return true
			end

			local v10 = not (self.Cooldown > 0) and 0 or self.CooldownRemaining / self.Cooldown or 0
			self.CooldownFillGroup.Visible = true
			self.CooldownFill.Size = UDim2.new(1, 0, v10, 0)
			return false
		end,
		_ShowTooltip = function(self)
			object:ActivateItem(self.DisplayName, {
				LayoutOrder = -1,
				TextSize = 24,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextColor = Color3.fromRGB(180, 255, 0)
			})
			object:ScaleFrame()
			object:ShowIfActiveItems()
		end,
		_UpdateState = function(self)
			object:DeactivateAllItems()
			object:Hide()
			self.ImageButton:SetAttribute("Selected", self:IsDisabled())
			self.CountText.Text = self.Count
			self.CountText.Visible = true
			self.UsesRemainingText.Visible = self.MaxUses ~= nil
			local infiniteIcon = self.InfiniteIcon
			infiniteIcon.Visible = self.MaxUses == nil and self.Count > 0
			local config = PowerUpsConfigHandler.GetConfig(self.Name)

			if self.MaxUses ~= nil then
				local v10 = self.MaxUses - self.NumUsed
				local v11 = math.min(self.Count, v10)
				self.UsesRemainingText.Text = `{v11} left`
				object:ActivateItem(`{v11} USES REMAINING`, { LayoutOrder = 1, TextSize = 20 })

				if self.Count <= v10 then
					self.CountText.Visible = false
				end
			end

			local isLocked, v10 = self:IsLocked()

			if isLocked then
				self.UsesRemainingText.Visible = false
				self.InfiniteIcon.Visible = false
				self.LockIcon.Visible = true
				self.CountText.Visible = true
				local v11 = "DISABLED"

				if v10 == Enums.PowerUpErrors.WaveRequirementNotReached then
					v11 = `ONLY USABLE ON WAVE {config.MinWave}+`
				elseif v10 == Enums.PowerUpErrors.NoBosses then
					v11 = "ONLY USABLE WHEN BOSSES ARE ALIVE"
				else
					local _ = v10 == Enums.PowerUpErrors.Disabled
				end

				object:ActivateItem(v11, {
					LayoutOrder = 3,
					TextSize = 20,
					TextColor = color7,
					ImageId = "rbxassetid://135958591312863"
				})
			else
				self.LockIcon.Visible = false
			end

			if self.CooldownRemaining > 0 and self.Cooldown > 0 then
				self.CooldownFillGroup.Visible = true
				self.CooldownFill.Size = UDim2.new(1, 0, self.CooldownRemaining / self.Cooldown, 0)
			else
				self.CooldownFillGroup.Visible = false
			end

			if self:IsDisabled() then
				self.Icon.ImageColor3 = color3
				self.Border.ImageColor3 = color6
			elseif self.Hovered then
				self.Icon.ImageColor3 = color2
				self.Border.ImageColor3 = color5
			else
				self.Icon.ImageColor3 = color
				self.Border.ImageColor3 = color4
			end

			self.ImageButton.Visible = self.InLoadout
		end
	}
	button.Activated:Connect(function()
		v10:Activated()
	end)
	button.MouseEnter:Connect(function()
		v10:MouseEntered()
	end)
	button.MouseLeave:Connect(function()
		v10:MouseLeft()
	end)
	v10:_UpdateState()
	button.ImageTransparency = 1
	return v10
end

local function InventoryChanged(inventory)
	if not inventory then
		warn("PowerUpsScreenHandler: Inventory is nil")
		return
	end

	local powerUps2 = inventory.PowerUps

	if not powerUps2 then
		warn("PowerUpsScreenHandler: Inventory.PowerUps is nil")
		return
	end

	if isStudio and DEV_UNLIMITED_POWERUPS then
		for _, powerUp in pairs(Enums.PowerUps) do
			powerUps2[powerUp] = 99
		end
	end

	for k, powerUp in pairs(powerUps2) do
		local v9 = v3[k] or v4[k]

		if v9 then
			v9:CountChanged(powerUp)
		end
	end
end

local heartbeatConnection = nil

local function StartCooldownTick() -- 1 equivalent call inferred from this helper
	if heartbeatConnection then
		return
	end

	heartbeatConnection = RunService.Heartbeat:Connect(function(dt: number)
		if not v then
			local module = require(gameClass)
			v = module
		end

		local currentGame = v.GetCurrentGame()
		local v9 = dt * (currentGame and currentGame:GetFinalSpeedMultiplier() or 1)

		for _, v10 in v3 do
			v10:_TickCooldown(v9)
		end

		for _, v10 in v4 do
			v10:_TickCooldown(v9)
		end
	end)
end

function PowerUpsScreenHandler.Initialize(p: number, items)
	StartCooldownTick() -- inferred equivalent call
	local v9

	if p > 4 then
		v9 = Utilities.FlipTable({ 1, 2, 3, 4, 5, 6 })
		main.Size = udim3
		main.Position = udim5
		uiGridLayout.CellSize = udim9
		uiGridLayout.CellPadding = udim7
	else
		v9 = Utilities.FlipTable({ 1, 2, 3, 4 })
		main.Size = udim4
		main.Position = udim6
		uiGridLayout.CellSize = udim10
		uiGridLayout.CellPadding = udim8
	end

	for _, v10 in pairs(v3) do
		local v11 = nil

		for k, item in pairs(items) do
			if v10:GetName() ~= item then
				continue
			end

			v11 = k
			break
		end

		if v11 then
			v9[v11] = nil
		end

		v10:SetInLoadout(v11)
	end

	for i = 1, p do
		local v10 = v9[i]
		local findFirstChild = inner:FindFirstChild("Disabled" .. i)
		findFirstChild.Visible = v10 ~= nil
	end

	PowerUpsScreenHandler.InitializePVP()
end

function PowerUpsScreenHandler.Enable()
	if not flag3 then
		return
	end

	powerUps.Position = udim2
	TweenService:Create(powerUps, tweenInfo, { Position = udim }):Play()
	powerUps.Visible = true
	flag3 = false
end

function PowerUpsScreenHandler.Disable()
	if flag3 then
		return
	end

	powerUps.Position = udim2
	powerUps.Visible = false
	flag3 = true
end

local function GetEquippedPVPName(attributeName: string) -- 2 equivalent calls inferred from this helper
	local attribute = LocalPlayer:GetAttribute(attributeName)

	if attribute == nil or attribute == "" then
		return nil
	end

	return attribute
end

local function GetPVPCategory(k: string) -- 1 equivalent call inferred from this helper
	local config = PowerUpsConfigHandler.GetConfig(k)
	return config and config.Category or nil
end

local function RefreshPVPSlots()
	local equippedPVPName = GetEquippedPVPName("PVPPowerUpOffensive") -- inferred equivalent call
	local equippedPVPName2 = GetEquippedPVPName("PVPPowerUpDefensive") -- inferred equivalent call

	for k, v9 in pairs(v4) do
		local pvpCategory = GetPVPCategory(k) -- inferred equivalent call
		local v10 = pvpCategory == Enums.PowerUpCategories.Offensive and 1
			or pvpCategory == Enums.PowerUpCategories.Defensive and 2
			or nil
		local v11

		if pvpCategory == Enums.PowerUpCategories.Offensive and k == equippedPVPName then
			v11 = true
		elseif pvpCategory == Enums.PowerUpCategories.Defensive then
			v11 = k == equippedPVPName2
		else
			v11 = false
		end

		if not v11 then
			v10 = nil
		end

		v9:SetInLoadout(v10)
	end

	disabledOffensive.Visible = equippedPVPName == ""
	disabledDefensive.Visible = equippedPVPName2 == ""
end

function PowerUpsScreenHandler.InitializePVP()
	if flag then
		return
	end

	flag = true
	LocalPlayer:GetAttributeChangedSignal("PVPPowerUpOffensive"):Connect(RefreshPVPSlots)
	LocalPlayer:GetAttributeChangedSignal("PVPPowerUpDefensive"):Connect(RefreshPVPSlots)
	RefreshPVPSlots()
end

function PowerUpsScreenHandler.EnablePVP(flag4: boolean?)
	if flag2 then
		return
	end

	flag2 = true

	if flag4 then
		powerUpsPVP.Position = udim11
		TweenService:Create(powerUpsPVP, tweenInfo, { Position = position }):Play()
	else
		TweenService:Create(powerUpsPVP, tweenInfo2, { Position = position }):Play()
	end

	powerUpsPVP.Visible = true
	RefreshPVPSlots()
end

function PowerUpsScreenHandler.DisablePVP()
	if not flag2 then
		return
	end

	flag2 = false
	TweenService:Create(powerUpsPVP, tweenInfo2, { Position = udim11 }):Play()
	powerUpsPVP.Visible = false
end

PowerUpsScreenHandler.Disable()
powerUpsPVP.Position = udim11
powerUpsPVP.Visible = false

for _, button in pairs(inner:GetChildren()) do
	if button:IsA("ImageButton") then
		v3[button.Name] = NewPowerUpButton(button, loadAssetTemplates, v7)
	end
end

for _, button in pairs(inner2:GetChildren()) do
	if not button:IsA("ImageButton") then
		continue
	end

	local newPowerUpButton = NewPowerUpButton(button, loadAssetTemplates2, v8, true)

	if not newPowerUpButton then
		continue
	end

	v4[button.Name] = newPowerUpButton
	newPowerUpButton:SetInLoadout(nil)
end

InventoryChanged(Data.Get("Inventory"))
Data.Updated:Connect(function(p: string)
	if p == "Inventory" then
		InventoryChanged(Data.Get("Inventory"))
	end
end)
toggleButton.Activated:Connect(function()
	if PowerUpsDisabledForDifficulty() then -- inferred equivalent call
		event:Fire("Power-ups disabled for this difficulty!")
	else
		if not PowerUpsDisabledForMapDifficulty() then -- inferred equivalent call
			main.Visible = not main.Visible
			return
		end

		event:Fire("Power-ups disabled for this map!")
	end

	main.Visible = false
end)
event2:AttachCallback(function(p: string)
	Easy = p
	UpdateEnabled() -- inferred equivalent call
end)
event3:AttachCallback(function(_: string, p: string)
	easy = p
	UpdateEnabled() -- inferred equivalent call
end)
event5:AttachCallback(function(items)
	for k, item in items do
		local v9 = v3[k] or v4[k]

		if v9 then
			v9:OnUsageStatsChanged(item.NumUsed)
		end
	end
end)
event6:AttachCallback(function()
	for _, v9 in v3 do
		v9:OnConfigChanged()
	end

	for _, v9 in v4 do
		v9:OnConfigChanged()
	end

	if flag then
		RefreshPVPSlots()
	end
end)
event7:AttachCallback(function(value: number, _: boolean)
	v5 = value or 0

	for _, v9 in v3 do
		v9:_UpdateState()
	end

	for _, v9 in v4 do
		v9:_UpdateState()
	end
end)
event4:AttachCallback(function(p: number)
	v6 = p

	for _, v9 in v3 do
		v9:_UpdateState()
	end

	for _, v9 in v4 do
		v9:_UpdateState()
	end
end)
return PowerUpsScreenHandler