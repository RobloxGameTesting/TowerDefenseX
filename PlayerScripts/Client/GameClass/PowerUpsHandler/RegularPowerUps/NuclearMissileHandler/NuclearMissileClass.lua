local NuclearMissileClass = {}
NuclearMissileClass.__index = NuclearMissileClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
require(common.Resources.Misc.RegularPowerUps.NuclearMissile.Types)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local nuclearMissile = common.Resources.Misc.RegularPowerUps.NuclearMissile.NuclearMissile
local explosionVFXPart = common.Resources.Misc.RegularPowerUps.NuclearMissile.ExplosionVFXPart
local NukeSiren = workspace.Terrain:WaitForChild("NukeSiren")

function NuclearMissileClass.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local position = data.End
	local totalTime = data.TotalTime
	local v = position - start
	local clone = nuclearMissile:Clone()
	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(start, start - v)
	clone.Parent = raycastIgnore
	local clone2 = explosionVFXPart:Clone()
	clone2.Parent = raycastIgnore
	clone2.Position = position
	local trails = { clone:FindFirstChild("TrailPart"):FindFirstChild("Trail") }
	local idleSFX = clone:FindFirstChild("IdleSFX")
	local soundWrapper = WrapperFactory.NewSoundWrapper(idleSFX, speedMultiplier)
	local hitSFX = clone:FindFirstChild("HitSFX")
	local soundWrapper2 = WrapperFactory.NewSoundWrapper(hitSFX, speedMultiplier)
	local emitterWrapper = WrapperFactory.NewEmitterWrapper(clone2:FindFirstChild("A"), speedMultiplier)
	local emitterWrapper2 = WrapperFactory.NewEmitterWrapper(clone2:FindFirstChild("B"), speedMultiplier)
	local emitterWrapper3 = WrapperFactory.NewEmitterWrapper(clone2:FindFirstChild("C"), speedMultiplier)
	local emitterWrapper4 = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier)
	local stem = clone2:FindFirstChild("Stem")
	local emitterWrapper5 = WrapperFactory.NewEmitterWrapper(nil, speedMultiplier)
	emitterWrapper5:AddEmitter(stem, speedMultiplier)

	for _, emitter in pairs(clone2:GetChildren()) do
		if emitter:IsA("ParticleEmitter") and emitter ~= stem then
			emitterWrapper4:AddEmitter(emitter, speedMultiplier)
		end
	end

	local v2 = {
		Hash = hash,
		Player = child,
		Start = start,
		End = position,
		TimePassed = 0,
		TotalTime = totalTime,
		SpeedMultiplier = speedMultiplier,
		Destroyed = false,
		ObjModel = clone,
		ExplosionVFXPart = clone2,
		Root = primaryPart,
		Trails = trails,
		Hit = false,
		StemEmitter = stem,
		StemTimeUntilTransparent = 21,
		StemTotalTimeUntilTransparent = 21,
		_TimingHelpers = {
			Stage1 = TimingHelperClass.New({
				TimeUntilCallback = 2,
				Callback = function()
					emitterWrapper:PlayAll()
				end
			}),
			Stage2 = TimingHelperClass.New({
				TimeUntilCallback = 3,
				Callback = function()
					emitterWrapper2:PlayAll()
				end
			}),
			Stage3 = TimingHelperClass.New({
				TimeUntilCallback = 4,
				Callback = function()
					emitterWrapper3:PlayAll()
				end
			}),
			Stem = TimingHelperClass.New({
				TimeUntilCallback = 20,
				Callback = function()
					emitterWrapper5:StopContinuous()
				end
			})
		},
		_Wrappers = {
			IdleSFXWrapper = soundWrapper,
			HitSFXWrapper = soundWrapper2,
			Stage1 = emitterWrapper,
			Stage2 = emitterWrapper2,
			Stage3 = emitterWrapper3,
			Stem = emitterWrapper5,
			MiscVFX = emitterWrapper4
		}
	}
	setmetatable(v2, NuclearMissileClass)
	v2:_ScaleTrails()
	v2._Wrappers.IdleSFXWrapper:PlayAll()
	NukeSiren:Play()

	for _, v3 in pairs(trails) do
		v3.Enabled = true
	end

	return v2
end

function NuclearMissileClass:Run(p: number)
	self.TimePassed += p

	if self.Hit then
		self.StemTimeUntilTransparent -= p
		local v = 1 - self.StemTimeUntilTransparent / self.StemTotalTimeUntilTransparent
		self.StemEmitter.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.0271, 1, 0),
			NumberSequenceKeypoint.new(0.111, 1.3 * v, 0.133),
			NumberSequenceKeypoint.new(1, 1, 0)
		})
	else
		local v = self.End - self.Start
		self.Position = self.Start:Lerp(self.End, (math.min(1, self.TimePassed / self.TotalTime)))
		self.Root.CFrame = CFrame.new(self.Position, self.Position - v)
		local baseMotor6D = self.Root:FindFirstChild("BaseMotor6D")

		if baseMotor6D then
			baseMotor6D.C0 *= CFrame.Angles(0, 0, p * 1.5707963267948966)
		end

		if self.TimePassed >= self.TotalTime then
			self:_Hit()
		end
	end

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function NuclearMissileClass.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function NuclearMissileClass:Destroy()
	self.ObjModel:Destroy()
	self.ExplosionVFXPart:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function NuclearMissileClass:ReceiveUpdate(p: string, _)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "Hit" and not self.Hit then
		self:_Hit()
	end
end

function NuclearMissileClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
	self:_ScaleTrails()
end

function NuclearMissileClass:_ScaleTrails()
	for _, trail in pairs(self.Trails) do
		trail.Lifetime = 2 / math.max(self.SpeedMultiplier, 0.1)
	end
end

function NuclearMissileClass:_Hit()
	self.Hit = true

	for _, part in pairs(self.ObjModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = 1
		end
	end

	self._TimingHelpers.Stage1:Start()
	self._TimingHelpers.Stage2:Start()
	self._TimingHelpers.Stage3:Start()
	self._TimingHelpers.Stem:Start()
	self._Wrappers.IdleSFXWrapper:StopContinuous()
	self._Wrappers.HitSFXWrapper:PlayAll()
	self._Wrappers.Stem:PlayAll()
	self._Wrappers.MiscVFX:PlayAll()
end

return NuclearMissileClass