local createVector = vector.create

if workspace:GetAttribute("IsLobby") then
	return {}
end

local PingUI = { ClassName = script.Name, ClassModule = script }
PingUI.__index = PingUI
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local Keybinds = require(Common:WaitForChild("Keybinds"))
local PingConfig = require(Common:WaitForChild("PingConfig"))
local PingWorldMarker = require(Common:WaitForChild("PingWorldMarker"))
local MapHandler = require(Common:WaitForChild("MapHandler"))
local ButtonR3 = Enum.KeyCode.ButtonR3
local v = { Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonA }
local ButtonB = Enum.KeyCode.ButtonB
local Thumbstick1 = Enum.KeyCode.Thumbstick1
local Gamepad1 = Enum.UserInputType.Gamepad1
local tweenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local SlotCount = PingConfig.SlotCount
local AngleOffsetDegrees = PingConfig.AngleOffsetDegrees
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local CurrentCamera = workspace.CurrentCamera
local event = BindableHandler.GetEvent("ErrorPrompt")
local Pings = PlayerGui:WaitForChild("Pings", 10)
local PingActiveIconPC = Pings:WaitForChild("PingActiveIconPC", 10)
local WheelFrame = Pings:WaitForChild("WheelFrame", 10)
local UIScale = WheelFrame:WaitForChild("UIScale", 10)
local CenterFrame = WheelFrame:WaitForChild("CenterFrame", 10)
local Background = CenterFrame:WaitForChild("Background", 10)
local Info = CenterFrame:WaitForChild("Info", 10)
local Button = CenterFrame:WaitForChild("Button", 10)
local mouseIcon = CenterFrame:WaitForChild("CancelFrame", 10):WaitForChild("MouseIcon", 10)
local children = {}
local selecteds = {}
local buttons = {}
local icons = {}

for i = 1, SlotCount do
	local child = WheelFrame:WaitForChild(tostring(i), 10)
	children[i] = child
	selecteds[i] = child:WaitForChild("Selected", 10)
	local button = child:WaitForChild("Button", 10)
	buttons[i] = button
	local icon = button:WaitForChild("Icon", 10)
	icons[i] = icon
	local ping = PingConfig.Pings[i]

	if ping then
		icon.Image = ping.WorldIcon
	end
end

local PingButton = PlayerGui:WaitForChild("PingButton", 10)
local button = PingButton:WaitForChild("Button", 10)
local BackgroundInactive = button:WaitForChild("BackgroundInactive", 10)
local BackgroundActive = button:WaitForChild("BackgroundActive", 10)

local function GetSlotFromAngle(x: number, y: number, p: number, p2: number) -- 2 equivalent calls inferred from this helper
	return math.floor(((90 - math.deg((math.atan2(y - p2, p - x))) - AngleOffsetDegrees) % 360 + 360) % 360 / (360 / SlotCount)) + 1
end

local function IsInDeadzone(x: number, y: number, x2: number, y2: number) -- 1 equivalent call inferred from this helper
	local v2 = CenterFrame.AbsoluteSize.X * 0.5
	local v3 = x2 - x
	local v4 = y2 - y
	return v3 * v3 + v4 * v4 <= v2 * v2
end

local function RaycastCursor(point: Vector2)
	local viewportPointToRay = CurrentCamera:ViewportPointToRay(point.X, point.Y)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	raycastParams.IgnoreWater = false
	local raycastResult = workspace:Raycast(
		viewportPointToRay.Origin,
		viewportPointToRay.Direction * 1000,
		raycastParams
	)

	if raycastResult then
		return raycastResult.Instance, raycastResult.Position
	end

	return nil, nil
end

local function ResolveInputMode(p) -- 2 equivalent calls inferred from this helper
	if p == Enum.UserInputType.Touch then
		return "Touch"
	end

	if
		p == Enum.UserInputType.MouseButton1
		or p == Enum.UserInputType.MouseMovement
		or p == Enum.UserInputType.Keyboard
	then
		return "Mouse"
	end

	if string.sub(p.Name, 1, 7) == "Gamepad" then
		return "Gamepad"
	end

	return nil
end

local controls = nil

local function GetPlayerControls()
	if controls then
		return controls
	end

	local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
	local playerModule = playerScripts and playerScripts:FindFirstChild("PlayerModule")

	if playerModule and playerModule:IsA("ModuleScript") then
		local module = require(playerModule)
		controls = module:GetControls()
	end

	return controls
end

function PingUI.new(_)
	return (setmetatable({
		Cleaner = Cleaner.new(),
		State = "Inactive",
		UseTouch = UserInputService:GetLastInputType() == Enum.UserInputType.Touch,
		UseGamepad = false,
		Selected = 0,
		WheelOpenPosition = createVector(0, 0, 0),
		WheelScreenCenter = Vector2.zero,
		ActiveTween = nil,
		FiredEvent = nil,
		CursorTrackingConnection = nil,
		PingTimes = {},
		LockoutUntil = 0,
		InputLocked = false,
		SavedCameraType = Enum.CameraType.Custom,
		RestoreToken = 0
	}, PingUI))
end

function PingUI:ApplySelected(selected: number)
	self.Selected = selected

	for i = 1, SlotCount do
		local ping = PingConfig.Pings[i]
		local visible = i == self.Selected
		selecteds[i].Visible = visible
		children[i].ImageTransparency = visible and 1 or 0

		if ping then
			icons[i].ImageColor3 = visible and ping.ActiveColor or ping.InactiveColor
		end
	end

	local ping = PingConfig.Pings[self.Selected]
	Background.ImageColor3 = ping and ping.ActiveColor or PingConfig.NoneInactiveColor

	if ping then
		Info.Text = ping.Text
		Info.TextColor3 = ping.ActiveColor
	else
		Info.Text = PingConfig.NoneText
		Info.TextColor3 = PingConfig.NoneInactiveColor
	end
end

function PingUI:TweenWheelScale(scale: number, callback)
	if self.ActiveTween then
		self.ActiveTween:Cancel()
	end

	local tween = TweenService:Create(UIScale, UIScale.Scale < scale and tweenInfo or tweenInfo2, {
		Scale = scale
	})
	self.ActiveTween = tween

	if callback then
		local completedConnection = nil
		completedConnection = tween.Completed:Connect(function(p)
			if completedConnection then
				completedConnection:Disconnect()
				completedConnection = nil
			end

			if p == Enum.PlaybackState.Completed then
				callback()
			end
		end)
	end

	tween:Play()
end

function PingUI:StartCursorTracking()
	if self.CursorTrackingConnection then
		return
	end

	PingActiveIconPC.AnchorPoint = Vector2.new(1, 0)
	self.CursorTrackingConnection = RunService.RenderStepped:Connect(function()
		local mouseLocation = UserInputService:GetMouseLocation()
		PingActiveIconPC.Position = UDim2.fromOffset(mouseLocation.X + 4, mouseLocation.Y + 6)
	end)
end

function PingUI:StopCursorTracking()
	if self.CursorTrackingConnection then
		self.CursorTrackingConnection:Disconnect()
		self.CursorTrackingConnection = nil
	end
end

function PingUI:SetTargetingVisible(visible: boolean)
	local visible2 = visible and not (self.UseTouch or self.UseGamepad)
	PingActiveIconPC.Visible = visible2

	if visible2 then
		self:StartCursorTracking()
	else
		self:StopCursorTracking()
	end

	BackgroundInactive.Visible = not visible
	BackgroundActive.Visible = visible
end

function PingUI:EnterTargeting()
	if self.State ~= "Inactive" then
		return
	end

	self.State = "Targeting"
	self:SetTargetingVisible(true)
end

function PingUI:ExitToInactive(p: number?)
	self.State = "Inactive"
	self:SetInputLocked(false, p)
	self:SetTargetingVisible(false)
	self:TweenWheelScale(0, function()
		WheelFrame.Visible = false
	end)
end

function PingUI:OpenWheel(wheelOpenPosition: Vector3, wheelScreenCenter: Vector2)
	self.WheelOpenPosition = wheelOpenPosition
	self.State = "WheelOpen"
	self.Selected = 0
	PingActiveIconPC.Visible = false
	self:StopCursorTracking()
	UIScale.Scale = 0
	WheelFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	self.WheelScreenCenter = wheelScreenCenter
	WheelFrame.Position = UDim2.fromOffset(wheelScreenCenter.X, wheelScreenCenter.Y)
	WheelFrame.Visible = true
	self:ApplySelected(0)
	self:TweenWheelScale(1)
end

function PingUI:TryConsumePing()
	local now = os.clock()
	local v2 = now - PingConfig.WindowSeconds
	local pingTimes = {}

	for _, pingTime in ipairs(self.PingTimes) do
		if v2 <= pingTime then
			table.insert(pingTimes, pingTime)
		end
	end

	self.PingTimes = pingTimes

	if not (now < self.LockoutUntil) then
		if not (#self.PingTimes >= PingConfig.MaxPings) then
			table.insert(self.PingTimes, now)
			return true
		end

		self.LockoutUntil = now + PingConfig.WindowSeconds
	end

	event:Fire(`Slow down! Wait {math.ceil(self.LockoutUntil - now)}s before pinging again.`)
	return false
end

function PingUI:Confirm(p: number)
	if not PingConfig.Pings[p] then
		self:ExitToInactive(0.5)
		return
	end

	if not self:TryConsumePing() then
		self:ExitToInactive(0.5)
		return
	end

	PingWorldMarker.Render(p, self.WheelOpenPosition, LocalPlayer.DisplayName, LocalPlayer.UserId)

	if self.FiredEvent then
		self.FiredEvent:FireServer(p, self.WheelOpenPosition)
	end

	self:ExitToInactive(0.5)
end

function PingUI:ApplyInputMode(p: string)
	local v2 = p == "Touch"
	local visible = p == "Mouse"
	self.UseTouch = v2
	self.UseGamepad = p == "Gamepad"
	PingButton.Enabled = v2

	if not visible then
		PingActiveIconPC.Visible = false
	end

	mouseIcon.Visible = visible
	Button.Active = v2

	for i = 1, SlotCount do
		buttons[i].Active = v2
	end
end

function PingUI:ToggleWheelGamepad()
	if self.State == "WheelOpen" then
		self:ExitToInactive()
		return
	end

	local mouseLocation = UserInputService:GetMouseLocation()
	local _, v2 = RaycastCursor(mouseLocation)

	if v2 then
		self:OpenWheel(v2, mouseLocation)
		self:SetInputLocked(true)
	end
end

function PingUI:SetInputLocked(inputLocked: boolean, duration: number?)
	if inputLocked == self.InputLocked then
		return
	end

	self.InputLocked = inputLocked
	self.RestoreToken += 1

	if inputLocked then
		local playerControls = GetPlayerControls()

		if playerControls then
			playerControls:Disable()
		end

		if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			self.SavedCameraType = CurrentCamera.CameraType
		end

		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		ContextActionService:BindActionAtPriority("PingWheelConfirm", function(_: string, p, _)
			if p == Enum.UserInputState.Begin and self.Selected > 0 then
				self:Confirm(self.Selected)
			end

			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, table.unpack(v))
		ContextActionService:BindActionAtPriority("PingWheelCancel", function(_: string, p, _)
			if p == Enum.UserInputState.Begin then
				self:ExitToInactive()
			end

			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, ButtonB)
	else
		ContextActionService:UnbindAction("PingWheelConfirm")
		ContextActionService:UnbindAction("PingWheelCancel")
		local restoreToken = self.RestoreToken

		local function Restore() -- 1 equivalent call inferred from this helper
			if restoreToken ~= self.RestoreToken then
				return
			end

			local playerControls = GetPlayerControls()

			if playerControls then
				playerControls:Enable()
			end

			CurrentCamera.CameraType = self.SavedCameraType
		end

		if duration and duration > 0 then
			task.delay(duration, Restore)
			return
		end

		Restore() -- inferred equivalent call
	end
end

function PingUI:Init()
	self.FiredEvent = NetworkingHandler.GetEvent("PingFired")
	NetworkingHandler.GetEvent("PingBroadcast"):AttachCallback(function(player, p: number, vector: Vector3)
		local displayName

		if player then
			displayName = player.DisplayName or nil
		end

		local userId = player and player.UserId or nil
		PingWorldMarker.Render(p, vector, displayName, userId)
	end)
	WheelFrame.Visible = false
	UIScale.Scale = 0
	self:SetTargetingVisible(false)
	self:ApplyInputMode(ResolveInputMode(UserInputService:GetLastInputType()) or "Mouse") -- inferred equivalent call
	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed: boolean)
		if Keybinds.IsActionInput("Ping", input) and not (gameProcessed or self.UseTouch) then
			if self.State == "Inactive" then
				self:EnterTargeting()
			else
				self:ExitToInactive()
			end
		else
			if self.UseTouch or self.UseGamepad then
				return
			end

			if self.State == "Targeting" then
				if gameProcessed then
					return
				end

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local mouseLocation = UserInputService:GetMouseLocation()
					local _, v2 = RaycastCursor(mouseLocation)

					if v2 then
						self:OpenWheel(v2, mouseLocation)
					end
				elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
					self:ExitToInactive()
				end
			elseif self.State == "WheelOpen" then
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if self.Selected > 0 then
						self:Confirm(self.Selected)
					end
				elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
					self:ExitToInactive()
				end
			end
		end
	end))
	self.Cleaner:Add(UserInputService.InputEnded:Connect(function(input)
		if
			self.UseTouch
			or self.UseGamepad
			or self.State ~= "WheelOpen"
			or input.UserInputType ~= Enum.UserInputType.MouseButton1
		then
			return
		end

		if self.Selected > 0 then
			self:Confirm(self.Selected)
		end
	end))
	self.Cleaner:Add(UserInputService.InputChanged:Connect(function(input)
		if self.State ~= "WheelOpen" then
			return
		end

		if input.UserInputType == Gamepad1 and input.KeyCode == Thumbstick1 then
			local x = input.Position.X
			local y = input.Position.Y

			if math.sqrt(x * x + y * y) < 0.2 then
				self:ApplySelected(0)
				return
			end

			local x2 = self.WheelScreenCenter.X
			local y2 = self.WheelScreenCenter.Y
			self:ApplySelected(GetSlotFromAngle(x2, y2, x2 + x, y2 - y)) -- inferred equivalent call
		else
			if self.UseTouch or self.UseGamepad or input.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end

			local mouseLocation = UserInputService:GetMouseLocation()
			local x = self.WheelScreenCenter.X
			local y = self.WheelScreenCenter.Y

			if IsInDeadzone(x, y, mouseLocation.X, mouseLocation.Y) then -- inferred equivalent call
				self:ApplySelected(0)
				return
			end

			self:ApplySelected(GetSlotFromAngle(x, y, mouseLocation.X, mouseLocation.Y)) -- inferred equivalent call
		end
	end))

	local function HandlePingButton(_: string, p, _)
		if p == Enum.UserInputState.Begin then
			self:ToggleWheelGamepad()
		end

		return Enum.ContextActionResult.Sink
	end

	ContextActionService:BindActionAtPriority(
		"PingWheelToggle",
		HandlePingButton,
		false,
		Enum.ContextActionPriority.High.Value,
		ButtonR3
	)
	self.Cleaner:Add(function()
		ContextActionService:UnbindAction("PingWheelToggle")
	end)
	self.Cleaner:Add(UserInputService.TouchTapInWorld:Connect(function(point: Vector2, flag: boolean)
		if not self.UseTouch or flag or self.State ~= "Targeting" then
			return
		end

		local _, v2 = RaycastCursor(point)

		if v2 then
			self:OpenWheel(v2, point)
		end
	end))
	self.Cleaner:Add(UserInputService.LastInputTypeChanged:Connect(function(p)
		local inputMode = ResolveInputMode(p) -- inferred equivalent call

		if not inputMode then
			return
		end

		self:ApplyInputMode(inputMode)
	end))
	self.Cleaner:Add(button.Activated:Connect(function()
		if not self.UseTouch then
			return
		end

		if self.State == "Inactive" then
			self:EnterTargeting()
		else
			self:ExitToInactive()
		end
	end))

	for i = 1, SlotCount do
		local v2 = i
		self.Cleaner:Add(buttons[i].Activated:Connect(function()
			if self.UseTouch and self.State == "WheelOpen" then
				self:Confirm(v2)
			end
		end))
	end

	self.Cleaner:Add(Button.Activated:Connect(function()
		if self.UseTouch and self.State == "WheelOpen" then
			self:ExitToInactive()
		end
	end))
end

function PingUI:Destroy()
	self:StopCursorTracking()
	self:SetInputLocked(false)
	self.Cleaner:Clean()
end

Director.Register(script.Name, { PingUI }, game.Players)
return PingUI