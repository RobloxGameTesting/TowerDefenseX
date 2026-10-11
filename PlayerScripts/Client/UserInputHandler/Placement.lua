local Placement = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Utilities"))
local PlacementHandler = require(Common:WaitForChild("PlacementHandler"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local MapHandler = require(Common:WaitForChild("MapHandler"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
require(Common:WaitForChild("NetworkingHandler"))
local PathHandler = require(Common:WaitForChild("PathHandler"))
local PathUtilities = require(Common:WaitForChild("PathUtilities"))
local ValidArcsUtilities = require(Common:WaitForChild("ValidArcsUtilities"))
local TowerUtilities = require(Common:WaitForChild("TowerUtilities"))
local TowerUpgradeShopUtilities = require(Common:WaitForChild("TowerUpgradeShopUtilities"))
local TeamUtilities = require(Common:WaitForChild("TeamUtilities"))
local DashedCircleUtilities = require(Common:WaitForChild("DashedCircleUtilities"))
local parent = script.Parent.Parent
local gameClass = parent:WaitForChild("GameClass")
local PlayerClass = require(parent:WaitForChild("PlayerClass"))
local towerClass = gameClass:WaitForChild("TowerClass")
local mapEntityClass = gameClass:WaitForChild("MapEntityClass")
local baseClasses = gameClass:WaitForChild("BaseClasses")
local CharacterClass = require(baseClasses:WaitForChild("CharacterClass"))
local RangeCircleHandler = require(script.Parent:WaitForChild("RangeCircleHandler"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local Data = require(TDX_Shared.Client.Services.Data)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local cframe = CFrame.Angles(0, 0, 0)
local DEADZONE_DASHED_CIRCLE_COLOR = _G.DEADZONE_DASHED_CIRCLE_COLOR
local event = BindableHandler.GetEvent("TowerPlacementRotationIncrement")
local event2 = BindableHandler.GetEvent("DefaultUpgradePathLevelChanged")
local event3 = BindableHandler.GetEvent("RefreshTowersBar")
local event4 = BindableHandler.GetEvent("SetSpeedMultiplier")
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local v = false
local v2 = nil
local name = nil
local config = nil
local v3 = nil
local character2 = nil
local splashRadius = nil
local flag = false
local v4 = 0
local v5 = nil
local v6 = false
local flag2 = false
local v7 = nil
local v8 = nil
local v9 = {}
local goalCFrame = nil
local v10 = false
local v11 = false
local v12 = nil
local v13 = nil
local v14 = 0
local v15 = 0

local function DestroyDeadzoneDashedCircle() -- 4 equivalent calls inferred from this helper
	if v8 then
		DashedCircleUtilities.DestroyCircle(v8)
		v8 = nil
	end
end

local function GetSkinName(p: string) -- 1 equivalent call inferred from this helper
	return Data.Get("TowerSkins")[p]
end

local now = 0

local function MakeNewTowerModel(p: string, cframe2: CFrame)
	DestroyDeadzoneDashedCircle() -- inferred equivalent call
	config = ResourceManager.GetTowerConfig(p)
	name = p

	if character2 then
		character2:FadeOutDestroy()
		character2 = nil
	end

	local upgradePathData = config.UpgradePathData
	local pathLockLevel = upgradePathData.PathLockLevel
	local overridePath1Level = v14
	local v16 = v15
	local overridePath2Level = upgradePathData.OnePathOnly and 0 or v16

	if pathLockLevel <= overridePath1Level then
		overridePath2Level = math.min(overridePath2Level, pathLockLevel - 1)
	end

	v3 = TowerUtilities.GetLevelStats(upgradePathData, overridePath1Level, overridePath2Level)
	local v17 = {
		Hash = 0,
		Type = p,
		SkinName = GetSkinName(p), -- inferred equivalent call
		EntityClass = "Tower",
		Config = config,
		SpawnCFrame = CFrame.new(),
		Parent = raycastIgnore,
		TurretConfigs = v3.TurretConfigs,
		RotatingBarrelData = v3.RotatingBarrelData,
		OverridePath1Level = overridePath1Level,
		OverridePath2Level = overridePath2Level
	}
	character2 = CharacterClass.New(v17, nil, nil, v3)
	splashRadius = v3.IsSplash and v3.SplashRadius
	local v18 = cframe2 * cframe
	character2:SetCFrame(v18, true)
	character2:MakeRing(config.Radius, true, false)
	local characterModel = character2:GetCharacterModel()

	if not config.NoAnimations or characterModel:GetAttribute("ForceAnimations") then
		character2:SetAnimationState("Idle")
	end

	character2:SetPreviewMode()
	RangeCircleHandler.TowerChanged()
end

function Placement.PlacementRequiresManualAim()
	return not (v3 and v3.DisableManualAiming) and name and config and config.ManualAiming
end

function Placement.Run(p: number, position: Vector3, p2: string)
	local v16 = CFrame.new(position) * CFrame.Angles(0, v4 * 3.141592653589793 / 4, 0)
	goalCFrame = v16
	v2 = position

	if name == p2 then
		if character2 then
			character2:MarkNextCFrameAsWorldFixedBase()
			character2:SetPositionLerpRotation(p, v16, true)
		elseif os.clock() - now >= 1 then
			now = os.clock()
			MakeNewTowerModel(p2, v16)
		end
	else
		MakeNewTowerModel(p2, v16)
	end

	if not character2 then
		return
	end

	MapHandler.ShowPathHighlight()

	if not flag then
		RangeCircleHandler.Show()
		flag = true
	end

	v = PlacementHandler.Check(position, config)

	if v10 and not v11 and v and v12 then
		v = (v12 - position).Magnitude <= v13
	end

	character2.RingHandler:SetIsInvalid(not v)

	if not config.RangeDisabled then
		local upgradeTypeToActiveUpgradeShopData = TowerUpgradeShopUtilities.GetUpgradeTypeToActiveUpgradeShopData(
			localPlayerWrapper.UpgradeShopDataHandler:GetCurrentData(),
			name
		)
		local amount = TowerUpgradeShopUtilities.GetAmount(
			upgradeTypeToActiveUpgradeShopData,
			Enums.TowerUpgradeShopTypes.Range
		)
		local v17 = v3.Range * amount
		v7 = PlacementHandler.GetValidArcs(position, config, v17, v16, v3.MaximumROM, v3.IgnoreObstacles)
		local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
		local vector = Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z)
		RangeCircleHandler.DrawRangeCircle(vector, v, v7, nil, nil, config.RangeNoFill)
		local minRange = v3.MinRange > 0 and v3.MinRange or nil

		if minRange then
			if v8 and minRange == v8.Radius then
				DashedCircleUtilities.UpdateCirclePosition(v8, vector)
			else
				DestroyDeadzoneDashedCircle() -- inferred equivalent call
				v8 = DashedCircleUtilities.NewDashedCircleData(vector, minRange, DEADZONE_DASHED_CIRCLE_COLOR, 0.15)
			end
		else
			DestroyDeadzoneDashedCircle() -- inferred equivalent call
		end
	end

	local module = require(towerClass)
	module.PlacementChanged(v2, config.Radius)
	local module2 = require(mapEntityClass)
	module2.PlacementChanged(v2, config.Radius)
end

function Placement.RunAiming(p: number, vector: Vector3)
	if not name then
		warn("Current tower missing for aiming")
		return
	end

	if not character2 then
		warn("Current temp character missing for aiming")
		return
	end

	MapHandler.HidePathHighlight()
	local closestPointOnPath = PathUtilities.GetClosestPointOnPath(
		vector,
		PathHandler.GetPathLineSegments(TeamUtilities.GetLocalPlayerTeamIndex()),
		nil,
		MapHandler.GetFreeAimForPathTargeting()
	)
	local maximumDistanceAtAngle = ValidArcsUtilities.GetMaximumDistanceAtAngle(
		v2.X,
		v2.Z,
		closestPointOnPath.X,
		closestPointOnPath.Z,
		v7
	)
	local magnitude = (Vector3.new(closestPointOnPath.X, v2.Y, closestPointOnPath.Z) - v2).Magnitude
	v6 = magnitude <= maximumDistanceAtAngle
	local minRange = v6 and (v3.MinRange > 0 and v3.MinRange or nil)

	if minRange then
		v6 = minRange <= magnitude
	end

	local vector2 = Vector3.new(closestPointOnPath.X, v2.Y, closestPointOnPath.Z)
	local cframe2 = CFrame.new(v2, vector2)
	goalCFrame = cframe2

	if character2 then
		character2:MarkNextCFrameAsWorldFixedBase()
		character2:SetPositionLerpRotation(p, cframe2, true)
	end

	local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(v2.X, v2.Z)
	RangeCircleHandler.DrawRangeCircle(
		Vector3.new(v2.X, rangeDisplayHeightAtXZ, v2.Z),
		true,
		v7,
		nil,
		true,
		config.RangeNoFill
	)
	local upgradeTypeToActiveUpgradeShopData = TowerUpgradeShopUtilities.GetUpgradeTypeToActiveUpgradeShopData(
		localPlayerWrapper.UpgradeShopDataHandler:GetCurrentData(),
		name
	)
	local amount = TowerUpgradeShopUtilities.GetAmount(
		upgradeTypeToActiveUpgradeShopData,
		Enums.TowerUpgradeShopTypes.Splash
	)
	local v16 = splashRadius * amount
	AimingGuideHandler.Show(p, v2, closestPointOnPath, v6, v16)
	v5 = closestPointOnPath
	flag2 = true
end

function Placement.HideTowerPreview()
	name = nil

	if character2 then
		character2:FadeOutDestroy(true)
	end

	MapHandler.HidePathHighlight()

	if flag then
		RangeCircleHandler.Hide()
		AimingGuideHandler.Hide()
		flag = false
	end

	if flag2 then
		AimingGuideHandler.Hide()
		flag2 = false
	end

	DestroyDeadzoneDashedCircle() -- inferred equivalent call
end

function Placement.GetCurrentPlacementData()
	return v and name ~= nil, name, v2, v4
end

function Placement.GetCurrentAimPosition()
	return v6, v5
end

function Placement.SetTutorialMode(flag3: boolean)
	v10 = flag3
	v11 = false
end

function Placement.EnableTutorialFreebuild()
	v11 = true
end

function Placement.SetTutorialForcePosition(vector: Vector3?, p: number?)
	v12 = vector
	v13 = p
end

function Placement.CacheCurrentCharacterModel(p)
	if not (name and character2) then
		return
	end

	local v16 = { Name = name, Character = character2, GoalCFrame = goalCFrame }
	name = nil
	character2 = nil
	v9[p] = v16
	flag = false
	flag2 = false
end

function Placement.PopCachedCharacterModel(p, p2)
	local v16 = v9[p]

	if not v16 or v16.Name ~= p2 then
		return
	end

	local character = v16.Character
	v9[p] = nil
	return character
end

function Placement.RemoveCachedCharacterModel(p, p2)
	local v16 = v9[p]

	if v16 and v16.Name == p2 then
		v16.Character:FadeOutDestroy()
	end
end

function Placement.CacheRun(p)
	local now2 = os.clock()

	for k, v16 in pairs(v9) do
		if now2 - k > 5 then
			v16.Character:FadeOutDestroy()
			v9[k] = nil
		elseif v16.Character then
			v16.Character:SetPositionLerpRotation(p, v16.GoalCFrame, true)
		end
	end
end

event:AttachCallback(function()
	if not name then
		return
	end

	v4 -= 1
	v4 %= 8
end)
event2:AttachCallback(function(p: number?, p2: number?)
	if p then
		v14 = p
		Placement.HideTowerPreview()
	end

	if p2 then
		v15 = p2
		Placement.HideTowerPreview()
	end
end)
event3:AttachCallback(function()
	Placement.HideTowerPreview()
end)
event4:AttachCallback(function(p: number)
	if character2 then
		character2:SetSpeedMultiplier(p)
	end
end)
return Placement