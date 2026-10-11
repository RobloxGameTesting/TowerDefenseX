local MOABClass = {}
MOABClass.__index = MOABClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.MOAB.Types)
local AttackHandlerClass = require(script.Parent:WaitForChild("AttackHandlerClass"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local moab = common.Resources.Misc.RegularPowerUps.MOAB.MOAB

local function SetUpAttacks(clone, p: number, config)
	local result = {}

	for k, attack in pairs(config.Attacks) do
		result[k] = AttackHandlerClass.New(clone, k, attack, p)
	end

	return result
end

function MOABClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local v = data.End
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.MOAB)
	local airspaceHeight = MapHandler.GetAirspaceHeight()
	local vector = Vector3.new(start.X, airspaceHeight, start.Z)
	local vector2 = Vector3.new(v.X, airspaceHeight, v.Z)
	local totalTime = data.TotalTime
	local vector3 = Vector3.new(0, config.Altitude + (hash - 1) * 12, 0)
	local v2 = vector2 - vector
	local v3 = vector + vector3
	local clone = moab:Clone()
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(v3, v3 - v2)
	clone.Parent = raycastIgnore
	local attacks = SetUpAttacks(clone, speedMultiplier, config)
	local trails = {
		clone:FindFirstChild("TrailPart1"):FindFirstChild("Trail"),
		clone:FindFirstChild("TrailPart2"):FindFirstChild("Trail")
	}
	local zoomSFX = clone:FindFirstChild("ZoomSFX")
	local soundWrapper = WrapperFactory.NewSoundWrapper(zoomSFX, speedMultiplier)
	local idleSFX = clone:FindFirstChild("IdleSFX")
	local soundWrapper2 = WrapperFactory.NewSoundWrapper(idleSFX, speedMultiplier)
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
		Attacks = attacks,
		Trails = trails,
		MinigunSFXStarted = false,
		_TimingHelpers = {
			ZoomSFXTimingHelper = TimingHelperClass.New({
				TimeUntilCallback = 1,
				Callback = function()
					soundWrapper:PlayAll()
				end
			})
		},
		_Wrappers = { ZoomSFXWrapper = soundWrapper, IdleSFXWrapper = soundWrapper2 }
	}
	setmetatable(v4, MOABClass)
	v4:_ScaleTrails()
	v4._Wrappers.IdleSFXWrapper:PlayAll()
	v4._TimingHelpers.ZoomSFXTimingHelper:Start()

	for _, v5 in pairs(trails) do
		v5.Enabled = true
	end

	return v4
end

function MOABClass:Run(p: number)
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

function MOABClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function MOABClass:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function MOABClass:HandleAttack(data)
	local attackName = data.AttackName
	self.Attacks[attackName]:HandleAttack(data.TargetPosition, data.BurstIndex)
end

function MOABClass:ReceiveUpdate(p: string, p2)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "Attack" then
		self:HandleAttack(p2)
	end
end

function MOABClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, attack in pairs(self.Attacks) do
		attack:SpeedMultiplierChanged(speedMultiplier)
	end

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
	self:_ScaleTrails()
end

function MOABClass:_ScaleTrails()
	for _, trail in pairs(self.Trails) do
		trail.Lifetime = 3 / math.max(self.SpeedMultiplier, 0.1)
	end
end

return MOABClass