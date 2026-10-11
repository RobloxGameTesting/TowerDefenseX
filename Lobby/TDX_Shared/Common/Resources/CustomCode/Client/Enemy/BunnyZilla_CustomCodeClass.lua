local BunnyZillaCustomCodeClass = {}
BunnyZillaCustomCodeClass.__index = BunnyZillaCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local MapHandler = require(common:WaitForChild("MapHandler"))

function BunnyZillaCustomCodeClass.New(speedMultiplier: number)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		RootPart = nil,
		BeamRaycastParams = raycastParams,
		LaserSweepOn = false,
		LaserSweepBeams = {},
		LaserSweepAttachment = nil,
		LaserSweepBeamPart = nil,
		_Wrappers = { BeamEffects = nil, BurrowMoveFX = nil }
	}, BunnyZillaCustomCodeClass))
end

function BunnyZillaCustomCodeClass:Initialize(enemy, config)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	self.Config = config
	self.RootPart = characterModel.PrimaryPart
	local speedMultiplier = self.SpeedMultiplier
	local laserSweepBeams = characterModel:FindFirstChild("LaserSweepBeams")
	local _1 = laserSweepBeams:FindFirstChild("1")
	self.LaserSweepBeamPart = _1

	for _, beam in pairs(_1:GetChildren()) do
		if beam:IsA("Beam") then
			table.insert(self.LaserSweepBeams, beam)
		end
	end

	self.LaserSweepAttachment = _1:FindFirstChild("End")
	self._Wrappers.BeamEffects = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._Wrappers.BeamEffects:AddFrom(laserSweepBeams, speedMultiplier)
	local burrowMoveFX = characterModel:FindFirstChild("BurrowMoveFX")
	self._Wrappers.BurrowMoveFX = WrapperFactory.NewEmitterAndSoundWrapper(burrowMoveFX, speedMultiplier)
end

function BunnyZillaCustomCodeClass:Run_FromCharacter(p: number)
	self:_RunLaserSweep(p)
end

function BunnyZillaCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.BunnyZillaEmerge then
		self._Wrappers.BurrowMoveFX:StopContinuous()
	end
end

function BunnyZillaCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.BunnyZillaLaser then
		if p2 == "LaserStart" then
			self:_StartLaserSweep()
		elseif p2 == "LaserStop" then
			self:_StopLaserSweep()
		end
	elseif p == Enums.EnemyAbilities.BunnyZillaBurrow and p2 == "UndergroundStart" then
		self._Wrappers.BurrowMoveFX:PlayAll()
	end
end

function BunnyZillaCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function BunnyZillaCustomCodeClass:EnemyDestroyed(_: boolean?, _: boolean?)
	self:_StopLaserSweep()
	self._Wrappers.BurrowMoveFX:StopContinuous()
end

function BunnyZillaCustomCodeClass.CharacterCleanedUp(_) end

function BunnyZillaCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function BunnyZillaCustomCodeClass:_StartLaserSweep()
	self.LaserSweepOn = true

	for _, laserSweepBeam in pairs(self.LaserSweepBeams) do
		laserSweepBeam.Enabled = true
	end

	self:_RunLaserSweep(0)
	self._Wrappers.BeamEffects:PlayAll()
end

function BunnyZillaCustomCodeClass:_StopLaserSweep()
	self.LaserSweepOn = false

	for _, laserSweepBeam in pairs(self.LaserSweepBeams) do
		laserSweepBeam.Enabled = false
	end

	if self._Wrappers.BeamEffects then
		self._Wrappers.BeamEffects:StopContinuous()
	end
end

function BunnyZillaCustomCodeClass:_RunLaserSweep(_: number)
	if not self.LaserSweepOn then
		return
	end

	local laserSweepBeamPart = self.LaserSweepBeamPart
	local lookVector = laserSweepBeamPart.CFrame.LookVector
	local v = -self.RootPart.CFrame.UpVector
	local v2 = math.acos((math.clamp(lookVector:Dot(v), -1, 1)))

	if v2 > 1.3962634015954636 then
		local cross = lookVector:Cross(v)

		if cross.Magnitude > 0.001 then
			local unit = cross.Unit
			local v3 = v2 - 1.3962634015954636
			lookVector = CFrame.fromAxisAngle(unit, v3):VectorToWorldSpace(lookVector)
		end
	end

	local v3 = lookVector * 30
	local position = laserSweepBeamPart.CFrame.Position
	local laserSweepAttachment = self.LaserSweepAttachment
	local raycastResult = workspace:Raycast(position, v3, self.BeamRaycastParams)

	if raycastResult then
		laserSweepAttachment.WorldCFrame = CFrame.new(raycastResult.Position)
	else
		laserSweepAttachment.WorldCFrame = CFrame.new(position + v3)
	end
end

return BunnyZillaCustomCodeClass