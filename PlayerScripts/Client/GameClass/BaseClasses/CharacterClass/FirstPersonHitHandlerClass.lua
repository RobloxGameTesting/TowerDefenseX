local createVector = vector.create
local FirstPersonHitHandlerClass = {}
FirstPersonHitHandlerClass.__index = FirstPersonHitHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("Utilities"))
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(66, 220, 255)
local color3 = Color3.fromRGB(255, 247, 12)
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.03, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local miscResource = ResourceManager.GetMiscResource("Torso", true)
local miscResource2 = ResourceManager.GetMiscResource("FPSDamageIndicator", true)
local damageNumbers = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore"):WaitForChild("DamageNumbers")

function FirstPersonHitHandlerClass.New(realTorso)
	local clone = miscResource:Clone()
	clone.Name = "AdorneePart"
	clone.Size = realTorso.Size
	clone.Parent = damageNumbers
	local clone2 = miscResource2:Clone()
	clone2.Parent = clone
	clone2.Adornee = clone
	clone2.Enabled = false
	local textLabel = clone2:FindFirstChild("TextLabel")
	local v = {
		RealTorso = realTorso,
		AdorneePart = clone,
		Indicator = clone2,
		TextLabel = textLabel,
		UIStroke = textLabel:FindFirstChild("UIStroke"),
		SolidTimeLeft = 0,
		FadeOutTimeLeft = 0,
		TimeSinceLastDamage = 0,
		AccumulatedDamage = 0,
		LastDamageAmount = 0,
		LastDamageHitsLanded = 1,
		MovementTimeLeft = 0,
		MovementTotalTime = 0,
		MovementGoal = nil,
		Destroyed = false,
		TimeUntilCleanUp = 3,
		CleanedUp = false
	}
	setmetatable(v, FirstPersonHitHandlerClass)
	local heartbeatConnection = nil
	heartbeatConnection = RunService.Heartbeat:Connect(function(dt: number)
		v:Run(dt)

		if v.Destroyed and not v.CleanedUp then
			if v.TimeUntilCleanUp > 0 then
				v.TimeUntilCleanUp -= dt
			else
				clone:Destroy()
				heartbeatConnection:Disconnect()
				v.CleanedUp = true
			end
		end
	end)
	return v
end

function FirstPersonHitHandlerClass:Hit(p: number, flag: boolean, flag2: boolean, _: boolean, vector: Vector3, flag3: boolean)
	if self.Destroyed then
		return
	end

	local realTorso = self.RealTorso
	local adorneePart = self.AdorneePart
	local indicator = self.Indicator
	local textLabel = self.TextLabel
	local uiStroke = self.UIStroke
	self.SolidTimeLeft = 0.6
	self.FadeOutTimeLeft = 0.3
	self.TimeSinceLastDamage = 0
	self.AccumulatedDamage += p
	adorneePart.CFrame = realTorso.CFrame
	local v = 2.5 - 1.5 / 1.05 ^ (0.0006 * self.AccumulatedDamage)
	textLabel.TextTransparency = 0
	textLabel.Text = tostring((math.ceil(self.AccumulatedDamage)))
	textLabel.Size = UDim2.new(0.1, 0, 0.1, 0)
	TweenService:Create(textLabel, self.SolidTimeLeft > 0 and tweenInfo2 or tweenInfo, {
		Size = UDim2.new(v, 0, v, 0)
	}):Play()

	if flag2 then
		textLabel.TextColor3 = color2
	elseif flag then
		textLabel.TextColor3 = color3
	else
		textLabel.TextColor3 = color
	end

	uiStroke.Transparency = 0
	self:_HandleHitOrigin(vector, flag3)
	indicator.Enabled = true
end

function FirstPersonHitHandlerClass:_HandleHitOrigin(_: Vector3, flag: boolean)
	local indicator = self.Indicator
	local movementGoal, v

	if flag then
		local unit = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)).Unit
		movementGoal = Vector3.new(unit.X, 0.7, unit.Z).Unit * (math.random(80, 120) / 10)
		indicator.StudsOffset = createVector(0, 1, 0)
		v = math.random(80, 100) / 10 * 0.6
	else
		indicator.StudsOffset = createVector(1.5, 1, 0)
		v = math.random(80, 100) / 10 * 0.15
		movementGoal = createVector(0, 1.5, 0)
	end

	self.MovementGoal = movementGoal
	self.MovementTotalTime = v
	self.MovementTimeLeft = v
end

function FirstPersonHitHandlerClass:Run(p: number)
	local indicator = self.Indicator
	local textLabel = self.TextLabel
	local uiStroke = self.UIStroke

	if self.AccumulatedDamage ~= 0 then
		self.TimeSinceLastDamage += p

		if self.TimeSinceLastDamage > 1.75 then
			self.AccumulatedDamage = 0
		end
	end

	local movementGoal = self.MovementGoal

	if movementGoal then
		self.MovementTimeLeft = math.max(0, self.MovementTimeLeft - p)
		indicator.StudsOffsetWorldSpace = (1 - self.MovementTimeLeft / self.MovementTotalTime) ^ 0.5 * movementGoal
	end

	if self.SolidTimeLeft > 0 then
		self.SolidTimeLeft = math.max(0, self.SolidTimeLeft - p)
	elseif self.FadeOutTimeLeft > 0 then
		self.FadeOutTimeLeft = math.max(0, self.FadeOutTimeLeft - p)
		local v = 1 - self.FadeOutTimeLeft / 0.3
		textLabel.TextTransparency = v
		uiStroke.Transparency = v

		if v <= 0 then
			indicator.Enabled = false
		end
	end
end

function FirstPersonHitHandlerClass:Destroy()
	self.Destroyed = true
end

return FirstPersonHitHandlerClass