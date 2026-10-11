local UberFieldClass = {}
UberFieldClass.__index = UberFieldClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common.Resources.Misc.RegularPowerUps.UberField.Types)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local modelTemplate = common.Resources.Misc.RegularPowerUps.UberField.ModelTemplate

function UberFieldClass.New(data, speedMultiplier: number)
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
			RangeEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(clone, speedMultiplier)
		}
	}

	for _, wrapper in pairs(v._Wrappers) do
		wrapper:PlayAll()
	end

	setmetatable(v, UberFieldClass)
	return v
end

function UberFieldClass:Run(p: number)
	self.TimePassed += p

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function UberFieldClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function UberFieldClass:Destroy()
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

function UberFieldClass:ReceiveUpdate(p: string, _)
	if p == "Destroy" then
		self:Destroy()
	end
end

function UberFieldClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

return UberFieldClass