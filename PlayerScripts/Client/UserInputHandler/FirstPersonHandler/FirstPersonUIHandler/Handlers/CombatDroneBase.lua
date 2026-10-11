local CombatDroneBase = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
local Utilities = require(common:WaitForChild("Utilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local parent = script.Parent.Parent
local parent2 = parent.Parent
require(parent:WaitForChild("FirstPersonUIUtilities"))
local FirstPersonAttackManager = require(parent2:WaitForChild("FirstPersonAttackManager"))
local BaseClasses = script.Parent.Parent:WaitForChild("BaseClasses")
local WeaponFrameClass = require(BaseClasses:WaitForChild("WeaponFrameClass"))
local AbilityButtonClass = require(BaseClasses:WaitForChild("AbilityButtonClass"))
local HealthbarClass = require(BaseClasses:WaitForChild("HealthbarClass"))
local AltitudeMeterClass = require(BaseClasses:WaitForChild("AltitudeMeterClass"))
local DirectionMeterClass = require(BaseClasses:WaitForChild("DirectionMeterClass"))
local VelocityTextClass = require(BaseClasses:WaitForChild("VelocityTextClass"))
local RangeTextClass = require(BaseClasses:WaitForChild("RangeTextClass"))
local color = Color3.fromRGB(168, 38, 38)
local color2 = Color3.fromRGB(255, 255, 255)
local child = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FirstPersonInterface"):WaitForChild("FirstPersonScreen"):WaitForChild("Frames"):WaitForChild(script.Name)
local cameraFrame = child.CameraFrame
local edges = cameraFrame.Edges
local searchForTargetsText = cameraFrame.SearchForTargetsText
local weaponName = cameraFrame.WeaponName.WeaponName
local range = cameraFrame.Range
local feedName = child.StaticElements.FeedName
local timeText = child.Time.TimeText
local upgradedCrosshair = child.UpgradedCrosshair
local zoom = child.Zoom
local zoomText = zoom.ZoomText
local v = { zoom.Ticks["1_Main"].ImageLabel, zoom.Ticks["2_Main"].ImageLabel, zoom.Ticks["3_Main"].ImageLabel }
local weaponInfo = child.WeaponInfo
local backgroundTint = child.BackgroundTint
local colorCorrection = child:WaitForChild("LightingEffects").ColorCorrection
local v2 = {}
local v3 = nil
local v4 = 1
local v5 = AbilityButtonClass.New(1, zoom.ShieldButton, {
	UsingColor = Color3.fromRGB(161, 27, 27),
	UsingTransparency = 0.5,
	AvailableColor = Color3.fromRGB(85, 85, 85),
	AvailableTransparency = 0.2,
	CooldownColor = Color3.fromRGB(161, 27, 27),
	CooldownTransparency = 0.5
})
local v6 = HealthbarClass.New(zoom.Health)
local v7 = AltitudeMeterClass.New(child.AltitudeMeter, { Interval = 20 })
local v8 = DirectionMeterClass.New(child.DirectionMeter, {})
local v9 = VelocityTextClass.New(child.Time.VelocityText, {})
local v10 = RangeTextClass.New(range.RangeText, { Format = "%s STUDS" })
local v11 = nil

local function ActivateWeaponFrame(p: number) -- 1 equivalent call inferred from this helper
	if v3 then
		v3:Deselect()
		v3 = nil
	end

	v3 = v2[p]

	if v3 then
		v3:Select()
	end
end

function CombatDroneBase:SetTower(p)
	v11 = self
	local overallLevel = self.LevelHandler:GetOverallLevel()

	if overallLevel <= 0 then
		feedName.Text = "> FEED_DRONE_T0B0"
	elseif overallLevel == 1 then
		feedName.Text = "> FEED_DRONE_T1BX"
	elseif overallLevel == 2 then
		feedName.Text = "> FEED_DRONE_T2BX"
	elseif overallLevel == 3 then
		feedName.Text = "> FEED_DRONE_T3BX"
	elseif overallLevel == 4 then
		feedName.Text = "> FEED_DRONE_T4BX"
	elseif overallLevel >= 5 then
		feedName.Text = "> FEED_DRONE_T5BX"
	end

	if overallLevel <= 3 then
		colorCorrection.Enabled = true
		backgroundTint.Visible = false
		MapHandler.DisableColorCorrectionEffects_Client()
	else
		colorCorrection.Enabled = false
		backgroundTint.Visible = true
		MapHandler.EnableColorCorrectionEffects_Client()
	end

	if overallLevel < 1 then
		upgradedCrosshair.Visible = false
	else
		upgradedCrosshair.Visible = true
	end

	if overallLevel >= 3 then
		v5.Visible = true
		edges.Visible = true
	else
		v5.Visible = false
		edges.Visible = false
	end

	if overallLevel >= 4 then
		v6:SetEnabled(true)
		v8:SetEnabled(true)
		searchForTargetsText.Visible = true
	else
		v6:SetEnabled(false)
		v8:SetEnabled(false)
		searchForTargetsText.Visible = false
	end

	if overallLevel >= 5 then
		range.Visible = true
		v10:SetEnabled(true)
		v9:SetEnabled(true)
	else
		range.Visible = false
		v10:SetEnabled(false)
		v9:SetEnabled(false)
	end

	v7:SetEnabled(true)

	if p.AttackConfigs then
		for i, v12 in ipairs(v2) do
			v12:SetAttackConfig(p.AttackConfigs[i])
		end
	end

	local module = require(parent2)
	v5:SetAbility(module.GetAbility(1))
	v6:SetHealthHandler(self.HealthHandler)
	v7:SetTower(self)
	v8:SetTower(self)
	v9:SetTower(self)
	CombatDroneBase.SetZoomIndex(1)
end

function CombatDroneBase.RemoveTower()
	v5:SetAbility()
	v7:SetTower()
	v8:SetTower()
	v9:SetTower()
	MapHandler.EnableColorCorrectionEffects_Client()
end

function CombatDroneBase.SwitchAttackHandler(p: number)
	v4 = p
	local attackHandlerData = FirstPersonAttackManager.GetAttackHandlerData(p)

	if attackHandlerData.AttackConfig.WeaponName then
		weaponName.Text = attackHandlerData.AttackConfig.WeaponName
	end

	ActivateWeaponFrame(p) -- inferred equivalent call
end

function CombatDroneBase.ShotFired() end

function CombatDroneBase.SetZoomIndex(p: number)
	for k, v12 in pairs(v) do
		if k == p then
			v12.Visible = true
		else
			v12.Visible = false
		end
	end

	zoomText.Text = `ZOOM: {p == 1 and 1 or p == 2 and 3 or p == 3 and 5 or 1}X`
end

function CombatDroneBase:Run()
	local timeAlive = v11.TimeAlive

	if timeAlive > 0 then
		timeText.Text = Utilities.ConvertToTimeStringFull(timeAlive)
	end

	if FirstPersonAttackManager.GetAttackHandlerData(v4).IsReloading then
		if math.floor(timeAlive * 3) % 2 == 0 then
			weaponName.TextColor3 = color
		else
			weaponName.TextColor3 = color2
		end
	else
		weaponName.TextColor3 = color2
	end

	for i, v12 in ipairs(v2) do
		if v12.Enabled then
			v12:Run(self, FirstPersonAttackManager.GetAttackHandlerData(i))
		end
	end

	v5:Run(self)
	v6:Run(self)
	v7:Run(self)
	v8:Run(self)
	v9:Run(self)
end

function CombatDroneBase:OnRenderStepped(p: number)
	v10:OnRenderStepped(p)
end

for i = 1, 1e999 do
	local child2 = weaponInfo:FindFirstChild((tostring(i)))

	if not child2 then
		break
	end

	v2[i] = WeaponFrameClass.New(i, child2)
end

return CombatDroneBase