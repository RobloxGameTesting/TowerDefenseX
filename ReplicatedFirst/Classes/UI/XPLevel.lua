local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Util = require(game.ReplicatedStorage.TDX_Shared.Modules.Util)
local Shared = require(game.ReplicatedStorage.TDX_Shared.Modules.Shared)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Lang = require(game.ReplicatedStorage.TDX_Shared.Modules.Lang)
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local XPLevel = { ClassName = script.Name, ClassModule = script }
XPLevel.__index = XPLevel

function XPLevel.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, XPLevel))
end

function XPLevel:Init()
	self:Update()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "XP" then
			self:Update()
		end
	end))
end

function XPLevel:Update()
	local xpToLevelAndProgress, v, v2 = Util.XPToLevelAndProgress(Data.Get("XP"))
	self.Root.xp.Text = string.format("%d/%d XP", v2, v)
	self.Root.rank.level.level.Text = Lang.Get(Lang.Strings.General.Level, (tostring(xpToLevelAndProgress)))
	self.Root.rank.Image = Shared.RANK_IMAGES[xpToLevelAndProgress] or Shared.RANK_IMAGES[#Shared.RANK_IMAGES]
	local v3 = v2 / v
	local v4 = v3 < 0.005 and 0 or v3
	self.Root.BarHolder.fill.Size = UDim2.new(v4, 0, 1, 0)
end

function XPLevel.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { XPLevel }, PlayerGui)
return XPLevel