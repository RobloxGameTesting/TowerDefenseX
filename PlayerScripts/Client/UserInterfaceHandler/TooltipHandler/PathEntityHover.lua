local PathEntityHover = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local ColorUtilities = require(common:WaitForChild("ColorUtilities"))
local TooltipUtilities = require(script.Parent:WaitForChild("TooltipUtilities"))
local pathEntityHover = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("Tooltips"):WaitForChild("PathEntityHover")
local nameText = pathEntityHover:WaitForChild("Name"):WaitForChild("NameText")
local detectionIcon = pathEntityHover:WaitForChild("Detection"):WaitForChild("DetectionIcon")
local tags = pathEntityHover:WaitForChild("Tags")
local guiObjectsByName = {}
local textsByName = {}
local bar = pathEntityHover:WaitForChild("HealthBarParent"):WaitForChild("Bar")
local healthText = pathEntityHover:WaitForChild("HealthText")
pathEntityHover:WaitForChild("HealthBarBackground")
pathEntityHover:WaitForChild("HealthBarGlass")

local function DisplayTags(collisionResistance: number?, allDamageReduction: number?)
	for k, v in pairs(guiObjectsByName) do
		local v2 = textsByName[k]

		if k == "Collision" then
			if collisionResistance then
				v2.Text = `{math.floor(100 * collisionResistance)}%`
				v.Visible = true
			else
				v.Visible = false
			end
		elseif k == "AllDamageReduction" then
			if allDamageReduction then
				v2.Text = `-{math.round(100 * allDamageReduction)}%`
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end
end

function PathEntityHover.Run(data)
	if data then
		nameText.Text = string.upper(data.DisplayName)
		detectionIcon.Visible = data.StealthDetection
		local allDamageReduction = data.AllDamageReduction

		if allDamageReduction == 0 then
			allDamageReduction = nil
		end

		DisplayTags(data.Config.CollisionResistance, allDamageReduction)
		local v = math.max(1, data.HealthHandler:GetHealth())
		local maxHealth = data.HealthHandler:GetMaxHealth()
		local healthbarColor = ColorUtilities.GetHealthbarColor(v, maxHealth)
		healthText.Text = tostring((math.ceil(v))) .. "/" .. tostring((math.ceil(maxHealth))) .. " HP"
		bar.BackgroundColor3 = healthbarColor
		bar.Size = UDim2.new(math.clamp(v / maxHealth, 0, 1), 0, 1, 0)
	else
		warn("Tooltip error: path entity is nil")
	end

	TooltipUtilities.PositionTooltipAtMousePosition(pathEntityHover, UDim2.new(0, 2, 0, 0))
	return pathEntityHover
end

for _, guiObject in pairs(tags:GetChildren()) do
	if not guiObject:IsA("GuiObject") then
		continue
	end

	local contentFrame = guiObject:FindFirstChild("ContentFrame")
	local text = contentFrame and contentFrame:FindFirstChild("Text")

	if not text then
		continue
	end

	guiObjectsByName[guiObject.Name] = guiObject
	textsByName[guiObject.Name] = text
end

return PathEntityHover