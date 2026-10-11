local createVector = vector.create
local EmperorCustomCodeClass = {}
EmperorCustomCodeClass.__index = EmperorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local BasicPlaneClass = require(common:WaitForChild("BasicPlaneClass"))
local HashGeneratorClass = require(common:WaitForChild("HashGeneratorClass"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local basicPlanes = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore"):WaitForChild("BasicPlanes")
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(255, 0, 0)
local color3 = Color3.fromRGB(255, 139, 139)
local event = NetworkingHandler.GetEvent("ResetDataExecuted")
local event2 = BindableHandler.GetEvent("TryStartNextWaveAmbientPlaylist")
local event3 = BindableHandler.GetEvent("CreateColorCorrectionEffect")
local blackoutFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BlackoutFrame")
local colorCorrectionEffect = nil
local colorCorrectionEffect2 = nil

local function StartTimeStopColorCorrection()
	if colorCorrectionEffect then
		colorCorrectionEffect.Enabled = true
		TweenService:Create(colorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Saturation = -1
		}):Play()
	end
end

local function StopTimeStopColorCorrection()
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

function EmperorCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_DeathTimingHelpers = {},
		_Wrappers = {},
		_CurrentDrones = {},
		DroneHashGenerator = HashGeneratorClass.New(),
		DronesToSpawn = 0,
		TimeToNextDroneSpawn = 0,
		DeathStarted = false,
		DeathBeams = {},
		DeathBeamStart = nil,
		DeathBeamEnd = nil
	}, EmperorCustomCodeClass))
end

function EmperorCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart

	if colorCorrectionEffect then
		colorCorrectionEffect:Destroy()
		colorCorrectionEffect = nil
	end

	colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "EmperorTimeStopColorCorrection"
	colorCorrectionEffect.Enabled = false
	colorCorrectionEffect.TintColor = color
	colorCorrectionEffect.Parent = Lighting

	if colorCorrectionEffect2 then
		colorCorrectionEffect2:Destroy()
		colorCorrectionEffect2 = nil
	end

	colorCorrectionEffect2 = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect2.Name = "EmperorDeathColorCorrection"
	colorCorrectionEffect2.Enabled = false
	colorCorrectionEffect2.TintColor = color
	colorCorrectionEffect2.Parent = Lighting
	local beams = {}
	local folder = Utilities.TryGetInstanceFromPath(characterModel, "Death>Beam")
	local deathBeamStart = Utilities.TryGetInstanceFromPath(characterModel, "Death>Beam>Att0")
	local deathBeamEnd = Utilities.TryGetInstanceFromPath(characterModel, "Death>Beam>Att1")

	if folder then
		for _, beam in pairs(folder:GetDescendants()) do
			if beam:IsA("Beam") then
				table.insert(beams, beam)
			end
		end
	end

	self.DeathBeams = beams
	self.DeathBeamStart = deathBeamStart
	self.DeathBeamEnd = deathBeamEnd
	local v = Utilities.TryGetInstanceFromPath(characterModel, "Death>Death1")
	local v2 = Utilities.TryGetInstanceFromPath(characterModel, "Death>Death2")
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(v, speedMultiplier)
	local emitterAndSoundWrapper2 = WrapperFactory.NewEmitterAndSoundWrapper(v2, speedMultiplier)
	local emitterAndSoundWrapper3 = WrapperFactory.NewEmitterAndSoundWrapper(folder, speedMultiplier)
	table.insert(self._Wrappers, emitterAndSoundWrapper)
	table.insert(self._Wrappers, emitterAndSoundWrapper2)
	table.insert(self._Wrappers, emitterAndSoundWrapper3)
	self._DeathTimingHelpers.Death1Start = TimingHelperClass.New({
		TimeUntilCallback = 12.15,
		Callback = function()
			emitterAndSoundWrapper:PlayAll()
		end
	})
	self._DeathTimingHelpers.Death1End = TimingHelperClass.New({
		TimeUntilCallback = 15.15,
		Callback = function()
			emitterAndSoundWrapper:StopContinuous()
		end
	})
	self._DeathTimingHelpers.Death2 = TimingHelperClass.New({
		TimeUntilCallback = 12.15,
		Callback = function()
			emitterAndSoundWrapper2:PlayAll()
		end
	})
	self._DeathTimingHelpers.DeathBeam = TimingHelperClass.New({
		TimeUntilCallback = 27.85,
		Callback = function()
			emitterAndSoundWrapper3:PlayAll()

			for _, deathBeam in pairs(self.DeathBeams) do
				deathBeam.Enabled = true
			end

			if colorCorrectionEffect2 then
				colorCorrectionEffect2.TintColor = color
				colorCorrectionEffect2.Enabled = true
				TweenService:Create(
					colorCorrectionEffect2,
					TweenInfo.new(6.649999999999999, Enum.EasingStyle.Cubic, Enum.EasingDirection.In),
					{ TintColor = color2 }
				):Play()
			end
		end
	})
	self._DeathTimingHelpers.DeathExplosion = TimingHelperClass.New({
		TimeUntilCallback = 34.5,
		Callback = function()
			for _, effect in pairs(self.CharacterModel:GetDescendants()) do
				if effect:IsA("Trail") or effect:IsA("Beam") then
					effect:Destroy()
				end
			end

			for _, wrapper in pairs(self._Wrappers) do
				wrapper:StopContinuous()
			end

			blackoutFrame.Visible = true
			blackoutFrame.BackgroundTransparency = 1
			task.delay(0.15, function()
				TweenService:Create(
					blackoutFrame,
					TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ BackgroundTransparency = 0 }
				):Play()
				task.wait(3)

				if colorCorrectionEffect2 then
					colorCorrectionEffect2:Destroy()
					colorCorrectionEffect2 = nil
				end
			end)
		end
	})
end

function EmperorCustomCodeClass:Run_FromCharacter(p: number)
	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Run(p)
	end

	if self.DronesToSpawn > 0 then
		self.TimeToNextDroneSpawn -= p

		if self.TimeToNextDroneSpawn <= 0 then
			local projectileModel = ResourceManager.GetProjectileModel(Enums.Projectiles.EmperorDrone)
			local v = {
				Model = projectileModel,
				GoalLocation = ProjectileUtilities.RandomOffsetPosition(self.Enemy:GetPosition(), 20),
				EntranceDistance = 400,
				ExitDistance = 400,
				Speed = 85,
				Height = 50 + math.random(-12, 12),
				RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
			}
			projectileModel.Parent = basicPlanes
			self._CurrentDrones[self.DroneHashGenerator:Get()] = BasicPlaneClass.New(v, self.SpeedMultiplier)
			self.DronesToSpawn -= 1
			self.TimeToNextDroneSpawn = 0.03
		end
	end

	for k, currentDrone in pairs(self._CurrentDrones) do
		if currentDrone:CanCleanup() then
			self._CurrentDrones[k] = nil
			self.DroneHashGenerator:Return(k)
		end

		currentDrone:Run(p)
	end

	if self.DeathStarted then
		local deathBeamStart = self.DeathBeamStart
		local deathBeamEnd = self.DeathBeamEnd

		if deathBeamStart and deathBeamEnd then
			deathBeamEnd.WorldCFrame = deathBeamStart.WorldCFrame + createVector(0, 1000, 0)
		end
	end
end

function EmperorCustomCodeClass:AbilityUsed(previousAbilityName: string)
	if previousAbilityName == Enums.EnemyAbilities.EmperorDroneStrike then
		self:_StartDroneStrike()
	end

	self.PreviousAbilityName = previousAbilityName
end

function EmperorCustomCodeClass.AbilityAnimationKeyframeReached(_, p: string, p2: string)
	if p == Enums.EnemyAbilities.EmperorTimeStop then
		if p2 == "TimeStop" then
			StartTimeStopColorCorrection()
		elseif p2 == "TimeStop_Stop" then
			StopTimeStopColorCorrection()
		end
	end
end

function EmperorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	for _, currentDrone in pairs(self._CurrentDrones) do
		currentDrone:SpeedMultiplierChanged(speedMultiplier)
	end
end

function EmperorCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	self.DeathStarted = true

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Start()
	end

	StopTimeStopColorCorrection()
end

function EmperorCustomCodeClass:CharacterCleanedUp()
	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Destroy()
	end

	for _, currentDrone in pairs(self._CurrentDrones) do
		currentDrone:Destroy()
	end

	if colorCorrectionEffect then
		colorCorrectionEffect:Destroy()
		colorCorrectionEffect = nil
	end

	if colorCorrectionEffect2 then
		colorCorrectionEffect2:Destroy()
		colorCorrectionEffect2 = nil
	end
end

function EmperorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function EmperorCustomCodeClass:_StartDroneStrike()
	self.DronesToSpawn = 300
	self.TimeToNextDroneSpawn = 1
end

event:AttachCallback(function()
	if not workspace:GetAttribute("SecretWaveTriggered") then
		return
	end

	event3:Fire("SecretWaveColorCorrection", color3)
	task.wait(7)
	TweenService:Create(blackoutFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1
	}):Play()
	event2:Fire()
	task.wait(2)
	blackoutFrame.Visible = false
end)
return EmperorCustomCodeClass