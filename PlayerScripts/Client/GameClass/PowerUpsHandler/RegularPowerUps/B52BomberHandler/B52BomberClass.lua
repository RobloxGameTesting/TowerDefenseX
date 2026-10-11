local B52BomberClass = {}
B52BomberClass.__index = B52BomberClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.B52Bomber.Types)
local ProjectileHandler = require(script.Parent.Parent.Parent.Parent:WaitForChild("ProjectileHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local b52 = common.Resources.Misc.RegularPowerUps.B52Bomber:WaitForChild("B52")

local function GetTrails(folder)
	local trails = {}

	for _, trail in pairs(folder:GetDescendants()) do
		if trail:IsA("Trail") then
			table.insert(trails, trail)
		end
	end

	return trails
end

local function GetBombOriginParts(clone, projectileName: string)
	local primaryParts = {}

	for _, model in pairs(clone:GetChildren()) do
		local v = model.Name:split("___")[1]

		if not (model:IsA("Model") and model.PrimaryPart and v:match(`^{projectileName}%d*$`)) then
			continue
		end

		table.insert(primaryParts, model.PrimaryPart)
	end

	table.sort(primaryParts, function(a, b)
		return a.Parent.Name < b.Parent.Name
	end)

	if #primaryParts == 0 then
		warn(`Origin model {projectileName} not found in B52 plane model, using PrimaryPart`)
	end

	return primaryParts
end

local function GetGateParts(clone, childName: string)
	local parts = {}
	local child = clone:FindFirstChild(childName)

	if child then
		for _, part in pairs(child:GetChildren()) do
			if part:IsA("BasePart") then
				table.insert(parts, part)
			end
		end
	end

	return parts
end

function B52BomberClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local v = data.End
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.B52Bomber)
	local airspaceHeight = MapHandler.GetAirspaceHeight()
	local vector = Vector3.new(start.X, airspaceHeight, start.Z)
	local vector2 = Vector3.new(v.X, airspaceHeight, v.Z)
	local totalTime = data.TotalTime
	local vector3 = Vector3.new(0, config.Altitude + (hash - 1) * 12, 0)
	local v2 = vector2 - vector
	local v3 = vector + vector3
	local clone = b52:Clone()
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(v3, v3 - v2)
	clone.Parent = raycastIgnore
	local trails = GetTrails(clone)
	local wrappers = {}
	local timingHelpers = {}
	local zoomSFX = clone:FindFirstChild("ZoomSFX")

	if zoomSFX then
		local soundWrapper = WrapperFactory.NewSoundWrapper(zoomSFX, speedMultiplier)
		wrappers.ZoomSFXWrapper = soundWrapper
		timingHelpers.ZoomSFXTimingHelper = TimingHelperClass.New({
			TimeUntilCallback = 1,
			Callback = function()
				soundWrapper:PlayAll()
			end
		})
	end

	local idleSFX = clone:FindFirstChild("IdleSFX")

	if idleSFX then
		wrappers.IdleSFXWrapper = WrapperFactory.NewSoundWrapper(idleSFX, speedMultiplier)
	end

	local v4 = {
		Hash = hash,
		Player = child,
		Start = vector,
		End = vector2,
		TimePassed = 0,
		TotalTime = totalTime,
		SpeedMultiplier = speedMultiplier,
		Destroyed = false,
		HeightOffset = vector3,
		PlaneModel = clone,
		Root = primaryPart,
		Trails = trails,
		ProjectileName = config.ProjectileName,
		ProjectileConfig = ResourceManager.GetProjectileConfig(config.ProjectileName),
		BombOriginParts = GetBombOriginParts(clone, config.ProjectileName),
		GateOpenParts = GetGateParts(clone, "GateOpen"),
		GateClosedParts = GetGateParts(clone, "GateClosed"),
		BombCount = config.BombCount,
		BombsDropped = 0,
		_TimingHelpers = timingHelpers,
		_Wrappers = wrappers
	}
	setmetatable(v4, B52BomberClass)
	v4:_ScaleTrails()
	v4:_SetGatesOpen(false)

	if v4._Wrappers.IdleSFXWrapper then
		v4._Wrappers.IdleSFXWrapper:PlayAll()
	end

	if v4._TimingHelpers.ZoomSFXTimingHelper then
		v4._TimingHelpers.ZoomSFXTimingHelper:Start()
	end

	for _, v5 in pairs(trails) do
		v5.Enabled = true
	end

	return v4
end

function B52BomberClass:Run(p: number)
	self.TimePassed += p
	local v = self.End - self.Start
	self.Position = self.Start:Lerp(self.End, self.TimePassed / self.TotalTime) + self.HeightOffset
	self.Root.CFrame = CFrame.new(self.Position, self.Position - v)

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function B52BomberClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function B52BomberClass:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function B52BomberClass:_SetGatesOpen(flag: boolean)
	for _, gateOpenPart in pairs(self.GateOpenParts) do
		gateOpenPart.Transparency = flag and 0 or 1
	end

	for _, gateClosedPart in pairs(self.GateClosedParts) do
		gateClosedPart.Transparency = flag and 1 or 0
	end
end

function B52BomberClass:_GetBombOriginPart(p: number)
	if #self.BombOriginParts == 0 then
		return self.Root
	end

	return self.BombOriginParts[(p - 1) % #self.BombOriginParts + 1]
end

function B52BomberClass:_DropBomb(p)
	if not self.ProjectileConfig then
		return
	end

	self.BombsDropped += 1

	if self.BombsDropped == 1 then
		self:_SetGatesOpen(true)
	end

	if self.BombsDropped >= self.BombCount then
		local gateCloseTimingHelper = TimingHelperClass.New({
			TimeUntilCallback = 1,
			Callback = function()
				self:_SetGatesOpen(false)
			end
		})
		self._TimingHelpers.GateCloseTimingHelper = gateCloseTimingHelper
		gateCloseTimingHelper:Start()
	end

	local bombOriginPart = self:_GetBombOriginPart(p.BombIndex)
	local timeToHitForRangedProjectile = ProjectileUtilities.GetTimeToHitForRangedProjectile(
		bombOriginPart.Position,
		p.TargetPosition,
		self.ProjectileConfig
	)
	local v = {
		OriginEntityClass = "Misc",
		TargetEntityClass = "Enemy",
		OverrideGoalPosition = p.TargetPosition,
		TimeToHit = timeToHitForRangedProjectile,
		FaceTarget = true,
		ProjectileConfig = self.ProjectileConfig,
		OverrideOriginPart = bombOriginPart,
		CustomCharacterHandling = true
	}
	ProjectileHandler.NewProjectile(v)
end

function B52BomberClass:ReceiveUpdate(p: string, p2)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "BombDrop" then
		self:_DropBomb(p2)
	end
end

function B52BomberClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
	self:_ScaleTrails()
end

function B52BomberClass:_ScaleTrails()
	for _, trail in pairs(self.Trails) do
		trail.Lifetime = 3 / math.max(self.SpeedMultiplier, 0.1)
	end
end

return B52BomberClass