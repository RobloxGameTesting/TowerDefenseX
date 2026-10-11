local MapEntityHover = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local ColorUtilities = require(common:WaitForChild("ColorUtilities"))
local TooltipUtilities = require(script.Parent:WaitForChild("TooltipUtilities"))
local mapEntityHover = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("Tooltips"):WaitForChild("MapEntityHover")
local nameText = mapEntityHover:WaitForChild("Name"):WaitForChild("NameText")
local detectionIcon = mapEntityHover:WaitForChild("Detection"):WaitForChild("DetectionIcon")
local healthBarParent = mapEntityHover:WaitForChild("HealthBarParent")
local bar = healthBarParent:WaitForChild("Bar")
local healthText = mapEntityHover:WaitForChild("HealthText")
mapEntityHover:WaitForChild("HealthBarBackground")
mapEntityHover:WaitForChild("HealthBarGlass")

function MapEntityHover.Run(data)
	if data then
		nameText.Text = string.upper(data.DisplayName)
		detectionIcon.Visible = data.StealthDetection
		local healthHandler = data.HealthHandler

		if healthHandler then
			local v = math.max(1, healthHandler:GetHealth())
			local maxHealth = healthHandler:GetMaxHealth()
			local healthbarColor = ColorUtilities.GetHealthbarColor(v, maxHealth)
			healthText.Text = tostring((math.ceil(v))) .. "/" .. tostring(maxHealth) .. " HP"
			bar.BackgroundColor3 = healthbarColor
			bar.Size = UDim2.new(math.clamp(v / maxHealth, 0, 1), 0, 1, 0)
			healthBarParent.Visible = true
		else
			healthBarParent.Visible = false
		end
	else
		warn("Tooltip error: map entity is nil")
	end

	TooltipUtilities.PositionTooltipAtMousePosition(mapEntityHover, UDim2.new(0, 2, 0, 0))
	return mapEntityHover
end

return MapEntityHover