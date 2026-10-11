local EmergencySupplyCrateClass = {}
EmergencySupplyCrateClass.__index = EmergencySupplyCrateClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.EmergencySupplyCrate.Types)
local VisualEffectHandler = require(script.Parent.Parent.Parent.Parent:WaitForChild("VisualEffectHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local blackhawk = common.Resources.Misc.RegularPowerUps.EmergencySupplyCrate.Blackhawk

local function GetRotorWelds(clone)
	local children = {}

	for _, child in pairs(clone:FindFirstChild("Root"):GetChildren()) do
		if child.Name == "Rotor" then
			table.insert(children, child)
		end
	end

	return children
end

function EmergencySupplyCrateClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local v = data.End
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.EmergencySupplyCrate)
	local v2 = MapHandler.GetAirspaceHeight() + 5
	local vector = Vector3.new(start.X, v2, start.Z)
	local vector2 = Vector3.new(v.X, v2, v.Z)
	local totalTime = data.TotalTime
	local vector3 = Vector3.new(0, config.Altitude + (hash - 1) * 10, 0)
	local v3 = vector2 - vector
	local v4 = vector + vector3
	local clone = blackhawk:Clone()
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(v4, v4 - v3)
	clone.Parent = raycastIgnore
	local idleSFX = clone:FindFirstChild("IdleSFX")
	local soundWrapper = WrapperFactory.NewSoundWrapper(idleSFX, speedMultiplier)
	local cashCrate = clone:FindFirstChild("CashCrate")
	local healthCrate = clone:FindFirstChild("HealthCrate")

	if not cashCrate then
		warn("EmergencySupplyCrateClass:_DropCrate() - CashCrate not found")
		return
	end

	if not healthCrate then
		warn("EmergencySupplyCrateClass:_DropCrate() - HealthCrate not found")
		return
	end

	local dropSFX = clone:FindFirstChild("DropSFX")
	local soundWrapper2 = WrapperFactory.NewSoundWrapper(dropSFX, speedMultiplier)
	local v5 = {
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
		CashCrate = cashCrate,
		HealthCrate = healthCrate,
		MinigunSFXStarted = false,
		_TimingHelpers = {},
		_Wrappers = { IdleSFXWrapper = soundWrapper, DropSFXWrapper = soundWrapper2 }
	}
	setmetatable(v5, EmergencySupplyCrateClass)
	v5._Wrappers.IdleSFXWrapper:PlayAll()
	return v5
end

function EmergencySupplyCrateClass:Run(p: number)
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

function EmergencySupplyCrateClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function EmergencySupplyCrateClass:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function EmergencySupplyCrateClass:ReceiveUpdate(p: string, _)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "DropCrate" then
		self:_DropCrate()
	elseif p == "OpenCrate" then
		self:_OpenCrate()
	end
end

function EmergencySupplyCrateClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

function EmergencySupplyCrateClass:_DropCrate()
	local cashCrate = self.Root:FindFirstChild("CashCrate")
	local healthCrate = self.Root:FindFirstChild("HealthCrate")

	if not cashCrate then
		warn("EmergencySupplyCrateClass:_DropCrate() - CashCrateWeld not found")
		return
	end

	if not healthCrate then
		warn("EmergencySupplyCrateClass:_DropCrate() - HealthCrateWeld not found")
		return
	end

	self.CashCrate.CanCollide = true
	self.HealthCrate.CanCollide = true
	cashCrate:Destroy()
	healthCrate:Destroy()
	self._Wrappers.DropSFXWrapper:PlayAll()
end

function EmergencySupplyCrateClass:_OpenCrate()
	local position = self.CashCrate.Position
	local position2 = self.HealthCrate.Position
	self.CashCrate:Destroy()
	self.HealthCrate:Destroy()
	local v = { Name = Enums.VisualEffects.CrateCashOpen, Position = position }
	local v2 = { Name = Enums.VisualEffects.CrateHealthOpen, Position = position2 }
	VisualEffectHandler.NewVisualEffect(v)
	VisualEffectHandler.NewVisualEffect(v2)
end

return EmergencySupplyCrateClass