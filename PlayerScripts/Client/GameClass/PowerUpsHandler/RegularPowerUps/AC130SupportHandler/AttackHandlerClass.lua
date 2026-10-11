local AttackHandlerClass = {}
AttackHandlerClass.__index = AttackHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common.Resources.Misc.RegularPowerUps.AC130Support.Types)
local VisualEffectHandler = require(script.Parent.Parent.Parent.Parent:WaitForChild("VisualEffectHandler"))

local function GetAttackModel(instance, childName: string) -- 3 equivalent calls inferred from this helper
	local child = instance:FindFirstChild(childName)

	if not child then
		warn(`Attack model with name {childName} not found`)
	end

	return child
end

local function GetBarrel(instance, childName: string)
	local attackModel = GetAttackModel(instance, childName) -- inferred equivalent call

	if not attackModel then
		return
	end

	local barrel = attackModel:FindFirstChild("Barrel")

	if barrel then
		return barrel
	end

	warn(`Attack model with name {childName} missing barrel`)
end

local function GetAnimation(instance, childName: string)
	local attackModel = GetAttackModel(instance, childName) -- inferred equivalent call

	if not attackModel then
		return
	end

	local animation = attackModel:FindFirstChildOfClass("Animation")

	if not animation then
		return
	end

	local animationController = Instance.new("AnimationController", attackModel)
	return (Instance.new("Animator", animationController):LoadAnimation(animation))
end

local function AimWeaponThroughMotor6D(motor6D, torsoPosition: Vector3) -- 1 equivalent call inferred from this helper
	local part0 = motor6D.Part0
	local part1 = motor6D.Part1
	local v = CFrame.new(part1.Position, torsoPosition) * CFrame.Angles(0, 1.5707963267948966, 0)
	motor6D.C0 = part0.CFrame:Inverse() * v * motor6D.C1
end

function AttackHandlerClass.New(instance, childName: string, p, speedMultiplier: number)
	local primaryPart = instance.PrimaryPart
	local primaryPart2 = GetAttackModel(instance, childName).PrimaryPart -- inferred equivalent call
	local child = primaryPart:FindFirstChild(childName .. "Anchor")
	local child2 = instance:FindFirstChild(childName)

	if not child2 then
		warn(`Attack model with name {childName} not found`)
	end

	local barrel

	if child2 then
		barrel = child2:FindFirstChild("Barrel")

		if not barrel then
			warn(`Attack model with name {childName} missing barrel`)
			barrel = nil
		end
	end

	local animation = GetAnimation(instance, childName)
	return (setmetatable({
		PlaneModel = instance,
		AttackName = childName,
		ExplosionName = p.ExplosionName,
		SoundWrapper = WrapperFactory.NewSoundWrapper(barrel, speedMultiplier),
		EmitterWrapper = WrapperFactory.NewEmitterWrapper(barrel, speedMultiplier),
		Animation = animation,
		SpeedMultiplier = speedMultiplier,
		Motor6D = child,
		AttackRoot = primaryPart2
	}, AttackHandlerClass))
end

function AttackHandlerClass.HandleAttack(data, object)
	data.SoundWrapper:PlayAll()
	data.EmitterWrapper:PlayAll()
	local torsoPosition = object:GetIsAirUnit() and object:GetTorsoPosition() or object:GetPosition()
	AimWeaponThroughMotor6D(data.Motor6D, torsoPosition) -- inferred equivalent call

	if data.Animation then
		data.Animation:Play(nil, nil, data.SpeedMultiplier)
	end

	local v = Vector3.new(math.random(-100, 100), 0, math.random(-100, 100)) * 0.015
	local v2 = {
		Name = data.ExplosionName,
		Position = torsoPosition + v
	}
	VisualEffectHandler.NewVisualEffect(v2)
end

function AttackHandlerClass:SpeedMultiplierChanged(speedMultiplier: number)
	self.SoundWrapper:SpeedMultiplierChanged(speedMultiplier)
	self.EmitterWrapper:SpeedMultiplierChanged(speedMultiplier)

	if self.Animation then
		self.Animation:AdjustSpeed(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

return AttackHandlerClass