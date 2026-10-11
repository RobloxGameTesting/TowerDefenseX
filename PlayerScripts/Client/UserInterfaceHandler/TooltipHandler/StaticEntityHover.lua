local StaticEntityHover = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local ColorUtilities = require(common:WaitForChild("ColorUtilities"))
local TooltipUtilities = require(script.Parent:WaitForChild("TooltipUtilities"))
local staticEntityHover = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("Tooltips"):WaitForChild("StaticEntityHover")
local nameText = staticEntityHover:WaitForChild("Name"):WaitForChild("NameText")
local detectionIcon = staticEntityHover:WaitForChild("Detection"):WaitForChild("DetectionIcon")
local healthBarParent = staticEntityHover:WaitForChild("HealthBarParent")
local bar = healthBarParent:WaitForChild("Bar")
local healthText = staticEntityHover:WaitForChild("HealthText")
local healthBarBackground = staticEntityHover:WaitForChild("HealthBarBackground")
local healthBarGlass = staticEntityHover:WaitForChild("HealthBarGlass")

function StaticEntityHover.Run(data)
	if data then
		local path1Level = data.Path1Level
		local path2Level = data.Path2Level
		local customPathLevelStringDisplayText = data.CustomPathLevelStringDisplayText
		nameText.Text = string.upper(data.DisplayName)
		detectionIcon.Visible = data.StealthDetection

		if not data.NoDisplayPathLevelString then
			if customPathLevelStringDisplayText then
				nameText.Text ..= " (" .. string.upper(customPathLevelStringDisplayText) .. ")"
			elseif path1Level and path2Level then
				nameText.Text ..= " (LVL " .. tostring(path1Level) .. "-" .. tostring(path2Level) .. ")"
			end
		end

		local visible

		if data.HealthHandler then
			local v = math.max(1, data.HealthHandler:GetHealth())
			local maxHealth = data.HealthHandler:GetMaxHealth()
			local healthbarColor = ColorUtilities.GetHealthbarColor(v, maxHealth)
			healthText.Text = tostring((math.ceil(v))) .. "/" .. tostring(maxHealth) .. " HP"
			bar.BackgroundColor3 = healthbarColor
			bar.Size = UDim2.new(math.clamp(v / maxHealth, 0, 1), 0, 1, 0)
			visible = true
		else
			visible = false
		end

		healthBarParent.Visible = visible
		healthText.Visible = visible
		healthBarBackground.Visible = visible
		healthBarGlass.Visible = visible
	else
		warn("Tooltip error: static entity is nil")
	end

	TooltipUtilities.PositionTooltipAtMousePosition(staticEntityHover, UDim2.new(0, 2, 0, 0))
	return staticEntityHover
end

return StaticEntityHover