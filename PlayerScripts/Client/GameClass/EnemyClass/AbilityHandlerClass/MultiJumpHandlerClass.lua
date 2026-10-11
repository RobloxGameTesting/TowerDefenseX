local MultiJumpHandlerClass = {}
MultiJumpHandlerClass.__index = MultiJumpHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
local Utilities = require(common:WaitForChild("Utilities"))
require(common:WaitForChild("MapHandler"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local v = {
	[Enums.MultiJumpTypes.TargetTower] = true,
	[Enums.MultiJumpTypes.TargetPathEntity] = true,
	[Enums.MultiJumpTypes.Return] = true
}

local function BuildSequenceDataTable(sequence)
	local result = {}

	for _, jumpData in ipairs(sequence) do
		table.insert(result, {
			JumpData = jumpData,
			Started = false,
			Ended = false,
			GoalPosition = Vector3.new(),
			StartPosition = Vector3.new(),
			LandEffectWrapper = nil,
			JumpEffectWrapper = nil
		})
	end

	return result
end

function MultiJumpHandlerClass.New(p)
	local enemyMultiJumpData = p.EnemyMultiJumpData
	assert(enemyMultiJumpData, "MultiJumpHandlerClass requires EnemyMultiJumpData in the config.")
	local sequence = enemyMultiJumpData.Sequence
	assert(sequence and #sequence > 0, "EnemyMultiJumpData must have a non-empty Sequence.")
	return (setmetatable(
		{
			SequenceDataTable = BuildSequenceDataTable(sequence),
			Enemy = nil,
			TimePassed = 0,
			Finished = true
		},
		MultiJumpHandlerClass
	))
end

function MultiJumpHandlerClass:SetEnemy(enemy, p: number)
	self.Enemy = enemy
	local characterModel = enemy.Character:GetCharacterModel()

	for _, v2 in pairs(self.SequenceDataTable) do
		local jumpData = v2.JumpData

		if jumpData.LandEffectNames then
			v2.LandEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, p)

			for _, landEffectName in pairs(jumpData.LandEffectNames) do
				local v3 = Utilities.TryGetInstanceFromPath(characterModel, landEffectName)

				if v3 then
					v2.LandEffectWrapper:AddFrom(v3, p)
				else
					warn("Effect not found", landEffectName)
				end
			end
		end

		if not jumpData.JumpEffectNames then
			continue
		end

		v2.JumpEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, p)

		for _, jumpEffectName in pairs(jumpData.JumpEffectNames) do
			local v3 = Utilities.TryGetInstanceFromPath(characterModel, jumpEffectName)

			if v3 then
				v2.JumpEffectWrapper:AddFrom(v3, p)
			else
				warn("Effect not found", jumpEffectName)
			end
		end
	end
end

function MultiJumpHandlerClass:Run(p: number)
	self.TimePassed += p

	if self.Finished then
		return
	end

	local v2 = false

	for _, v3 in ipairs(self.SequenceDataTable) do
		local jumpData = v3.JumpData

		if not v3.Started and self.TimePassed >= jumpData.StartTime then
			self:_SequenceStarted(v3)
		end

		if not v3.Ended and self.TimePassed >= jumpData.EndTime then
			self:_SequenceEnded(v3)
		end

		if v3.Started and not v3.Ended and v[jumpData.Type] then
			self:_HandleMovement(v3)
		end

		if not v3.Ended then
			v2 = true
		end
	end

	if not v2 then
		self.Finished = true
	end
end

function MultiJumpHandlerClass:AbilityUsedOnServer(list)
	local v2 = list[14]
	self.Finished = false
	self.TimePassed = 0
	local sequenceDataTable = self.SequenceDataTable

	for i, v3 in ipairs(sequenceDataTable) do
		v3.GoalPosition = v2[i][1]
		v3.Started = false
		v3.Ended = false
	end
end

function MultiJumpHandlerClass:_SequenceStarted(p)
	p.StartPosition = self.Enemy.MovementHandler:GetRealCFrame().Position
	p.Started = true

	if p.JumpEffectWrapper then
		p.JumpEffectWrapper:PlayAll()
	end
end

function MultiJumpHandlerClass:_SequenceEnded(state)
	if state.JumpData.Type == Enums.MultiJumpTypes.Return then
		local movementHandler = self.Enemy.MovementHandler
		movementHandler:RemoveAbilityOffset()
		movementHandler:RemoveKnockbackOffset()
	end

	state.Ended = true

	if state.LandEffectWrapper then
		state.LandEffectWrapper:PlayAll()
	end
end

function MultiJumpHandlerClass:_HandleMovement(data)
	local jumpData = data.JumpData
	local movementHandler = self.Enemy.MovementHandler
	local position = movementHandler:GetRealCFrame(true).Position
	local startPosition = data.StartPosition
	local goalPosition = data.GoalPosition

	if jumpData.Type == Enums.MultiJumpTypes.Return then
		goalPosition = movementHandler:GetRealCFrame(true).Position
	end

	if not jumpData.TweenToGoal then
		movementHandler:SetAbilityOffset(goalPosition - position)
		return
	end

	local v2 = jumpData.EndTime - jumpData.StartTime
	local v3 = 1 - (v2 - (self.TimePassed - jumpData.StartTime)) / v2
	local vector = Vector3.new()

	if jumpData.AdditionalJumpHeight then
		vector = Vector3.new(0, 4 * jumpData.AdditionalJumpHeight * (-(v3 - 0.5) ^ 2 + 0.25), 0)
	end

	movementHandler:SetAbilityOffset(startPosition:Lerp(goalPosition, v3) + vector - position)
end

function MultiJumpHandlerClass:SpeedMultiplierChanged(p: number)
	for _, v2 in pairs(self.SequenceDataTable) do
		if v2.LandEffectWrapper then
			v2.LandEffectWrapper:SpeedMultiplierChanged(p)
		end

		if v2.JumpEffectWrapper then
			v2.JumpEffectWrapper:SpeedMultiplierChanged(p)
		end
	end
end

return MultiJumpHandlerClass