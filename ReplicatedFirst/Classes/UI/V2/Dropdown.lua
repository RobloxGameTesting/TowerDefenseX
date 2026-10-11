local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Signal = require(ReplicatedStorage.TDX_Shared.Modules.Signal)
local Dropdown = { ClassName = script.Name, ClassModule = script }
Dropdown.__index = Dropdown

function Dropdown.new(root)
	return (setmetatable({
		Root = root,
		OnSelectionChanged = Signal.new(),
		Items = {},
		CurrentSelection = nil,
		Expanded = false,
		Cleaner = Cleaner.new()
	}, Dropdown))
end

function Dropdown:Init()
	self.Root.Button.Activated:Connect(function()
		if self.Expanded then
			self:_Collapse()
		else
			self:_Expand()
		end
	end)
	self.Root:GetPropertyChangedSignal("GuiState"):Connect(function()
		self:_UpdateAppearance()
	end)
end

function Dropdown:AddItem(p: string, layoutOrder: number?)
	local clone = self.Root.Items.ItemTemplate:Clone()
	clone.Name = p
	clone.Parent = self.Root.Items
	clone.Text = p
	clone.Visible = true
	clone.Activated:Connect(function()
		self:_OnItemClicked(clone)
	end)
	clone:GetPropertyChangedSignal("GuiState"):Connect(function()
		if clone.GuiState == Enum.GuiState.Idle then
			clone.BackgroundTransparency = 1
		else
			clone.BackgroundTransparency = 0.9
		end
	end)

	if layoutOrder ~= nil then
		clone.LayoutOrder = layoutOrder
	end

	if self.CurrentSelection == nil then
		self.CurrentSelection = p
		self.Root.Label.Text = p
	end
end

function Dropdown:SetSelectedItem(p: string, flag: boolean?)
	self.CurrentSelection = p
	self.Root.Label.Text = p

	if not flag then
		self.OnSelectionChanged:Fire(self.CurrentSelection)
	end

	self:_Collapse()
end

function Dropdown:_OnItemClicked(p)
	self:SetSelectedItem(p.Name, false)
end

function Dropdown:_Expand()
	self.Expanded = true
	self.Root.Items.Visible = true
	self.Root.Arrow.Rotation = 180
	self:_UpdateAppearance()
end

function Dropdown:_Collapse()
	self.Expanded = false
	self.Root.Items.Visible = false
	self.Root.Arrow.Rotation = 0
	self:_UpdateAppearance()
end

function Dropdown:_UpdateAppearance()
	local colorActive = self.Root:GetAttribute("ColorActive")

	if self.Root.GuiState == Enum.GuiState.Idle and not self.Expanded then
		colorActive = self.Root:GetAttribute("ColorDefault")
	end

	self.Root.UIStroke.Color = colorActive
	self.Root.Label.TextColor3 = colorActive
	self.Root.Arrow.ImageColor3 = colorActive
end

function Dropdown.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { Dropdown }, game.Players)
return Dropdown