local AnimationHandlerClass = {}
AnimationHandlerClass.__index = AnimationHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("CustomCodeTypes"))
local Utilities = require(common:WaitForChild("Utilities"))
local MapUtilities = require(common:WaitForChild("MapUtilities"))
local AnimationClass = require(script:WaitForChild("AnimationClass"))
local v = {}

local function WarnAnimationNotFound(characterType: string, characterModelName: string, p: string) -- 2 equivalent calls inferred from this helper
	if not p then
		return
	end

	local v2 = characterType .. " model " .. characterModelName .. " missing animation " .. tostring(p)

	if not v[v2] then
		print(v2)
		v[v2] = true
	end
end

local function AddPhysicalAnimations(p, instance, p2)
	for _, animation in pairs(instance:GetChildren()) do
		if not animation:IsA("Animation") then
			continue
		end

		local name = animation.Name

		if p2 and p2[name] then
			continue
		end

		local v2 = Utilities.TryReadChildValue(animation, "Index", nil)

		if v2 then
			if not p[name] then
				p[name] = {}
			end

			p[name][v2] = animation
		else
			p[name] = animation
		end
	end
end

local function GetMapOverrideAnimationsFolder(instance) -- 1 equivalent call inferred from this helper
	local mapAnimations = instance:FindFirstChild("MapAnimations")

	if not mapAnimations then
		return nil
	end

	local mapName = workspace:GetAttribute("MapName")
	return mapName and mapAnimations:FindFirstChild(MapUtilities.GetResourceMapName(mapName))
end

local function GetPhysicalAnimations(instance)
	local animations = instance:FindFirstChild("Animations")
	assert(animations, "Character model for " .. instance.Name .. " did not have an animations folder")
	local v2 = {}
	local mapOverrideAnimationsFolder = GetMapOverrideAnimationsFolder(instance) -- inferred equivalent call

	if not mapOverrideAnimationsFolder then
		AddPhysicalAnimations(v2, animations)
		return v2
	end

	AddPhysicalAnimations(v2, mapOverrideAnimationsFolder)
	local v3 = {}

	for k in pairs(v2) do
		v3[k] = true
	end

	AddPhysicalAnimations(v2, animations, v3)
	return v2
end

local function GetOverrideAnimator(parent) -- 1 equivalent call inferred from this helper
	local humanoid = parent:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	Utilities.SetModelCollisionGroup(parent, Enums.CollisionGroups.PlayerCharacters)
	return humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
end

local function LoadAnimations(p: string, p2, parent, items, p3: number, p4: number)
	local overrideAnimator = GetOverrideAnimator(parent) -- inferred equivalent call

	if not overrideAnimator then
		local animationController = Instance.new("AnimationController", parent)
		overrideAnimator = Instance.new("Animator", animationController)
	end

	local result = {}

	local function LoadAnimationInner(p5, flag: boolean)
		if p5.AnimationId == "" then
			Utilities.WarnEmptyAnimationOnce(parent, p5)
			return
		end

		local v2 = p5.Name:find("^Attack")
		local v3 = p5.Name == "Move"
		local v4 = AnimationClass.New(p5.Name, p, p2, parent, overrideAnimator, p5, p3, v3 and p4 or 1, v2)

		if not flag then
			result[p5.Name] = v4
			return
		end

		if not result[p5.Name] then
			result[p5.Name] = {}
		end

		table.insert(result[p5.Name], v4)
	end

	for _, item in pairs(items) do
		if typeof(item) == "table" then
			for _, v2 in ipairs(item) do
				LoadAnimationInner(v2, true)
			end
		elseif item.AnimationId == "" then
			Utilities.WarnEmptyAnimationOnce(parent, item)
		else
			local v2 = item.Name:find("^Attack")
			local v3 = item.Name == "Move"
			local v4 = AnimationClass.New(item.Name, p, p2, parent, overrideAnimator, item, p3, v3 and p4 or 1, v2)
			result[item.Name] = v4
		end
	end

	return result
end

local function GetAnimationsFlattened(items)
	local result = {}

	for _, item in pairs(items) do
		if item.Name then
			table.insert(result, item)
		else
			for _, v2 in pairs(item) do
				table.insert(result, v2)
			end
		end
	end

	return result
end

function AnimationHandlerClass.New(hash: number, characterType: string, entityClass: string, p, p2, p3: number, value: number?, p4: number?)
	local animations = LoadAnimations(entityClass, p, p2, GetPhysicalAnimations(p2), p3, value or 1)
	local v2 = nil
	local v3

	if entityClass == "Tower" then
		v3 = "Idle"
	elseif entityClass == "Enemy" then
		v3 = "Move"
	elseif entityClass == "PathEntity" then
		v3 = p.StopToAttack and "Idle" or "Move"
	elseif entityClass == "StaticEntity" then
		v3 = "Idle"
	elseif entityClass == "AttachmentEntity" then
		v3 = "Idle"
	elseif entityClass == "MapEntity" then
		v3 = "Idle"
	else
		v3 = v2
	end

	local v4 = {
		Hash = hash,
		RandomHash = p4 or hash,
		EntityClass = entityClass,
		CharacterType = characterType,
		CharacterModelName = p2.Name,
		State = nil,
		DefaultState = v3,
		OriginalDefaultState = v3,
		CurrentAnimation = nil,
		BackgroundAnimation = nil,
		Animations = animations,
		AnimationsFlattened = GetAnimationsFlattened(animations),
		CustomCode = nil
	}
	setmetatable(v4, AnimationHandlerClass)

	for _, v5 in pairs(v4.AnimationsFlattened) do
		v5:SetAnimationHandler(v4)
	end

	return v4
end

function AnimationHandlerClass:Run(p: number)
	for _, v2 in pairs(self.AnimationsFlattened) do
		v2:Run(p)
	end
end

function AnimationHandlerClass:SetHash(hash: number)
	self.Hash = hash
end

function AnimationHandlerClass:InitializeWithCharacter(p)
	for _, v2 in pairs(self.AnimationsFlattened) do
		v2:InitializeWithCharacter(p)
	end
end

function AnimationHandlerClass:SetSpeedMultiplier(p: number)
	for _, v2 in pairs(self.AnimationsFlattened) do
		v2:SetSpeedMultiplier(p)
	end
end

function AnimationHandlerClass:SetAnimationStateSpeed(p: string, p2: number)
	for k, animation in pairs(self.Animations) do
		if k ~= p then
			continue
		end

		if animation.Name then
			animation:SetAnimationSpeed(p2)

			if animation.NextAnimationState then
				self:SetAnimationStateSpeed(animation.NextAnimationState, p2)
			end
		else
			for _, v2 in pairs(animation) do
				v2:SetAnimationSpeed(p2)

				if v2.NextAnimationState then
					self:SetAnimationStateSpeed(v2.NextAnimationState, p2)
				end
			end
		end
	end
end

function AnimationHandlerClass:SetAttackAnimationSpeed(p: number)
	self:SetAnimationStateSpeed("Attack", p)
	self:SetAnimationStateSpeed("Reload", p)
end

function AnimationHandlerClass:SetMovementAnimationSpeed(p: number)
	self:SetAnimationStateSpeed("Move", p)
	self:SetAnimationStateSpeed("Idle", p)

	for k, animation in pairs(self.Animations) do
		if animation.Name then
			if animation:HasAnimationCalibratedSpeed() then
				self:SetAnimationStateSpeed(k, p)
			end
		else
			for _, v2 in pairs(animation) do
				if not v2:HasAnimationCalibratedSpeed() then
					continue
				end

				self:SetAnimationStateSpeed(k, p)
				break
			end
		end
	end
end

function AnimationHandlerClass:SetCustomCode(customCode)
	self.CustomCode = customCode
end

function AnimationHandlerClass:_TriggerCustomCode(p: string, p2)
	if self.CustomCode then
		self.CustomCode:AnimationStateChanged(p, p2)
	end
end

function AnimationHandlerClass:Set(state: string, flag: boolean?, flag2: boolean?, flag3: boolean?, p: number?)
	if self.DefaultState ~= self.OriginalDefaultState then
		local v2 = (state or "") .. "_" .. self.DefaultState

		if self:GetAnimation(v2) then
			state = v2
		end
	end

	local animation = self:GetAnimation(state)

	if not animation then
		if not flag3 then
			WarnAnimationNotFound(self.CharacterType, self.CharacterModelName, state) -- inferred equivalent call
		end

		animation = self:GetAnimation(self.DefaultState)
	end

	if state == self.DefaultState and self.CurrentAnimation and not self.CurrentAnimation:CanInterrupt() then
		if not (self.CurrentAnimation:IsLooped() or flag2 or self.CurrentAnimation:IsPaused()) then
			return false
		end

		local nextAnimationState = self.CurrentAnimation:GetNextAnimationState()

		if nextAnimationState then
			animation = self:GetAnimation(nextAnimationState)
			state = nextAnimationState
		end
	end

	local v2 = false

	if animation == self.CurrentAnimation then
		if animation and not animation:IsLooped() then
			animation:Play(nil, p)
			v2 = true
		end
	else
		local currentAnimation = self.CurrentAnimation
		self.CurrentAnimation = nil

		if animation:IsAdditive() then
			if currentAnimation and not currentAnimation:IsAdditive() then
				self.BackgroundAnimation = currentAnimation
			end
		else
			if currentAnimation then
				currentAnimation:Stop()
			end

			local backgroundAnimation = self.BackgroundAnimation

			if backgroundAnimation and backgroundAnimation ~= animation then
				backgroundAnimation:Stop()
			end

			self.BackgroundAnimation = nil
		end

		animation:Play(flag, p)
		self.CurrentAnimation = animation
		self.State = state
		v2 = true
	end

	if v2 and not flag3 then
		self:_TriggerCustomCode(state, animation)
	end

	return v2
end

function AnimationHandlerClass.GetState(p)
	return p.State
end

function AnimationHandlerClass:GetAnimation(p: string)
	local animation = self.Animations[p]

	if not animation then
		return
	end

	if animation.Name then
		return animation
	end

	local v2 = #animation
	return animation[(self.RandomHash - 1) % v2 + 1]
end

function AnimationHandlerClass:NotLoopedAnimationFinished(object, flag: boolean?)
	if self.CurrentAnimation == object then
		if flag then
			self:Set(self.CurrentAnimation.Name)
			return
		end

		local nextAnimationState = object:GetNextAnimationState()

		if nextAnimationState then
			self:Set(nextAnimationState, nil, true)
		else
			self:Set(self.DefaultState, nil, true)
		end
	end
end

function AnimationHandlerClass.SetCurrentAnimationTimePosition(p, p2: number)
	if p.CurrentAnimation then
		p.CurrentAnimation:SetTimePosition(p2)
	end
end

function AnimationHandlerClass.PauseCurrentAnimation(p)
	if p.CurrentAnimation then
		p.CurrentAnimation:Pause()
	end
end

function AnimationHandlerClass:OverrideAnimation(p: string, p2: string)
	self.Animations[p] = self.Animations[p2]

	if self.State == p then
		self:Set(p2)
	end
end

function AnimationHandlerClass:OverrideDefaultState(defaultState: string, flag: boolean?)
	if self.Animations[defaultState] then
		self.DefaultState = defaultState

		if self.State == self.OriginalDefaultState then
			self:Set(defaultState)
		end
	elseif not flag then
		WarnAnimationNotFound(self.CharacterType, self.CharacterModelName, defaultState) -- inferred equivalent call
	end
end

function AnimationHandlerClass:ResetDefaultStateOverride()
	if self.DefaultState == self.OriginalDefaultState then
		return
	end

	if self.State == self.DefaultState then
		self:Set(self.OriginalDefaultState)
	end

	self.DefaultState = self.OriginalDefaultState
end

function AnimationHandlerClass:PlayAnimationLowPriority(p: string)
	local animation = self:GetAnimation(p)

	if animation then
		animation:SetPriority(Enum.AnimationPriority.Idle)
		animation:Play(true)
	end
end

function AnimationHandlerClass:Destroy()
	for _, v2 in pairs(self.AnimationsFlattened) do
		v2:Destroy()
	end
end

return AnimationHandlerClass