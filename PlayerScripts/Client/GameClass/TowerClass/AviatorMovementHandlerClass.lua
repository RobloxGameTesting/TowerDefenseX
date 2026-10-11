local createVector = vector.create
local AviatorMovementHandlerClass = {}
AviatorMovementHandlerClass.__index = AviatorMovementHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TowerTypes"))
local AviatorFlightPathUtilities = require(common:WaitForChild("AviatorFlightPathUtilities"))

function AviatorMovementHandlerClass.New(p, data, cframe: CFrame?)
	local aviatorMovementConfig = p.AviatorMovementConfig

	if not aviatorMovementConfig then
		error("AviatorMovementConfig not found in LevelStats")
	end

	local takeoffTime = aviatorMovementConfig.TakeoffTime or 2
	local state = { Path = data.Path, Mode = data.Mode, U = data.U, Sign = data.Sign }
	local currentRotation

	if takeoffTime <= data.TakeoffElapsed then
		currentRotation = CFrame.lookAt(createVector(0, 0, 0), AviatorFlightPathUtilities.GetTravelDirection(state)).Rotation
	else
		currentRotation = cframe or CFrame.new().Rotation
	end

	local v = {
		CenterPosition = data.CenterPosition,
		CurrentPosition = data.CenterPosition,
		State = state,
		TakeoffElapsed = data.TakeoffElapsed,
		WasAlive = true,
		CorrectionDistance = 0,
		VisualOffset = createVector(0, 0, 0),
		GoalCFrame = CFrame.new(data.CenterPosition),
		PortCFrame = CFrame.new(),
		CurrentRotation = currentRotation,
		SpawnRotation = cframe or CFrame.new().Rotation,
		CurrentRoll = 0,
		Radius = aviatorMovementConfig.Radius,
		Speed = aviatorMovementConfig.Speed,
		Altitude = aviatorMovementConfig.Altitude or 0,
		PortAngle = aviatorMovementConfig.PortAngle or 25,
		TakeoffTime = takeoffTime,
		AttackOffset = aviatorMovementConfig.AttackOffset or p.Range
	}
	setmetatable(v, AviatorMovementHandlerClass)
	return v
end

function AviatorMovementHandlerClass.SetCurrentGoal(_, _: Vector3?) end

function AviatorMovementHandlerClass:LevelStatsChanged(p)
	local aviatorMovementConfig = p.AviatorMovementConfig

	if not aviatorMovementConfig then
		error("AviatorMovementConfig not found in LevelStats")
	end

	self.Radius = aviatorMovementConfig.Radius
	self.Speed = aviatorMovementConfig.Speed
	self.Altitude = aviatorMovementConfig.Altitude or 0
	self.PortAngle = aviatorMovementConfig.PortAngle or 25
	self.TakeoffTime = aviatorMovementConfig.TakeoffTime or 2
	self.AttackOffset = aviatorMovementConfig.AttackOffset or p.Range
end

function AviatorMovementHandlerClass:ApplyServerSync(p: number, p2: number, value: number)
	local decodeState = AviatorFlightPathUtilities.DecodeState(p, p2)
	local state = self.State
	local radius = self.Radius
	local v = math.clamp(value, 0, 1)

	if v > 0 then
		AviatorFlightPathUtilities.Advance(decodeState, v * self.Speed, radius)
	end

	if decodeState.Path == state.Path and decodeState.Sign == state.Sign then
		local pathLength = AviatorFlightPathUtilities.GetPathLength(state.Path, radius)
		local correctionDistance = (((decodeState.U - state.U) * state.Sign + 0.5) % 1 - 0.5) * pathLength

		if math.abs(correctionDistance) <= 6 then
			state.Mode = decodeState.Mode
			self.CorrectionDistance = correctionDistance
			return
		end
	end

	local offsetXZ, v2 = AviatorFlightPathUtilities.GetOffsetXZ(state.Path, state.U, radius)
	local offsetXZ2, v3 = AviatorFlightPathUtilities.GetOffsetXZ(decodeState.Path, decodeState.U, radius)
	self.VisualOffset += Vector3.new(offsetXZ - offsetXZ2, 0, v2 - v3)
	self.CorrectionDistance = 0
	self.State = decodeState
end

function AviatorMovementHandlerClass:Run(p: number, flag: boolean?, flag2: boolean?)
	if flag == false then
		if self.WasAlive then
			self.WasAlive = false
			self.TakeoffElapsed = 0
			self.CurrentRoll = 0
			self.CorrectionDistance = 0
			self.VisualOffset = createVector(0, 0, 0)
			self.CurrentPosition = self.CenterPosition
			self.CurrentRotation = self.SpawnRotation
			self.GoalCFrame = CFrame.new(self.CenterPosition) * self.CurrentRotation
			self.PortCFrame = CFrame.new()
		end
	else
		self.WasAlive = true
		local state = self.State
		local centerPosition = self.CenterPosition
		local currentPosition = self.CurrentPosition
		local v = 1
		local v2 = 1

		if not flag2 then
			local v3 = p * self.Speed
			local correctionDistance = self.CorrectionDistance

			if correctionDistance ~= 0 then
				local v4 = v3 * 0.5
				local v5 = math.clamp(correctionDistance * math.min(1, p * 3), -v4, v4)
				self.CorrectionDistance -= v5
				v3 += v5
			end

			AviatorFlightPathUtilities.Advance(state, v3, self.Radius)
		end

		local offsetXZ, v3 = AviatorFlightPathUtilities.GetOffsetXZ(state.Path, state.U, self.Radius)
		local vector = Vector3.new(centerPosition.X + offsetXZ, centerPosition.Y, centerPosition.Z + v3)
		local v4 = self.TakeoffElapsed < self.TakeoffTime

		if v4 then
			if not flag2 then
				self.TakeoffElapsed = math.min(self.TakeoffTime, self.TakeoffElapsed + p)
			end

			local v5 = self.TakeoffElapsed / self.TakeoffTime
			v2 = v5 * v5 * (3 - 2 * v5)
			self.CurrentPosition = centerPosition:Lerp(vector, v2)
			v = v2
		else
			self.CurrentPosition = vector
		end

		local v5

		if v4 then
			v5 = (self.CurrentPosition - currentPosition) * createVector(1, 0, 1)
		else
			v5 = AviatorFlightPathUtilities.GetTravelDirection(state)
		end

		if v5.Magnitude > 0.0001 then
			local rotation = CFrame.lookAt(createVector(0, 0, 0), v5).Rotation
			self.CurrentRotation = self.CurrentRotation:Lerp(rotation, (math.min(1, p * 4)))
		end

		local v6 = math.clamp(AviatorFlightPathUtilities.GetNormalizedTurn(state), -2, 2)
		local v7 = math.rad(self.PortAngle) * v6 * v2
		self.CurrentRoll += (v7 - self.CurrentRoll) * math.min(1, p * 5)
		local visualOffset = self.VisualOffset
		local visualOffset2 = not (visualOffset.Magnitude > 0.001) and createVector(0, 0, 0)
			or visualOffset * math.exp(-p * 6)
		self.VisualOffset = visualOffset2
		local v8 = self.CurrentPosition + visualOffset2 + Vector3.new(0, self.Altitude * v, 0)
		self.GoalCFrame = CFrame.new(v8) * self.CurrentRotation
		self.PortCFrame = CFrame.Angles(0, 0, self.CurrentRoll)
	end
end

function AviatorMovementHandlerClass.GetGoalCFrame(p)
	return p.GoalCFrame
end

function AviatorMovementHandlerClass.GetPortCFrame(p)
	return p.PortCFrame
end

function AviatorMovementHandlerClass.GetCenterPosition(p)
	return p.CenterPosition
end

function AviatorMovementHandlerClass.GetFlightState(p)
	return p.State, p.Radius
end

function AviatorMovementHandlerClass.GetParkedCFrame(p)
	return CFrame.new(p.CenterPosition) * p.SpawnRotation
end

function AviatorMovementHandlerClass.GetAttackPosition(data)
	return data.CurrentPosition + AviatorFlightPathUtilities.GetTravelDirection(data.State) * data.AttackOffset
end

return AviatorMovementHandlerClass