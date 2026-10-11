local createVector = vector.create
local NemesisCustomCodeClass = {}
NemesisCustomCodeClass.__index = NemesisCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local Utilities = require(common:WaitForChild("Utilities"))
local event = BindableHandler.GetEvent("ClearCreatedColorCorrectionEffects")
local blackoutFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BlackoutFrame")

function NemesisCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		_DeathTimingHelpers = {},
		_TimingHelpers = {},
		_Wrappers = {},
		NewLightingEffectsFolder = nil,
		NewLightingEffects = nil,
		DeathStarted = false,
		DeathBeams = {},
		DeathBeamStart = nil,
		DeathBeamEnd = nil
	}, NemesisCustomCodeClass))
end

function NemesisCustomCodeClass:Initialize(enemy, config)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	self.Config = config
	local deathFX = characterModel:FindFirstChild("DeathFX")
	self._Wrappers.DeathVFXWrapper = WrapperFactory.NewEmitterWrapper(deathFX, self.SpeedMultiplier)
	self._Wrappers.DeathSFXWrapper = WrapperFactory.NewSoundWrapper(deathFX, self.SpeedMultiplier)
	self._TimingHelpers.DeathVFXTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 19 / 12,
		Callback = function()
			self._Wrappers.DeathVFXWrapper:PlayAll()
		end
	})
	self.DelayedEnrageFXModel = characterModel:FindFirstChild("FX").Enrage.Delayed
	self._Wrappers.EnrageVFXWrapper = WrapperFactory.NewEmitterWrapper(self.DelayedEnrageFXModel, self.SpeedMultiplier)
	self._TimingHelpers.EnrageVFXTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 3.45,
		Callback = function()
			self._Wrappers.EnrageVFXWrapper:PlayAll()
		end
	})
	local delayed = characterModel:FindFirstChild("FX").Summon.Delayed
	local delayed2 = characterModel:FindFirstChild("FX").Summon.Delayed2
	self._Wrappers.SummonVFXWrapper = WrapperFactory.NewEmitterWrapper(delayed, self.SpeedMultiplier)
	self._Wrappers.SummonVFXWrapper2 = WrapperFactory.NewEmitterWrapper(delayed2, self.SpeedMultiplier)
	local scythe = characterModel:FindFirstChild("Scythe")
	self._DeathTimingHelpers.Death1Start = TimingHelperClass.New({
		TimeUntilCallback = 0.5,
		Callback = function()
			scythe:Destroy()
		end
	})
	local miscResource = ResourceManager.GetMiscResource("SecretWaveLightingEffects")
	local children = {}

	if miscResource then
		for _, child in pairs(miscResource:GetChildren()) do
			table.insert(children, child)
		end
	end

	self.NewLightingEffectsFolder = miscResource
	self.NewLightingEffects = children
	self._DeathTimingHelpers.Death2Start = TimingHelperClass.New({
		TimeUntilCallback = 0,
		Callback = function()
			local tweenInfo = TweenInfo.new(8, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)

			for _, instance in pairs(self.NewLightingEffects) do
				if instance:IsA("ColorCorrectionEffect") then
					local brightness = instance.Brightness
					local contrast = instance.Contrast
					local saturation = instance.Saturation
					local tintColor = instance.TintColor
					instance.Brightness = 0
					instance.Contrast = 0
					instance.Saturation = 0
					instance.TintColor = Color3.fromRGB(255, 255, 255)
					TweenService:Create(instance, tweenInfo, {
						Brightness = brightness,
						Contrast = contrast,
						Saturation = saturation,
						TintColor = tintColor
					}):Play()
				elseif instance:IsA("BloomEffect") then
					local intensity = instance.Intensity
					local size = instance.Size
					local threshold = instance.Threshold
					instance.Intensity = 0
					instance.Size = 0
					instance.Threshold = 10
					TweenService:Create(instance, tweenInfo, {
						Intensity = intensity,
						Size = size,
						Threshold = threshold
					}):Play()
				elseif instance:IsA("DepthOfFieldEffect") then
					local farIntensity = instance.FarIntensity
					local nearIntensity = instance.NearIntensity
					instance.FarIntensity = 0
					instance.NearIntensity = 0
					TweenService:Create(instance, tweenInfo, {
						FarIntensity = farIntensity,
						NearIntensity = nearIntensity
					}):Play()
				end

				instance.Enabled = true
				instance.Parent = Lighting
			end
		end
	})
	self._DeathTimingHelpers.Death3Start = TimingHelperClass.New({
		TimeUntilCallback = 5,
		Callback = function()
			blackoutFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			blackoutFrame.Visible = true
			blackoutFrame.BackgroundTransparency = 1
			TweenService:Create(blackoutFrame, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				BackgroundTransparency = 0
			}):Play()
			task.delay(3, function()
				if self.NewLightingEffects then
					for _, newLightingEffect in pairs(self.NewLightingEffects) do
						newLightingEffect:Destroy()
					end

					self.NewLightingEffects = nil
				end

				if self.NewLightingEffectsFolder then
					self.NewLightingEffectsFolder:Destroy()
					self.NewLightingEffectsFolder = nil
				end

				event:Fire()
			end)
		end
	})
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
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(folder, self.SpeedMultiplier)
	self._Wrappers.DeathBeamVFXWrapper = emitterAndSoundWrapper
	self._DeathTimingHelpers.Death4Start = TimingHelperClass.New({
		TimeUntilCallback = 6.9,
		Callback = function()
			emitterAndSoundWrapper:PlayAll()

			for _, deathBeam in pairs(self.DeathBeams) do
				deathBeam.Enabled = true
			end
		end
	})
end

function NemesisCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Run(p)
	end

	if self.DeathStarted then
		local deathBeamStart = self.DeathBeamStart
		local deathBeamEnd = self.DeathBeamEnd

		if deathBeamStart and deathBeamEnd then
			deathBeamEnd.WorldCFrame = deathBeamStart.WorldCFrame + createVector(0, 1000, 0)
		end
	end
end

function NemesisCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.NemesisEnrage then
		self._TimingHelpers.EnrageVFXTimingHelper:Start()
	elseif p == Enums.EnemyAbilities.NemesisSummon then
		self._TimingHelpers.SummonVFXTimingHelper = TimingHelperClass.New({
			TimeUntilCallback = 13 / 3,
			Callback = function()
				self._Wrappers.SummonVFXWrapper:PlayAll()
				self._TimingHelpers.SummonVFXTimingHelper = nil
			end
		})
		self._TimingHelpers.SummonVFXTimingHelper2 = TimingHelperClass.New({
			TimeUntilCallback = 367 / 60,
			Callback = function()
				self._Wrappers.SummonVFXWrapper:PlayAll()
				self._Wrappers.SummonVFXWrapper2:PlayAll()
				self._TimingHelpers.SummonVFXTimingHelper2 = nil
			end
		})
		self._TimingHelpers.SummonVFXTimingHelper:Start()
		self._TimingHelpers.SummonVFXTimingHelper2:Start()
	end
end

function NemesisCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function NemesisCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if not flag then
		self._Wrappers.DeathSFXWrapper:PlayAll()
		self._TimingHelpers.DeathVFXTimingHelper:Start()
		self._Wrappers.EnrageVFXWrapper:StopContinuous()

		for _, beam in self.DelayedEnrageFXModel:GetDescendants() do
			if beam:IsA("Beam") then
				beam.Enabled = false
			end
		end
	end

	if flag or flag2 then
		return
	end

	self.DeathStarted = true

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Start()
	end
end

function NemesisCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Destroy()
	end
end

function NemesisCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function NemesisCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return NemesisCustomCodeClass