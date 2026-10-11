local CashCrateClass = {}
CashCrateClass.__index = CashCrateClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.CashCrate.Types)
local VisualEffectHandler = require(script.Parent.Parent.Parent.Parent:WaitForChild("VisualEffectHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local blackhawk = common.Resources.Misc.RegularPowerUps.CashCrate.Blackhawk

local function GetRotorWelds(clone)
	local children = {}

	for _, child in pairs(clone:FindFirstChild("Root"):GetChildren()) do
		if child.Name == "Rotor" then
			table.insert(children, child)
		end
	end

	return children
end

function CashCrateClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local v = data.End
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.CashCrate)
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

	if not cashCrate then
		warn("CashCrateClass:_DropCrate() - CashCrateMesh not found")
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
		CashCrateMesh = cashCrate,
		MinigunSFXStarted = false,
		_TimingHelpers = {},
		_Wrappers = { IdleSFXWrapper = soundWrapper, DropSFXWrapper = soundWrapper2 }
	}
	setmetatable(v5, CashCrateClass)
	v5._Wrappers.IdleSFXWrapper:PlayAll()
	return v5
end

function CashCrateClass:Run(p: number)
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

function CashCrateClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function CashCrateClass:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function CashCrateClass:ReceiveUpdate(p: string, _)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "DropCrate" then
		self:_DropCrate()
	elseif p == "OpenCrate" then
		self:_OpenCrate()
	end
end

function CashCrateClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

function CashCrateClass:_DropCrate()
	local cashCrate = self.Root:FindFirstChild("CashCrate")

	if not cashCrate then
		warn("CashCrateClass:_DropCrate() - CrateWeld not found")
		return
	end

	self.CashCrateMesh.CanCollide = true
	cashCrate:Destroy()
	self._Wrappers.DropSFXWrapper:PlayAll()
end

function CashCrateClass:_OpenCrate()
	local position = self.CashCrateMesh.Position
	self.CashCrateMesh:Destroy()
	local v = { Name = Enums.VisualEffects.CrateCashOpen, Position = position }
	VisualEffectHandler.NewVisualEffect(v)
end

return CashCrateClass