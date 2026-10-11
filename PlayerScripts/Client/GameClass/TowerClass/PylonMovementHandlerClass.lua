local createVector = vector.create
local PylonMovementHandlerClass = {}
PylonMovementHandlerClass.__index = PylonMovementHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TowerTypes"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("PathHandler"))
require(common:WaitForChild("MapHandler"))

function PylonMovementHandlerClass.New(p, data)
	local pylonMovementConfig = p.PylonMovementConfig

	if not pylonMovementConfig then
		error("PylonMovementConfig not found in LevelStats")
	end

	local v = {
		CenterPosition = data.CenterPosition,
		CurrentPosition = createVector(0, 0, 0),
		PreviousPosition = createVector(0, 0, 1),
		StartingAngle = data.StartingAngle,
		CurrentAngle = data.StartingAngle,
		TimePassed = data.TimePassed,
		GoalCFrame = CFrame.new(),
		PortCFrame = CFrame.new(),
		Radius = pylonMovementConfig.Radius,
		Speed = pylonMovementConfig.Speed,
		Altitude = pylonMovementConfig.Altitude or 0,
		PortAngle = pylonMovementConfig.PortAngle or 25
	}
	setmetatable(v, PylonMovementHandlerClass)
	return v
end

function PylonMovementHandlerClass:SetCurrentGoal(currentGoal: Vector3?)
	self.CurrentGoal = currentGoal
end

function PylonMovementHandlerClass:LevelStatsChanged(p)
	local pylonMovementConfig = p.PylonMovementConfig

	if not pylonMovementConfig then
		error("PylonMovementConfig not found in LevelStats")
	end

	self.Radius = pylonMovementConfig.Radius
	self.Speed = pylonMovementConfig.Speed
	self.Altitude = pylonMovementConfig.Altitude or 0
	self.PortAngle = pylonMovementConfig.PortAngle or 25
end

function PylonMovementHandlerClass:Run(p: number)
	self.TimePassed += p
	local v = self.TimePassed * self.Speed / self.Radius
	self.CurrentAngle = self.StartingAngle - v
	local v2 = math.cos(self.CurrentAngle) * self.Radius
	local v3 = math.sin(self.CurrentAngle) * self.Radius
	self.PreviousPosition = self.CurrentPosition
	self.CurrentPosition = Vector3.new(self.CenterPosition.X + v2, self.CenterPosition.Y, self.CenterPosition.Z + v3)
	local v4 = self.CurrentPosition + Vector3.new(0, self.Altitude, 0)
	local rotation = CFrame.new(self.CurrentPosition, self.PreviousPosition).Rotation
	local cframe = CFrame.Angles(0, 0, -math.rad(self.PortAngle))
	self.GoalCFrame = CFrame.new(v4) * rotation
	self.PortCFrame = cframe
end

function PylonMovementHandlerClass.GetGoalCFrame(p)
	return p.GoalCFrame
end

function PylonMovementHandlerClass.GetPortCFrame(p)
	return p.PortCFrame
end

function PylonMovementHandlerClass.GetCenterPosition(p)
	return p.CenterPosition
end

return PylonMovementHandlerClass