local Relocation = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("AbilityTypes"))
require(Common:WaitForChild("ProjectileTypes"))
require(Common:WaitForChild("Utilities"))
local PlacementHandler = require(Common:WaitForChild("PlacementHandler"))
require(Common:WaitForChild("ResourceManager"))
local MapHandler = require(Common:WaitForChild("MapHandler"))
require(Common:WaitForChild("PathHandler"))
require(Common:WaitForChild("PathUtilities"))
require(Common:WaitForChild("ValidArcsUtilities"))
require(Common:WaitForChild("TowerBuffUtilities"))
local parent = script.Parent.Parent
local gameClass = parent:WaitForChild("GameClass")
require(parent:WaitForChild("PlayerClass"))
local baseClasses = gameClass:WaitForChild("BaseClasses")
local CharacterClass = require(baseClasses:WaitForChild("CharacterClass"))
local RangeCircleHandler = require(script.Parent:WaitForChild("RangeCircleHandler"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local Data = require(TDX_Shared.Client.Services.Data)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local cframe = CFrame.Angles(0, 0, 0)
local v = nil
local v2 = nil
local position = nil
local config = nil
local v3 = nil
local v4 = false
local manualAimInfiniteRange = false
local manualAimCustomRange = 0
local v5 = nil

local function GetSkinName(kind: string) -- 1 equivalent call inferred from this helper
	return Data.Get("TowerSkins")[kind]
end

local function MakeNewTowerModel(cframe2: CFrame)
	if not v then
		warn("No current tower to preview")
		return
	end

	config = v.Config

	if v2 then
		v2:FadeOutDestroy()
	end

	local kind = v.Type
	local levelHandler = v.LevelHandler
	local levelStats = levelHandler:GetLevelStats()
	local levelOnPath = levelHandler:GetLevelOnPath(1)
	local levelOnPath2 = levelHandler:GetLevelOnPath(2)
	local v6 = {
		Hash = 0,
		Type = kind,
		SkinName = GetSkinName(kind), -- inferred equivalent call
		EntityClass = "Tower",
		Config = config,
		SpawnCFrame = CFrame.new(),
		Parent = raycastIgnore,
		TurretConfigs = levelStats.TurretConfigs,
		RotatingBarrelData = levelStats.RotatingBarrelData,
		OverridePath1Level = levelOnPath,
		OverridePath2Level = levelOnPath2
	}
	v2 = CharacterClass.New(v6, nil, nil, levelStats)
	local v7 = cframe2 * cframe
	v2:SetCFrame(v7, true)
	v2:MakeRing(config.Radius, true, false)
	local characterModel = v2:GetCharacterModel()

	if not config.NoAnimations or characterModel:GetAttribute("ForceAnimations") then
		v2:SetAnimationState("Idle")
	end

	v2:SetPreviewMode()
	RangeCircleHandler.TowerChanged()
end

function Relocation.Run(p: number, position2: Vector3)
	if not v then
		return
	end

	if v2 then
		v2:MarkNextCFrameAsWorldFixedBase()
		v2:SetPositionLerpRotation(p, CFrame.new(position2), true)
	else
		MakeNewTowerModel(CFrame.new(position2))
	end

	local v6 = PlacementHandler.Check(position2, config)
	local v7 = manualAimInfiniteRange and true
		or (Vector3.new(position2.X, position.Y, position2.Z) - position).Magnitude <= manualAimCustomRange
	v4 = v6 and v7
	v2.RingHandler:SetIsInvalid(not v4)
	local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
	RangeCircleHandler.DrawRangeCircle(
		Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z),
		true,
		v5,
		nil,
		true,
		config.RangeNoFill,
		manualAimInfiniteRange
	)
	AimingGuideHandler.Show(p, position, position2, v4)
	v3 = position2
end

function Relocation.BeginManualRelocationAbility(object, p)
	v = object
	position = object.CFrame.Position
	config = object.Config
	manualAimCustomRange = p.ManualAimCustomRange or object:GetCurrentRange()
	manualAimInfiniteRange = p.ManualAimInfiniteRange

	if v2 then
		v2:FadeOutDestroy(true)
		v2 = nil
	end

	MapHandler.ShowPathHighlight()
	v5 = PlacementHandler.GetValidArcs(position, config, math.max(0.1, manualAimCustomRange), nil, nil, true)
end

function Relocation.Hide()
	if v2 then
		v = nil
		v2:FadeOutDestroy(true)
		v2 = nil
	end

	MapHandler.HidePathHighlight()
end

function Relocation.GetCurrentRelocationPosition()
	return v4, v3
end

return Relocation