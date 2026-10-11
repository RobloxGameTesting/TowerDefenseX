local FirstPersonCameraHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
local Spring = require(common:WaitForChild("Spring"))
local v = false
local character = nil
local torso = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local recoilConfig = nil
local class = {}

local function RandomVector3(camKickMin: Vector3, camKickMax: Vector3) -- 1 equivalent call inferred from this helper
	return camKickMin + Vector3.new(math.random(), math.random(), math.random()) * (camKickMax - camKickMin)
end

local function GetHeadHeight() -- 1 equivalent call inferred from this helper
	if v4.UseHoverHeightForHeadHeight then
		return character:GetCurrentHoverHeight()
	end

	if v4.HeadHeight then
		return v4.HeadHeight
	end

	return 0
end

function FirstPersonCameraHandler.SetTower(player, p)
	v = true
	character = player.Character
	torso = player.Character:GetTorso()
	v2 = p
	local zoomOptions = v2.ZoomOptions

	if zoomOptions and #zoomOptions > 0 then
		FirstPersonCameraHandler.SetFOV(zoomOptions[1])
	else
		FirstPersonCameraHandler.SetFOV(70)
	end
end

function FirstPersonCameraHandler.RemoveTower()
	v = false
	FirstPersonCameraHandler.SetFOV(70)
	class.CurrentCamera.FieldOfView = 70
end

function FirstPersonCameraHandler.SwitchAttackHandler(p: number)
	v4 = v2.AttackConfigs[p]

	if not v4 then
		warn("FirstPersonCameraHandler.SwitchAttackHandler - Invalid attack handler index: " .. tostring(p))
	end

	v5 = GetHeadHeight() -- inferred equivalent call
	recoilConfig = v4.RecoilConfig

	if recoilConfig then
		class.ShakeSpring.Speed = recoilConfig.CamKickSpeed
	end
end

function FirstPersonCameraHandler.ShotFired()
	if recoilConfig then
		class.ShakeSpring:Accelerate(RandomVector3(recoilConfig.CamKickMin, recoilConfig.CamKickMax)) -- inferred equivalent call
	end
end

function FirstPersonCameraHandler.GetFacePosition()
	return class.FacePosition
end

function FirstPersonCameraHandler.GetCFrame()
	return class.CurrentCamera.CFrame
end

function FirstPersonCameraHandler:MouseMoved()
	class:MouseMoved(self.Delta)
end

function FirstPersonCameraHandler:TouchMoved()
	class:TouchMoved(self.Delta)
end

function FirstPersonCameraHandler:GamepadMoved()
	if self.KeyCode == Enum.KeyCode.Thumbstick2 then
		local position = self.Position
		local magnitude = position.Magnitude
		local vector = Vector3.new(position.X, -position.Y, position.Z)

		if magnitude > 0.1 then
			v3 = (1 - 0.1 / magnitude) / 0.9 * vector
		elseif v3 then
			v3 = nil
		end
	end
end

function FirstPersonCameraHandler.OnRenderStepped(p: number, _: number)
	if v3 then
		class:GamepadMoved(p * v3, p)
	end

	class.step(p)
end

function FirstPersonCameraHandler.SetFOV(baseFOV: number)
	class.BaseFOV = baseFOV
end

function FirstPersonCameraHandler.SetSpeedMultiplier(speedMultiplier: number)
	class.ShakeSpring.SpeedMultiplier = speedMultiplier
	class.MagSpring.SpeedMultiplier = speedMultiplier
	class.SwaySpring.SpeedMultiplier = speedMultiplier
end

local log = math.log
local cos = math.cos
local tick = tick
local new = Vector3.new
local new2 = CFrame.new
local Angles = CFrame.Angles
local vector = new()
local tan = math.tan
local atan = math.atan
class.senvalue = -1
class.CurrentCamera = game.Workspace.CurrentCamera
class.sensitivity = 0.5
class.sensitivitymult = 2 ^ (class.senvalue / 2)
class.controllermult = 1
class.BaseFOV = 70
class.angles = vector
class.maxangle = 1.4726215563702154
class.minangle = -1.4726215563702154
class.ShakeSpring = Spring.New(vector)
class.MagSpring = Spring.New(0)
class.SwaySpring = Spring.New(0)
class.Delta = vector
class.FacePosition = vector
local v6 = 1 / 60
local v7 = false
class.ShakeSpring.Speed = 12
class.ShakeSpring.Damper = 0.65
class.MagSpring.Speed = 12
class.MagSpring.Damper = 1
class.SwaySpring.Speed = 4
class.SwaySpring.Damper = 1

function class.Shake(_, p)
	class.ShakeSpring:Accelerate(p)
end

function class.Magnify(_, p)
	class.MagSpring.Target = log(p)
end

function class.SetSway(_, target)
	class.SwaySpring.Target = target
end

function class:_UpdateAngles(p: number, vector2: Vector3)
	v7 = true
	local vector3 = new(
		math.clamp(class.angles.X - p * vector2.Y, class.minangle, class.maxangle),
		class.angles.Y - p * vector2.X,
		0
	)
	class.Delta = (vector3 - class.angles) / v6
	class.angles = vector3
end

function class:MouseMoved(vector2: Vector3)
	class:_UpdateAngles(
		class.sensitivity * class.sensitivitymult * atan(tan(class.BaseFOV * 0.017453292519943295 / 2) / 2.718281828459045 ^ class.MagSpring.Position) / 100.53096491487338,
		vector2
	)
end

function class:TouchMoved(vector2: Vector3)
	class:_UpdateAngles(
		3 * class.sensitivity * class.sensitivitymult * atan(tan(class.BaseFOV * 0.017453292519943295 / 2) / 2.718281828459045 ^ class.MagSpring.Position) / 100.53096491487338,
		vector2
	)
end

function class:GamepadMoved(vector2: Vector3, p: number)
	class:_UpdateAngles(
		1500 * vector2.Magnitude / p * class.sensitivity * class.controllermult * class.sensitivitymult * atan(tan(class.BaseFOV * 0.017453292519943295 / 2) / 2.718281828459045 ^ class.MagSpring.Position) / 100.53096491487338,
		vector2
	)
end

local function fromaxisangle(position, y, z)
	if not y then
		local x = position.X
		y = position.Y
		z = position.Z
		position = x
	end

	local v8 = (position * position + y * y + z * z) ^ 0.5

	if not (v8 > 0.00001) then
		return CFrame.new()
	end

	local v9 = math.sin(v8 / 2) / v8
	return new2(0, 0, 0, v9 * position, v9 * y, v9 * z, (cos(v8 / 2)))
end

function class.step(p)
	v6 = p

	if not v7 then
		class.Delta = vector
	end

	v7 = false

	if not v then
		return
	end

	local now = tick()
	local position = class.SwaySpring.Position
	local vector2 = new(0, v5, 0)
	local cframe = Angles(0, class.angles.Y, 0) * Angles(class.angles.X, 0, 0) * fromaxisangle(class.ShakeSpring.Position) * fromaxisangle(
		position * cos(2 * now + 2) / 2048,
		position * cos(2 * now / 2) / 2048,
		position * cos(2 * now / 2 - 2) / 4096
	) * new2(0, 0, 0.5) + torso.CFrame * vector2
	local currentCamera = class.CurrentCamera
	currentCamera.FieldOfView = atan(tan(class.BaseFOV * 0.017453292519943295 / 2) / 2.718281828459045 ^ class.MagSpring.Position) * 2 / 0.017453292519943295
	class.CurrentCamera.CFrame = cframe
	class.FacePosition = torso.Position + vector2 + 100 * cframe.LookVector
end

return FirstPersonCameraHandler