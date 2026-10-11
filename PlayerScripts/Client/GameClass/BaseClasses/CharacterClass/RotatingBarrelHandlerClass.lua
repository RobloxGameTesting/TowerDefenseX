local RotatingBarrelHandlerClass = {}
RotatingBarrelHandlerClass.__index = RotatingBarrelHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Utilities = require(common:WaitForChild("Utilities"))
require(common:WaitForChild("WrapperFactory"))
local v = false

local function IsBarrelWeld(instance) -- 3 equivalent calls inferred from this helper
	return instance:IsA("JointInstance") or instance:IsA("Bone")
end

local function FindBarrelWeld(p, p2: string)
	local v2 = Utilities.TryGetInstanceFromPath(p, p2)

	if not v2 or IsBarrelWeld(v2) then -- inferred equivalent call
		return v2
	end

	for _, child in pairs(v2.Parent:GetChildren()) do
		if child.Name == v2.Name and IsBarrelWeld(child) then -- inferred equivalent call
			return child
		end
	end

	return v2
end

function RotatingBarrelHandlerClass.New(instance, data, flag: boolean?, p)
	local pathToBarrelWeld = data.PathToBarrelWeld
	local weld = nil

	if pathToBarrelWeld then
		weld = FindBarrelWeld(instance, pathToBarrelWeld) or p and FindBarrelWeld(p, pathToBarrelWeld)
	else
		local instance2 = Utilities.TryGetInstanceFromPath(instance, data.WeldPointerName)

		if not instance2 then
			warn("RotatingBarrelHandlerClass: WeldPointerName not found in", instance:GetFullName())
			return
		end

		if instance2:IsA("ObjectValue") then
			weld = instance2.Value
		elseif instance2:IsA("StringValue") then
			weld = FindBarrelWeld(instance, instance2.Value) or p and FindBarrelWeld(p, instance2.Value)
		end
	end

	if not weld then
		warn("RotatingBarrelHandlerClass: Weld not found in", instance:GetFullName())
		return
	end

	if IsBarrelWeld(weld) then -- inferred equivalent call
		return (setmetatable({
			UseC0 = not flag,
			Weld = weld,
			WeldIsBone = weld:IsA("Bone"),
			TimeSinceLastAttack = 1e999,
			TimeToMaxRotationSpeed = data.TimeToMaxRotationSpeed,
			TimeToSpinAfterShot = data.TimeToSpinAfterShot,
			TimeToStopRotation = data.TimeToStopRotation,
			MaxRotationSpeedX = instance:GetAttribute("MaxRotationSpeedX") or data.MaxRotationSpeedX or 0,
			MaxRotationSpeedY = instance:GetAttribute("MaxRotationSpeedY") or data.MaxRotationSpeedY or 0,
			MaxRotationSpeedZ = instance:GetAttribute("MaxRotationSpeedZ") or data.MaxRotationSpeedZ or 0,
			CurrentSpeedPercentage = 0
		}, RotatingBarrelHandlerClass))
	end

	warn("RotatingBarrelHandlerClass: Weld isn't a joint or bone:", weld:GetFullName())
end

function RotatingBarrelHandlerClass.ToggleOscillation()
	v = not v
end

function RotatingBarrelHandlerClass:Attacked(p: number?)
	self.TimeSinceLastAttack = p and -p or 0
end

function RotatingBarrelHandlerClass:Run(p: number)
	self.TimeSinceLastAttack += p
	local timeSinceLastAttack = self.TimeSinceLastAttack
	local weld = self.Weld
	local weldIsBone = self.WeldIsBone
	local timeToMaxRotationSpeed = self.TimeToMaxRotationSpeed
	local timeToSpinAfterShot = self.TimeToSpinAfterShot
	local timeToStopRotation = self.TimeToStopRotation
	local currentSpeedPercentage = self.CurrentSpeedPercentage
	local currentSpeedPercentage2

	if timeSinceLastAttack < timeToMaxRotationSpeed then
		currentSpeedPercentage2 = math.min(1, currentSpeedPercentage + p / timeToMaxRotationSpeed)
	else
		currentSpeedPercentage2 = timeSinceLastAttack < timeToSpinAfterShot and 1
			or math.max(0, currentSpeedPercentage - p / timeToStopRotation)
	end

	self.CurrentSpeedPercentage = currentSpeedPercentage2

	if currentSpeedPercentage2 > 0 and not v then
		local cframe = CFrame.Angles(
			self.MaxRotationSpeedX * currentSpeedPercentage2 * p,
			self.MaxRotationSpeedY * currentSpeedPercentage2 * p,
			self.MaxRotationSpeedZ * currentSpeedPercentage2 * p
		)

		if weldIsBone then
			weld.CFrame *= cframe
		elseif self.UseC0 then
			weld.C0 *= cframe
		else
			weld.Transform *= cframe
		end
	end
end

return RotatingBarrelHandlerClass