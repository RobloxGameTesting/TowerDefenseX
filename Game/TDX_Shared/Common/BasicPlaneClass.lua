local BasicPlaneClass = {}
BasicPlaneClass.__index = BasicPlaneClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

local function GetPositionData(data)
	local goalLocation = data.GoalLocation
	local startingAngle = data.StartingAngle or math.random() * 3.141592653589793 * 2
	local entranceDistance = data.EntranceDistance
	local exitDistance = data.ExitDistance
	local speed = data.Speed
	return {
		Start = Vector3.new(
			goalLocation.X + math.cos(startingAngle) * entranceDistance,
			goalLocation.Y,
			goalLocation.Z + math.sin(startingAngle) * entranceDistance
		),
		End = Vector3.new(
			goalLocation.X - math.cos(startingAngle) * exitDistance,
			goalLocation.Y,
			goalLocation.Z - math.sin(startingAngle) * exitDistance
		),
		Time = (entranceDistance + exitDistance) / speed
	}
end

local function GetTrails(folder)
	local trails = {}

	for _, trail in pairs(folder:GetDescendants()) do
		if trail:IsA("Trail") then
			table.insert(trails, trail)
		end
	end

	return trails
end

function BasicPlaneClass.New(data, speedMultiplier: number)
	local positionData = GetPositionData(data)
	local start = positionData.Start
	local v = positionData.End
	local v2 = {
		Start = positionData.Start,
		End = positionData.End,
		Position = positionData.Start,
		TimePassed = 0,
		TotalTime = positionData.Time,
		HeightOffset = Vector3.new(0, data.Height, 0),
		RotationOffset = data.RotationOffset or CFrame.new(),
		Model = data.Model,
		Trails = GetTrails(data.Model),
		SpeedMultiplier = speedMultiplier
	}
	local v3 = v - start
	v2.Model:PivotTo(CFrame.new(start, start + v3) * v2.RotationOffset)
	setmetatable(v2, BasicPlaneClass)
	v2:_ScaleTrails()
	return v2
end

function BasicPlaneClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function BasicPlaneClass:Destroy()
	self.Model:Destroy()
	self.Destroyed = true
end

function BasicPlaneClass:Run(p: number)
	self.TimePassed += p
	local v = self.End - self.Start
	self.Position = self.Start:Lerp(self.End, self.TimePassed / self.TotalTime) + self.HeightOffset
	self.Model:PivotTo(CFrame.new(self.Position, self.Position + v) * self.RotationOffset)

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function BasicPlaneClass:SpeedMultiplierChanged(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
	self:_ScaleTrails()
end

function BasicPlaneClass:_ScaleTrails()
	for _, trail in pairs(self.Trails) do
		if not trail:GetAttribute("DefaultLifetime") then
			trail:SetAttribute("DefaultLifetime", trail.Lifetime)
		end

		trail.Lifetime = trail:GetAttribute("DefaultLifetime") / math.max(self.SpeedMultiplier, 0.1)
	end
end

return BasicPlaneClass