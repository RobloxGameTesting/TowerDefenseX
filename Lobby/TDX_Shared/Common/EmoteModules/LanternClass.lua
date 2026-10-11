local TweenService = game:GetService("TweenService")
local LanternClass = {}
LanternClass.__index = LanternClass
local v = {
	UpwardForceMultiplier = 1.0025,
	TargetHeight = 5,
	BaseDriftStrength = 1.2,
	DriftChangeInterval = 2,
	YawRotationSpeed = 6,
	WobbleAmount = 8,
	WobbleSpeed = 0.8,
	Lifetime = 10,
	FadeTime = 3,
	FlickerSpeed = 0.08,
	FlickerVariance = 0.4
}

local function ApplySettings(p)
	local result = {}

	for k, v2 in pairs(v) do
		if p then
			v2 = p[k] or v2
		end

		result[k] = v2
	end

	return result
end

function LanternClass.new(model, p)
	assert(model.PrimaryPart, "Lantern model must have PrimaryPart")
	local object = setmetatable({}, LanternClass)
	object.Model = model
	object.PrimaryPart = model.PrimaryPart
	object.Settings = ApplySettings(p)
	object:_SetupPhysics()
	object:_StartOrientationUpdate()
	object:_StartDrift()
	object:_StartFlicker()
	object:_StartLifetime()
	return object
end

function LanternClass:_SetupPhysics()
	local primaryPart = self.PrimaryPart
	primaryPart.Anchored = false
	primaryPart.CanCollide = false
	local attachment = Instance.new("Attachment")
	attachment.Parent = primaryPart
	self.Attachment = attachment
	local vectorForce = Instance.new("VectorForce")
	vectorForce.Attachment0 = attachment
	vectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
	vectorForce.Force = Vector3.new(
		0,
		primaryPart:GetMass() * workspace.Gravity * self.Settings.UpwardForceMultiplier,
		0
	)
	vectorForce.Parent = primaryPart
	self.VectorForce = vectorForce
	local alignOrientation = Instance.new("AlignOrientation")
	alignOrientation.Attachment0 = attachment
	alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	alignOrientation.RigidityEnabled = false
	alignOrientation.Responsiveness = 5
	alignOrientation.MaxTorque = 1e999
	alignOrientation.Parent = primaryPart
	self.AlignOrientation = alignOrientation
end

function LanternClass:_StartOrientationUpdate()
	self._Time = 0
	self._CurrentYaw = 0
	self._TargetHeight = self.PrimaryPart.Position.Y + (self.Settings.TargetHeight or 100)
	task.spawn(function()
		while true do
			local v2 = task.wait()

			if not self.Model.Parent then
				break
			end

			self._Time += v2
			self._CurrentYaw += math.rad(self.Settings.YawRotationSpeed) * v2
			local v3 = math.rad(math.sin(self._Time * self.Settings.WobbleSpeed) * self.Settings.WobbleAmount)
			local v4 = math.rad(math.cos(self._Time * self.Settings.WobbleSpeed) * self.Settings.WobbleAmount)
			local cframe = CFrame.Angles(v3, self._CurrentYaw, v4) * CFrame.fromOrientation(0, 0, 3.141592653589793)
			self.AlignOrientation.CFrame = cframe

			if self._Falling or not (self.PrimaryPart.Position.Y >= self._TargetHeight) then
				continue
			end

			self._Falling = true
			local mass = self.PrimaryPart:GetMass()
			self.VectorForce.Force = Vector3.new(0, mass * workspace.Gravity * 0.999, 0)
		end
	end)
end

function LanternClass:_StartDrift()
	task.spawn(function()
		while self.Model.Parent do
			local v2 = math.random(-10, 10) / 10 * self.Settings.BaseDriftStrength
			local v3 = math.random(-10, 10) / 10 * self.Settings.BaseDriftStrength
			self.VectorForce.Force += Vector3.new(v2, 0, v3)
			task.wait(self.Settings.DriftChangeInterval)
		end
	end)
end

function LanternClass:_StartFlicker()
	local pointLight = self.PrimaryPart:FindFirstChildOfClass("PointLight")

	if not pointLight then
		return
	end

	pointLight.Enabled = true
	task.spawn(function()
		while self.Model.Parent do
			pointLight.Brightness = 2 + (math.random() - 0.5) * self.Settings.FlickerVariance
			task.wait(self.Settings.FlickerSpeed)
		end
	end)
end

function LanternClass:_StartLifetime()
	task.delay(self.Settings.Lifetime, function()
		self:_FadeAndDestroy()
	end)
end

function LanternClass:_FadeAndDestroy()
	for _, part in pairs(self.Model:GetDescendants()) do
		if part:IsA("BasePart") then
			TweenService:Create(part, TweenInfo.new(self.Settings.FadeTime), { Transparency = 1 }):Play()
		end
	end

	task.wait(self.Settings.FadeTime)
	self.Model:Destroy()
end

function LanternClass:Destroy()
	if self.Model then
		self.Model:Destroy()
	end
end

return LanternClass