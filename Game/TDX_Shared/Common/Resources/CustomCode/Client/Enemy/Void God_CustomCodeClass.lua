local VoidGodCustomCodeClass = {}
VoidGodCustomCodeClass.__index = VoidGodCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("AbilityTypes"))
local PathHandler = require(common:WaitForChild("PathHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local event = NetworkingHandler.GetEvent("PathLaserStarted")
local blackoutFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BlackoutFrame")
local colorCorrectionEffect = nil

local function StartBlackHoleColorCorrection()
	if colorCorrectionEffect then
		colorCorrectionEffect.Enabled = true
		TweenService:Create(colorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Saturation = -0.5
		}):Play()
	end
end

local function StopBlackHoleColorCorrection()
	if colorCorrectionEffect then
		TweenService:Create(colorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Saturation = 0
		}):Play()
		task.delay(1, function()
			if colorCorrectionEffect then
				colorCorrectionEffect.Enabled = false
			end
		end)
	end
end

local function DestroyBlackHoleColorCorrection() -- 2 equivalent calls inferred from this helper
	if colorCorrectionEffect then
		colorCorrectionEffect:Destroy()
		colorCorrectionEffect = nil
	end
end

local function NewSoundWrapperFromPath(characterModel, p: string, speedMultiplier: number, p2: number?)
	local sound = Utilities.TryGetInstanceFromPath(characterModel, p)

	if not sound then
		warn("Void God SFX not found at path " .. p)
		return nil
	end

	local soundWrapper = WrapperFactory.NewSoundWrapper(nil, speedMultiplier)

	if sound:IsA("Sound") then
		soundWrapper:AddSound(sound, speedMultiplier, p2)
		return soundWrapper
	end

	soundWrapper:AddSoundsFrom(sound, speedMultiplier, p2)
	return soundWrapper
end

local v = {}

local function GetDistanceToSegment(position: Vector3, vector: Vector3, vector2: Vector3) -- 1 equivalent call inferred from this helper
	local vector3 = vector2 - vector
	local dot = vector3:Dot(vector3)

	if dot < 1e-6 then
		return (position - vector).Magnitude
	end

	return (position - (vector + vector3 * math.clamp((position - vector):Dot(vector3) / dot, 0, 1))).Magnitude
end

function VoidGodCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		IdleSoundWrapper = nil,
		Enemy = nil,
		LaserEyeBeams = {},
		LaserEyeBeamTextureSpeeds = {},
		LaserEyeStartAttachment = nil,
		LaserEyeEndAttachment = nil,
		LaserEyeImpactPart = nil,
		LaserEyeImpactWrapper = nil,
		LaserEyeData = nil,
		LaserEyeElapsed = 0,
		LaserEyeFiring = false,
		_DeathTimingHelpers = {},
		_HoldingAmbientMusic = false
	}, VoidGodCustomCodeClass))
end

local function ApplyMapPositions(folder)
	local mapName = workspace:GetAttribute("MapName")

	if not mapName then
		warn("Void God custom code: MapName attribute is not set on workspace")
		return
	end

	local formatted = `{mapName}_Position`

	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		local attribute = part:GetAttribute(formatted)

		if attribute == nil then
			continue
		end

		if part.Anchored then
			if typeof(attribute) == "CFrame" then
				part.CFrame = attribute
			elseif typeof(attribute) == "Vector3" then
				part.Position = attribute
			else
				warn(`Void God custom code: {part:GetFullName()} has {formatted} with unsupported type {typeof(attribute)}`)
			end
		else
			warn(`Void God custom code: {part:GetFullName()} has {formatted} but is not anchored`)
		end
	end
end

function VoidGodCustomCodeClass:Initialize(enemy, _)
	local characterModel = enemy.Character:GetCharacterModel()

	if not characterModel then
		warn("Void God custom code could not resolve the character model")
		return
	end

	ApplyMapPositions(characterModel)
	self.Enemy = enemy
	v[enemy.Hash] = self
	self:_SetUpLaserEye(characterModel)
	self.IdleSoundWrapper = NewSoundWrapperFromPath(characterModel, "RootPart>SFX>Idle", self.SpeedMultiplier, 3)

	if self.IdleSoundWrapper then
		self.IdleSoundWrapper:PlayContinuous()
	end

	DestroyBlackHoleColorCorrection() -- inferred equivalent call
	colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "VoidGodBlackHoleColorCorrection"
	colorCorrectionEffect.Enabled = false
	colorCorrectionEffect.Parent = Lighting
	self._DeathTimingHelpers.IdleSoundFadeOut = TimingHelperClass.New({
		TimeUntilCallback = 38,
		Callback = function()
			self:_StopIdleSound()
		end
	})
	self._DeathTimingHelpers.Blackout = TimingHelperClass.New({
		TimeUntilCallback = 37.6,
		Callback = function()
			blackoutFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			blackoutFrame.Visible = true
			blackoutFrame.BackgroundTransparency = 1
			TweenService:Create(blackoutFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				BackgroundTransparency = 0
			}):Play()
		end
	})
end

function VoidGodCustomCodeClass:Run_FromCharacter(p: number)
	self:_RunLaserEye(p)

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Run(p)
	end
end

function VoidGodCustomCodeClass:_SetUpLaserEye(instance)
	local laserEye = instance:FindFirstChild("LaserEye")

	if not laserEye then
		warn("Void God custom code: LaserEye not found, the laser eye will have no beam")
		return
	end

	local att0 = laserEye:FindFirstChild("Att0", true)
	local att1 = laserEye:FindFirstChild("Att1", true)

	if not (att0 and att0:IsA("Attachment") and att1 and att1:IsA("Attachment")) then
		warn("Void God custom code: LaserEye needs Att0 and Att1 attachments")
		return
	end

	self.LaserEyeStartAttachment = att0
	self.LaserEyeEndAttachment = att1

	for _, beam in pairs(laserEye:GetDescendants()) do
		if not beam:IsA("Beam") then
			continue
		end

		beam.Enabled = false
		table.insert(self.LaserEyeBeams, beam)
		self.LaserEyeBeamTextureSpeeds[beam] = beam.TextureSpeed
	end

	self:_UpdateLaserEyeBeamTextureSpeeds()
	local part = laserEye:FindFirstChild("End", true)

	if part and part:IsA("BasePart") then
		self.LaserEyeImpactPart = part
		self.LaserEyeImpactWrapper = WrapperFactory.NewEmitterAndSoundWrapper(part, self.SpeedMultiplier)
	end
end

function VoidGodCustomCodeClass:_UpdateLaserEyeBeamTextureSpeeds()
	for k, laserEyeBeamTextureSpeed in pairs(self.LaserEyeBeamTextureSpeeds) do
		k.TextureSpeed = laserEyeBeamTextureSpeed * self.SpeedMultiplier
	end
end

function VoidGodCustomCodeClass:_GetLaserEyeTargetPosition(data, p: number)
	local v2 = math.clamp((p - data.StartTime) / math.max(data.EndTime - data.StartTime, 0.001), 0, 1)
	local v3 = data.StartPathPercentage + (data.EndPathPercentage - data.StartPathPercentage) * v2
	return PathHandler.GetPositionAtPathPercentage(data.PathIndex, data.PVPTeamIndex, v3)
end

function VoidGodCustomCodeClass:_StartLaserEye(laserEyeData)
	self:_StopLaserEye()
	self.LaserEyeData = laserEyeData
	self.LaserEyeElapsed = 0
	self.LaserEyeFiring = false
end

function VoidGodCustomCodeClass:_SetLaserEyeFiring(flag: boolean, flag2: boolean?)
	if self.LaserEyeFiring == flag then
		return
	end

	self.LaserEyeFiring = flag

	for _, laserEyeBeam in pairs(self.LaserEyeBeams) do
		laserEyeBeam.Enabled = flag
	end

	local laserEyeImpactWrapper = self.LaserEyeImpactWrapper

	if laserEyeImpactWrapper then
		if flag then
			laserEyeImpactWrapper:PlayAll()
		else
			laserEyeImpactWrapper:StopContinuous(flag2)
		end
	end
end

function VoidGodCustomCodeClass:_StopLaserEye(flag: boolean?)
	self:_SetLaserEyeFiring(false, flag)
	self.LaserEyeData = nil
end

function VoidGodCustomCodeClass:_KillLocalPlayerIfInLaserEye(vector: Vector3, vector2: Vector3)
	local character = Players.LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

	if not humanoid or humanoid.Health <= 0 or not (humanoidRootPart and humanoidRootPart:IsA("BasePart")) then
		return
	end

	if GetDistanceToSegment(humanoidRootPart.Position, vector, vector2) <= 8 then -- inferred equivalent call
		humanoid.Health = 0
	end
end

function VoidGodCustomCodeClass:_RunLaserEye(p: number)
	local laserEyeData = self.LaserEyeData

	if not laserEyeData then
		return
	end

	self.LaserEyeElapsed += p
	local laserEyeElapsed = self.LaserEyeElapsed

	if laserEyeData.EndTime <= laserEyeElapsed then
		self:_StopLaserEye()
		return
	end

	local v2 = laserEyeData.StartTime <= laserEyeElapsed
	self:_SetLaserEyeFiring(v2)

	if not v2 then
		return
	end

	local laserEyeTargetPosition = self:_GetLaserEyeTargetPosition(laserEyeData, laserEyeElapsed)
	local laserEyeEndAttachment = self.LaserEyeEndAttachment
	local laserEyeStartAttachment = self.LaserEyeStartAttachment

	if laserEyeEndAttachment then
		laserEyeEndAttachment.WorldPosition = laserEyeTargetPosition
	end

	if self.LaserEyeImpactPart then
		self.LaserEyeImpactPart.Position = laserEyeTargetPosition
	end

	if laserEyeStartAttachment then
		self:_KillLocalPlayerIfInLaserEye(laserEyeStartAttachment.WorldPosition, laserEyeTargetPosition)
	end
end

function VoidGodCustomCodeClass.AbilityUsed(_, _: string) end

function VoidGodCustomCodeClass.AbilityAnimationKeyframeReached(_, p: string, p2: string)
	if p == Enums.EnemyAbilities.VoidGodBlackHole then
		if p2 == "BlackHole" then
			StartBlackHoleColorCorrection()
		elseif p2 == "BlackHole_Stop" then
			StopBlackHoleColorCorrection()
		end
	end
end

function VoidGodCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	if self.IdleSoundWrapper then
		self.IdleSoundWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.LaserEyeImpactWrapper then
		self.LaserEyeImpactWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self:_UpdateLaserEyeBeamTextureSpeeds()
end

function VoidGodCustomCodeClass:_StopIdleSound(flag: boolean?)
	if self.IdleSoundWrapper then
		self.IdleSoundWrapper:StopContinuous(flag)
	end
end

function VoidGodCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	StopBlackHoleColorCorrection()
	self:_StopLaserEye(flag)

	if flag or flag2 then
		self:_StopIdleSound(flag)
		return
	end

	self._HoldingAmbientMusic = true
	SoundHandler.StopAmbientPlaylistForTime(1e999)

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Start()
	end
end

function VoidGodCustomCodeClass:CharacterCleanedUp()
	self:_StopIdleSound(true)
	DestroyBlackHoleColorCorrection() -- inferred equivalent call
	self:_StopLaserEye(true)

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Destroy()
	end

	self._DeathTimingHelpers = {}

	if self._HoldingAmbientMusic then
		self._HoldingAmbientMusic = false
		SoundHandler.StopAmbientPlaylistForTime(0)
	end

	local enemy = self.Enemy

	if enemy and v[enemy.Hash] == self then
		v[enemy.Hash] = nil
	end
end

function VoidGodCustomCodeClass.AnimationStateChanged(_, _: string, _) end

event:AttachCallback(function(p)
	if p.AbilityName ~= Enums.EnemyAbilities.VoidGodLaserEye then
		return
	end

	local v2 = v[p.EnemyHash]

	if v2 then
		v2:_StartLaserEye(p)
	end
end)
return VoidGodCustomCodeClass