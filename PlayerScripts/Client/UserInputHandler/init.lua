local UserInputHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
require(common:WaitForChild("Utilities"))
require(script:WaitForChild("UserInputTypes"))
local UserInputUtilities = require(script:WaitForChild("UserInputUtilities"))
local MouseInput = require(script:WaitForChild("MouseInput"))
local KeyboardInput = require(script:WaitForChild("KeyboardInput"))
local TouchInput = require(script:WaitForChild("TouchInput"))
local GamepadInput = require(script:WaitForChild("GamepadInput"))
local Placement = require(script:WaitForChild("Placement"))
local Selection = require(script:WaitForChild("Selection"))
local Aiming = require(script:WaitForChild("Aiming"))
local GroundAiming = require(script:WaitForChild("GroundAiming"))
local GroundDirectionalAiming = require(script:WaitForChild("GroundDirectionalAiming"))
local Relocation = require(script:WaitForChild("Relocation"))
local PathAiming = require(script:WaitForChild("PathAiming"))
local TowerAiming = require(script:WaitForChild("TowerAiming"))
local RotationAiming = require(script:WaitForChild("RotationAiming"))
local RangeCircleHandler = require(script:WaitForChild("RangeCircleHandler"))
local DashedCircleHandler = require(script:WaitForChild("DashedCircleHandler"))
local FirstPersonHandler = require(script:WaitForChild("FirstPersonHandler"))
local parent = script.Parent
local PlayerClass = require(parent:WaitForChild("PlayerClass"))
local UserInterfaceHandler = require(parent:WaitForChild("UserInterfaceHandler"))
local TooltipHandler = require(parent:WaitForChild("UserInterfaceHandler"):WaitForChild("TooltipHandler"))
local gameClass = parent:WaitForChild("GameClass")
gameClass:WaitForChild("EnemyClass")
local towerClass = gameClass:WaitForChild("TowerClass")
gameClass:WaitForChild("PathEntityClass")
local mapEntityClass = gameClass:WaitForChild("MapEntityClass")
local LeftShift = Enum.KeyCode.LeftShift
local RightShift = Enum.KeyCode.RightShift
local MAX_AIR_TOWERS_PER_PLAYER = _G.MAX_AIR_TOWERS_PER_PLAYER
local event = BindableHandler.GetEvent("UserInputStateChanged")
local event2 = BindableHandler.GetEvent("MouseButton1Down")
local event3 = BindableHandler.GetEvent("MouseButton1Up")
local event4 = BindableHandler.GetEvent("MouseButton3Down")
local event5 = BindableHandler.GetEvent("TouchTapInWorld")
local event6 = BindableHandler.GetEvent("DoubleTouchTapInWorld")
local event7 = BindableHandler.GetEvent("TouchStarted")
local event8 = BindableHandler.GetEvent("TouchMoved")
local event9 = BindableHandler.GetEvent("StartTowerPlacement")
local event10 = BindableHandler.GetEvent("StopTowerPlacement")
local event11 = BindableHandler.GetEvent("DeselectTower")
local event12 = BindableHandler.GetEvent("DeselectCurrentTower")
local event13 = BindableHandler.GetEvent("TowerChanged")
local event14 = BindableHandler.GetEvent("SelectTowerBarButton")
local event15 = BindableHandler.GetEvent("DeselectTowerBarButton")
local event16 = BindableHandler.GetEvent("NoCashError")
local event17 = BindableHandler.GetEvent("TowerCountFullError")
local event18 = BindableHandler.GetEvent("LastInputTypeChanged")
local event19 = BindableHandler.GetEvent("StopTowerDirectControl")
local event20 = BindableHandler.GetEvent("MessagePrompt")
local event21 = BindableHandler.GetEvent("ErrorPrompt")
local v = NetworkingHandler.GetFunction("PlaceTower")
local v2 = NetworkingHandler.GetFunction("RetargetTower")
local lastInputType = UserInputService:GetLastInputType()
local v3 = lastInputType == Enum.UserInputType.Touch
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = "Normal"
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local stats = localPlayerWrapper.Stats
local lastChangeTimestamp = RangeCircleHandler.GetLastChangeTimestamp()
local now = os.clock()
local flag = false

local function LastInputTypeChanged(lastInputType2)
	lastInputType = lastInputType2
	event18:Fire(lastInputType)

	if lastInputType == Enum.UserInputType.Touch then
		v3 = true
	elseif lastInputType == Enum.UserInputType.MouseButton1 then
		v3 = false
	end

	if v3 then
		UserInterfaceHandler.EnableTouchControls()
	else
		UserInterfaceHandler.DisableTouchControls()
	end
end

local function Deselect() -- 10 equivalent calls inferred from this helper
	if v12 then
		Selection.DeselectTower()
		UserInterfaceHandler.DeselectTower()
		v12:Deselect()
		v12 = nil
	end

	UserInterfaceHandler.ToggleAdminHoverPanel()
end

local function CheckIfDeselect() -- 10 equivalent calls inferred from this helper
	if flag then
		Deselect() -- inferred equivalent call
		flag = false
	end
end

local function NoHover() -- 12 equivalent calls inferred from this helper
	if v10 then
		v10.UserInputHovered = false
		v10 = nil
	end

	TooltipHandler.RunNoHover()
end

local function Click() -- 3 equivalent calls inferred from this helper
	if v10 and v11 == "Tower" then
		UserInputHandler.SelectTower(v10)
		return
	end

	Deselect() -- inferred equivalent call
end

local function ConfirmPlacement()
	local towerConfig = ResourceManager.GetTowerConfig(v9)
	local cost = towerConfig.UpgradePathData.BaseLevelData.Cost
	local module = require(gameClass)
	local v20 = cost * module.GetTowerCostMultiplier(v9)

	if stats:HasCash(v20) then
		if stats:MaxTowersReached() then
			event21:Fire(`Can't place more than {stats:GetMaxTowerCount() or 1} towers!`)
			event17:Fire()
		elseif localPlayerWrapper:TowerTypeLimitReached(v9) then
			local towerTypeLimit = localPlayerWrapper:GetTowerTypeLimit(v9)

			if towerTypeLimit then
				event21:Fire(`Cannot place more than {towerTypeLimit} {towerConfig.OverrideDisplayName or v9}(s)!`)
			end
		else
			if towerConfig.PlacementType == Enums.PlacementTypes.Air and not towerConfig.IgnoreAirPlacementLimit then
				local module2 = require(towerClass)

				if module2.AirTowerLimitReached() then
					event21:Fire(`Cannot place more than {MAX_AIR_TOWERS_PER_PLAYER} total air towers!`)
					return
				end
			end

			local now2 = os.clock()
			local currentPlacementData, v21, v22, v23 = Placement.GetCurrentPlacementData()

			if not currentPlacementData then
				event21:Fire("Invalid placement!")
			elseif Placement.PlacementRequiresManualAim() then
				SoundHandler.Play("ClickTower")
				UserInputHandler.SetState("InitialAiming")
			else
				lastChangeTimestamp = RangeCircleHandler.GetLastChangeTimestamp()
				now = now2
				Placement.CacheCurrentCharacterModel(now2)

				if not (UserInputService:IsKeyDown(LeftShift) or UserInputService:IsKeyDown(RightShift)) then
					event10:Fire(true)
				end

				SoundHandler.Play("PlaceTower")

				if not v:InvokeServer(now2, v21, v22, v23) then
					Placement.RemoveCachedCharacterModel(now2, v21)
					event21:Fire("Error occurred during placement, try again!")
				end
			end
		end
	else
		local v21 = v20 - localPlayerWrapper.Stats:GetCash()
		event21:Fire(`You need ${math.ceil(v21)} more cash!`)
		event16:Fire()
	end
end

local function ConfirmManualAim()
	local now2 = os.clock()
	local currentPlacementData, v20, v21, v22 = Placement.GetCurrentPlacementData()
	local currentAimPosition, v23 = Placement.GetCurrentAimPosition()

	if not currentPlacementData then
		event21:Fire("Invalid placement!")
		return
	end

	if not currentAimPosition then
		event21:Fire("Target too far away or blocked!")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	lastChangeTimestamp = RangeCircleHandler.GetLastChangeTimestamp()
	now = now2
	Placement.CacheCurrentCharacterModel(now2)
	event10:Fire(true)
	SoundHandler.Play("PlaceTower")

	if not v:InvokeServer(now2, v20, v21, v22, v23) then
		Placement.RemoveCachedCharacterModel(now2, v20)
		event21:Fire("Error occurred during placement, try again!")
	end
end

local function CheckAbilityStatus(object)
	if object:GetStunned() then
		event21:Fire("Cannot use while stunned!")
		return false
	end

	if object:GetDisabled() then
		event21:Fire("Cannot use while disabled!")
		return false
	end

	if object:GetConverted() then
		event21:Fire("Cannot use while converted!")
		return false
	end

	if not object:GetTowerRebuilding() then
		return true
	end

	event21:Fire("Cannot use while rebuilding!")
	return false
end

local function ConfirmRetargeting()
	local currentAimPosition, v20 = Aiming.GetCurrentAimPosition()

	if not currentAimPosition then
		event21:Fire("Target too far away or blocked!")
		return
	end

	local v21 = v12

	if not v21 then
		warn("No tower currently selected")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if not (v14 and CheckAbilityStatus(v14)) then
		return
	end

	v14:BeginCooldown()
	SoundHandler.Play("PlaceTower")
	local manualAimPosition = v21.ManualAimPosition
	v21:SetManualAimPosition(v20)
	Selection.ManualAimPositionChanged(v20)

	if not v2:InvokeServer(v21.Hash, v20) then
		v21:SetManualAimPosition(manualAimPosition)
		Selection.ManualAimPositionChanged(manualAimPosition)
		event21:Fire("Error occurred during targeting, try again!")
	end
end

local function ConfirmAimingAbility()
	local currentAimPosition, v20 = Aiming.GetCurrentAimPosition()

	if not currentAimPosition then
		event21:Fire("Target too far away or blocked!")
		return
	end

	if not v12 then
		warn("No tower currently selected")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if v15 then
		CheckAbilityStatus(v15)
		v15:_AimingFinishedCallback(v20)
	end
end

local function ConfirmAimingAbilityGroundDirectional()
	local currentAimData, v20, v21 = GroundDirectionalAiming.GetCurrentAimData()

	if not currentAimData then
		event21:Fire("Invalid position!")
		return
	end

	if not v12 then
		warn("No tower currently selected")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if v15 then
		CheckAbilityStatus(v15)
		v15:_AimingAtGroundDirectionalFinishedCallback(v20, v21)
	end
end

local function ConfirmRelocationAbility()
	local currentRelocationPosition, v20 = Relocation.GetCurrentRelocationPosition()

	if not currentRelocationPosition then
		event21:Fire("Target too far away or blocked!")
		return
	end

	if not v12 then
		warn("No tower currently selected")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if v16 then
		CheckAbilityStatus(v16)
		v16:_AimingFinishedCallback(v20)
	end
end

local function ConfirmAimingAtTowerAbility()
	local currentAimTower, v20 = TowerAiming.GetCurrentAimTower()

	if not currentAimTower then
		event21:Fire("Select a valid tower!")
		return
	end

	if not v12 then
		warn("No tower currently selected")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if v17 then
		CheckAbilityStatus(v17)
		v17:_AimingAtTowerFinishedCallback(v20)
	end
end

local function ConfirmAimingPowerUpGround() -- 2 equivalent calls inferred from this helper
	local currentAimPosition, v20 = GroundAiming.GetCurrentAimPosition()

	if not currentAimPosition then
		event21:Fire("Invalid position!")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if v19 then
		v19:TryUse(v20)
	end
end

local function ConfirmAimingPowerUpGroundDirectional() -- 2 equivalent calls inferred from this helper
	local currentAimData, v20, v21 = GroundDirectionalAiming.GetCurrentAimData()

	if not currentAimData then
		event21:Fire("Invalid position!")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if v19 then
		v19:TryUse(v20, v21)
	end
end

local function ConfirmAimingPowerUpPath() -- 2 equivalent calls inferred from this helper
	local currentAimPosition, v20, v21, v22 = PathAiming.GetCurrentAimPosition()

	if not currentAimPosition then
		event21:Fire("Invalid position!")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")

	if v19 then
		v19:TryUse(v20, v21, v22)
	end
end

local function ConfirmTowerRotation() -- 2 equivalent calls inferred from this helper
	local currentAimRotation, v20 = RotationAiming.GetCurrentAimRotation()

	if not currentAimRotation then
		event21:Fire("Invalid position!")
		return
	end

	CheckIfDeselect() -- inferred equivalent call
	UserInputHandler.SetState("Normal")
	v15:_RotationFinishedCallback(v20)
end

local function EntityHovered(p, p2: string) -- 1 equivalent call inferred from this helper
	if v10 then
		v10.UserInputHovered = false
	end

	p.UserInputHovered = true
	v10 = p
	v11 = p2
end

local function TryGetEntityFromHit(p)
	if typeof(p) == "boolean" then
		return nil, nil
	end

	local v20 = nil
	local v21 = nil

	if not p then
		return nil, nil
	end

	local enemy = UserInputUtilities.GetEnemyFromHit(p)
	local selected = not enemy and UserInputUtilities.GetTowerFromHit(p)
	local selected2 = not selected and UserInputUtilities.GetPathEntityFromHit(p)
	local selected3 = not selected2 and UserInputUtilities.GetStaticEntityFromHit(p)
	local v22 = not selected3 and UserInputUtilities.GetMapEntityFromHit(p)

	if enemy then
		return enemy, "Enemy"
	end

	if selected then
		return selected, "Tower"
	end

	if selected2 then
		return selected2, "PathEntity"
	end

	if selected3 then
		return selected3, "StaticEntity"
	end

	if v22 then
		v20 = v22
		v21 = "MapEntity"
	end

	return v20, v21
end

local function RunNormal(p: number, p2, _: Vector3)
	if v12 then
		Selection.Run(p)
	end

	local v20, v21 = TryGetEntityFromHit(p2)

	if v20 then
		EntityHovered(v20, v21) -- inferred equivalent call

		if v21 == "Enemy" then
			TooltipHandler.RunEnemyHover(v20)
		elseif v21 == "Tower" then
			TooltipHandler.RunTowerHover(v20)
		elseif v21 == "PathEntity" then
			TooltipHandler.RunPathEntityHover(v20)
		elseif v21 == "StaticEntity" then
			TooltipHandler.RunStaticEntityHover(v20)
		elseif v21 == "MapEntity" then
			TooltipHandler.RunMapEntityHover(v20)
		end
	else
		NoHover() -- inferred equivalent call
	end
end

local function RunPlacement(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	Deselect() -- inferred equivalent call

	if vector then
		Placement.Run(p, vector, v9)
	end

	NoHover() -- inferred equivalent call
end

local function RunAiming(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	Deselect() -- inferred equivalent call

	if vector then
		Placement.RunAiming(p, vector)
	end

	NoHover() -- inferred equivalent call
end

local function RunRetargeting(p: number, _, vector: Vector3) -- 2 equivalent calls inferred from this helper
	if v12 and vector then
		Aiming.Run(p, vector)
	end

	NoHover() -- inferred equivalent call
end

local function RunRelocation(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	if v12 and vector then
		Relocation.Run(p, vector)
	end

	NoHover() -- inferred equivalent call
end

local function RunTowerAiming(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	if v12 and vector then
		TowerAiming.Run(p, vector)
	end

	NoHover() -- inferred equivalent call
end

local function RunAimingPowerUpGround(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	if vector then
		GroundAiming.Run(p, vector)
	end

	NoHover() -- inferred equivalent call
end

local function RunAimingPowerUpGroundDirectional(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	if vector then
		GroundDirectionalAiming.Run(p, vector)
	end

	NoHover() -- inferred equivalent call
end

local function RunAimingPowerUpPath(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	if vector then
		PathAiming.Run(p, vector)
	end

	NoHover() -- inferred equivalent call
end

local function RunAimingTowerRotation(p: number, _, vector: Vector3) -- 1 equivalent call inferred from this helper
	if vector then
		RotationAiming.Run(p, vector, lastInputType)
	end

	NoHover() -- inferred equivalent call
end

local function RunTowerDirectControl(p: number, p2, _: Vector3) -- 1 equivalent call inferred from this helper
	if v18 then
		FirstPersonHandler.Run(p, p2)
	end

	NoHover() -- inferred equivalent call
end

local function GetCurrentScreenHit()
	local v20 = nil
	local v21 = nil

	if not v3 then
		v20, v21 = UserInputUtilities.ScreenPositionGetHit(UserInputService:GetMouseLocation(), v8)
		return v20, v21
	end

	if table.find({
		"AimingPowerUpGround",
		"AimingPowerUpGroundDirectional",
		"AimingPowerUpPath",
		"AimingAbility",
		"AimingAbilityGroundDirectional",
		"RelocationAbility",
		"Retargeting",
		"InitialAiming",
		"Placement",
		"TowerRotation"
	}, v8) then
		if not v5 then
			return v20, v21
		end

		if v6 then
			return true, v6
		end

		local screenPositionGetHit, v22 = UserInputUtilities.ScreenPositionGetHit(v5, v8)
		return screenPositionGetHit, v22
	else
		if not v4 then
			return v20, v21
		end

		local screenPositionGetHit, v22 = UserInputUtilities.ScreenPositionGetHit(v4, v8)
		return screenPositionGetHit, v22
	end
end

function UserInputHandler.Update(p: number, p2: number, p3: number)
	local v20 = p * p2
	local v21, v22 = GetCurrentScreenHit()

	if v18 then
		if not v18:Alive() or v18:IsDestroyed() then
			UserInputHandler.SetState("Normal")
			v18 = nil
		end
	elseif
		v13
		and (not v13:Alive() or v15 and v15.Destroyed or v14 and v14.Destroyed or v16 and v16.Destroyed or v17 and v17.Destroyed)
	then
		UserInputHandler.SetState("Normal")
		v13 = nil
		v15 = nil
		v14 = nil
		v16 = nil
		v17 = nil
	end

	if v7 == Enums.GameStates.Running then
		if v8 == "Retargeting" then
			RunRetargeting(p, nil, v22) -- inferred equivalent call
		elseif v8 == "InitialAiming" then
			RunAiming(p, nil, v22) -- inferred equivalent call
		elseif v8 == "AimingAbility" then
			RunRetargeting(p, nil, v22) -- inferred equivalent call
		elseif v8 == "AimingAbilityGroundDirectional" or v8 == "AimingPowerUpGroundDirectional" then
			RunAimingPowerUpGroundDirectional(p, nil, v22) -- inferred equivalent call
		elseif v8 == "RelocationAbility" then
			RunRelocation(p, nil, v22) -- inferred equivalent call
		elseif v8 == "AimingAtTowerAbility" then
			RunTowerAiming(p, nil, v22) -- inferred equivalent call
		elseif v8 == "AimingPowerUpGround" then
			RunAimingPowerUpGround(p, nil, v22) -- inferred equivalent call
		elseif v8 == "AimingPowerUpPath" then
			RunAimingPowerUpPath(p, nil, v22) -- inferred equivalent call
		elseif v8 == "TowerRotation" then
			RunAimingTowerRotation(p, nil, v22) -- inferred equivalent call
		elseif v8 == "TowerDirectControl" then
			RunTowerDirectControl(p, v21) -- inferred equivalent call
		elseif v8 == "Placement" then
			RunPlacement(p, nil, v22) -- inferred equivalent call
		else
			RunNormal(p, v21, v22)
		end
	else
		NoHover() -- inferred equivalent call
	end

	Placement.CacheRun(p)
	DashedCircleHandler.Run(p)
	FirstPersonHandler.OnRenderStepped(p, v20, p * p3)
end

function UserInputHandler.SelectTower(object, flag2: boolean?, flag3: boolean?, flag4: boolean?)
	if flag2 == nil then
		flag2 = false
	end

	if v12 == object and not flag2 then
		return
	end

	if v12 and not flag2 then
		v12:Deselect()
	end

	if not object:Selectable() then
		return
	end

	Selection.SelectTower(object, flag2)
	UserInterfaceHandler.SelectTower(object)
	object:Select()
	v12 = object

	if not (flag2 or flag3 or flag4) then
		SoundHandler.Play("ClickTower")
	end

	if flag4 then
		flag = true
	end
end

function UserInputHandler.SelectTowerFromInitialPlacement(p, p2: number)
	if not (lastChangeTimestamp == RangeCircleHandler.GetLastChangeTimestamp() and now == p2) then
		return
	end

	UserInputHandler.SelectTower(p, nil, true)
end

function UserInputHandler.IsPlacingTower()
	return v8 == "Placement"
end

function UserInputHandler.GetState()
	return v8
end

function UserInputHandler.SetState(p, p2)
	local v20 = v8
	v8 = p
	event:Fire(v8)

	if v20 ~= v8 then
		if p == "Normal" then
			flag = false
		end

		if p == "AimingPowerUpGround" then
			event20:Fire("Select location on ground!")
		elseif v20 == "AimingPowerUpGround" then
			GroundAiming.Hide()
		end

		if p == "AimingPowerUpGroundDirectional" or p == "AimingAbilityGroundDirectional" then
			event20:Fire("Select location on ground! (R to rotate)")
		elseif v20 == "AimingPowerUpGroundDirectional" or v20 == "AimingAbilityGroundDirectional" then
			GroundDirectionalAiming.Hide()
		end

		if p == "AimingPowerUpPath" then
			event20:Fire("Select location on path!")
		elseif v20 == "AimingPowerUpPath" then
			PathAiming.Hide()
		end

		if p == "TowerRotation" then
			event20:Fire("Select new direction!")
		elseif v20 == "TowerRotation" then
			RotationAiming.Hide()
		end

		if p == "Placement" then
			local module = require(towerClass)
			module.PlacementStarted()
			local module2 = require(mapEntityClass)
			module2.PlacementStarted()
		elseif v20 == "Placement" then
			local module = require(towerClass)
			module.PlacementStopped()
			local module2 = require(mapEntityClass)
			module2.PlacementStopped()
		end

		if (v20 == "InitialAiming" or v20 == "Placement") and p == "Normal" then
			Placement.HideTowerPreview()
		end

		if v20 == "InitialAiming" and p == "Placement" then
			Placement.HideTowerPreview()
		end

		if v20 == "Placement" and p == "InitialAiming" then
			event20:Fire("Select location on path to aim at!")
		end

		if p == "Retargeting" then
			event20:Fire("Select location on path to aim at!")
		end

		if p == "AimingAbility" then
			if p2 then
				event20:Fire("Select location on path!")
			else
				event20:Fire("Select location on ground!")
			end
		end

		if p == "RelocationAbility" then
			event20:Fire("Select new tower location!")
		end

		if v20 == "RelocationAbility" then
			Relocation.Hide()
		end

		if p == "AimingAtTowerAbility" then
			event20:Fire("Select target tower!")
		end

		if p == "TowerDirectControl" then
			KeyboardInput.SetIsDirectControlMode(true)
			GamepadInput.SetIsDirectControlMode(true)
		elseif v20 == "TowerDirectControl" then
			KeyboardInput.SetIsDirectControlMode(false)
			GamepadInput.SetIsDirectControlMode(false)
			FirstPersonHandler.Stop()
		end
	end
end

function UserInputHandler.GameStateChanged(p: string)
	v7 = p

	if
		v7 == Enums.GameStates.DifficultyVoting
		or v7 == Enums.GameStates.LoadoutSelection
		or v7 == Enums.GameStates.SeizureWarning
		or v7 == Enums.GameStates.Cutscene
	then
		event10:Fire()
		event19:Fire()
	end

	if v7 == Enums.GameStates.EndScreen then
		event10:Fire()
		event19:Fire()
		v13 = nil
		v15 = nil
		v14 = nil
		v16 = nil
		v17 = nil
		v19 = nil
		Deselect() -- inferred equivalent call
	end
end

function UserInputHandler.BeginManualAimRetargeting(p, p2)
	v13 = p
	v14 = p2
	Aiming.BeginManualAimRetargeting(p)
	UserInputHandler.SetState("Retargeting")
end

function UserInputHandler.BeginManualAimAbility(p, p2)
	v13 = p
	v15 = p2
	Aiming.BeginManualAimAbility(p, p2)
	UserInputHandler.SetState("AimingAbility", p2.IsManualAimAtPath)
end

function UserInputHandler.BeginManualAimGroundDirectionalAbility(p, p2)
	v13 = p
	v15 = p2
	GroundDirectionalAiming.BeginGroundDirectionalAiming(p2.StrikeZoneLength, p2.StrikeZoneWidth)
	UserInputHandler.SetState("AimingAbilityGroundDirectional")
end

function UserInputHandler.BeginManualRelocationAbility(p, p2)
	v13 = p
	v16 = p2
	Relocation.BeginManualRelocationAbility(p, p2)
	UserInputHandler.SetState("RelocationAbility")
end

function UserInputHandler.BeginManualAimAtTowerAbility(p, p2)
	v13 = p
	v17 = p2
	TowerAiming.BeginAimingAtTowerAbility(p, p2)
	UserInputHandler.SetState("AimingAtTowerAbility")
end

function UserInputHandler.BeginManualAimGroundPowerUp(p, p2: number)
	event10:Fire()
	Deselect() -- inferred equivalent call
	v19 = p
	GroundAiming.BeginGroundAiming(p2)
	UserInputHandler.SetState("AimingPowerUpGround")
end

function UserInputHandler.BeginManualAimGroundDirectionalPowerUp(p, p2: number, p3: number)
	event10:Fire()
	Deselect() -- inferred equivalent call
	v19 = p
	GroundDirectionalAiming.BeginGroundDirectionalAiming(p2, p3)
	UserInputHandler.SetState("AimingPowerUpGroundDirectional")
end

function UserInputHandler.BeginManualAimPathPowerUp(p)
	event10:Fire()
	Deselect() -- inferred equivalent call
	v19 = p
	PathAiming.BeginPathAiming(5)
	UserInputHandler.SetState("AimingPowerUpPath")
end

function UserInputHandler.BeginManualTowerRotation(p, p2)
	v13 = p
	v15 = p2
	RotationAiming.BeginRotationAiming(p)
	UserInputHandler.SetState("TowerRotation")
end

function UserInputHandler.BeginTowerDirectControl(p)
	if not FirstPersonHandler.CanBegin() then
		event21:Fire("Cannot control tower right now!")
		return
	end

	if v8 == "TowerDirectControl" then
		FirstPersonHandler.Stop()
	end

	v18 = p
	FirstPersonHandler.Begin(p)
	UserInputHandler.SetState("TowerDirectControl")
end

function UserInputHandler.SetSpeedMultiplier(p: number)
	FirstPersonHandler.SetSpeedMultiplier(p)
end

function UserInputHandler.Initialize()
	UserInputUtilities.Initialize()
end

UserInputService.LastInputTypeChanged:Connect(LastInputTypeChanged)
event2:AttachCallback(function()
	if v3 then
		return
	end

	if v8 == "InitialAiming" then
		ConfirmManualAim()
	elseif v8 == "Retargeting" then
		ConfirmRetargeting()
	elseif v8 == "AimingAbility" then
		ConfirmAimingAbility()
	elseif v8 == "AimingAbilityGroundDirectional" then
		ConfirmAimingAbilityGroundDirectional()
	elseif v8 == "RelocationAbility" then
		ConfirmRelocationAbility()
	elseif v8 == "AimingAtTowerAbility" then
		ConfirmAimingAtTowerAbility()
	elseif v8 == "AimingPowerUpGround" then
		ConfirmAimingPowerUpGround() -- inferred equivalent call
	elseif v8 == "AimingPowerUpGroundDirectional" then
		ConfirmAimingPowerUpGroundDirectional() -- inferred equivalent call
	elseif v8 == "AimingPowerUpPath" then
		ConfirmAimingPowerUpPath() -- inferred equivalent call
	elseif v8 == "TowerRotation" then
		ConfirmTowerRotation() -- inferred equivalent call
	elseif v8 == "Placement" then
		ConfirmPlacement()
	elseif v8 == "Normal" then
		Click() -- inferred equivalent call
	end
end)
event3:AttachCallback(function()
	if v3 then
	end
end)
event4:AttachCallback(function()
	if not PlayerClass.LocalPlayerHasAdminPanelAccess() then
		return
	end

	local v20, _ = GetCurrentScreenHit()
	local v21, v22 = TryGetEntityFromHit(v20)
	UserInterfaceHandler.ToggleAdminHoverPanel(v21, v22)
end)
event5:AttachCallback(function(point: Vector2, flag2: boolean)
	if not v3 or flag2 then
		return
	end

	local screenPositionGetHit, v20 = UserInputUtilities.ScreenPositionGetHit(point, v8)
	v5 = point
	v6 = v20

	if v8 == "Normal" then
		TryGetEntityFromHit(screenPositionGetHit)
		Click() -- inferred equivalent call
	end
end)
event6:AttachCallback(function(flag2: boolean)
	if not v3 or flag2 then
		return
	end

	if v8 == "InitialAiming" then
		ConfirmManualAim()
	elseif v8 == "Retargeting" then
		ConfirmRetargeting()
	elseif v8 == "AimingAbility" then
		ConfirmAimingAbility()
	elseif v8 == "AimingAbilityGroundDirectional" then
		ConfirmAimingAbilityGroundDirectional()
	elseif v8 == "RelocationAbility" then
		ConfirmRelocationAbility()
	elseif v8 == "AimingAtTowerAbility" then
		ConfirmAimingAtTowerAbility()
	elseif v8 == "AimingPowerUpGround" then
		ConfirmAimingPowerUpGround() -- inferred equivalent call
	elseif v8 == "AimingPowerUpGroundDirectional" then
		ConfirmAimingPowerUpGroundDirectional() -- inferred equivalent call
	elseif v8 == "AimingPowerUpPath" then
		ConfirmAimingPowerUpPath() -- inferred equivalent call
	elseif v8 == "TowerRotation" then
		ConfirmTowerRotation() -- inferred equivalent call
	elseif v8 == "Placement" then
		ConfirmPlacement()
	elseif v8 == "Normal" then
		Click() -- inferred equivalent call
	end
end)
event8:AttachCallback(function(point: Vector2)
	if not v3 then
		return
	end

	v4 = point
end)
event7:AttachCallback(function(point: Vector2)
	if not v3 then
		return
	end

	v4 = point
end)
event9:AttachCallback(function(p: number, p2: string)
	assert(p2, "Start tower placement expected tower config")

	if v7 ~= Enums.GameStates.Running then
		print("Cannot place during", v7)
		return
	end

	local towerConfig = ResourceManager.GetTowerConfig(p2)

	if towerConfig.BannedInPVP and workspace:GetAttribute("IsPVP") then
		event21:Fire(`{towerConfig.OverrideDisplayName or p2} cannot be placed in PVP!`)
	elseif localPlayerWrapper:TowerTypeLimitReached(p2) then
		local towerTypeLimit = localPlayerWrapper:GetTowerTypeLimit(p2)

		if towerTypeLimit then
			event21:Fire(`Cannot place more than {towerTypeLimit} {towerConfig.OverrideDisplayName or p2}(s)!`)
		end
	else
		if towerConfig.PlacementType == Enums.PlacementTypes.Air and not towerConfig.IgnoreAirPlacementLimit then
			local module = require(towerClass)

			if module.AirTowerLimitReached() then
				event21:Fire(`Cannot place more than {MAX_AIR_TOWERS_PER_PLAYER} total air towers!`)
				return
			end
		end

		v9 = p2
		UserInputHandler.SetState("Placement")
		event14:Fire(p)
		GuiService.SelectedObject = nil
	end
end)
event10:AttachCallback(function(p)
	if not p and table.find({
		"AimingPowerUpGround",
		"AimingPowerUpGroundDirectional",
		"AimingAbility",
		"AimingAbilityGroundDirectional",
		"RelocationAbility",
		"AimingAtTowerAbility",
		"TowerRotation",
		"Retargeting",
		"InitialAiming",
		"Placement"
	}, v8) then
		SoundHandler.Play("CancelTower")
	end

	UserInputHandler.SetState("Normal")
	event15:Fire()
end)
event19:AttachCallback(function()
	UserInputHandler.SetState("Normal")
	v18 = nil
end)
event11:AttachCallback(function(p: number)
	if v12 and (not v12.Hash or v12.Hash == p) then
		Deselect() -- inferred equivalent call
		UserInputHandler.SetState("Normal")
		GuiService.SelectedObject = nil
	end
end)
event12:AttachCallback(function()
	if v12 then
		Deselect() -- inferred equivalent call
		UserInputHandler.SetState("Normal")
	end

	GuiService.SelectedObject = nil
end)
event13:AttachCallback(function(p: number, flag2: boolean)
	if v12 and v12.Hash == p then
		UserInputHandler.SelectTower(v12, true)
	end

	if flag2 and v18 and v18.Hash == p and v8 == "TowerDirectControl" then
		UserInputHandler.SetState("Normal")
		v18 = nil
	end

	DashedCircleHandler.RefreshDashedCircleForTower(p)
end)
MouseInput.Initialize()
KeyboardInput.Initialize()
TouchInput.Initialize()
GamepadInput.Initialize()
LastInputTypeChanged(lastInputType)
return UserInputHandler