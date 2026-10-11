local TooltipHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ColorUtilities"))
local EnemyHover = require(script:WaitForChild("EnemyHover"))
local TowerHover = require(script:WaitForChild("TowerHover"))
local PathEntityHover = require(script:WaitForChild("PathEntityHover"))
local StaticEntityHover = require(script:WaitForChild("StaticEntityHover"))
local MapEntityHover = require(script:WaitForChild("MapEntityHover"))
local AdminHoverPanelHandler = require(script:WaitForChild("AdminHoverPanelHandler"))
local v = "None"
local v2 = nil

local function SetNewHoverFrame(p) -- 6 equivalent calls inferred from this helper
	if v2 then
		v2.Visible = false
	end

	if p then
		p.Visible = true
		v2 = p
	end
end

function TooltipHandler.RunEnemyHover(p)
	local v3 = EnemyHover.Run(p)

	if v ~= "Enemy" then
		v = "Enemy"
		SetNewHoverFrame(v3) -- inferred equivalent call
	end
end

function TooltipHandler.RunTowerHover(p)
	local v3 = TowerHover.Run(p)

	if v ~= "Tower" then
		v = "Tower"
		SetNewHoverFrame(v3) -- inferred equivalent call
	end
end

function TooltipHandler.RunPathEntityHover(p)
	local v3 = PathEntityHover.Run(p)

	if v ~= "PathEntity" then
		v = "PathEntity"
		SetNewHoverFrame(v3) -- inferred equivalent call
	end
end

function TooltipHandler.RunStaticEntityHover(p)
	local v3 = StaticEntityHover.Run(p)

	if v ~= "StaticEntity" then
		v = "StaticEntity"
		SetNewHoverFrame(v3) -- inferred equivalent call
	end
end

function TooltipHandler.RunMapEntityHover(p)
	local config = p and p.Config

	if config and config.NoHoverTooltip then
		return
	end

	local v3 = MapEntityHover.Run(p)

	if v ~= "MapEntity" then
		v = "MapEntity"
		SetNewHoverFrame(v3) -- inferred equivalent call
	end
end

function TooltipHandler.RunNoHover()
	if v ~= "None" then
		v = "None"
		SetNewHoverFrame() -- inferred equivalent call
	end
end

function TooltipHandler.ToggleAdminHoverPanel(p, p2: string?)
	AdminHoverPanelHandler.ToggleAdminHoverPanel(p, p2)
end

function TooltipHandler.Update()
	AdminHoverPanelHandler.Update()
end

return TooltipHandler