local createVector = vector.create
local AC130Class = {}
AC130Class.__index = AC130Class
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.AC130Support.Types)
local Utilities2 = require(common.Resources.Misc.RegularPowerUps.AC130Support.Utilities)
local EnemyClass = require(script.Parent.Parent.Parent.Parent:WaitForChild("EnemyClass"))
local AttackHandlerClass = require(script.Parent:WaitForChild("AttackHandlerClass"))
local States = Utilities2.States
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local ac130 = common.Resources.Misc.RegularPowerUps.AC130Support.AC130

local function GetRotorWelds(clone)
	local children = {}

	for _, child in pairs(clone:FindFirstChild("Root"):GetChildren()) do
		if child.Name == "Rotor" then
			table.insert(children, child)
		end
	end

	return children
end

local function SetUpAttacks(clone, p: number, config)
	local result = {}

	for k, attack in pairs(config.Attacks) do
		result[k] = AttackHandlerClass.New(clone, k, attack, p)
	end

	return result
end

function AC130Class.New(data, speedMultiplier: number)
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.AC130Support)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local goalLocation = data.GoalLocation
	local pylonEntryPoint = data.PylonEntryPoint
	local startingAngle = data.StartingAngle
	local entranceData = Utilities2.GetEntranceData(pylonEntryPoint, goalLocation, startingAngle)
	local vector = Vector3.new(0, (hash - 1) * 32, 0)
	local clone = ac130:Clone()
	local primaryPart = clone.PrimaryPart
	local rotation = CFrame.new(entranceData.End, entranceData.Start).Rotation
	primaryPart.CFrame = CFrame.new(entranceData.Start + vector) * rotation
	clone.Parent = raycastIgnore
	local attacks = SetUpAttacks(clone, speedMultiplier, config)
	local v = {
		Hash = hash,
		Player = child,
		State = States.ENTRANCE,
		TimeLeftInState = entranceData.Time,
		TotalStateTime = entranceData.Time,
		GoalLocation = goalLocation,
		PreviousPosition = entranceData.Start - createVector(0.01, 0, 0),
		Position = entranceData.Start,
		SpeedMultiplier = speedMultiplier,
		Destroyed = false,
		EntranceData = entranceData,
		ExitData = nil,
		HeightOffset = vector,
		PylonRadius = config.PylonRadius,
		PylonSpeed = config.PylonSpeed,
		PylonDuration = config.PylonDuration,
		MaximumPortAngle = -config.PylonPortAngle,
		PlaneModel = clone,
		Root = primaryPart,
		Attacks = attacks,
		RotorWelds = GetRotorWelds(clone),
		SoundWrapper = WrapperFactory.NewSoundWrapper(primaryPart, speedMultiplier),
		Trails = {
			clone:FindFirstChild("TrailPart1"):FindFirstChild("Trail"),
			clone:FindFirstChild("TrailPart2"):FindFirstChild("Trail")
		}
	}
	setmetatable(v, AC130Class)
	v.SoundWrapper:PlayAll()
	v:ScaleTrails()
	return v
end

function AC130Class:_SetNewStateTime(p: number)
	self.TimeLeftInState = p
	self.TotalStateTime = p
end

function AC130Class:Run(p: number)
	if self.Destroyed then
		return
	end

	self.TimeLeftInState -= p

	if self.TimeLeftInState <= 0 then
		if self.State == States.ENTRANCE then
			self.State = States.DEFAULT
			self:_SetNewStateTime(self.PylonDuration)
		elseif self.State == States.DEFAULT then
			self:BeginExit()
		elseif self.State == States.EXIT then
			self.State = States.FINISHED
		end
	end

	local v = self.TotalStateTime - self.TimeLeftInState

	if self.State == States.ENTRANCE then
		local entranceData = self.EntranceData
		local v2 = entranceData.InitialSpeed + entranceData.Acceleration * v
		self.Position += p * v2 * entranceData.MovementUnitVector
	elseif self.State == States.DEFAULT then
		local v2 = v * self.PylonSpeed / self.PylonRadius
		local v3 = self.EntranceData.StartingAngle - v2
		local v4 = math.cos(v3) * self.PylonRadius
		local v5 = math.sin(v3) * self.PylonRadius
		self.Position = Vector3.new(self.GoalLocation.X + v4, self.GoalLocation.Y, self.GoalLocation.Z + v5)
	elseif self.State == States.EXIT then
		local exitData = self.ExitData
		local v2 = exitData.InitialSpeed + exitData.Acceleration * v
		self.Position += p * v2 * exitData.MovementUnitVector
		self.Position += p * Vector3.new(0, math.min(50, 10 * v), 0)
	end

	self:HandleAircraftModel(p)
	self.PreviousPosition = self.Position
end

function AC130Class:HandleAircraftModel(p: number)
	local v = self.TotalStateTime - self.TimeLeftInState
	local lerped = 0

	if self.State == States.ENTRANCE then
		if self.TimeLeftInState <= 5 then
			local value = TweenService:GetValue(
				1 - self.TimeLeftInState / 5,
				Enum.EasingStyle.Cubic,
				Enum.EasingDirection.In
			)
			lerped = Utilities.Lerp(0, 0.5 * self.MaximumPortAngle, value)
		end
	elseif self.State == States.EXIT then
		if v <= 5 then
			local v2 = 1 - TweenService:GetValue(v / 5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
			lerped = Utilities.Lerp(0, 0.5 * self.MaximumPortAngle, v2)
		end
	elseif self.State == States.DEFAULT then
		if self.TimeLeftInState <= 5 then
			local v2 = 1 - TweenService:GetValue(
				1 - self.TimeLeftInState / 5,
				Enum.EasingStyle.Cubic,
				Enum.EasingDirection.In
			)
			lerped = Utilities.Lerp(0.5 * self.MaximumPortAngle, self.MaximumPortAngle, v2)
		elseif v <= 5 then
			local value = TweenService:GetValue(v / 5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
			lerped = Utilities.Lerp(0.5 * self.MaximumPortAngle, self.MaximumPortAngle, value)
		else
			lerped = self.MaximumPortAngle
		end
	end

	local rotation = CFrame.new(self.Position, self.PreviousPosition).Rotation
	local cframe = CFrame.Angles(0, 0, (math.rad(lerped)))
	self.Root.CFrame = CFrame.new(self.Position + self.HeightOffset) * rotation * cframe

	for _, rotorWeld in pairs(self.RotorWelds) do
		rotorWeld.C1 *= CFrame.Angles(0, 0, p * 30)
	end
end

function AC130Class:BeginExit()
	self.ExitData = Utilities2.GetExitData(self.Position, self.GoalLocation)
	self.State = States.EXIT
	self:_SetNewStateTime(self.ExitData.Time)
end

function AC130Class.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function AC130Class:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true
end

function AC130Class:HandleAttack(p)
	local attackName = p.AttackName
	local attack = self.Attacks[attackName]
	local enemyHash = p.EnemyHash
	local enemy = EnemyClass.GetEnemy(enemyHash)

	if enemy then
		attack:HandleAttack(enemy)
	end
end

function AC130Class:ReceiveUpdate(p: string, p2)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "EarlyExit" then
		self:BeginExit()
	elseif p == "Attack" then
		self:HandleAttack(p2)
	end
end

function AC130Class:SpeedMultiplierChanged(speedMultiplier: number)
	for _, attack in pairs(self.Attacks) do
		attack:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SoundWrapper:SpeedMultiplierChanged(speedMultiplier)
	self:ScaleTrails()
	self.SpeedMultiplier = speedMultiplier
end

function AC130Class:ScaleTrails()
	for _, trail in pairs(self.Trails) do
		trail.Lifetime = 5 / math.max(self.SpeedMultiplier, 0.1)
	end
end

return AC130Class