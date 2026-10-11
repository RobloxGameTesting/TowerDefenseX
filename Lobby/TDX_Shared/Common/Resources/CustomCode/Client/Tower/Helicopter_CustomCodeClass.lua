local createVector = vector.create
local HelicopterCustomCodeClass = {}
HelicopterCustomCodeClass.__index = HelicopterCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

function HelicopterCustomCodeClass.New(_: number)
	return (setmetatable({
		Tower = nil,
		Character = nil,
		Torso = nil,
		CurrentPosition = nil,
		RotationOffset = nil,
		MaxSpeed = nil,
		MaxSpeedMultiplier = 1 - 0.2 * math.random()
	}, HelicopterCustomCodeClass))
end

function HelicopterCustomCodeClass:Initialize(tower, p)
	self.Tower = tower
	self.Character = tower.Character
	self.Torso = self.Character.Torso
	self.CurrentPosition = self.Torso.CFrame.Position
	self.RotationOffset = p.RotationOffset
	self.MaxSpeed = tower.LevelHandler:GetLevelStats().MovementSpeed
end

function HelicopterCustomCodeClass:Run_FromCharacter(p: number)
	if p == 0 then
		return
	end

	local torsoToRootWeld = self.Character:GetTorsoToRootWeld()

	if not torsoToRootWeld then
		return
	end

	local cframe = self.Torso.CFrame
	local currentPosition = self.CurrentPosition
	self.CurrentPosition = cframe.Position
	local v = (cframe.Position - currentPosition) * createVector(1, 0, 1)
	local magnitude = v.Magnitude
	local cframe2 = CFrame.Angles(0, 0, 0)

	if magnitude > 0 then
		local unit = v.Unit
		local v2 = self.MaxSpeed * self.MaxSpeedMultiplier
		local v3 = math.clamp(magnitude / p / v2, 0, 1)
		local v4 = select(2, cframe:ToEulerAnglesYXZ())
		cframe2 = CFrame.Angles(
			(math.cos(v4 + 3.141592653589793) * unit.Z + math.sin(v4 + 3.141592653589793) * unit.X) * v3 * 0.3141592653589793,
			0,
			(math.sin(v4 + 3.141592653589793) * unit.Z + math.cos(v4) * unit.X) * v3 * 0.3141592653589793
		)
	end

	torsoToRootWeld.C0 = CFrame.new(torsoToRootWeld.C0.Position) * self.RotationOffset * cframe2
end

function HelicopterCustomCodeClass.AbilityUsed(_, _) end

function HelicopterCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function HelicopterCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function HelicopterCustomCodeClass:Upgraded(p)
	self.MaxSpeed = p.MovementSpeed
end

function HelicopterCustomCodeClass.CharacterCleanedUp(_) end

function HelicopterCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function HelicopterCustomCodeClass.Attacked(_, _, _: boolean?) end

function HelicopterCustomCodeClass.Death(_) end

return HelicopterCustomCodeClass