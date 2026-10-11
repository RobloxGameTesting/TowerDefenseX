local AttachmentEntityHandlerClass = {}
AttachmentEntityHandlerClass.__index = AttachmentEntityHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("EntityCreationTypes"))
require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("HashGeneratorClass"))
require(common:WaitForChild("AttachmentEntityUtilities"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
require(common:WaitForChild("Utilities"))
local parent = script.Parent
local CharacterClass = require(parent:WaitForChild("CharacterClass"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

local function GetCharacter(hash: number, kind: string, attachmentEntityConfig, primaryPartCFrame: CFrame, parentCharacter, object)
	if object and not attachmentEntityConfig.OverrideProjectileCFrame then
		primaryPartCFrame = object:GetPrimaryPartCFrame()
	end

	local v = {
		Hash = hash,
		Type = kind,
		EntityClass = "AttachmentEntity",
		Config = attachmentEntityConfig,
		SpawnCFrame = primaryPartCFrame,
		Parent = parentCharacter:GetTorso(),
		NoSpawnTween = object ~= nil,
		TurretConfigs = attachmentEntityConfig.TurretConfigs
	}
	return CharacterClass.New(v)
end

local function GetRandomInitialVelocity() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25), math.random(30, 55), math.random(-22, 22)))
end

local function GetRandomInitialAngularImpulse() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25) / 100, math.random(-35, 35) / 100, 0))
end

function AttachmentEntityHandlerClass.New()
	return (setmetatable(
		{ ParentEntity = nil, ParentCharacter = nil, ActiveEntities = {} },
		AttachmentEntityHandlerClass
	))
end

function AttachmentEntityHandlerClass:SetParentEntity(parentEntity)
	self.ParentEntity = parentEntity
	self.ParentCharacter = parentEntity.Character
end

function AttachmentEntityHandlerClass:Create(p, p2)
	local hash = p.Hash
	local kind = p.Type
	local attachmentEntityConfig = ResourceManager.GetAttachmentEntityConfig(kind)

	if not attachmentEntityConfig then
		warn("Missing attachment entity config")
		return
	end

	local effectFollowPart = EntityUtilities.GetEffectFollowPart(
		self.ParentCharacter,
		attachmentEntityConfig.AttachToHead,
		attachmentEntityConfig.AttachToGround
	)
	local goalCFrame, origin = self:_GetGoalCFrame(effectFollowPart, attachmentEntityConfig, p2)
	local character = GetCharacter(hash, kind, attachmentEntityConfig, goalCFrame, self.ParentCharacter, p2)
	local weldTorsoToPart = character:WeldTorsoToPart(effectFollowPart)

	if not attachmentEntityConfig.NoAnimations then
		character:SetAnimationState("Idle")
	end

	self.ActiveEntities[hash] = {
		Hash = hash,
		Config = attachmentEntityConfig,
		Origin = origin,
		Character = character,
		CharacterWeld = weldTorsoToPart
	}
end

function AttachmentEntityHandlerClass:_GetGoalCFrame(p, data, object, position: Vector3?)
	if not position then
		local position2 = p.Position

		if object then
			position = object:GetOriginCFrame().Position
		else
			position = position2 + Vector3.new(math.random(-100, 100), math.random(0, 50), math.random(-100, 100))
		end
	end

	local pointOnPartBounds = EntityUtilities.GetPointOnPartBounds(position, p)
	local cframe = CFrame.new(pointOnPartBounds, pointOnPartBounds + (pointOnPartBounds - position).Unit)

	if data.AttachToGround and data.OverrideProjectileCFrame then
		cframe = CFrame.new(p.Position)
	end

	if data.RotationOffset then
		cframe *= data.RotationOffset
	end

	return cframe, position
end

function AttachmentEntityHandlerClass.Remove(p, p2)
	local hash = p2.Hash
	local activeEntity = p.ActiveEntities[hash]

	if not activeEntity then
		print("Attachment entity not found")
		return
	end

	local character = activeEntity.Character
	character:HideCharacterModel()
	character:FadeOutEmitters()
	local delayedDespawn = p2.DelayedDespawn or 0
	task.delay(delayedDespawn, function()
		if not p.ActiveEntities[hash] then
			return
		end

		activeEntity.CharacterWeld:Destroy()
		character:Destroy()
		task.spawn(function()
			for _, part in character:GetCharacterModel():GetDescendants(), nil, nil do
				if not part:IsA("BasePart") or part.Massless then
					continue
				end

				local mass = part:GetMass()
				part.Parent = raycastIgnore
				part:ApplyImpulse(GetRandomInitialVelocity() * mass * 0.32) -- inferred equivalent call
				part:ApplyAngularImpulse(GetRandomInitialAngularImpulse() * mass * 0.32) -- inferred equivalent call
			end
		end)
		p.ActiveEntities[hash] = nil
	end)
end

function AttachmentEntityHandlerClass:Run(p: number)
	for _, activeEntity in pairs(self.ActiveEntities) do
		activeEntity.Character:Run(p)
	end
end

function AttachmentEntityHandlerClass:SetSpeedMultiplier(p: number)
	for _, activeEntity in pairs(self.ActiveEntities) do
		activeEntity.Character:SetSpeedMultiplier(p)
	end
end

function AttachmentEntityHandlerClass:CharacterModelChanged()
	for _, activeEntity in pairs(self.ActiveEntities) do
		local character = activeEntity.Character
		local config = activeEntity.Config
		local characterWeld = activeEntity.CharacterWeld
		local effectFollowPart = EntityUtilities.GetEffectFollowPart(
			self.ParentCharacter,
			config.AttachToHead,
			config.AttachToGround
		)
		local goalCFrame = self:_GetGoalCFrame(effectFollowPart, config, nil, activeEntity.Origin)
		characterWeld:Destroy()
		character:SetCFrame(goalCFrame, true)
		activeEntity.CharacterWeld = character:WeldTorsoToPart(effectFollowPart)
	end
end

return AttachmentEntityHandlerClass