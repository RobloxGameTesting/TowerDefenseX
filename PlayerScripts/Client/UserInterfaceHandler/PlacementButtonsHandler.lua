local PlacementButtonsHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local event = BindableHandler.GetEvent("UserInputStateChanged")
local event2 = BindableHandler.GetEvent("StopTowerPlacement")
local event3 = BindableHandler.GetEvent("TowerPlacementRotationIncrement")
local touchPlacementButtons = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BottomBar"):WaitForChild("TouchPlacementButtons")
local hint = touchPlacementButtons:WaitForChild("Hint")
local leftButton = touchPlacementButtons:WaitForChild("LeftButton")
local rightButton = touchPlacementButtons:WaitForChild("RightButton")
local centerButton = touchPlacementButtons:WaitForChild("CenterButton")
local v = nil
local v2 = nil
local v3 = nil
local v4 = true
local v5 = false
local v6 = false

local function SetUpButton(instance, text: string, fn)
	local textLabel = instance:WaitForChild("TextLabel")
	textLabel.Text = text
	local v7 = {
		Button = instance,
		Callback = fn,
		EnabledForUserInputType = false,
		EnabledForUserInputState = false,
		SetEnabledForUserInputType = function(self, enabledForUserInputType: boolean)
			self.EnabledForUserInputType = enabledForUserInputType
			self:UpdateState()
		end,
		SetEnabledForUserInputState = function(self, enabledForUserInputState: boolean)
			self.EnabledForUserInputState = enabledForUserInputState
			self:UpdateState()
		end,
		UpdateState = function(self)
			if v4 and self.EnabledForUserInputType and self.EnabledForUserInputState then
				self.Button.Visible = true
			else
				self.Button.Visible = false
			end
		end
	}
	instance.Activated:Connect(function()
		v7.Callback()
	end)
	return v7
end

local function StopPlacement() -- 2 equivalent calls inferred from this helper
	event2:Fire()
end

local function Rotate() -- 1 equivalent call inferred from this helper
	event3:Fire()
end

local function UpdateHintState() -- 4 equivalent calls inferred from this helper
	if v4 and v6 and v5 then
		hint.Visible = true
	else
		hint.Visible = false
	end
end

local function HintIfTouchControls(flag: boolean, text: string?)
	v6 = flag

	if text then
		hint.Text = text
	end

	UpdateHintState() -- inferred equivalent call
end

function PlacementButtonsHandler.EnableTouchControls()
	v:SetEnabledForUserInputType(true)
	v2:SetEnabledForUserInputType(true)
	v3:SetEnabledForUserInputType(true)
	v5 = true
	touchPlacementButtons.Visible = true
end

function PlacementButtonsHandler.DisableTouchControls()
	v:SetEnabledForUserInputType(false)
	v2:SetEnabledForUserInputType(false)
	v3:SetEnabledForUserInputType(false)
	v5 = false
	touchPlacementButtons.Visible = false
end

function PlacementButtonsHandler.Enable()
	v4 = true
	v:UpdateState()
	v2:UpdateState()
	v3:UpdateState()
	UpdateHintState() -- inferred equivalent call
end

function PlacementButtonsHandler.Disable()
	v4 = false
	v:UpdateState()
	v2:UpdateState()
	v3:UpdateState()
	UpdateHintState() -- inferred equivalent call
end

hint.Visible = false
v = SetUpButton(leftButton, "ROTATE", function()
	Rotate() -- inferred equivalent call
end)
v2 = SetUpButton(rightButton, "CANCEL", function()
	StopPlacement() -- inferred equivalent call
end)
v3 = SetUpButton(centerButton, "CANCEL", function()
	StopPlacement() -- inferred equivalent call
end)
event:AttachCallback(function(p: string)
	if p == "Retargeting" then
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(true)
		v6 = true
		hint.Text = "Double tap to retarget!"
	elseif p == "AimingAbility" then
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(true)
		v6 = true
		hint.Text = "Double tap on path to use!"
	elseif p == "RelocationAbility" then
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(true)
		v6 = true
		hint.Text = "Double tap to confirm placement!"
	elseif p == "AimingAtTowerAbility" then
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(true)
		v6 = true
		hint.Text = "Double tap on target tower to use!"
	elseif p == "InitialAiming" then
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(true)
		v6 = true
		hint.Text = "Double tap to aim!"
	elseif p == "Placement" then
		v:SetEnabledForUserInputState(true)
		v2:SetEnabledForUserInputState(true)
		v3:SetEnabledForUserInputState(false)
		v6 = true
		hint.Text = "Double tap to confirm placement!"
	elseif p == "AimingPowerUpGround" then
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(true)
		v6 = true
		hint.Text = "Double tap to use!"
	elseif p == "AimingPowerUpGroundDirectional" then
		v:SetEnabledForUserInputState(true)
		v2:SetEnabledForUserInputState(true)
		v3:SetEnabledForUserInputState(false)
		v6 = true
		hint.Text = "Double tap to use!"
	elseif p == "AimingPowerUpPath" then
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(true)
		v6 = true
		hint.Text = "Double tap on path to use!"
	elseif p == "TowerRotation" then
		v:SetEnabledForUserInputState(true)
		v2:SetEnabledForUserInputState(true)
		v3:SetEnabledForUserInputState(false)
		v6 = true
		hint.Text = "Double tap to confirm rotation!"
	else
		v:SetEnabledForUserInputState(false)
		v2:SetEnabledForUserInputState(false)
		v3:SetEnabledForUserInputState(false)
		v6 = false
	end

	UpdateHintState() -- inferred equivalent call
end)
return PlacementButtonsHandler