local DamageFieldClass = {}
DamageFieldClass.__index = DamageFieldClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common.Resources.Misc.RegularPowerUps.DamageField.Types)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local modelTemplate = common.Resources.Misc.RegularPowerUps.DamageField.ModelTemplate

function DamageFieldClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local location = data.Location
	local totalTime = data.TotalTime
	local clone = modelTemplate:Clone()
	clone.Name = modelTemplate.Parent.Name
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(location)
	clone.Parent = raycastIgnore
	local v = {
		Hash = hash,
		Player = child,
		TimePassed = 0,
		TotalTime = totalTime,
		SpeedMultiplier = speedMultiplier,
		Destroyed = false,
		Model = clone,
		Root = primaryPart,
		_TimingHelpers = {},
		_Wrappers = {
			DamageEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(clone, speedMultiplier)
		}
	}

	for _, wrapper in pairs(v._Wrappers) do
		wrapper:PlayAll()
	end

	setmetatable(v, DamageFieldClass)
	return v
end

function DamageFieldClass:Run(p: number)
	self.TimePassed += p

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function DamageFieldClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function DamageFieldClass:Destroy()
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:StopContinuous()
	end

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end

	task.delay(3, function()
		self.Model:Destroy()
	end)
	self.Destroyed = true
end

function DamageFieldClass:ReceiveUpdate(p: string, _)
	if p == "Destroy" then
		self:Destroy()
	end
end

function DamageFieldClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

return DamageFieldClass