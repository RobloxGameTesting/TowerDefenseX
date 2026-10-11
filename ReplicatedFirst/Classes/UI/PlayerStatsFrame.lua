local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local PlayerStatsFrame = { ClassName = script.Name, ClassModule = script }
PlayerStatsFrame.__index = PlayerStatsFrame

function PlayerStatsFrame.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, PlayerStatsFrame))
end

function PlayerStatsFrame:Init()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Gold" or p == "Wins" then
			self:Update()
		end
	end))
	self:Update()
end

local function formatNumber(p)
	return tostring((math.floor(p))):reverse():gsub("(%d%d%d)", "%1,"):gsub(",(%-?)$", "%1"):reverse()
end

function PlayerStatsFrame:Update() end

function PlayerStatsFrame.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { PlayerStatsFrame }, PlayerGui)
return PlayerStatsFrame