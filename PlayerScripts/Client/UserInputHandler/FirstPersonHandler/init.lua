local FirstPersonHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local FirstPersonTypes = require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local parent = script.Parent
local UserInterfaceHandler = require(parent.Parent:WaitForChild("UserInterfaceHandler"))
local RangeCircleHandler = require(parent:WaitForChild("RangeCircleHandler"))
local UserInputUtilities = require(parent:WaitForChild("UserInputUtilities"))
local FirstPersonCameraHandler = require(script:WaitForChild("FirstPersonCameraHandler"))
local FirstPersonUIHandler = require(script:WaitForChild("FirstPersonUIHandler"))
local FirstPersonAttackManager = require(script:WaitForChild("FirstPersonAttackManager"))
local FirstPersonMovementHandler = require(script:WaitForChild("FirstPersonMovementHandler"))
local FirstPersonSoundHandler = require(script:WaitForChild("FirstPersonSoundHandler"))
local defaultConfig = FirstPersonTypes.GetDefaultConfig()
local event = BindableHandler.GetEvent("MouseButton1Down")
local event2 = BindableHandler.GetEvent("MouseButton1Up")
local event3 = BindableHandler.GetEvent("ScrollWheelUp")
local event4 = BindableHandler.GetEvent("ScrollWheelDown")
local event5 = BindableHandler.GetEvent("ShiftDown")
local event6 = BindableHandler.GetEvent("ShiftUp")
local event7 = BindableHandler.GetEvent("StopTowerDirectControl")
local event8 = BindableHandler.GetEvent("LockTowerDirectControlForTime")
local event9 = BindableHandler.GetEvent("DirectControlReload")
local event10 = BindableHandler.GetEvent("DirectControlSelectWeapon")
local event11 = BindableHandler.GetEvent("DirectControlCycleWeaponUp")
local event12 = BindableHandler.GetEvent("DirectControlCycleWeaponDown")
local event13 = BindableHandler.GetEvent("DirectControlZoomOut")
local event14 = BindableHandler.GetEvent("DirectControlZoomIn")
local event15 = BindableHandler.GetEvent("DirectControlUseAbility")
local LocalPlayer = Players.LocalPlayer
local v = nil
local levelStats = nil
local firstPersonConfig = nil
local v2 = 1
local v3 = 1
local v4 = 0

local function SetAttackHandlerIndex(p: number) -- 2 equivalent calls inferred from this helper
	if v then
		v:SetFirstPersonIndex(p)
	end

	FirstPersonCameraHandler.SwitchAttackHandler(p)
	FirstPersonAttackManager.SwitchAttackHandler(p)
	FirstPersonUIHandler.SwitchAttackHandler(p)
	FirstPersonSoundHandler.SwitchAttackHandler(p)
	v2 = p
end

local function GetAbility(p: number)
	if not (v and firstPersonConfig) then
		return
	end

	local abilityNames = firstPersonConfig and firstPersonConfig.AbilityNames
	local v5 = abilityNames and abilityNames[p]

	if not v5 then
		return
	end

	local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(v5)
	local ability = nil

	if towerAbilityConfig then
		ability = v.AbilityHandler:GetAbility(towerAbilityConfig.Name)

		if not ability then
			warn(`Shield ability with name {v5} not found`)
			return ability
		end
	else
		warn(`Shield ability config with name {v5} not found`)
	end

	return ability
end

local function UpdateZoomIndex(flag: boolean)
	if not firstPersonConfig then
		return
	end

	local zoomOptions = firstPersonConfig.ZoomOptions

	if not zoomOptions or #zoomOptions == 0 then
		return
	end

	v3 += flag and -1 or 1
	v3 = math.clamp(v3, 1, #zoomOptions)
	FirstPersonCameraHandler.SetFOV(zoomOptions[v3])
	FirstPersonUIHandler.SetZoomIndex(v3)
end

function FirstPersonHandler.CanBegin()
	return not (v4 > 0)
end

function FirstPersonHandler.Begin(p)
	v = p
	levelStats = p.LevelHandler:GetLevelStats()
	firstPersonConfig = levelStats.FirstPersonConfig or defaultConfig
	v3 = 1
	v:StartDirectControl(firstPersonConfig)
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = false
	FirstPersonCameraHandler.SetTower(p, firstPersonConfig)
	FirstPersonAttackManager.SetTower(p, firstPersonConfig)
	FirstPersonUIHandler.SetTower(p, firstPersonConfig)
	FirstPersonMovementHandler.SetTower(p, firstPersonConfig)
	FirstPersonSoundHandler.SetTower(p, firstPersonConfig)
	RangeCircleHandler.ToggleFPSMode(true, p)
	UserInterfaceHandler.ToggleFPSMode(true)
	workspace:SetAttribute("FPSMode", true)
	SetAttackHandlerIndex(1) -- inferred equivalent call
end

function FirstPersonHandler.Stop()
	if v then
		v:StopDirectControl()
		v = nil
	end

	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = true
	FirstPersonCameraHandler.RemoveTower()
	FirstPersonAttackManager.RemoveTower()
	FirstPersonUIHandler.RemoveTower()
	FirstPersonMovementHandler.RemoveTower()
	FirstPersonSoundHandler.RemoveTower()
	RangeCircleHandler.ToggleFPSMode(false)
	UserInterfaceHandler.ToggleFPSMode(false)
	workspace:SetAttribute("FPSMode", false)
end

function FirstPersonHandler.SwitchAttackHandler(p: number)
	local attackConfigs = firstPersonConfig and firstPersonConfig.AttackConfigs

	if not attackConfigs or p <= 0 or #attackConfigs < p then
		return
	end

	SetAttackHandlerIndex(p) -- inferred equivalent call
end

function FirstPersonHandler:GetAbility()
	return GetAbility(self)
end

function FirstPersonHandler.UseAbility(p: number)
	local ability = GetAbility(p)

	if ability then
		if not ability:CanUse() then
			return
		end

		local v5 = nil

		if ability.IsManualAimAtEnemy then
			local crosshairPosition = FirstPersonHandler.GetCrosshairPosition()
			local screenPositionGetHitForFPSMode = UserInputUtilities.ScreenPositionGetHitForFPSMode(crosshairPosition)
			local enemy = UserInputUtilities.GetEnemyFromHit(screenPositionGetHitForFPSMode)

			if enemy and enemy:FirstPersonTargetable() then
				v5 = ability:_AimingAtEnemyFinishedCallback(enemy, true)
			end
		else
			v5 = ability:Use(true)
		end

		if v5 then
			FirstPersonSoundHandler.AbilityUsed(p)
		end
	end
end

function FirstPersonHandler.AttackHitEnemies(p: number, p2, vector: Vector3, p3: number?, p4: number?, p5: number?)
	if not v then
		return
	end

	v:FirstPersonHitEnemies(p, p2, vector, p3, p4, p5)
	FirstPersonUIHandler.HitEnemy(p3)
end

function FirstPersonHandler.AttackMiss(vector: Vector3)
	if not v then
		return
	end

	v:FirstPersonMissInDirection(vector)
end

function FirstPersonHandler.FireProjectile(p, vector: Vector3, p2: number, p3: number?, p4: number?)
	if not v then
		return
	end

	local v5 = workspace:GetServerTimeNow() + p2
	v:FirstPersonFireProjectile(p, vector, v5, p3, p4)
end

function FirstPersonHandler.Attacked(_: number, _: string?, flag: boolean?)
	if not v then
		return
	end

	FirstPersonCameraHandler.ShotFired()
	FirstPersonUIHandler.ShotFired()
	FirstPersonSoundHandler.ShotFired()
	v:FirstPersonAttacked(flag)
end

function FirstPersonHandler.Reloaded()
	FirstPersonSoundHandler.Reloaded()
end

function FirstPersonHandler.GetCrosshairPosition()
	return FirstPersonUIHandler.GetCrosshairPosition()
end

function FirstPersonHandler.GetCurrentSpreadFactor()
	return FirstPersonUIHandler.GetCurrentSpreadFactor()
end

function FirstPersonHandler.GetCameraCFrame()
	return FirstPersonCameraHandler.GetCFrame()
end

function FirstPersonHandler.Run(p: number, _)
	if not v or p <= 0 then
		return
	end

	FirstPersonUIHandler.Run(p)
	FirstPersonAttackManager.Run(p)
end

function FirstPersonHandler.OnRenderStepped(p: number, p2: number, p3: number)
	v4 = math.max(0, v4 - p2)

	if not v or p2 <= 0 then
		return
	end

	FirstPersonCameraHandler.OnRenderStepped(p, p2)
	FirstPersonUIHandler.OnRenderStepped(p, p2)
	FirstPersonAttackManager.OnRenderStepped(p, p3)
	FirstPersonMovementHandler.OnRenderStepped(p, p2)
	v:FacePosition(FirstPersonCameraHandler.GetFacePosition())
end

function FirstPersonHandler.SetSpeedMultiplier(p: number)
	FirstPersonSoundHandler.SetSpeedMultiplier(p)
	FirstPersonUIHandler.SetSpeedMultiplier(p)
	FirstPersonCameraHandler.SetSpeedMultiplier(p)
	FirstPersonMovementHandler.SetSpeedMultiplier(p)
end

UserInputService.InputChanged:Connect(function(input, gameProcessed: boolean)
	if not v or gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement then
		FirstPersonCameraHandler.MouseMoved(input)
	elseif input.UserInputType == Enum.UserInputType.Touch then
		FirstPersonCameraHandler.TouchMoved(input)
	elseif input.UserInputType == Enum.UserInputType.Gamepad1 then
		FirstPersonCameraHandler.GamepadMoved(input)
	end
end)
event:AttachCallback(function()
	if not v then
		return
	end

	FirstPersonAttackManager.ToggleTryAttacking(true)
end)
event2:AttachCallback(function()
	FirstPersonAttackManager.ToggleTryAttacking(false)
end)
event3:AttachCallback(function()
	if not (v and firstPersonConfig) then
		return
	end

	local zoomOptions = firstPersonConfig.ZoomOptions

	if zoomOptions then
		if #zoomOptions == 0 then
			return
		end

		v3 += 1
		v3 = math.clamp(v3, 1, #zoomOptions)
		FirstPersonCameraHandler.SetFOV(zoomOptions[v3])
		FirstPersonUIHandler.SetZoomIndex(v3)
	end
end)
event4:AttachCallback(function()
	if not (v and firstPersonConfig) then
		return
	end

	local zoomOptions = firstPersonConfig.ZoomOptions

	if zoomOptions then
		if #zoomOptions == 0 then
			return
		end

		v3 += -1
		v3 = math.clamp(v3, 1, #zoomOptions)
		FirstPersonCameraHandler.SetFOV(zoomOptions[v3])
		FirstPersonUIHandler.SetZoomIndex(v3)
	end
end)
event5:AttachCallback(function()
	if not (v and LocalPlayer:GetAttribute("Developer")) then
		return
	end

	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = true
end)
event6:AttachCallback(function()
	if not (v and LocalPlayer:GetAttribute("Developer")) then
		return
	end

	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = false
end)
event9:AttachCallback(function()
	if not v then
		return
	end

	FirstPersonAttackManager.Reload()
end)
event10:AttachCallback(function(p: number)
	if not v then
		return
	end

	FirstPersonHandler.SwitchAttackHandler(p)
end)
event11:AttachCallback(function()
	if not v then
		return
	end

	FirstPersonHandler.SwitchAttackHandler(v2 - 1)
end)
event12:AttachCallback(function()
	if not v then
		return
	end

	FirstPersonHandler.SwitchAttackHandler(v2 + 1)
end)
event13:AttachCallback(function()
	if not (v and firstPersonConfig) then
		return
	end

	local zoomOptions = firstPersonConfig.ZoomOptions

	if zoomOptions then
		if #zoomOptions == 0 then
			return
		end

		v3 += -1
		v3 = math.clamp(v3, 1, #zoomOptions)
		FirstPersonCameraHandler.SetFOV(zoomOptions[v3])
		FirstPersonUIHandler.SetZoomIndex(v3)
	end
end)
event14:AttachCallback(function()
	if not (v and firstPersonConfig) then
		return
	end

	local zoomOptions = firstPersonConfig.ZoomOptions

	if zoomOptions then
		if #zoomOptions == 0 then
			return
		end

		v3 += 1
		v3 = math.clamp(v3, 1, #zoomOptions)
		FirstPersonCameraHandler.SetFOV(zoomOptions[v3])
		FirstPersonUIHandler.SetZoomIndex(v3)
	end
end)
event15:AttachCallback(function(p: number)
	if not v then
		return
	end

	FirstPersonHandler.UseAbility(p)
end)
event8:AttachCallback(function(p: number)
	v4 = p
	event7:Fire()
end)
return FirstPersonHandler