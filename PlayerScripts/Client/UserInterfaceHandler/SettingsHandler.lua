local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Data = require(TDX_Shared.Client.Services.Data)
local ControlsWindow = require(TDX_Shared:WaitForChild("Components"):WaitForChild("ControlsWindow"))
local VIP_GAMEPASS_ID = _G.VIP_GAMEPASS_ID
local isTenFootInterface = GuiService:IsTenFootInterface()
local v = _G.DISABLE_BLOOD_CONSOLE and isTenFootInterface
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(0, 0, 0)
local event = NetworkingHandler.GetEvent("RequestUpdateSetting")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Interface = PlayerGui:WaitForChild("Interface")
local button = PlayerGui:WaitForChild("LowPriorityInterface"):WaitForChild("LeftButtons"):WaitForChild("SettingsButton"):WaitForChild("Button")
local Settings = Interface:WaitForChild("Settings")
local Categories = Settings:WaitForChild("Categories")
local Frames = Settings:WaitForChild("Frames")
local v2 = nil

local function NewButtonHandler(instance, p: string, p2: string, p3)
	local v3 = {
		TextLabel = instance:FindFirstChild("TextLabel"),
		Hovered = false,
		Active = false,
		SetHovered = function(self, hovered: boolean)
			self.Hovered = hovered
			self:UpdateState()
		end,
		SetActive = function(self, active: boolean)
			self.Active = active
			self:UpdateState()
		end,
		UpdateState = function(self)
			local hovered = self.Hovered or self.Active
			local image = hovered and p2 or p

			if p3 then
				p3.Image = image
			else
				instance.Image = image
			end

			if self.TextLabel then
				self.TextLabel.TextColor3 = hovered and color2 or color
			end
		end
	}
	instance.MouseEnter:Connect(function()
		v3:SetHovered(true)
	end)
	instance.MouseLeave:Connect(function()
		v3:SetHovered(false)
	end)
	v3:UpdateState()
	return v3
end

local function IsBooleanSetting(frame) -- 1 equivalent call inferred from this helper
	return frame:FindFirstChild("on") ~= nil
end

local function UpdateBooleanState(flag: boolean, object, object2) -- 3 equivalent calls inferred from this helper
	object:SetActive(flag)
	object2:SetActive(not flag)
end

local function UpdateBooleanSetting(p: string, flag: boolean)
	SoundHandler.Play(flag and "SettingOn" or "SettingOff")
	Data.Update("Settings", function(p2)
		p2[p] = flag
		return p2
	end)
	event:FireServer(p, flag)
end

local function IsSliderSetting(frame) -- 1 equivalent call inferred from this helper
	return frame:FindFirstChild("Frame") ~= nil and frame.Frame:FindFirstChild("1") ~= nil
end

local function UpdateSliderState(p: number, list) -- 4 equivalent calls inferred from this helper
	for i, v3 in ipairs(list) do
		v3:SetActive(i <= p)
	end
end

local function UpdateSliderSetting(name: string, p: number) -- 3 equivalent calls inferred from this helper
	Data.Update("Settings", function(p2)
		p2[name] = p
		return p2
	end)
	event:FireServer(name, p)
end

local function AddControlsTab()
	local v3 = ControlsWindow.AddSettingsTab(Categories, Categories:WaitForChild("General"))
	NewButtonHandler(v3, "rbxassetid://11347200850", "rbxassetid://11347201155")
	v2 = ControlsWindow.new(Interface, function()
		Settings.Visible = true
	end)
	v3.Activated:Connect(function()
		Settings.Visible = false
		v2:Open()
	end)
end

button.Activated:Connect(function()
	if v2 and v2:IsOpen() then
		v2:Close()
	else
		Settings.Visible = not Settings.Visible
	end
end)

for _, childName in pairs({ "General", "Sounds" }) do
	local child = Categories:WaitForChild(childName)
	NewButtonHandler(child, "rbxassetid://11347200850", "rbxassetid://11347201155")
	local child2 = Frames:WaitForChild(childName)
	child.Activated:Connect(function()
		for _, child3 in pairs(Frames:GetChildren()) do
			child3.Visible = child2 == child3
		end
	end)
	local children = Frames:WaitForChild(childName):GetChildren()

	for _, frame in pairs(children) do
		if not frame:IsA("Frame") then
			continue
		end

		if IsBooleanSetting(frame) then -- inferred equivalent call
			local name = frame.Name

			if v and name == "Blood" then
				frame.Visible = false
			else
				local on = frame:WaitForChild("on")
				local off = frame:WaitForChild("off")
				local newButtonHandler = NewButtonHandler(on, "rbxassetid://11347201481", "rbxassetid://11347201763")
				local newButtonHandler2 = NewButtonHandler(off, "rbxassetid://11347201481", "rbxassetid://11347201763")
				local v3 = frame

				local function CheckVIP()
					if not v3:GetAttribute("VIP") or LocalPlayer:GetAttribute("VIP") then
						return true
					end

					task.spawn(function()
						MarketplaceService:PromptGamePassPurchase(LocalPlayer, VIP_GAMEPASS_ID)
					end)
					return false
				end

				on.Activated:Connect(function()
					if not CheckVIP() then
						return
					end

					local name2 = name
					SoundHandler.Play("SettingOn")
					local v4 = true
					Data.Update("Settings", function(p)
						p[name2] = v4
						return p
					end)
					event:FireServer(name2, true)
					UpdateBooleanState(true, newButtonHandler, newButtonHandler2) -- inferred equivalent call
				end)
				off.Activated:Connect(function()
					local name2 = name
					SoundHandler.Play("SettingOff")
					local v4 = false
					Data.Update("Settings", function(p)
						p[name2] = v4
						return p
					end)
					event:FireServer(name2, false)
					UpdateBooleanState(false, newButtonHandler, newButtonHandler2) -- inferred equivalent call
				end)
				UpdateBooleanState(Data.Get("Settings")[name], newButtonHandler, newButtonHandler2) -- inferred equivalent call
			end
		elseif IsSliderSetting(frame) then -- inferred equivalent call
			local name = frame.Name
			local frame2 = frame:WaitForChild("Frame")
			local down = frame2:WaitForChild("down")
			local up = frame2:WaitForChild("up")
			NewButtonHandler(
				down,
				"rbxassetid://15344491372",
				"rbxassetid://15344491464",
				down:FindFirstChildOfClass("ImageLabel")
			)
			NewButtonHandler(
				up,
				"rbxassetid://15344491300",
				"rbxassetid://15344491224",
				up:FindFirstChildOfClass("ImageLabel")
			)
			local v3 = {}
			down.Activated:Connect(function()
				local v4 = math.clamp(Data.Get("Settings")[name] - 1, 0, 10)
				UpdateSliderSetting(name, v4) -- inferred equivalent call
				UpdateSliderState(v4, v3) -- inferred equivalent call
			end)
			up.Activated:Connect(function()
				local v4 = math.clamp(Data.Get("Settings")[name] + 1, 0, 10)
				UpdateSliderSetting(name, v4) -- inferred equivalent call
				UpdateSliderState(v4, v3) -- inferred equivalent call
			end)

			for i = 1, 10 do
				local child3 = frame2:WaitForChild((tostring(i)))
				local newButtonHandler = NewButtonHandler(
					child3,
					"rbxassetid://11347201481",
					"rbxassetid://11347201763",
					child3:FindFirstChildOfClass("ImageLabel")
				)
				local v4 = i
				child3.Activated:Connect(function()
					UpdateSliderSetting(name, v4) -- inferred equivalent call
					UpdateSliderState(v4, v3) -- inferred equivalent call
				end)
				v3[i] = newButtonHandler
			end

			UpdateSliderState(Data.Get("Settings")[name], v3) -- inferred equivalent call
		end
	end
end

if UserInputService.KeyboardEnabled then
	AddControlsTab()
end

return {}