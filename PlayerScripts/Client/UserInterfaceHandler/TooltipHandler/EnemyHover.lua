local EnemyHover = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local ColorUtilities = require(common:WaitForChild("ColorUtilities"))
require(common:WaitForChild("EnemyBuffUtilities"))
local TooltipUtilities = require(script.Parent:WaitForChild("TooltipUtilities"))
local FROZEN_REWORK_ENABLED = _G.FROZEN_REWORK_ENABLED
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(151, 250, 128)
local color3 = Color3.fromRGB(255, 141, 141)
local enemyHover = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("Tooltips"):WaitForChild("EnemyHover")
local name = enemyHover:WaitForChild("Name")
local nameText = name:WaitForChild("NameText")
local size = name.Size
local healthBar = enemyHover:WaitForChild("HealthBar")
local bar = healthBar:WaitForChild("BarParent"):WaitForChild("Bar")
local textLabel = healthBar:WaitForChild("TextLabel")
local hiddenGlass = bar:WaitForChild("HiddenGlass")
local detectionIcon = healthBar:WaitForChild("DetectionIcon")
local shieldBar = enemyHover:WaitForChild("ShieldBar")
local bar2 = shieldBar:WaitForChild("BarParent"):WaitForChild("Bar")
local textLabel2 = shieldBar:WaitForChild("TextLabel")
local tick = enemyHover:WaitForChild("Tick")
local uiScale = enemyHover:WaitForChild("UIScale")
local tags = enemyHover:WaitForChild("Tags")
local uiScale2 = tags:WaitForChild("UIScale")
local framesByName = {}
local textsByName = {}

local function ResizeTag(p, p2) -- 1 equivalent call inferred from this helper
	local v = uiScale.Scale * uiScale2.Scale
	local v2 = 31 + p2.Position.X.Offset + p2.TextBounds.X / v
	p.Size = UDim2.new(0, v2, 1, 0)
end

local function DisplayTags(damageReductionTable, damageResistanceModifier: number, noCash: boolean?, topSpeedMultiplier: number?, p: number?, damageMultiplier: number?, maximumDamage: number?, frozen: boolean?, allDamageReduction: number?, isGhostlyUnit: boolean?)
	local v = {}

	if damageReductionTable then
		for _, item in pairs(damageReductionTable) do
			v[item.DamageType] = math.clamp(item.DamageReduction + damageResistanceModifier, 0, 1)
		end
	end

	for k, v2 in pairs(framesByName) do
		local v3 = textsByName[k]
		local v4 = v[k]

		if v4 then
			v3.Text = tostring((math.round(v4 * 100))) .. "%"

			if damageResistanceModifier > 0 then
				v3.TextColor3 = color2
			elseif damageResistanceModifier < 0 then
				v3.TextColor3 = color3
			else
				v3.TextColor3 = color
			end

			v2.Visible = true
		else
			v2.Visible = false
		end

		if k == "NoCash" then
			v2.Visible = noCash
		elseif k == "TopSpeedMultiplier" then
			if topSpeedMultiplier and not (FROZEN_REWORK_ENABLED and frozen) then
				if topSpeedMultiplier >= 1 then
					v3.Text = "+" .. tostring((math.round(100 * (topSpeedMultiplier - 1)))) .. "%"
				else
					v3.Text = tostring((math.round(100 * (topSpeedMultiplier - 1)))) .. "%"
				end

				v2.Visible = true
			else
				v2.Visible = false
			end
		elseif k == "RangeMultiplier" then
			if p then
				if p >= 1 then
					v3.Text = "+" .. tostring((math.round(100 * (p - 1)))) .. "%"
				else
					v3.Text = tostring((math.round(100 * (p - 1)))) .. "%"
				end

				v2.Visible = true
			else
				v2.Visible = false
			end
		elseif k == "ExtraDamageMultiplier" then
			if damageMultiplier then
				if damageMultiplier >= 1 then
					v3.Text = "+" .. tostring((math.round(100 * (damageMultiplier - 1)))) .. "%"
				else
					v3.Text = tostring((math.round(100 * (damageMultiplier - 1)))) .. "%"
				end

				v2.Visible = true
			else
				v2.Visible = false
			end
		elseif k == "AllDamageReduction" then
			if allDamageReduction then
				v3.Text = "-" .. tostring((math.round(100 * allDamageReduction))) .. "%"
				v2.Visible = true
			else
				v2.Visible = false
			end
		elseif k == "MaxDamage" then
			if maximumDamage then
				v3.Text = `MAX DMG: {math.round(maximumDamage)}`
				v2.Visible = true
			else
				v2.Visible = false
			end
		elseif k == "Frozen" then
			if frozen then
				v2.Visible = true
			else
				v2.Visible = false
			end
		elseif k == "Ghostly" then
			if isGhostlyUnit then
				v2.Visible = true
			else
				v2.Visible = false
			end
		end

		ResizeTag(v2, v3) -- inferred equivalent call
	end
end

local function UpdateBarVisibility(visible: boolean)
	if visible then
		healthBar.Position = UDim2.new(0.5, 0, 1.1, 0)
		name.Position = UDim2.new(0.5, 0, 1.5, 0)
	else
		healthBar.Position = UDim2.new(0.5, 0, 0.5, 0)
		name.Position = UDim2.new(0.5, 0, 0.95, 0)
	end

	shieldBar.Visible = visible
end

function EnemyHover.Run(object)
	if object then
		local stealthDetection = object.StealthDetection
		local hasShield = object.HealthHandler:HasShield()
		UpdateBarVisibility(hasShield)
		local statMultipliers = object.BuffHandler:GetStatMultipliers()
		local v = math.max(
			object:Alive() and not object.PreventDeathUntilAbilityExecuted and 1 or 0,
			object.HealthHandler:GetHealth()
		)
		local maxHealth = object.HealthHandler:GetMaxHealth()
		local healthbarColor = ColorUtilities.GetHealthbarColor(v, maxHealth, object.Cloned)
		local visible = object.Stealth and not object.Revealed
		local v2 = visible and not object.NoStealthName
		local damageReductionTable = object.DamageReductionTable
		local damageResistanceModifier = object.DamageResistanceModifier
		local noCash = object.NoCash
		local topSpeedMultiplier = object.MovementHandler:GetTopSpeedMultiplier()
		local damageMultiplier = object.DamageMultiplier
		local maximumDamage = object.MaximumDamage
		local frozen = FROZEN_REWORK_ENABLED and object.Frozen
		local allDamageReduction = object.AllDamageReduction
		local isGhostlyUnit = object.IsGhostlyUnit

		if topSpeedMultiplier == 1 then
			topSpeedMultiplier = nil
		end

		local v3 = 1 + statMultipliers.RangeMultiplier

		if v3 == 1 then
			v3 = nil
		end

		if damageMultiplier == 1 then
			damageMultiplier = nil
		end

		if maximumDamage < 0 then
			maximumDamage = nil
		end

		if allDamageReduction == 0 then
			allDamageReduction = nil
		end

		local visible2 = damageReductionTable and #damageReductionTable > 0 and true
			or noCash
			or topSpeedMultiplier
			or v3
			or damageMultiplier
			or maximumDamage
			or frozen
			or allDamageReduction
			or isGhostlyUnit
		local v4 = v2 and "STEALTH " or ""

		if object.SenderName then
			v4 = `{v4}{string.upper(object.SenderName)}'S `
		end

		nameText.Text = `{v4}{string.upper(object.DisplayName)}`

		if #nameText.Text > 24 then
			local v5 = TextService:GetTextSize(
				nameText.Text,
				nameText.TextSize,
				nameText.Font,
				Vector2.new(1e999, 1e999)
			).X + 0
			name.Size = UDim2.new(0, v5, size.Y.Scale, size.Y.Offset)
		else
			name.Size = size
		end

		textLabel.Text = tostring((math.ceil(v))) .. "/" .. tostring(maxHealth) .. " HP"
		bar.BackgroundColor3 = healthbarColor
		bar.Size = UDim2.new(math.clamp(v / maxHealth, 0, 1), 0, 1, 0)
		hiddenGlass.Visible = visible
		tick.Visible = visible2
		detectionIcon.Visible = stealthDetection
		local shield = object.HealthHandler:GetShield()
		local maxShield = object.HealthHandler:GetMaxShield()

		if hasShield then
			textLabel2.Text = tostring((math.ceil(shield))) .. "/" .. tostring((math.ceil(maxShield))) .. " SHIELD"
			bar2.Size = UDim2.new(math.clamp(shield / maxShield, 0, 1), 0, 1, 0)
		end

		hiddenGlass.ImageColor3 = Color3.fromRGB(
			math.max(0, 255 * healthbarColor.R - 110),
			math.max(0, 255 * healthbarColor.G - 110),
			(math.max(0, 255 * healthbarColor.B - 110))
		)
		DisplayTags(
			damageReductionTable,
			damageResistanceModifier,
			noCash,
			topSpeedMultiplier,
			v3,
			damageMultiplier,
			maximumDamage,
			frozen,
			allDamageReduction,
			isGhostlyUnit
		)
	else
		warn("Tooltip error: enemy is nil")
	end

	TooltipUtilities.PositionTooltipAtMousePosition(enemyHover, UDim2.new(0, 2, 0, -15))
	return enemyHover
end

for _, frame in pairs(tags:GetChildren()) do
	if not frame:IsA("Frame") then
		continue
	end

	framesByName[frame.Name] = frame
	textsByName[frame.Name] = frame:FindFirstChild("ContentFrame"):FindFirstChild("Text")
end

return EnemyHover