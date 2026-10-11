local CombatDroneP2 = {}
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
local enemyClass = parent2.Parent.Parent:WaitForChild("GameClass"):WaitForChild("EnemyClass")
require(parent:WaitForChild("FirstPersonUIUtilities"))
local FirstPersonAttackManager = require(parent2:WaitForChild("FirstPersonAttackManager"))
local BaseClasses = script.Parent.Parent:WaitForChild("BaseClasses")
local WeaponFrameClass = require(BaseClasses:WaitForChild("WeaponFrameClass"))
local AbilityButtonClass = require(BaseClasses:WaitForChild("AbilityButtonClass"))
local HealthbarClass = require(BaseClasses:WaitForChild("HealthbarClass"))
local AltitudeMeterClass = require(BaseClasses:WaitForChild("AltitudeMeterClass"))
local DirectionMeterClass = require(BaseClasses:WaitForChild("DirectionMeterClass"))
local RangeTextClass = require(BaseClasses:WaitForChild("RangeTextClass"))
local color = Color3.fromRGB(168, 38, 38)
local color2 = Color3.fromRGB(255, 255, 255)
local CurrentCamera = workspace.CurrentCamera
local child = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FirstPersonInterface"):WaitForChild("FirstPersonScreen"):WaitForChild("Frames"):WaitForChild(script.Name)
local innerFrame = child.InnerFrame
local spotterFrame = child.SpotterFrame
local weaponName = innerFrame.StaticElements.WeaponName.WeaponName
local feedName = innerFrame.StaticElements.FeedName
local timeText = innerFrame.Time.TimeText
local ellipse = innerFrame.Ellipse
local cross = ellipse.Cross
local upgradedCross = ellipse.UpgradedCross
local maxCross = ellipse.MaxCross
local zoom = innerFrame.Zoom
local zoomText = zoom.ZoomText
local v = { zoom.Ticks["1_Main"].ImageLabel, zoom.Ticks["2_Main"].ImageLabel, zoom.Ticks["3_Main"].ImageLabel }
local weaponInfo = innerFrame.WeaponInfo
local lightingEffects = child:WaitForChild("LightingEffects")
local blue = lightingEffects.Blue
local green = lightingEffects.Green
local v2 = {}
local v3 = nil
local v4 = 1
local v5 = AbilityButtonClass.New(1, zoom.SpotterButton, {
	UsingColor = Color3.fromRGB(161, 27, 27),
	UsingTransparency = 0.5,
	AvailableColor = Color3.fromRGB(85, 85, 85),
	AvailableTransparency = 0.2,
	CooldownColor = Color3.fromRGB(161, 27, 27),
	CooldownTransparency = 0.5
})
local v6 = HealthbarClass.New(innerFrame.Health, true)
local v7 = AltitudeMeterClass.New(innerFrame.AltitudeMeter, { Interval = 25 })
local v8 = DirectionMeterClass.New(innerFrame.DirectionMeter, {})
local v9 = RangeTextClass.New(innerFrame.RangeText, { Format = "RANGE: %s STUDS" })
local v10 = nil

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

function CombatDroneP2:SetTower(p)
	v10 = self
	local overallLevel = self.LevelHandler:GetOverallLevel()

	if overallLevel <= 3 then
		feedName.Text = "> FEED_DRONE_TXB3"
		cross.Visible = true
		upgradedCross.Visible = false
		maxCross.Visible = false
	elseif overallLevel == 4 then
		feedName.Text = "> FEED_DRONE_TXB4"
		cross.Visible = false
		upgradedCross.Visible = true
		maxCross.Visible = false
	elseif overallLevel >= 5 then
		feedName.Text = "> FEED_DRONE_TXB5"
		cross.Visible = false
		upgradedCross.Visible = false
		maxCross.Visible = true
	end

	if overallLevel < 4 then
		v7:SetEnabled(false)
	else
		v7:SetEnabled(true)
	end

	if overallLevel < 5 then
		v6:SetEnabled(false)
		v8:SetEnabled(false)
		v9:SetEnabled(false)
		blue.Enabled = true
		green.Enabled = false
	else
		v6:SetEnabled(true)
		v8:SetEnabled(true)
		v9:SetEnabled(true)
		blue.Enabled = false
		green.Enabled = true
	end

	MapHandler.DisableColorCorrectionEffects_Client()

	if p.AttackConfigs then
		for i, v11 in ipairs(v2) do
			v11:SetAttackConfig(p.AttackConfigs[i])
		end
	end

	local module = require(parent2)
	v5:SetAbility(module.GetAbility(1))
	v6:SetHealthHandler(self.HealthHandler)
	v7:SetTower(self)
	v8:SetTower(self)
	CombatDroneP2.SetZoomIndex(1)
end

function CombatDroneP2.RemoveTower()
	v5:SetAbility()
	v7:SetTower()
	v8:SetTower()
	MapHandler.EnableColorCorrectionEffects_Client()
end

function CombatDroneP2.SwitchAttackHandler(p: number)
	v4 = p
	local attackHandlerData = FirstPersonAttackManager.GetAttackHandlerData(p)

	if attackHandlerData.AttackConfig.WeaponName then
		weaponName.Text = attackHandlerData.AttackConfig.WeaponName
	end

	ActivateWeaponFrame(p) -- inferred equivalent call
end

function CombatDroneP2.ShotFired() end

function CombatDroneP2.SetZoomIndex(p: number)
	for k, v11 in pairs(v) do
		if k == p then
			v11.Visible = true
		else
			v11.Visible = false
		end
	end

	zoomText.Text = `ZOOM: {p == 1 and 1 or p == 2 and 3 or p == 3 and 5 or 1}X`
end

function CombatDroneP2:Run()
	local timeAlive = v10.TimeAlive

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

	for i, v11 in ipairs(v2) do
		if v11.Enabled then
			v11:Run(self, FirstPersonAttackManager.GetAttackHandlerData(i))
		end
	end

	v5:Run(self)
	v6:Run(self)
	v7:Run(self)
	v8:Run(self)
end

function CombatDroneP2:OnRenderStepped(p: number)
	v9:OnRenderStepped(p)
	CombatDroneP2._RunSpotterFrame()
end

function CombatDroneP2._RunSpotterFrame()
	local module = require(enemyClass)
	local v11 = nil

	for _, v12 in pairs(module.GetEnemies()) do
		if not v12.BuffHandler:IsSpotted() then
			continue
		end

		v11 = v12
		break
	end

	local visible = false

	if v11 then
		local realTorso = v11.Character:GetRealTorso()
		local position = realTorso.Position
		local worldToViewportPoint, v12 = CurrentCamera:WorldToViewportPoint(position)

		if v12 then
			local size = realTorso.Size
			local worldToViewportPoint2 = CurrentCamera:WorldToViewportPoint(position + size / 2)
			local worldToViewportPoint3 = CurrentCamera:WorldToViewportPoint(position - size / 2)
			spotterFrame.Size = UDim2.new(0.5, 0, 0.05, (math.abs(worldToViewportPoint2.Y - worldToViewportPoint3.Y)))
			spotterFrame.Position = UDim2.new(0, worldToViewportPoint.X, 0, worldToViewportPoint.Y)
			visible = true
		end
	end

	spotterFrame.Visible = visible
end

for i = 1, 1e999 do
	local child2 = weaponInfo:FindFirstChild((tostring(i)))

	if not child2 then
		break
	end

	v2[i] = WeaponFrameClass.New(i, child2)
end

return CombatDroneP2