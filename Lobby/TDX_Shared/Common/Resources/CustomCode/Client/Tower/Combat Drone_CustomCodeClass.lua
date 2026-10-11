local createVector = vector.create
local CombatDroneCustomCodeClass = {}
CombatDroneCustomCodeClass.__index = CombatDroneCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

local function MakeEqualizerSoundEffect(instance)
	local primaryPart = instance.PrimaryPart
	local spawn = primaryPart and primaryPart:FindFirstChild("Spawn")

	if not spawn then
		warn("Spawn sound not found in character model")
		return nil
	end

	local equalizerSoundEffect = Instance.new("EqualizerSoundEffect")
	equalizerSoundEffect.Enabled = false
	equalizerSoundEffect.LowGain = 0
	equalizerSoundEffect.MidGain = -10
	equalizerSoundEffect.HighGain = -40
	equalizerSoundEffect.Parent = spawn
	return equalizerSoundEffect
end

function CombatDroneCustomCodeClass.New(_: number)
	return (setmetatable({
		Tower = nil,
		Character = nil,
		Torso = nil,
		CurrentPosition = nil,
		RotationOffset = nil,
		MaxSpeed = nil,
		MaxSpeedMultiplier = 1 - 0.2 * math.random(),
		IdleSoundEqualizer = nil
	}, CombatDroneCustomCodeClass))
end

function CombatDroneCustomCodeClass:Initialize(tower, p)
	self.Tower = tower
	self.Character = tower.Character
	self.Torso = self.Character.Torso
	self.CurrentPosition = self.Torso.CFrame.Position
	self.RotationOffset = p.RotationOffset
	local primaryPart = self.Character:GetCharacterModel().PrimaryPart
	local spawn = primaryPart and primaryPart:FindFirstChild("Spawn")
	local equalizerSoundEffect

	if spawn then
		equalizerSoundEffect = Instance.new("EqualizerSoundEffect")
		equalizerSoundEffect.Enabled = false
		equalizerSoundEffect.LowGain = 0
		equalizerSoundEffect.MidGain = -10
		equalizerSoundEffect.HighGain = -40
		equalizerSoundEffect.Parent = spawn
	else
		warn("Spawn sound not found in character model")
	end

	self.IdleSoundEqualizer = equalizerSoundEffect
	self.MaxSpeed = tower.LevelHandler:GetLevelStats().MovementSpeed
end

function CombatDroneCustomCodeClass:Run_FromCharacter(p: number)
	if p == 0 then
		return
	end

	local tower = self.Tower

	if not self.Character:GetTorsoToRootWeld() then
		return
	end

	if not tower.PylonMovementHandler then
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

		self.Character:SetTorsoToRootWeldRotation(self.RotationOffset * cframe2)
	end
end

function CombatDroneCustomCodeClass.AbilityUsed(_, _) end

function CombatDroneCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function CombatDroneCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function CombatDroneCustomCodeClass:Upgraded(p)
	self.MaxSpeed = p.MovementSpeed
	local primaryPart = self.Character:GetCharacterModel().PrimaryPart
	local spawn = primaryPart and primaryPart:FindFirstChild("Spawn")
	local equalizerSoundEffect

	if spawn then
		equalizerSoundEffect = Instance.new("EqualizerSoundEffect")
		equalizerSoundEffect.Enabled = false
		equalizerSoundEffect.LowGain = 0
		equalizerSoundEffect.MidGain = -10
		equalizerSoundEffect.HighGain = -40
		equalizerSoundEffect.Parent = spawn
	else
		warn("Spawn sound not found in character model")
	end

	self.IdleSoundEqualizer = equalizerSoundEffect
end

function CombatDroneCustomCodeClass.CharacterCleanedUp(_) end

function CombatDroneCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function CombatDroneCustomCodeClass.Attacked(_, _, _: boolean?) end

function CombatDroneCustomCodeClass.Death(_) end

function CombatDroneCustomCodeClass.SetInFPSMode(p, enabled: boolean)
	local idleSoundEqualizer = p.IdleSoundEqualizer

	if idleSoundEqualizer then
		idleSoundEqualizer.Enabled = enabled
	end
end

return CombatDroneCustomCodeClass