local SettingsWindow = { ClassName = script.Name, ClassModule = script }
SettingsWindow.__index = SettingsWindow
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Network = require(ReplicatedFirst.Client.Network)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Data = require(TDX_Shared.Client.Services.Data)
local ControlsWindow = require(TDX_Shared.Components.ControlsWindow)
local v = { "General", "Sounds" }
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(0, 0, 0)
local LocalPlayer = Players.LocalPlayer

local function NewButtonHandler(instance, p: string, p2: string, p3)
	local v2 = {
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
		v2:SetHovered(true)
	end)
	instance.MouseLeave:Connect(function()
		v2:SetHovered(false)
	end)
	v2:UpdateState()
	return v2
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
	Network.Fire("UpdateSetting", p, flag)
end

local function IsSliderSetting(frame) -- 1 equivalent call inferred from this helper
	return frame:FindFirstChild("Frame") ~= nil and frame.Frame:FindFirstChild("1") ~= nil
end

local function UpdateSliderState(p: number, list) -- 4 equivalent calls inferred from this helper
	for i, v2 in ipairs(list) do
		v2:SetActive(i <= p)
	end
end

local function UpdateSliderSetting(name: string, p: number) -- 3 equivalent calls inferred from this helper
	Data.Update("Settings", function(p2)
		p2[name] = p
		return p2
	end)
	Network.Fire("UpdateSetting", name, p)
end

function SettingsWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, SettingsWindow))
end

function SettingsWindow:Init()
	local root = self.Root
	local categories = root.Categories
	local frames = root.Frames
	local v2 = nil

	for _, childName in pairs(v) do
		local child = categories:WaitForChild(childName)
		local newButtonHandler = NewButtonHandler(child, "rbxassetid://11347200850", "rbxassetid://11347201155")
		local child2 = frames:WaitForChild(childName)
		child.Activated:Connect(function()
			for _, child3 in pairs(frames:GetChildren()) do
				child3.Visible = child2 == child3
			end

			if v2 then
				v2:SetActive(false)
			end

			v2 = newButtonHandler
			newButtonHandler:SetActive(true)
		end)

		if childName == "General" then
			newButtonHandler:SetActive(true)
			v2 = newButtonHandler
		end

		local children = frames:WaitForChild(childName):GetChildren()

		for _, frame in pairs(children) do
			if not (frame:IsA("Frame") and frame.Name ~= "DIV") then
				continue
			end

			if IsBooleanSetting(frame) then -- inferred equivalent call
				local name = frame.Name
				local on = frame:WaitForChild("on")
				local off = frame:WaitForChild("off")
				local newButtonHandler2 = NewButtonHandler(on, "rbxassetid://11347201481", "rbxassetid://11347201763")
				local newButtonHandler3 = NewButtonHandler(off, "rbxassetid://11347201481", "rbxassetid://11347201763")
				local v3 = frame

				local function CheckVIP()
					if not v3:GetAttribute("VIP") or LocalPlayer:GetAttribute("VIP") then
						return true
					end

					task.spawn(function()
						MarketplaceService:PromptGamePassPurchase(LocalPlayer, _G.VIP_GAMEPASS_ID)
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
					Network.Fire("UpdateSetting", name2, true)
					UpdateBooleanState(true, newButtonHandler2, newButtonHandler3) -- inferred equivalent call
				end)
				off.Activated:Connect(function()
					local name2 = name
					SoundHandler.Play("SettingOff")
					local v4 = false
					Data.Update("Settings", function(p)
						p[name2] = v4
						return p
					end)
					Network.Fire("UpdateSetting", name2, false)
					UpdateBooleanState(false, newButtonHandler2, newButtonHandler3) -- inferred equivalent call
				end)
				UpdateBooleanState(Data.Get("Settings")[name], newButtonHandler2, newButtonHandler3) -- inferred equivalent call
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
					local newButtonHandler2 = NewButtonHandler(
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
					v3[i] = newButtonHandler2
				end

				UpdateSliderState(Data.Get("Settings")[name], v3) -- inferred equivalent call
			end
		end
	end

	if UserInputService.KeyboardEnabled then
		self:_AddControlsTab()
	end
end

function SettingsWindow:_AddControlsTab()
	local root = self.Root
	local categories = root.Categories
	local v2 = ControlsWindow.AddSettingsTab(categories, categories:WaitForChild("General"))
	NewButtonHandler(v2, "rbxassetid://11347200850", "rbxassetid://11347201155")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "Controls"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	screenGui.DisplayOrder = 5
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	local v3 = ControlsWindow.new(screenGui, function()
		root.Visible = true
	end)
	self.Cleaner:Add(v3)
	self.Cleaner:Add(screenGui)
	self.Cleaner:Add(v2.Activated:Connect(function()
		for _, v4 in Director.GetItemsFromClass(Director.Classes.Sidebar) do
			v4:AddFrame("Controls", v3.Root)
		end

		root.Visible = false
		v3:Open()
	end))
end

function SettingsWindow.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { SettingsWindow })
return SettingsWindow