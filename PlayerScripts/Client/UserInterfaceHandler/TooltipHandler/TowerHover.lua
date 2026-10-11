local TowerHover = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local ColorUtilities = require(common:WaitForChild("ColorUtilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local TooltipUtilities = require(script.Parent:WaitForChild("TooltipUtilities"))
local event = BindableHandler.GetEvent("SetDifficulty")
local towerHover = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("Tooltips"):WaitForChild("TowerHover")
local nameText = towerHover:WaitForChild("Name"):WaitForChild("NameText")
local levelText = towerHover:WaitForChild("Level"):WaitForChild("LevelText")
local detectionIcon = towerHover:WaitForChild("Level"):WaitForChild("DetectionIcon")
local healthBar = towerHover:WaitForChild("HealthBar")
local bar = healthBar:WaitForChild("HealthBarParent"):WaitForChild("Bar")
local healthText = healthBar:WaitForChild("HealthText")
healthBar:WaitForChild("HealthBarBackground")
healthBar:WaitForChild("HealthBarGlass")
local hiddenGlass = bar:WaitForChild("HiddenGlass")
local shieldBar = towerHover:WaitForChild("ShieldBar")
local bar2 = shieldBar:WaitForChild("ShieldBarParent"):WaitForChild("Bar")
local shieldText = shieldBar:WaitForChild("ShieldText")
shieldBar:WaitForChild("ShieldBarBackground")
shieldBar:WaitForChild("ShieldBarGlass")
local visible = false

function TowerHover.Run(object)
	if object then
		local levelHandler = object.LevelHandler
		local isStealth = object:IsStealth()
		local levelStats = levelHandler:GetLevelStats()
		local levelOnPath = levelHandler:GetLevelOnPath(1)
		local levelOnPath2 = levelHandler:GetLevelOnPath(2)
		nameText.Text = string.upper(object.DisplayName)
		levelText.Text = "LVL " .. tostring(levelOnPath) .. "-" .. tostring(levelOnPath2)
		detectionIcon.Visible = levelStats.StealthDetection or object.BuffHandler:GetStatMultipliers().StealthDetection
		local healthHandler = object.HealthHandler
		local shield = healthHandler:GetShield()
		local maxShield = healthHandler:GetMaxShield()
		local v = math.max(object:Alive() and 1 or 0, healthHandler:GetHealth())
		local maxHealth = healthHandler:GetMaxHealth()

		if visible then
			local healthbarColor = ColorUtilities.GetHealthbarColor(v, maxHealth)
			healthText.Text = tostring((math.ceil(v))) .. "/" .. tostring((math.ceil(maxHealth))) .. " HP"
			bar.BackgroundColor3 = healthbarColor
			bar.Size = UDim2.new(math.clamp(v / maxHealth, 0, 1), 0, 1, 0)
			hiddenGlass.Visible = isStealth
			hiddenGlass.ImageColor3 = Color3.fromRGB(
				math.max(0, 255 * healthbarColor.R - 110),
				math.max(0, 255 * healthbarColor.G - 110),
				(math.max(0, 255 * healthbarColor.B - 110))
			)
			shieldText.Text = tostring((math.ceil(shield))) .. "/" .. tostring((math.ceil(maxShield))) .. " SHIELD"
			bar2.Size = UDim2.new(math.clamp(shield / maxShield, 0, 1), 0, 1, 0)
		end

		healthBar.Visible = visible
		shieldBar.Visible = visible and maxShield > 0
	else
		warn("Tooltip error: tower is nil")
	end

	TooltipUtilities.PositionTooltipAtMousePosition(towerHover, UDim2.new(0, 2, 0, 0))
	return towerHover
end

event:AttachCallback(function(p: string)
	local waveConfig = ResourceManager.GetWaveConfig(p)
	assert(waveConfig ~= nil, "Error: waves config is nil")
	visible = not waveConfig.NoTowerDamageAllowed
end)
return TowerHover