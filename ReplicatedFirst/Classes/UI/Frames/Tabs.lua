local Players = game:GetService("Players")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Signal = require(game.ReplicatedStorage.Modules.Signal)
local formatted = `{Enum.GuiState.Idle.Name}Image`
local formatted2 = `{Enum.GuiState.Hover.Name}Image`
local formatted3 = `{Enum.GuiState.Press.Name}Image`;
("%*Transparency"):format(Enum.GuiState.Idle.Name);
("%*Transparency"):format(Enum.GuiState.Hover.Name);
("%*Transparency"):format(Enum.GuiState.Press.Name)
local Tabs = { ClassName = script.Name, ClassModule = script }
Tabs.__index = Tabs

function Tabs.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), OnTabClicked = Signal.new() }, Tabs))
end

local function UpdateTabAppearance(folder)
	local guiState = folder.GuiState

	if folder:GetAttribute("Selected") then
		guiState = Enum.GuiState.Press
	end

	local attribute = folder:GetAttribute(guiState.Name .. "Transparency") or 0
	folder.Image = `rbxassetid://{folder:GetAttribute(guiState.Name .. "Image")}`
	folder.ImageTransparency = attribute

	for _, guiObject in folder:GetDescendants() do
		local attribute2 = guiObject:GetAttribute(`{guiState.Name}Color`)

		if not attribute2 then
			continue
		end

		if guiObject:IsA("ImageLabel") then
			guiObject.ImageColor3 = attribute2
		elseif guiObject:IsA("TextLabel") then
			guiObject.TextColor3 = attribute2
		end
	end
end

function Tabs:Init()
	self.tabs = {}

	for _, button in self.Root:GetChildren() do
		if not button:IsA("ImageButton") then
			continue
		end

		self.tabs[button.Name] = button
		assert(button:GetAttribute(formatted), `Tab {button.Name} is missing {formatted} attribute`)
		assert(button:GetAttribute(formatted2), `Tab {button.Name} is missing {formatted2} attribute`)
		assert(button:GetAttribute(formatted3), `Tab {button.Name} is missing {formatted3} attribute`)
		local v = button
		self.Cleaner:Add(button:GetPropertyChangedSignal("GuiState"):Connect(function()
			UpdateTabAppearance(v)
		end))
		local v2 = button
		self.Cleaner:Add(button:GetAttributeChangedSignal("Selected"):Connect(function()
			UpdateTabAppearance(v2)
		end))
		UpdateTabAppearance(button)
		local v3 = button
		self.Cleaner:Add(button.Activated:Connect(function()
			self.OnTabClicked:Fire(v3.Name)
		end))
	end
end

function Tabs:SetTabVisible(p: string, visible: boolean)
	if not self.tabs[p] then
		error(`Unknown tab: {p}`)
	end

	self.tabs[p].Visible = visible
end

function Tabs:HideAllTabs()
	for k, _ in self.tabs do
		self:SetTabVisible(k, false)
	end
end

function Tabs:SetSelectedTab(p: string)
	if not self.tabs[p] then
		error(`Unknown tab: {p}`)
	end

	if self.selectedTab then
		self.selectedTab:SetAttribute("Selected", false)
	end

	self.selectedTab = self.tabs[p]
	self.selectedTab:SetAttribute("Selected", true)
end

function Tabs.GetSelectedTab(p)
	if p.selectedTab then
		return p.selectedTab.Name
	end

	return nil
end

function Tabs.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register("Tabs", { Tabs }, Players.LocalPlayer)
return Tabs