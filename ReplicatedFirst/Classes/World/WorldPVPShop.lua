local RunService = game:GetService("RunService")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local UIHelper = require(game.ReplicatedFirst.Util.UIHelper)

local function log(...)
	if RunService:IsStudio() then
		print("[WorldPVPShop]", ...)
	end
end

local WorldPVPShop = { ClassName = script.Name, ClassModule = script }
WorldPVPShop.__index = WorldPVPShop

function WorldPVPShop.new(root)
	return (setmetatable({ Root = root }, WorldPVPShop))
end

function WorldPVPShop.Init(p)
	log("Init()")
	p.Root.PrimaryPart.ProximityPrompt.Triggered:Connect(function()
		Director.GetFirstItemFromClass(Director.Classes.V2Sidebar):HideAll()
		UIHelper.ShowPVPShop()
	end)
end

Director.Register("WorldPVPShop", { WorldPVPShop }, workspace)
return WorldPVPShop