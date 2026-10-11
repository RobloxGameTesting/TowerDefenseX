local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Util = require(TDX_Shared.Modules.Util)
local Data = require(TDX_Shared.Client.Services.Data)
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(0, 0, 0)
local event = NetworkingHandler.GetEvent("RequestUpdateSetting")
local v = { "Visuals", "Sounds" }
local v2 = Util.Create("Sound", {
	Name = "SettingOff",
	SoundId = "rbxassetid://15098083849",
	Volume = 0.5,
	Parent = workspace,
	SoundGroup = GameSoundHandler.GetSoundGroup("UI")
})
local v3 = Util.Create("Sound", {
	Name = "SettingOn",
	SoundId = "rbxassetid://15098084231",
	Volume = 0.5,
	Parent = workspace,
	SoundGroup = GameSoundHandler.GetSoundGroup("UI")
})
local SettingsWindow = { ClassName = script.Name, ClassModule = script }
SettingsWindow.__index = SettingsWindow

function SettingsWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, SettingsWindow))
end

function SettingsWindow:Init()
	for _, childName in ipairs(v) do
		local v4 = childName
		self.Cleaner:Add(self.Root.Categories:FindFirstChild(childName).Activated:Connect(function()
			self:UpdateFrame(v4)
			self:ShowFrame(v4)
		end))
		self:UpdateFrame(childName)
	end
end

local function updateSetting(name: string, p) -- 3 equivalent calls inferred from this helper
	Data.Update("Settings", function(p2)
		p2[name] = p
		return p2
	end)
	event:FireServer(name, p)
end

local function setSliderState(frame, p)
	for _, child in ipairs(frame:GetChildren()) do
		local name = tonumber(child.Name)

		if not name then
			continue
		end

		local image

		if name <= p then
			image = child.HoverImage
		else
			image = child:GetAttribute("Base")
		end

		child.Image = image
	end
end

local function setButtonState(p, flag: boolean) -- 2 equivalent calls inferred from this helper
	p.Image = "rbxassetid://11347201763"
	local textLabel = p.TextLabel
	local textColor

	if flag then
		textColor = color2
	else
		textColor = color
	end

	textLabel.TextColor3 = textColor
end

local function updateButtonState(p, p2) -- 3 equivalent calls inferred from this helper
	setButtonState(p.on, p2) -- inferred equivalent call
	setButtonState(p.off, not p2) -- inferred equivalent call
end

function SettingsWindow:UpdateFrame(childName)
	local settings = Data.Get("Settings")
	local child = self.Root.Frames:FindFirstChild(childName)

	for _, child2 in ipairs(child:GetChildren()) do
		if child2:FindFirstChild("on") then
			updateButtonState(child2, settings[child2.Name]) -- inferred equivalent call
			local v4 = child2
			self.Cleaner:Add(child2.on.Activated:Connect(function()
				v3:Play()
				local name = v4.Name
				local v5 = true
				Data.Update("Settings", function(p)
					p[name] = v5
					return p
				end)
				event:FireServer(name, true)
				updateButtonState(v4, settings[v4.Name]) -- inferred equivalent call
			end))
			local v5 = child2
			self.Cleaner:Add(child2.off.Activated:Connect(function()
				v2:Play()
				local name = v5.Name
				local v6 = false
				Data.Update("Settings", function(p)
					p[name] = v6
					return p
				end)
				event:FireServer(name, false)
				updateButtonState(v5, settings[v5.Name]) -- inferred equivalent call
			end))
		elseif child2:FindFirstChild("Frame") and child2.Frame:FindFirstChild("1") then
			setSliderState(child2.Frame, settings[child2.Name])

			for i = 1, 10 do
				local child3 = child2.Frame:FindFirstChild((tostring(i)))
				local v4 = child2
				self.Cleaner:Add(child3.Activated:Connect(function()
					setSliderState(v4.Frame, tonumber(child3.Name))
					updateSetting(v4.Name, tonumber(child3.Name)) -- inferred equivalent call
				end))
			end

			local v4 = child2
			self.Cleaner:Add(child2.Frame.down.Activated:Connect(function()
				local v5 = math.clamp(settings[v4.Name] - 1, 0, 10)
				setSliderState(v4.Frame, v5)
				updateSetting(v4.Name, v5) -- inferred equivalent call
			end))
			local v5 = child2
			self.Cleaner:Add(child2.Frame.up.Activated:Connect(function()
				local v6 = math.clamp(settings[v5.Name] + 1, 0, 10)
				setSliderState(v5.Frame, v6)
				updateSetting(v5.Name, v6) -- inferred equivalent call
			end))
		end
	end
end

function SettingsWindow:ShowFrame(p)
	for _, childName in ipairs(v) do
		local findFirstChild = self.Root.Frames:FindFirstChild(childName)
		findFirstChild.Visible = childName == p
	end
end

function SettingsWindow.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { SettingsWindow })
return SettingsWindow