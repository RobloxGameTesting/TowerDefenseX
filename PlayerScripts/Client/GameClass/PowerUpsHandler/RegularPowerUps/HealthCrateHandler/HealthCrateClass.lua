local HealthCrateClass = {}
HealthCrateClass.__index = HealthCrateClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.HealthCrate.Types)
local VisualEffectHandler = require(script.Parent.Parent.Parent.Parent:WaitForChild("VisualEffectHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local blackhawk = common.Resources.Misc.RegularPowerUps.HealthCrate.Blackhawk

local function GetRotorWelds(clone)
	local children = {}

	for _, child in pairs(clone:FindFirstChild("Root"):GetChildren()) do
		if child.Name == "Rotor" then
			table.insert(children, child)
		end
	end

	return children
end

function HealthCrateClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local v = data.End
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.HealthCrate)
	local airspaceHeight = MapHandler.GetAirspaceHeight()
	local vector = Vector3.new(start.X, airspaceHeight, start.Z)
	local vector2 = Vector3.new(v.X, airspaceHeight, v.Z)
	local totalTime = data.TotalTime
	local vector3 = Vector3.new(0, config.Altitude + (hash - 1) * 10, 0)
	local v2 = vector2 - vector
	local v3 = vector + vector3
	local clone = blackhawk:Clone()
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(v3, v3 - v2)
	clone.Parent = raycastIgnore
	local idleSFX = clone:FindFirstChild("IdleSFX")
	local soundWrapper = WrapperFactory.NewSoundWrapper(idleSFX, speedMultiplier)
	local healthCrate = clone:FindFirstChild("HealthCrate")

	if not healthCrate then
		warn("HealthCrateClass:_DropCrate() - HealthCrateMesh not found")
		return
	end

	local dropSFX = clone:FindFirstChild("DropSFX")
	local soundWrapper2 = WrapperFactory.NewSoundWrapper(dropSFX, speedMultiplier)
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
		RotorWelds = GetRotorWelds(clone),
		HealthCrateMesh = healthCrate,
		MinigunSFXStarted = false,
		_TimingHelpers = {},
		_Wrappers = { IdleSFXWrapper = soundWrapper, DropSFXWrapper = soundWrapper2 }
	}
	setmetatable(v4, HealthCrateClass)
	v4._Wrappers.IdleSFXWrapper:PlayAll()
	return v4
end

function HealthCrateClass:Run(p: number)
	self.TimePassed += p
	local unit = (self.End - self.Start).Unit
	self.Position = self.Start:Lerp(self.End, self.TimePassed / self.TotalTime) + self.HeightOffset
	self.Root.CFrame = CFrame.new(self.Position, self.Position - unit) * CFrame.Angles(0.2617993877991494, 0, 0)

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	for _, rotorWeld in pairs(self.RotorWelds) do
		rotorWeld.C0 *= CFrame.Angles(0, p * 30, 0)
	end

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function HealthCrateClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function HealthCrateClass:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function HealthCrateClass:ReceiveUpdate(p: string, _)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "DropCrate" then
		self:_DropCrate()
	elseif p == "OpenCrate" then
		self:_OpenCrate()
	end
end

function HealthCrateClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

function HealthCrateClass:_DropCrate()
	local healthCrate = self.Root:FindFirstChild("HealthCrate")

	if not healthCrate then
		warn("HealthCrateClass:_DropCrate() - CrateWeld not found")
		return
	end

	self.HealthCrateMesh.CanCollide = true
	healthCrate:Destroy()
	self._Wrappers.DropSFXWrapper:PlayAll()
end

function HealthCrateClass:_OpenCrate()
	local position = self.HealthCrateMesh.Position
	self.HealthCrateMesh:Destroy()
	local v = { Name = Enums.VisualEffects.CrateHealthOpen, Position = position }
	VisualEffectHandler.NewVisualEffect(v)
end

return HealthCrateClass