local NodeClass = {}
NodeClass.__index = NodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Utilities"))
local HashGeneratorClass = require(common:WaitForChild("HashGeneratorClass"))
local PATH_TURN_RADIUS = _G.PATH_TURN_RADIUS
local RAMP_LEAN_RADIUS = _G.RAMP_LEAN_RADIUS
local RAMP_MIN_ELEVATION = _G.RAMP_MIN_ELEVATION
local v = {}
local v2 = HashGeneratorClass.New()

function NodeClass:New(flag: boolean?, flag2: boolean?, spawnPathIndex: number?)
	local v3 = {
		Hash = v2:Get(),
		Position = self.Position,
		IsDisabled = self:GetAttribute("DisabledByDefault") or false,
		PathOffsetMultiplier = self:GetAttribute("PathOffsetMultiplier") or 1,
		IsBossSpawn = 0,
		IsPathEntitySpawn = 0,
		IsCustomPath = 0,
		IsLoop = 0,
		QueryIgnore = 0,
		End = 0,
		Start = 0,
		MaxPathOffset = 0,
		SpawnPathIndex = 0,
		NodePart = 0,
		NextMap = 0,
		PreviousMap = 0,
		DistanceAlongPath = 0,
		PercentageAlongPath = 0,
		TotalPathLength = 0
	}
	local isBossSpawn

	if flag2 then
		isBossSpawn = self:GetAttribute("IsBossSpawn") or false
	else
		isBossSpawn = false
	end

	v3.IsBossSpawn = isBossSpawn
	local isPathEntitySpawn

	if flag2 then
		isPathEntitySpawn = self:GetAttribute("IsPathEntitySpawn") or false
	else
		isPathEntitySpawn = false
	end

	v3.IsPathEntitySpawn = isPathEntitySpawn
	local isCustomPath

	if flag2 then
		isCustomPath = self:GetAttribute("IsCustomPath") or false
	else
		isCustomPath = false
	end

	v3.IsCustomPath = isCustomPath
	v3.IsLoop = self:GetAttribute("IsLoop") or false
	v3.QueryIgnore = self:GetAttribute("QueryIgnore") or false
	v3.End = flag or false
	v3.Start = flag2 or false
	v3.MaxPathOffset = flag2 and self:GetAttribute("MaxPathOffset")
	v3.SpawnPathIndex = spawnPathIndex
	v3.NodePart = self
	v3.NextMap = {}
	v3.PreviousMap = {}
	v3.DistanceAlongPath = {}
	v3.PercentageAlongPath = {}
	v3.TotalPathLength = {}
	v[v3.Hash] = v3
	self.Transparency = 1
	return (setmetatable(v3, NodeClass))
end

function NodeClass.GetNodePart(p)
	return p.NodePart
end

function NodeClass.GetSpawnPathIndex(p)
	return p.SpawnPathIndex
end

function NodeClass.GetHash(p)
	return p.Hash
end

function NodeClass:GetPosition()
	return self.Position
end

function NodeClass.DistanceTo(p, object)
	return (p.Position - object:GetPosition()).Magnitude
end

function NodeClass.GetNext(p, p2: number)
	local v3 = p.NextMap[p2] or p.NextMap[1]
	return v3 and v3.Node
end

function NodeClass.SetNext(p, p2: number, node)
	local position = p.Position
	local position2 = node:GetPosition()
	local v3 = position2 - position
	local v4 = PATH_TURN_RADIUS

	if RAMP_MIN_ELEVATION < math.abs(position.Y - position2.Y) then
		v4 = RAMP_LEAN_RADIUS
	end

	local v5 = {
		Node = node,
		Distance = v3.Magnitude,
		UnitVector = v3.Unit,
		PathDistanceForCurve = math.min(v4, v3.Magnitude / 2)
	}
	p.NextMap[p2] = v5
end

function NodeClass.GetPrevious(p, p2: number)
	local v3 = p.PreviousMap[p2] or p.PreviousMap[1]
	return v3 and v3.Node
end

function NodeClass.SetPrevious(p, p2: number, node)
	local position = p.Position
	local position2 = node:GetPosition()
	local v3 = position2 - position
	local v4 = PATH_TURN_RADIUS

	if RAMP_MIN_ELEVATION < math.abs(position.Y - position2.Y) then
		v4 = RAMP_LEAN_RADIUS
	end

	local v5 = {
		Node = node,
		Distance = v3.Magnitude,
		UnitVector = v3.Unit,
		PathDistanceForCurve = math.min(v4, v3.Magnitude / 2)
	}
	p.PreviousMap[p2] = v5
end

function NodeClass.SetDistanceAlongPath(p, p2: number, p3: number)
	p.DistanceAlongPath[p2] = p3
end

function NodeClass:GetPercentageAlongPath(p: number)
	return self.PercentageAlongPath[p]
end

function NodeClass.CalculatePercentageAlongPath(p, p2: number, p3: number)
	p.PercentageAlongPath[p2] = p.DistanceAlongPath[p2] / p3
end

function NodeClass.GetTotalPathLength(p, p2: number)
	return p.TotalPathLength[p2]
end

function NodeClass.SetTotalPathLength(p, p2: number, p3: number)
	p.TotalPathLength[p2] = p3
end

function NodeClass.GetPercentageFromPosition(data, p: number, vector: Vector3, flag: boolean?)
	local magnitude = (vector - data.Position).Magnitude

	if flag then
		return (-magnitude + data.DistanceAlongPath[p]) / data.TotalPathLength[p]
	end

	return (magnitude + data.DistanceAlongPath[p]) / data.TotalPathLength[p]
end

function NodeClass.GetPercentageFromPreviousNode(data, p: number, vector: Vector3, flag: boolean?)
	local v3 = flag and data.PreviousMap[p] or data.NextMap[p]
	return (vector - data.Position).Magnitude / v3.Distance
end

function NodeClass:GetPositionFromPercentage(p: number, p2: number, flag: boolean?)
	local percentageAlongPath = self:GetPercentageAlongPath(p)
	local v3 = self.NextMap[p] or self.NextMap[1]
	local v4 = self.PreviousMap[p] or self.PreviousMap[1]
	local percentageAlongPath2

	if flag then
		percentageAlongPath2 = v4.Node:GetPercentageAlongPath(p)

		if p2 < percentageAlongPath2 then
			error("Percentage out of range of this node")
		end
	else
		percentageAlongPath2 = v3.Node:GetPercentageAlongPath(p)

		if percentageAlongPath2 < p2 then
			error("Percentage out of range of this node")
		end
	end

	local v5 = (p2 - percentageAlongPath) / (percentageAlongPath2 - percentageAlongPath)

	if flag then
		return self.Position + v5 * v4.Distance * v4.UnitVector
	end

	return self.Position + v5 * v3.Distance * v3.UnitVector
end

function NodeClass.GetNextUnitVector(p, p2: number)
	return (p.NextMap[p2] or p.NextMap[1]).UnitVector
end

function NodeClass.GetPreviousUnitVector(p, p2: number)
	return (p.PreviousMap[p2] or p.PreviousMap[1]).UnitVector
end

function NodeClass.GetNextPathDistanceForCurve(p, p2: number)
	local v3 = p.NextMap[p2] or p.NextMap[1]
	return v3 and v3.PathDistanceForCurve or 0
end

function NodeClass.GetPreviousPathDistanceForCurve(p, p2: number)
	local v3 = p.PreviousMap[p2] or p.PreviousMap[1]
	return v3 and v3.PathDistanceForCurve or 0
end

function NodeClass.IsEnd(p)
	return p.End and not p.IsLoop
end

function NodeClass.IsStart(p)
	return p.Start
end

function NodeClass.GetIsDisabled(p)
	return p.IsDisabled
end

function NodeClass:SetIsDisabled(isDisabled: boolean)
	self.IsDisabled = isDisabled
end

function NodeClass.GetIsBossSpawn(p)
	return p.IsBossSpawn
end

function NodeClass.GetIsPathEntitySpawn(p)
	return p.IsPathEntitySpawn
end

function NodeClass.GetIsCustomPath(p)
	return p.IsCustomPath
end

function NodeClass.GetQueryIgnore(p)
	return p.QueryIgnore
end

function NodeClass.GetIsLoop(p)
	return p.IsLoop
end

function NodeClass.GetMaxPathOffset(p)
	return p.MaxPathOffset
end

return NodeClass