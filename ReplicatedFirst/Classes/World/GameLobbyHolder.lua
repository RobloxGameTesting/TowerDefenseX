local v = { "StartTime", "EndTime", "Status", "MapName" }
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local MapData = require(ReplicatedStorage.TDX_Shared.Common.MapData)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local MEDALS_LIST = Shared.MEDALS_LIST
local GameLobbyHolder = { ClassName = script.Name, ClassModule = script }
GameLobbyHolder.__index = GameLobbyHolder

function GameLobbyHolder.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Screen = nil }, GameLobbyHolder))
end

function GameLobbyHolder:Init()
	local clone = ReplicatedStorage.LobbyResources.displayscreen:Clone()
	clone.Parent = self.Root.mapdisplay.screen
	self.Screen = clone
	self.Cleaner:Add(clone)
	self.Cleaner:Add(RunService.Heartbeat:Connect(function()
		self:UpdateBar()
	end))

	for _, v2 in ipairs(v) do
		self.Cleaner:Add(self.Root:GetAttributeChangedSignal(v2):Connect(function()
			self:Update()
		end))
	end

	self:Update()
end

function GameLobbyHolder:Update()
	local mapName = self.Root:GetAttribute("MapName")
	local v2

	if self.Root.APC:GetAttribute("LobbyType") == "HalloweenNightSelection" then
		v2 = self.Root.APC:GetAttribute("SelectedNight") == nil
	else
		v2 = false
	end

	local v3 = MapData[mapName]
	self.Screen.status.Text = self.Root:GetAttribute("Status")
	self.Screen.plrcount.Text = tostring(self.Root:GetAttribute("ActivePlayers")) .. "/" .. tostring(self.Root.APC:GetAttribute("PlayerCount"))
	self.Screen.status.Visible = not v2
	self.Screen.plrcount.Visible = not v2
	self.Screen.bar.Visible = not v2
	self.Screen.map.Text = v2 and "" or string.upper(v3.DisplayName or mapName)
	self.Screen.creator.Text = v2 and "" or "CREATOR: " .. string.upper(v3.Creator)
	self.Screen.diff.Text = v2 and "" or "DIFFICULTY: " .. string.upper(v3.Difficulty)
	self.Screen.mapicon.Image = v2 and "rbxassetid://87198122316914" or v3.Image
	local medals = self.Root.mapdisplay.screen:FindFirstChild("medals")

	if medals then
		local mapAndDifficultyWins = Data.Get("MapAndDifficultyWins") or {}

		for childName, v4 in MEDALS_LIST do
			local v5 = not mapAndDifficultyWins[mapName] and 0 or mapAndDifficultyWins[mapName][childName] or 0
			local child = medals.SurfaceGui.Frame:FindFirstChild(childName)

			if child then
				child.Image = v4[v5 > 0]
			end
		end
	end
end

function GameLobbyHolder:UpdateBar()
	local v2 = (workspace:GetServerTimeNow() - self.Root:GetAttribute("StartTime")) / self.Root:GetAttribute("Duration")
	self.Screen.bar.BarParent.Bar.Size = UDim2.new(math.max(0.02, v2), 0, 1, 0)
end

function GameLobbyHolder.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { GameLobbyHolder })
return GameLobbyHolder