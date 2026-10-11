local SR71StrikeClass = {}
SR71StrikeClass.__index = SR71StrikeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.SR71Strike.Types)
local AttackHandlerClass = require(script.Parent:WaitForChild("AttackHandlerClass"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local sr71 = common.Resources.Misc.RegularPowerUps.SR71Strike.SR71

local function SetUpAttacks(clone, p: number, config)
	local result = {}

	for k, attack in pairs(config.Attacks) do
		result[k] = AttackHandlerClass.New(clone, k, attack, p)
	end

	return result
end

function SR71StrikeClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local v = data.End
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.SR71Strike)
	local airspaceHeight = MapHandler.GetAirspaceHeight()
	local vector = Vector3.new(start.X, airspaceHeight, start.Z)
	local vector2 = Vector3.new(v.X, airspaceHeight, v.Z)
	local totalTime = data.TotalTime
	local vector3 = Vector3.new(0, config.Altitude + (hash - 1) * 12, 0)
	local v2 = vector2 - vector
	local v3 = vector + vector3
	local clone = sr71:Clone()
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(v3, v3 - v2)
	clone.Parent = raycastIgnore
	local attacks = SetUpAttacks(clone, speedMultiplier, config)
	local trails = {
		clone:FindFirstChild("TrailPart1"):FindFirstChild("Trail"),
		clone:FindFirstChild("TrailPart2"):FindFirstChild("Trail")
	}
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(clone, speedMultiplier)
	local zoomSFX = clone:FindFirstChild("ZoomSFX")
	local soundWrapper = WrapperFactory.NewSoundWrapper(zoomSFX, speedMultiplier)
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
				TimeUntilCallback = 2.75,
				Callback = function()
					soundWrapper:PlayAll()
				end
			})
		},
		_Wrappers = { EffectWrapper = emitterAndSoundWrapper, ZoomSFXWrapper = soundWrapper }
	}
	setmetatable(v4, SR71StrikeClass)
	v4._TimingHelpers.ZoomSFXTimingHelper:Start()
	emitterAndSoundWrapper:PlayAll()
	v4:_ScaleTrails()

	for _, v5 in pairs(trails) do
		v5.Enabled = true
	end

	return v4
end

function SR71StrikeClass:Run(p: number)
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

function SR71StrikeClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function SR71StrikeClass:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function SR71StrikeClass:HandleAttack(data)
	local attackName = data.AttackName
	self.Attacks[attackName]:HandleAttack(data.TargetPosition, data.BurstIndex)
end

function SR71StrikeClass:ReceiveUpdate(p: string, p2)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "Attack" then
		self:HandleAttack(p2)
	end
end

function SR71StrikeClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, attack in pairs(self.Attacks) do
		attack:SpeedMultiplierChanged(speedMultiplier)
	end

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
	self:_ScaleTrails()
end

function SR71StrikeClass:_ScaleTrails()
	for _, trail in pairs(self.Trails) do
		trail.Lifetime = 3 / math.max(self.SpeedMultiplier, 0.1)
	end
end

return SR71StrikeClass