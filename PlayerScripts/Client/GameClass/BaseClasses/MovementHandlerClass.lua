local createVector = vector.create
local MovementHandlerClass = {}
MovementHandlerClass.__index = MovementHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))
local PathHandler = require(common:WaitForChild("PathHandler"))
local EnemyUtilities = require(common:WaitForChild("EnemyUtilities"))
workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore"):WaitForChild("MovementDebugParts")

function MovementHandlerClass.New(hash: number, list, flag: boolean, p: number, p2: number, value: number?, value2: number?, flag2: boolean?, data, pvpTeamIndex: number)
	local pathIndex = list[1]
	local v = list[2]
	local pathPercentage = list[3]
	local speed = list[4]
	local defaultSpeed = list[5]
	local serverSpawnTime = list[6]
	local reverseDirection = list[7]
	local topSpeedMultiplier = list[8]
	local startYOffset, v2, summonedRaiseExponent

	if flag then
		local summonedYOffset = data and data.SummonedYOffset or p * -2
		startYOffset = Utilities.ApplyVariance(summonedYOffset, not data and 1.5 or data.SummonedYOffsetVariance or 1.5)
		local v3 = not data and 0.25 or data.SummonedRaiseTime or 0.25
		v2 = Utilities.ApplyVariance(v3, not data and 1.25 or data.SummonedRaiseTimeVariance or 1.25)
		summonedRaiseExponent = not data and 1.5 or data.SummonedRaiseExponent or 1.5
	end

	local staticSpawnCFrame = EnemyUtilities.GetStaticSpawnCFrame(data)
	local position = staticSpawnCFrame and staticSpawnCFrame.Position
	local v3

	if staticSpawnCFrame then
		local lookVector = staticSpawnCFrame.LookVector
		local vector = Vector3.new(lookVector.X, 0, lookVector.Z)
		v3 = vector.Magnitude < 0.001 and createVector(0, 0, -1) or vector.Unit
	end

	local v4

	if not position then
		v4 = reverseDirection and PathHandler.GetEnd(pathIndex, pvpTeamIndex)
			or PathHandler.GetSpawn(pathIndex, pvpTeamIndex)
	end

	local v5 = {
		Hash = hash,
		PVPTeamIndex = pvpTeamIndex,
		ReverseDirection = reverseDirection,
		Speed = speed,
		DefaultSpeed = defaultSpeed,
		TopSpeedMultiplier = topSpeedMultiplier,
		CustomSpeedMultiplier = 1,
		Static = position and true or false,
		PathIndex = pathIndex,
		PathOffset = position and 0 or v,
		PathOffsetMultiplier = 1,
		PathPercentage = pathPercentage,
		PathPosition = position or Vector3.new(),
		RealPosition = position or Vector3.new(),
		MoveVector = v3 or Vector3.new(),
		MoveVectorRejectCount = 0,
		RealCFrame = CFrame.new(),
		ServerSpawnTime = serverSpawnTime,
		NoAdjustMovementAnimationSpeed = data and data.NoAdjustMovementAnimationSpeed or false,
		PreviousNode = v4,
		CurrentNode = v4
	}
	local nextNode

	if v4 then
		nextNode = reverseDirection and v4:GetPrevious(pathIndex) or v4:GetNext(pathIndex) or nil
	end

	v5.NextNode = nextNode
	v5.SummonedOffset = Vector3.new()
	v5.SummonedData = flag
		and {
			StartYOffset = startYOffset,
			TimeLeft = v2,
			TotalTimeLeft = v2,
			SummonedRaiseExponent = summonedRaiseExponent
		}
	v5.AbilityOffset = Vector3.new()
	v5.KnockbackOffset = CFrame.new()
	v5.NoPathOffsetTimeLeft = 0
	v5.ForceFaceOn = false
	v5.ForceFacePosition = nil
	v5.ForceFaceTransitionTimeLeft = 0
	v5.ForceFaceTransitionTimeTotal = 0
	v5.ForceFaceStartPosition = nil
	v5.ForceFaceIntroTime = value or 0.3
	v5.ForceFaceOutroTime = value2 or 0.6
	v5._debug1 = 0
	v5._debug2 = 1
	v5._debugPart = nil
	v5._debugGui = nil
	setmetatable(v5, MovementHandlerClass)

	if v5.Static then
		v5:UpdateRealCFrame(true)
		return v5
	end

	v5:Initialize(p2, flag2)
	return v5
end

function MovementHandlerClass:_GetSpawn()
	local reverseDirection = self.ReverseDirection
	local pathIndex = self.PathIndex
	local pvpTeamIndex = self.PVPTeamIndex
	return reverseDirection and PathHandler.GetEnd(pathIndex, pvpTeamIndex)
		or PathHandler.GetSpawn(pathIndex, pvpTeamIndex)
end

function MovementHandlerClass:_GetEnd()
	local reverseDirection = self.ReverseDirection
	local pathIndex = self.PathIndex
	local pvpTeamIndex = self.PVPTeamIndex
	return reverseDirection and PathHandler.GetSpawn(pathIndex, pvpTeamIndex)
		or PathHandler.GetEnd(pathIndex, pvpTeamIndex)
end

function MovementHandlerClass:Initialize(p: number, flag: boolean?, p2: number?)
	local reverseDirection = self.ReverseDirection
	local pathIndex = self.PathIndex
	local v = PathHandler.GetPathLength(pathIndex, self.PVPTeamIndex) / self.Speed
	local v2 = math.max(0, p * (workspace:GetServerTimeNow() - self.ServerSpawnTime)) / v

	if not (flag or p2) then
		if reverseDirection then
			if self.PathPercentage - v2 >= 0 then
				self.PathPercentage -= v2
			end
		elseif self.PathPercentage + v2 <= 1 then
			self.PathPercentage += v2
		end
	end

	local spawn = self:_GetSpawn()
	local v3 = self:_GetEnd()

	if not reverseDirection then
		self.PathPercentage = math.clamp(
			self.PathPercentage,
			spawn:GetPercentageAlongPath(pathIndex),
			v3:GetPercentageAlongPath(pathIndex) - 0.001
		)
	end

	local pathPercentage = self.PathPercentage
	local percentageAlongPath = self.NextNode:GetPercentageAlongPath(pathIndex)

	if pathPercentage > 1 then
		warn("MovementHandlerClass::Initialize error: Path percentage is greater than 1")
		pathPercentage = 1
	end

	if reverseDirection then
		while pathPercentage < percentageAlongPath do
			self:IncrementCurrentNode()
			percentageAlongPath = self.NextNode:GetPercentageAlongPath(pathIndex)
		end
	else
		while percentageAlongPath < pathPercentage do
			self:IncrementCurrentNode()
			percentageAlongPath = self.NextNode:GetPercentageAlongPath(pathIndex)
		end
	end

	self.PathPosition = self.CurrentNode:GetPositionFromPercentage(pathIndex, pathPercentage, reverseDirection)
	local currentNode = self.CurrentNode
	local nextNode = self.NextNode
	local position = currentNode:GetPosition()
	local v4 = nextNode:GetPosition() - position
	self.RealPosition = self.PathPosition - v4
	self:UpdateRealCFrame(false)
end

function MovementHandlerClass:Move(p: number)
	local reverseDirection = self.ReverseDirection
	local v = self.Speed * p

	while v > 0 do
		local nextNode = self.NextNode
		local v2 = nextNode:GetPosition() - self.PathPosition
		local magnitude = v2.Magnitude
		local unit = v2.Unit

		if magnitude <= v then
			if reverseDirection and nextNode:IsStart() or nextNode:IsEnd() then
				self.EndReached = true
				return
			end

			self.PathPosition = nextNode:GetPosition()
			self:IncrementCurrentNode()
			v -= magnitude
		else
			self.PathPosition += v * unit
			v = 0
		end
	end

	self.PathPercentage = self.CurrentNode:GetPercentageFromPosition(
		self.PathIndex,
		self.PathPosition,
		reverseDirection
	)
	self.X = self.PathPosition.X
	self.Z = self.PathPosition.Z
end

function MovementHandlerClass.Destroy(_) end

function MovementHandlerClass:SetSpeed(speed: number)
	self.Speed = speed
end

function MovementHandlerClass:SetDefaultSpeed(defaultSpeed: number)
	self.DefaultSpeed = defaultSpeed
end

function MovementHandlerClass:SetTopSpeedMultiplier(topSpeedMultiplier: number)
	self.TopSpeedMultiplier = topSpeedMultiplier
end

function MovementHandlerClass.GetTopSpeedMultiplier(p)
	return p.TopSpeedMultiplier
end

function MovementHandlerClass.GetAnimationSpeed(data)
	if data.NoAdjustMovementAnimationSpeed then
		return 1
	end

	local defaultSpeed = data.DefaultSpeed

	if defaultSpeed == 0 then
		return 0
	end

	local v = data.CustomSpeedMultiplier * data.Speed / defaultSpeed

	if data.KnockbackOffset.Position.Magnitude > 0.5 then
		return v / 10
	end

	return v
end

function MovementHandlerClass:SetCustomSpeedMultiplier(customSpeedMultiplier: number)
	self.CustomSpeedMultiplier = customSpeedMultiplier
end

function MovementHandlerClass.GetCurrentSpeed(p)
	return p.Speed
end

function MovementHandlerClass:Run(p: number, flag: boolean)
	self.ForceFaceTransitionTimeLeft = math.max(0, self.ForceFaceTransitionTimeLeft - p)
	self.NoPathOffsetTimeLeft = math.max(0, self.NoPathOffsetTimeLeft - p)
	self:_CalculateSummonedOffset(p)

	if not (flag or self.Static) then
		self:Move(p)
	end

	self:UpdateRealCFrame(flag or self.Static)
end

function MovementHandlerClass.GetRealCFrame(data, flag: boolean?)
	if flag then
		return data.RealCFrame + data.SummonedOffset
	end

	local knockbackOffset = data.KnockbackOffset
	return (data.RealCFrame + data.SummonedOffset + data.AbilityOffset + knockbackOffset.Position) * knockbackOffset.Rotation
end

function MovementHandlerClass:GetPosition()
	return self.RealCFrame.Position
end

function MovementHandlerClass.GetPathPosition(p)
	return p.PathPosition
end

function MovementHandlerClass:SetPathPercentage(pathPercentage)
	self.PathPercentage = pathPercentage
end

function MovementHandlerClass:IncrementCurrentNode()
	self.PreviousNode = self.CurrentNode
	self.CurrentNode = self.NextNode

	if self.ReverseDirection then
		if self.NextNode:IsStart() then
			warn("[ReverseDirection] Attempt to get previous node on start node")
		else
			self.NextNode = self.NextNode:GetPrevious(self.PathIndex)
		end
	elseif self.NextNode:IsEnd() then
		warn("Attempt to get next node on end node")
	else
		self.NextNode = self.NextNode:GetNext(self.PathIndex)
	end
end

function MovementHandlerClass:_CalculateSummonedOffset(p: number)
	local summonedData = self.SummonedData

	if summonedData then
		summonedData.TimeLeft -= p

		if summonedData.TimeLeft > 0 then
			self.SummonedOffset = Vector3.new(
				0,
				(summonedData.TimeLeft / summonedData.TotalTimeLeft) ^ summonedData.SummonedRaiseExponent * summonedData.StartYOffset,
				0
			)
		else
			self.SummonedOffset = createVector(0, 0, 0)
			self.SummonedData = nil
		end
	end
end

function MovementHandlerClass:_GetAbilityOffsetNoPathOffsetMultiplier()
	return 1 - math.clamp(self.NoPathOffsetTimeLeft, 0, 1.25) / 1.25
end

function MovementHandlerClass:_GetPathOffset()
	return self.PathOffset * self.PathOffsetMultiplier * self:_GetAbilityOffsetNoPathOffsetMultiplier()
end

function MovementHandlerClass:UpdateRealCFrame(flag: boolean)
	local realPosition, moveVector

	if flag then
		realPosition = self.RealPosition
		moveVector = self.MoveVector
	else
		local reverseDirection = self.ReverseDirection
		local pathPosition = self.PathPosition
		local pathIndex = self.PathIndex
		local currentNode = self.CurrentNode
		local previousNode = self.PreviousNode
		local nextNode = self.NextNode
		local previous = reverseDirection and nextNode:GetPrevious(pathIndex) or nextNode:GetNext(pathIndex)
		local position = currentNode:GetPosition()
		local position2 = nextNode:GetPosition()
		local v, v2

		if reverseDirection then
			local previousPathDistanceForCurve = currentNode:GetPreviousPathDistanceForCurve(pathIndex)
			v = math.min(previousPathDistanceForCurve, nextNode:GetPreviousPathDistanceForCurve(pathIndex))
			v2 = math.min(previousPathDistanceForCurve, previousNode:GetPreviousPathDistanceForCurve(pathIndex))
		else
			local nextPathDistanceForCurve = currentNode:GetNextPathDistanceForCurve(pathIndex)
			v = math.min(nextPathDistanceForCurve, nextNode:GetNextPathDistanceForCurve(pathIndex))
			v2 = math.min(nextPathDistanceForCurve, previousNode:GetNextPathDistanceForCurve(pathIndex))
		end

		local magnitude = (position2 - pathPosition).Magnitude
		local magnitude2 = (position - pathPosition).Magnitude
		local abilityOffsetNoPathOffsetMultiplier = self:_GetAbilityOffsetNoPathOffsetMultiplier()

		if previous and magnitude < v then
			local v3 = v * 2
			local v4 = (v - magnitude) / v3
			local previousUnitVector = reverseDirection and currentNode:GetPreviousUnitVector(pathIndex)
				or currentNode:GetNextUnitVector(pathIndex)
			local previousUnitVector2 = reverseDirection and nextNode:GetPreviousUnitVector(pathIndex)
				or nextNode:GetNextUnitVector(pathIndex)
			local v5 = position2 - (1 - v4) * v * previousUnitVector
			realPosition = v5 + v4 * (position2 + v4 * v * previousUnitVector2 - v5)
			moveVector = previousUnitVector:Lerp(previousUnitVector2, v4)
		elseif previousNode and magnitude2 < v2 then
			local v3 = v2 * 2
			local v4 = (v2 + magnitude2) / v3
			local previousUnitVector = reverseDirection and previousNode:GetPreviousUnitVector(pathIndex)
				or previousNode:GetNextUnitVector(pathIndex)
			local previousUnitVector2 = reverseDirection and currentNode:GetPreviousUnitVector(pathIndex)
				or currentNode:GetNextUnitVector(pathIndex)
			local v5 = position - (1 - v4) * v2 * previousUnitVector
			realPosition = v5 + v4 * (position + v4 * v2 * previousUnitVector2 - v5)
			moveVector = previousUnitVector:Lerp(previousUnitVector2, v4)
		else
			moveVector = position2 - position
			realPosition = pathPosition
		end

		if abilityOffsetNoPathOffsetMultiplier < 1 then
			realPosition = pathPosition:Lerp(realPosition, abilityOffsetNoPathOffsetMultiplier)
		end

		self.RealPosition = realPosition
		self.MoveVector = moveVector
		local pathOffsetMultiplier = nextNode.PathOffsetMultiplier
		local pathOffsetMultiplier2 = currentNode.PathOffsetMultiplier
		local percentageFromPreviousNode = currentNode:GetPercentageFromPreviousNode(
			pathIndex,
			pathPosition,
			reverseDirection
		)
		self.PathOffsetMultiplier = Utilities.Lerp(
			pathOffsetMultiplier2,
			pathOffsetMultiplier,
			percentageFromPreviousNode
		)
	end

	local unit = moveVector:Cross(createVector(0, 1, 0)).Unit
	local v = realPosition + self:_GetPathOffset() * unit
	local v2 = v + moveVector

	if self.ForceFaceOn or self.ForceFaceTransitionTimeLeft > 0 then
		local v3 = 1 - self.ForceFaceTransitionTimeLeft / self.ForceFaceTransitionTimeTotal
		local forceFaceStartPosition = self.ForceFaceOn and self.ForceFaceStartPosition or v + moveVector.Unit
		local v4 = v + ((self.ForceFacePosition - v) * createVector(1, 0, 1)).Unit

		if self.ForceFaceOn then
			v2 = forceFaceStartPosition:Lerp(v4, v3)
		else
			v2 = v4:Lerp(forceFaceStartPosition, v3)
		end
	end

	self.RealCFrame = CFrame.new(v, v2)
end

function MovementHandlerClass.GetPredictedPosition(data, p: number)
	if data.Static then
		return data.PathPosition
	end

	local reverseDirection = data.ReverseDirection
	local v = data.Speed * p
	local nextNode = data.NextNode
	local pathPosition = data.PathPosition
	local pathIndex = data.PathIndex

	while v > 0 do
		local v2 = nextNode:GetPosition() - pathPosition
		local magnitude = v2.Magnitude
		local unit = v2.Unit

		if magnitude <= v then
			if reverseDirection and nextNode:IsStart() or nextNode:IsEnd() then
				return nextNode:GetPosition()
			end

			pathPosition = nextNode:GetPosition()
			nextNode = nextNode:GetNext(pathIndex)
			v -= magnitude
		else
			pathPosition += v * unit
			v = 0
		end
	end

	return pathPosition
end

function MovementHandlerClass:SetForceFacePosition(forceFacePosition: Vector3, p: number?)
	local v = p or self.ForceFaceIntroTime
	self.ForceFaceOn = true
	self.ForceFacePosition = forceFacePosition
	self.ForceFaceTransitionTimeLeft = v
	self.ForceFaceTransitionTimeTotal = v
	self.ForceFaceStartPosition = self.RealCFrame.Position + self.RealCFrame.LookVector
end

function MovementHandlerClass:RemoveForceFacePosition()
	if self.ForceFaceOn then
		self.ForceFaceOn = false
		self.ForceFaceTransitionTimeLeft = self.ForceFaceOutroTime
		self.ForceFaceTransitionTimeTotal = self.ForceFaceOutroTime
	end
end

function MovementHandlerClass:TeleportToPathIndexAndPercentage(pathIndex: number, pathPercentage: number)
	if self.Static then
		return
	end

	self.PathIndex = pathIndex
	self.PathPercentage = pathPercentage
	local reverseDirection = self.ReverseDirection
	local spawn = self:_GetSpawn()
	self.PreviousNode = spawn
	self.CurrentNode = spawn
	self.NextNode = reverseDirection and spawn:GetPrevious(pathIndex) or spawn:GetNext(pathIndex)
	self:Initialize(1, nil, true)
end

function MovementHandlerClass:KnockedBack(pathPercentage: number)
	if self.Static then
		return
	end

	self.PathPercentage = pathPercentage
	local pathIndex = self.PathIndex
	local reverseDirection = self.ReverseDirection
	local spawn = self:_GetSpawn()
	self.PreviousNode = spawn
	self.CurrentNode = spawn
	self.NextNode = reverseDirection and spawn:GetPrevious(pathIndex) or spawn:GetNext(pathIndex)
	self:Initialize(1, nil, true)
end

function MovementHandlerClass:SetAbilityOffset(abilityOffset: Vector3)
	self.AbilityOffset = abilityOffset
end

function MovementHandlerClass:SetKnockbackOffset(knockbackOffset: CFrame)
	self.KnockbackOffset = knockbackOffset
end

function MovementHandlerClass:RemoveAbilityOffset()
	self.AbilityOffset = Vector3.new()
	self.NoPathOffsetTimeLeft = 1.25
end

function MovementHandlerClass:RemoveKnockbackOffset()
	self.KnockbackOffset = CFrame.new()
end

return MovementHandlerClass