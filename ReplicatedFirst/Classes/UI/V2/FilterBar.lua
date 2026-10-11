local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local SearchBarClass = require(ReplicatedStorage.TDX_Shared.Common.SearchBarClass)
local Signal = require(ReplicatedStorage.TDX_Shared.Modules.Signal)
local Dropdown = require(script.Parent.Dropdown)
local color = Color3.fromHex("717171")
local FilterBar = { ClassName = script.Name, ClassModule = script }
FilterBar.__index = FilterBar

function FilterBar.new(root)
	return (setmetatable({
		Root = root,
		CurrentOptions = { Sort = "Default", Toggles = {} },
		OnFilterOptionsChanged = Signal.new(),
		Cleaner = Cleaner.new()
	}, FilterBar))
end

function FilterBar:Init()
	local accentColor = self.Root:GetAttribute("AccentColor")
	assert(accentColor ~= nil, "Missing attribute AccentColor")
	self._accentColor = accentColor
	local search = self.Root:FindFirstChild("Search")
	assert(search ~= nil, "Missing Search child")
	self.SearchBar = SearchBarClass.New({
		SearchBarGui = search,
		AccentColor = accentColor,
		TextChangedCallback = function(value)
			self:_OnSearchTextChanged(value:lower())
		end
	})

	for _, frame in self.Root.Toggles:GetChildren() do
		if not frame:IsA("Frame") then
			continue
		end

		frame.Visible = true
		local v = frame
		frame.TextButton.Activated:Connect(function()
			self:_OnToggleOptionClicked(v.Name)
		end)
	end

	if self.Root:FindFirstChild("Sort") then
		self.SortDropdown = Director.GetClassObjectYields(self.Root.Sort, Dropdown)
		self.SortDropdown.OnSelectionChanged:Connect(function(sort)
			self.CurrentOptions.Sort = sort
			self.OnFilterOptionsChanged:Fire(self.CurrentOptions)
		end)
	end
end

function FilterBar.GetCurrentOptions(p)
	return p.CurrentOptions
end

function FilterBar:_OnSearchTextChanged(searchText: string)
	if searchText == "" then
		searchText = nil
	end

	self.CurrentOptions.SearchText = searchText
	self.OnFilterOptionsChanged:Fire(self.CurrentOptions)
end

function FilterBar:_OnToggleOptionClicked(childName: string)
	self.CurrentOptions.Toggles[childName] = not self.CurrentOptions.Toggles[childName]
	local child = self.Root.Toggles:FindFirstChild(childName)
	local accentColor = self.CurrentOptions.Toggles[childName] and self._accentColor or color
	child.UIStroke.Color = accentColor
	child.Label.TextColor3 = accentColor
	self.OnFilterOptionsChanged:Fire(self.CurrentOptions)
end

function FilterBar.Reset(_) end

function FilterBar.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { FilterBar }, game.Players)
return FilterBar