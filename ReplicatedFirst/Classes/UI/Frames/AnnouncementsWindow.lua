local AnnouncementsWindow = { ClassName = script.Name, ClassModule = script }
AnnouncementsWindow.__index = AnnouncementsWindow
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
require(ReplicatedFirst.Client.Network)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
require(TDX_Shared.Client.Services.Data)
local ANNOUNCEMENT_VERSION_HISTORY = _G.ANNOUNCEMENT_VERSION_HISTORY

local function SetButtonActive(currentButton) -- 1 equivalent call inferred from this helper
	local textLabel = currentButton.TextLabel
	currentButton.ImageTransparency = 0
	textLabel.FontFace.Weight = Enum.FontWeight.Bold
end

local function SetButtonInactive(currentButton) -- 2 equivalent calls inferred from this helper
	local textLabel = currentButton.TextLabel
	currentButton.ImageTransparency = 1
	textLabel.FontFace.Weight = Enum.FontWeight.Regular
end

local function GetFirstTab(children) -- 1 equivalent call inferred from this helper
	for _, v in ipairs(children) do
		if v.ClassName == "ImageButton" and v.LayoutOrder == 1 then
			return v
		end
	end
end

function AnnouncementsWindow.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		CurrentFrame = nil,
		CurrentButton = nil,
		CurrentBuildVersion = nil,
		IsVersionDropdownOpen = false,
		CurrentDropdownButton = nil
	}, AnnouncementsWindow))
end

function AnnouncementsWindow:Init()
	local content = self.Root.Content

	for _, child in ipairs(content:GetChildren()) do
		local children = child.LeftNav.Buttons:GetChildren()

		for _, v in ipairs(children) do
			if v.ClassName ~= "ImageButton" then
				continue
			end

			local name = v.Name
			self.Cleaner:Add(v.MouseButton1Click:Connect(function()
				self:SwitchCategory(name)
			end))
			self.Cleaner:Add(v.MouseButton1Down:Connect(function()
				SoundHandler.Play("ClickDown")
			end))
			self.Cleaner:Add(v.MouseButton1Up:Connect(function()
				SoundHandler.Play("ClickUp")
			end))
		end
	end

	self:InitializeVersionButtons()
	self:InitializeContent()
end

function AnnouncementsWindow:InitializeContent()
	local child = self.Root.Content:WaitForChild(self.CurrentBuildVersion)
	self.CurrentButton = GetFirstTab(child.LeftNav.Buttons:GetChildren()) -- inferred equivalent call
	local main = child.Main
	local name = self.CurrentButton.Name

	if self.CurrentBuildVersion == "2.0.0" then
		self:Powerups((main:FindFirstChild(name)))
	end

	self:SwitchCategory(name)
end

function AnnouncementsWindow:Powerups(instance)
	local powerupButton = instance:FindFirstChild("PowerupButton")
	self.Cleaner:Add(powerupButton.MouseButton1Click:Connect(function()
		self:SwitchCategory("Powerups")
	end))
end

function AnnouncementsWindow:InitializeVersionButtons()
	local version = self.Root.Version
	local versionButton = version.VersionButton
	local versionSelection = version.VersionSelection
	local buttonTemplate = versionSelection.ButtonTemplate
	self.Cleaner:Add(versionButton.MouseButton1Click:Connect(function()
		self:ToggleVersionDropdown()
	end))

	for _, v in ipairs(ANNOUNCEMENT_VERSION_HISTORY) do
		local clone = buttonTemplate:Clone()
		local textLabel = clone.TextLabel
		clone.Name = v
		textLabel.Text = v
		clone.Parent = versionSelection
		clone.Visible = true
		local v2 = v
		self.Cleaner:Add(clone.MouseButton1Click:Connect(function()
			self:SelectVersion(v2)

			if self.CurrentDropdownButton then
				self.CurrentDropdownButton.BackgroundTransparency = 1
			end

			self.CurrentDropdownButton = clone
			clone.BackgroundTransparency = 0
			self:ToggleVersionDropdown()
		end))
	end

	self:SelectVersion(ANNOUNCEMENT_VERSION_HISTORY[1])
end

function AnnouncementsWindow:SelectVersion(currentBuildVersion: string)
	if self.CurrentButton then
		SetButtonInactive(self.CurrentButton) -- inferred equivalent call
		self.CurrentButton = nil
	end

	local root = self.Root
	root.Version.VersionButton.Version.Text = "v" .. currentBuildVersion

	if self.CurrentBuildVersion == currentBuildVersion then
		return
	end

	if self.CurrentBuildVersion then
		local currentBuildVersion2 = self.CurrentBuildVersion
		local waitForChild = root.Content:WaitForChild(currentBuildVersion2)
		waitForChild.Visible = false
	end

	local waitForChild = root.Content:WaitForChild(currentBuildVersion)
	waitForChild.Visible = true
	self.CurrentBuildVersion = currentBuildVersion
	self:InitializeContent()
end

function AnnouncementsWindow:ToggleVersionDropdown()
	local versionSelection = self.Root.Version.VersionSelection

	if self.IsVersionDropdownOpen then
		versionSelection.Visible = false
		self.IsVersionDropdownOpen = false
	else
		versionSelection.Visible = true
		self.IsVersionDropdownOpen = true
	end
end

function AnnouncementsWindow:SwitchButton(currentButton)
	SetButtonInactive(self.CurrentButton) -- inferred equivalent call
	SetButtonActive(currentButton) -- inferred equivalent call
	self.CurrentButton = currentButton
end

function AnnouncementsWindow:SwitchCategory(childName: string)
	local child = self.Root.Content:WaitForChild(self.CurrentBuildVersion)
	local scrollingFrame = child.Main:FindFirstChild(childName)
	local child2 = child.LeftNav.Buttons:WaitForChild(childName)

	if not scrollingFrame then
		warn("CategoryFrame not found", childName)
		return
	end

	if self.CurrentFrame == scrollingFrame then
		return
	end

	self:SwitchButton(child2)

	if self.CurrentFrame then
		self.CurrentFrame.Visible = false
	end

	self.CurrentFrame = scrollingFrame
	self.CurrentFrame.Visible = true

	if scrollingFrame:IsA("ScrollingFrame") then
		local automaticCanvasSize = scrollingFrame.AutomaticCanvasSize

		if automaticCanvasSize ~= Enum.AutomaticSize.None then
			scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
			scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.XY
			scrollingFrame.AutomaticCanvasSize = automaticCanvasSize
		end
	end
end

function AnnouncementsWindow.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { AnnouncementsWindow })
return AnnouncementsWindow