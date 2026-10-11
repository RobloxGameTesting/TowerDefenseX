local SpawnLandingHandlerClass = {}
SpawnLandingHandlerClass.__index = SpawnLandingHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local Utilities = require(common:WaitForChild("Utilities"))

function SpawnLandingHandlerClass.New(p)
	local spawnLandingData = p.SpawnLandingData
	assert(spawnLandingData, "SpawnLandingData is nil")
	return (setmetatable({
		LandEffectNames = spawnLandingData.LandEffectNames,
		LandingTimeLeft = spawnLandingData.Time,
		LandingTimeTotal = spawnLandingData.Time,
		StartHeight = spawnLandingData.StartHeight,
		LandingEffectWrapper = nil,
		TorsoToRootWeld = nil,
		OriginalTorsoToRootWeldC0 = nil
	}, SpawnLandingHandlerClass))
end

function SpawnLandingHandlerClass:SetCharacter(object, p: number)
	self.TorsoToRootWeld = object:GetTorsoToRootWeld()
	self.OriginalTorsoToRootWeldC0 = self.TorsoToRootWeld.C0
	local characterModel = object:GetCharacterModel()
	local landingEffectWrapper = nil

	for _, landEffectName in pairs(self.LandEffectNames) do
		local v = Utilities.TryGetInstanceFromPath(characterModel, landEffectName)

		if v then
			landingEffectWrapper = landingEffectWrapper or WrapperFactory.NewEmitterAndSoundWrapper(nil, p)
			landingEffectWrapper:AddFrom(v, p)
		else
			warn("Couldn't find instance with path", landEffectName)
		end
	end

	self.LandingEffectWrapper = landingEffectWrapper
end

function SpawnLandingHandlerClass:Run(p: number)
	if self.LandingTimeLeft > 0 then
		self.LandingTimeLeft -= p

		if self.LandingTimeLeft > 0 then
			local v = math.clamp(self.LandingTimeLeft / self.LandingTimeTotal, 0, 1) ^ 0.5
			self.TorsoToRootWeld.C0 = CFrame.new(self.OriginalTorsoToRootWeldC0.Position + Vector3.new(0, self.StartHeight * v, 0)) * self.OriginalTorsoToRootWeldC0.Rotation
		else
			self.TorsoToRootWeld.C0 = self.OriginalTorsoToRootWeldC0

			if self.LandingEffectWrapper then
				self.LandingEffectWrapper:PlayAll()
			end
		end
	end
end

function SpawnLandingHandlerClass:SpeedMultiplierChanged(p: number)
	if self.LandingEffectWrapper then
		self.LandingEffectWrapper:SpeedMultiplierChanged(p)
	end
end

return SpawnLandingHandlerClass