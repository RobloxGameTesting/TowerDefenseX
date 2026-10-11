local MapOverrideScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("BindableHandler"))
require(common:WaitForChild("MapHandler"))
local MapUtilities = require(common:WaitForChild("MapUtilities"))
local MapData = require(common:WaitForChild("MapData"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local SearchBarClass = require(common:WaitForChild("SearchBarClass"))
local LobbyTypeUtilities = require(common:WaitForChild("LobbyTypeUtilities"))
require(ReplicatedStorage.TDX_Shared.Modules.Shared)
require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
require(script.Parent.Parent:WaitForChild("PlayerClass"))
local event = NetworkingHandler.GetEvent("MapOverride")
local mapOverrideScreen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("MapOverrideScreen")
local scrollingFrame = mapOverrideScreen:WaitForChild("ScrollingFrame")
local template = scrollingFrame:WaitForChild("Template")
local search = mapOverrideScreen:WaitForChild("Options"):WaitForChild("Search")
local noResults = mapOverrideScreen:WaitForChild("NoResults")
local v = false
local v2 = nil
local v3 = {}
local v4 = ""
local options = {}

local function NewMapButton(name: string)
	local clone = template:Clone()
	clone.Name = name
	local icon = clone:FindFirstChild("Icon")
	local mapDifficulty = clone:FindFirstChild("MapDifficulty")
	local mapName = clone:FindFirstChild("MapName")
	local uiStroke = mapDifficulty:FindFirstChild("UIStroke")
	local new = clone:FindFirstChild("Tags"):FindFirstChild("New")
	local v5 = MapData[name]

	if not v5 then
		warn("MapVotingHandler: Map data not found for map: " .. name)
		return
	end

	local difficulty = v5.Difficulty
	local colorDataForMapDifficulty = MapUtilities.GetColorDataForMapDifficulty(difficulty)
	icon.Image = v5.Image
	mapDifficulty.Text = `{string.upper(difficulty)}`
	mapName.Text = `{string.upper(MapUtilities.GetDisplayName(name))}`
	mapDifficulty.TextColor3 = colorDataForMapDifficulty.Color
	uiStroke.Color = colorDataForMapDifficulty.BorderColor

	if v5.IsNew then
		clone.Name = "AAA " .. name
		new.Visible = true
	end

	local v6 = {
		IsHovered = false,
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Clicked = function(self)
			mapOverrideScreen.Visible = false
			SoundHandler.Play("SettingOn")
			event:FireServer(name)
		end,
		HandleNewQuery = function(self, value: string)
			local visible

			if value == "" then
				visible = true
			else
				local v6 = string.lower(value)
				visible = #v6 == 0
					or string.find(string.lower(name), v6)
					or #v6 == 0
					or string.find(string.lower(difficulty), v6)
			end

			if visible and table.find(options, name) then
				visible = false
			end

			clone.Visible = visible
			return visible
		end,
		_UpdateState = function(self)
			if self.IsHovered then
				icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
			else
				icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
			end
		end,
		Destroy = function(self)
			clone:Destroy()
		end
	}
	clone.MouseEnter:Connect(function()
		v6:Hovered()
	end)
	clone.MouseLeave:Connect(function()
		v6:Unhovered()
	end)
	clone.Activated:Connect(function()
		v6:Clicked()
	end)
	clone.Parent = scrollingFrame
	clone.Visible = true
	return v6
end

local function UpdateVisibleMapButtons()
	local v5 = false

	for _, v6 in pairs(v3) do
		if v6:HandleNewQuery(v4) then
			v5 = true
		end
	end

	noResults.Visible = not v5
end

local function SearchBarChanged(p: string)
	v4 = p
	UpdateVisibleMapButtons()
end

local function Initialize(lobbyType: string?)
	if v and lobbyType == v2 then
		return
	end

	local v5 = lobbyType and LobbyTypeUtilities.GetLobbyTypeData(lobbyType)
	template.Visible = false
	local randomMapNames = v5 and v5.RandomMapNames or MapUtilities.GetMainModeMaps()

	for _, v6 in pairs(v3) do
		v6:Destroy()
	end

	table.clear(v3)

	for _, randomMapName in pairs(randomMapNames) do
		table.insert(v3, NewMapButton(randomMapName))
	end

	SearchBarClass.New({ SearchBarGui = search, TextChangedCallback = SearchBarChanged })
	v = true
	v2 = lobbyType
end

function MapOverrideScreenHandler.Open(_)
	if not v then
		return
	end

	mapOverrideScreen.Visible = true
end

function MapOverrideScreenHandler.Close(_)
	mapOverrideScreen.Visible = false
end

function MapOverrideScreenHandler.DataChanged(_, p)
	Initialize(p.LobbyType)
	options = p.Options
	UpdateVisibleMapButtons()
end

mapOverrideScreen.Visible = false
noResults.Visible = false
return MapOverrideScreenHandler