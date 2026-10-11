local JumpAbilityHandlerClass = {}
JumpAbilityHandlerClass.__index = JumpAbilityHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))

local function GetTravelTime(p: number, p2: number, p3: number)
	local v = p2 / p3
	local v2 = p / 2
	local v3 = p2 / v
	local v4 = v * 0.5 * v3 ^ 2

	if v2 <= v4 then
		return math.sqrt(v2 * 2 / v) * 2, v2
	end

	local v5 = (p - v4 * 2) / p2
	return v3 * 2 + v5, v4
end

function JumpAbilityHandlerClass.New(p)
	local towerAbilityJumpData = p.TowerAbilityJumpData

	if not towerAbilityJumpData then
		error("JumpAbilityHandlerClass requires TowerAbilityJumpData in the config")
	end

	return (setmetatable({
		Tower = nil,
		ParentAbility = nil,
		JumpData = towerAbilityJumpData,
		StartingPosition = nil,
		CurrentTargetPosition = nil,
		RootStartingPosition = nil,
		RootEndingPosition = nil,
		MaximumAltitude = 0,
		CurrentSpeed = 0,
		DistanceTravelled = 0,
		DistanceDuringAcceleration = 0,
		JumpTimeRemaining = 0,
		JumpActive = false,
		TakeoffTimeRemaining = 0,
		TravelTimeRemaining = 0,
		LandingTimeRemaining = 0,
		TakeoffActive = false,
		TravelActive = false,
		LandingActive = false,
		TotalTravelTime = 0
	}, JumpAbilityHandlerClass))
end

function JumpAbilityHandlerClass:SetTower(tower)
	self.Tower = tower
end

function JumpAbilityHandlerClass:SetParentAbility(parentAbility)
	self.ParentAbility = parentAbility
end

function JumpAbilityHandlerClass:Start(currentTargetPosition: Vector3)
	if not currentTargetPosition then
		warn("JumpAbilityHandlerClass:Start called without TargetPosition")
		return
	end

	local jumpData = self.JumpData
	local tower = self.Tower
	local primaryPart = tower.Character:GetCharacterModel().PrimaryPart
	local position = tower:GetPosition()
	local magnitude = (currentTargetPosition - position).Magnitude
	local moveSpeed = jumpData.MoveSpeed
	local v = moveSpeed / jumpData.AccelerationTime
	local distanceDuringAcceleration = magnitude / 2
	local v2 = moveSpeed / v
	local v3 = v * 0.5 * v2 ^ 2
	local v4

	if distanceDuringAcceleration <= v3 then
		v4 = math.sqrt(distanceDuringAcceleration * 2 / v) * 2
	else
		local v5 = (magnitude - v3 * 2) / moveSpeed
		v4 = v2 * 2 + v5
		distanceDuringAcceleration = v3
	end

	local takeoffDuration = jumpData.TakeoffDuration
	local landingDuration = jumpData.LandingDuration
	self.StartingPosition = position
	self.CurrentTargetPosition = currentTargetPosition
	self.RootStartingPosition = primaryPart.Position
	self.RootEndingPosition = currentTargetPosition + (self.RootStartingPosition - position)
	self.MaximumAltitude = math.random(1000 * jumpData.Altitude.Min, 1000 * jumpData.Altitude.Max) / 1000
	self.CurrentSpeed = 0
	self.DistanceTravelled = 0
	self.DistanceDuringAcceleration = distanceDuringAcceleration
	self.JumpTimeRemaining = takeoffDuration + v4 + landingDuration
	self.JumpActive = true
	self.TakeoffTimeRemaining = takeoffDuration
	self.TravelTimeRemaining = v4
	self.LandingTimeRemaining = landingDuration
	self.TakeoffActive = false
	self.TravelActive = false
	self.LandingActive = false
	self.TotalTravelTime = v4
	tower:FacePosition(currentTargetPosition)
	self:_ToggleTorsoToRootWeld(false)
end

function JumpAbilityHandlerClass:Run(p: number)
	if not self.JumpActive then
		return
	end

	local jumpData = self.JumpData
	local tower = self.Tower
	self:_HandleTowerMovement(p)
	self.JumpTimeRemaining -= p

	if self.JumpTimeRemaining <= 0 then
		self:_Finished()
		self.JumpActive = false
	end

	if self.TakeoffTimeRemaining > 0 then
		self.TakeoffTimeRemaining -= p

		if not self.TakeoffActive then
			if jumpData.TakeoffAnimationName then
				tower:SetAnimationState(jumpData.TakeoffAnimationName)
			end

			self.TakeoffActive = true
		end
	elseif self.TravelTimeRemaining > 0 then
		self.TravelTimeRemaining -= p

		if not self.TravelActive then
			if jumpData.FlyingAnimationName then
				tower:SetAnimationState(jumpData.FlyingAnimationName)
			end

			self.TravelActive = true
		end
	else
		if not (self.LandingTimeRemaining > 0) then
			return
		end

		self.LandingTimeRemaining -= p

		if not self.LandingActive then
			if jumpData.LandingAnimationName then
				tower:SetAnimationState(jumpData.LandingAnimationName)
			end

			self.LandingActive = true
		end
	end
end

function JumpAbilityHandlerClass:_Finished()
	self.Tower:SetPosition(self.CurrentTargetPosition)
	self:_ToggleTorsoToRootWeld(true)
end

function JumpAbilityHandlerClass:_ToggleTorsoToRootWeld(enabled: boolean)
	local tower = self.Tower
	local primaryPart = tower.Character:GetCharacterModel().PrimaryPart
	local torsoToRootWeld = tower.Character:GetTorsoToRootWeld()
	primaryPart.Anchored = not enabled
	torsoToRootWeld.Enabled = enabled
end

function JumpAbilityHandlerClass:_HandleTowerMovement(p: number)
	local jumpData = self.JumpData
	local primaryPart = self.Tower.Character:GetCharacterModel().PrimaryPart
	local rootStartingPosition = self.RootStartingPosition
	local rootEndingPosition = self.RootEndingPosition
	local maximumAltitude = self.MaximumAltitude
	local v = nil

	if self.TakeoffTimeRemaining > 0 then
		local v2 = (1 - self.TakeoffTimeRemaining / jumpData.TakeoffDuration) ^ 0.5
		v = rootStartingPosition:Lerp(rootStartingPosition + Vector3.new(0, maximumAltitude, 0), v2)
	elseif self.TravelTimeRemaining > 0 then
		local v2 = 1 - self.TravelTimeRemaining / self.TotalTravelTime
		local v3 = jumpData.MoveSpeed / jumpData.AccelerationTime
		local magnitude = (rootEndingPosition - rootStartingPosition).Magnitude

		if v2 > 0.5 then
			if magnitude - self.DistanceTravelled < self.DistanceDuringAcceleration then
				self.CurrentSpeed -= v3 * p
				self.CurrentSpeed = math.max(self.CurrentSpeed, 0)
			end
		elseif self.DistanceTravelled < self.DistanceDuringAcceleration then
			self.CurrentSpeed += v3 * p
			self.CurrentSpeed = math.min(self.CurrentSpeed, jumpData.MoveSpeed)
		end

		self.DistanceTravelled += self.CurrentSpeed * p
		v = (rootStartingPosition + Vector3.new(0, maximumAltitude, 0)):Lerp(
			rootEndingPosition + Vector3.new(0, maximumAltitude, 0),
			(math.clamp(self.DistanceTravelled / magnitude, 0, 1))
		)
	elseif self.LandingTimeRemaining > 0 then
		local v2 = (1 - self.LandingTimeRemaining / jumpData.LandingDuration) ^ 2
		v = (rootEndingPosition + Vector3.new(0, maximumAltitude, 0)):Lerp(rootEndingPosition, v2)
	end

	primaryPart.CFrame = CFrame.new(v) * primaryPart.CFrame.Rotation
end

return JumpAbilityHandlerClass