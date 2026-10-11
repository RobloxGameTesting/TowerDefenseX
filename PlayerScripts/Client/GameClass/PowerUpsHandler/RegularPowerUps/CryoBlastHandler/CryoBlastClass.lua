local CryoBlastClass = {}
CryoBlastClass.__index = CryoBlastClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common.Resources.Misc.RegularPowerUps.CryoBlast.Types)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local modelTemplate = common.Resources.Misc.RegularPowerUps.CryoBlast.ModelTemplate

function CryoBlastClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local location = data.Location
	local totalTime = data.TotalTime
	local clone = modelTemplate:Clone()
	clone.Name = modelTemplate.Parent.Name
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(location)
	clone.Parent = raycastIgnore
	local beam = primaryPart:FindFirstChild("Beam")
	local hit = primaryPart:FindFirstChild("Hit")
	local summon = primaryPart:FindFirstChild("Summon")
	local v = {
		Hash = hash,
		Player = child,
		TimePassed = 0,
		TotalTime = totalTime,
		SpeedMultiplier = speedMultiplier,
		Destroyed = false,
		Model = clone,
		Root = primaryPart,
		Beam = beam,
		BeamOriginalTextureSpeed = beam.TextureSpeed,
		BeamHit = hit,
		Summon = summon,
		ImpactTimeLeft = 0.5,
		VFXStarted = false,
		_TimingHelpers = {},
		_Wrappers = {
			Effects = WrapperFactory.NewEmitterAndSoundWrapper(clone, speedMultiplier)
		}
	}
	hit.CFrame = CFrame.new(0, 300, 0)
	beam.TextureSpeed *= speedMultiplier
	beam.Enabled = true
	setmetatable(v, CryoBlastClass)
	return v
end

function CryoBlastClass:Run(p: number)
	self.TimePassed += p

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.ImpactTimeLeft > 0 then
		self.ImpactTimeLeft -= p
		self.BeamHit.CFrame = CFrame.new(0, 300 * (self.ImpactTimeLeft / 0.5) ^ 2, 0)
	else
		self.BeamHit.CFrame = CFrame.new(0, 0, 0)
	end

	if not self.VFXStarted and self.ImpactTimeLeft <= 0.25 then
		for _, wrapper in pairs(self._Wrappers) do
			wrapper:PlayAll()
		end

		self.VFXStarted = true
	end

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function CryoBlastClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function CryoBlastClass:Destroy()
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:StopContinuous()
	end

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end

	self.Beam.Enabled = false
	task.delay(3, function()
		self.Model:Destroy()
	end)
	self.Destroyed = true
end

function CryoBlastClass:ReceiveUpdate(p: string, _)
	if p == "Destroy" then
		self:Destroy()
	end
end

function CryoBlastClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.Beam.TextureSpeed = self.BeamOriginalTextureSpeed * speedMultiplier
	self.SpeedMultiplier = speedMultiplier
end

return CryoBlastClass