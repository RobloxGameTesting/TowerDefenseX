local createVector = vector.create
local ExoVoidCustomCodeClass = {}
ExoVoidCustomCodeClass.__index = ExoVoidCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local ReplacementPieceHandlerClass = require(common:WaitForChild("ReplacementPieceHandlerClass"))
local event = BindableHandler.GetEvent("NewVisualEffectBindable")
local LocalPlayer = Players.LocalPlayer
local numberRange = NumberRange.new(-300, 300)

local function NewSoundWrapperFromPath(characterModel, p: string, speedMultiplier: number)
	local sound = Utilities.TryGetInstanceFromPath(characterModel, p)

	if not sound then
		warn("Exo Void SFX not found at path " .. p)
		return nil
	end

	local soundWrapper = WrapperFactory.NewSoundWrapper(nil, speedMultiplier)

	if sound:IsA("Sound") then
		soundWrapper:AddSound(sound, speedMultiplier)
		return soundWrapper
	end

	soundWrapper:AddSoundsFrom(sound, speedMultiplier)
	return soundWrapper
end

local function HideCharacterInstances(folder)
	for _, descendant in pairs(folder:GetDescendants()) do
		if not (descendant:IsA("BasePart") or descendant:IsA("FaceInstance")) then
			continue
		end

		descendant:SetAttribute("StealthShimmerOverrideMinTransparency", 1)
		descendant.Transparency = 1

		if descendant:IsA("BasePart") then
			descendant.CanQuery = false
		end
	end
end

local function NewEffectWrapperByName(instance, childName: string, p: number)
	local child = instance:FindFirstChild(childName, true)

	if child then
		return WrapperFactory.NewEmitterAndSoundWrapper(child, p)
	end

	warn("Exo Void " .. childName .. " not found")
	return nil
end

local function GetEarthquakeShakeStrength(earthquakeElapsed: number) -- 1 equivalent call inferred from this helper
	if earthquakeElapsed <= 1.817 or earthquakeElapsed >= 5.933 then
		return 0
	end

	return (math.clamp(math.min((earthquakeElapsed - 1.817) / 1.2, (5.933 - earthquakeElapsed) / 1.2), 0, 1))
end

local function SetCameraShake(p: number)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	if p <= 0 then
		humanoid.CameraOffset = createVector(0, 0, 0)
	else
		humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * (p * 0.75)
	end
end

local function SetTrailsEnabled(folder, enabled: boolean)
	for _, trail in pairs(folder:GetDescendants()) do
		if trail:IsA("Trail") then
			trail.Enabled = enabled
		end
	end
end

local function DestroyFlaggedInstances(folder)
	for _, descendant in pairs(folder:GetDescendants()) do
		if descendant:GetAttribute("DestroyOnDeath") then
			descendant:Destroy()
		end
	end
end

local function HideArmorInstances(folder)
	for _, descendant in pairs(folder:GetDescendants()) do
		if not (descendant:IsA("BasePart") or descendant:IsA("FaceInstance")) then
			continue
		end

		descendant:SetAttribute("StealthShimmerOverrideMinTransparency", 1)

		if not descendant:GetAttribute("OriginalTransparency") then
			descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
		end

		descendant.Transparency = 1

		if not descendant:IsA("BasePart") then
			continue
		end

		if not descendant:GetAttribute("OriginalCanQuery") then
			descendant:SetAttribute("OriginalCanQuery", descendant.CanQuery)
		end

		descendant.CanQuery = false
	end
end

local function ShowArmorInstances(folder)
	for _, descendant in pairs(folder:GetDescendants()) do
		if not (descendant:IsA("BasePart") or descendant:IsA("FaceInstance")) then
			continue
		end

		descendant:SetAttribute("StealthShimmerOverrideMinTransparency", nil)
		descendant.Transparency = descendant:GetAttribute("OriginalTransparency") or 0

		if descendant:IsA("BasePart") and descendant:GetAttribute("OriginalCanQuery") ~= nil then
			descendant.CanQuery = descendant:GetAttribute("OriginalCanQuery")
		end
	end
end

function ExoVoidCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		RootPart = nil,
		ArmorFolder = nil,
		ArmorPieces = nil,
		ArmorPieceHandler = nil,
		ArmorFlyStarted = false,
		IdleSoundWrapper = nil,
		IdleDamagedSoundWrapper = nil,
		Damaged = false,
		SwordIdleVFX = nil,
		SwordTrailTimingHelper = nil,
		SwordDestroyTimingHelper = nil,
		SwordTrailsReady = false,
		SwordTrailsSuppressed = false,
		EarthquakeRunning = false,
		EarthquakeElapsed = 0,
		EarthquakeShaking = false,
		DeathVFXWrapper = nil,
		DeathVFX2Wrapper = nil,
		DeathVFX2TimingHelper = nil,
		DeathTimingHelper = nil,
		Dead = false
	}, ExoVoidCustomCodeClass))
end

function ExoVoidCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local characterModel = self.CharacterModel
	self.RootPart = characterModel.PrimaryPart
	self.IdleSoundWrapper = NewSoundWrapperFromPath(characterModel, "HumanoidRootPart>SFX>Idle", self.SpeedMultiplier)
	self.IdleDamagedSoundWrapper = NewSoundWrapperFromPath(
		characterModel,
		"HumanoidRootPart>SFX>IdleDamaged",
		self.SpeedMultiplier
	)

	if self.IdleSoundWrapper then
		self.IdleSoundWrapper:PlayContinuous()
	end

	local speedMultiplier = self.SpeedMultiplier
	local deathEffects = characterModel:FindFirstChild("DeathEffects", true)
	local deathVFXWrapper

	if deathEffects then
		deathVFXWrapper = WrapperFactory.NewEmitterAndSoundWrapper(deathEffects, speedMultiplier)
	else
		warn("Exo Void DeathEffects not found")
	end

	self.DeathVFXWrapper = deathVFXWrapper
	local speedMultiplier2 = self.SpeedMultiplier
	local deathEffects2 = characterModel:FindFirstChild("DeathEffects2", true)
	local deathVFX2Wrapper

	if deathEffects2 then
		deathVFX2Wrapper = WrapperFactory.NewEmitterAndSoundWrapper(deathEffects2, speedMultiplier2)
	else
		warn("Exo Void DeathEffects2 not found")
	end

	self.DeathVFX2Wrapper = deathVFX2Wrapper
	self.DeathVFX2TimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 5.65,
		Callback = function()
			if self.DeathVFX2Wrapper then
				self.DeathVFX2Wrapper:PlayAll()
			end
		end
	})
	self.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 7,
		Callback = function()
			self:_TeleportAway()
		end
	})
	local armor = characterModel:FindFirstChild("Armor")

	if not armor then
		warn("Exo Void Armor folder not found")
		return
	end

	self.ArmorFolder = armor
	HideArmorInstances(armor)
	self:_SetUpSwordTrails()
	local children = {}

	for _, child in pairs(armor:GetChildren()) do
		if child:GetAttribute("AttachTime") then
			table.insert(children, child)
		end
	end

	if #children == 0 then
		warn("Exo Void Armor folder has no pieces with an AttachTime attribute")
		return
	end

	local replacementPieceJet = characterModel:FindFirstChild("ReplacementPieceJet")
	self.ArmorPieces = children
	self.ArmorPieceHandler = ReplacementPieceHandlerClass.New(
		characterModel,
		children,
		self.SpeedMultiplier,
		nil,
		armor,
		1.3,
		replacementPieceJet
	)
	self:_StartArmorFly()
end

function ExoVoidCustomCodeClass:_SetUpSwordTrails()
	local swordIdleVFX = Utilities.TryGetInstanceFromPath(self.CharacterModel, "Armor>Sword>SwordIdleVFX")

	if not swordIdleVFX then
		warn("Exo Void sword trails not found at path Armor>Sword>SwordIdleVFX")
		return
	end

	self.SwordIdleVFX = swordIdleVFX
	self:_ApplySwordTrailState()
	self.SwordTrailTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 9.25,
		Callback = function()
			self.SwordTrailsReady = true
			self:_ApplySwordTrailState()
		end
	})
	self.SwordTrailTimingHelper:Start()
end

function ExoVoidCustomCodeClass:_ApplySwordTrailState()
	if not self.SwordIdleVFX then
		return
	end

	SetTrailsEnabled(self.SwordIdleVFX, self.SwordTrailsReady and not self.SwordTrailsSuppressed)
end

function ExoVoidCustomCodeClass:_GetStartBezierData()
	local position = self.RootPart.CFrame.Position
	return {
		P1 = position + createVector(0, 120, 0),
		P2 = position + createVector(0, 20, 0)
	}
end

function ExoVoidCustomCodeClass:_StartArmorFly()
	if self.ArmorFlyStarted or not self.ArmorPieceHandler then
		return
	end

	self.ArmorFlyStarted = true
	local position = self.RootPart.CFrame.Position

	for _, armorPiece in pairs(self.ArmorPieces) do
		local v = position + Vector3.new(
			Utilities.GetRandomNumberInNumberRange(numberRange),
			300,
			Utilities.GetRandomNumberInNumberRange(numberRange)
		)
		armorPiece:PivotTo(CFrame.new(v) * armorPiece:GetPivot().Rotation)
	end

	ShowArmorInstances(self.ArmorFolder)
	self.ArmorPieceHandler:Start(self:_GetStartBezierData())
end

function ExoVoidCustomCodeClass:Run_FromCharacter(p: number)
	local armorPieceHandler = self.ArmorPieceHandler

	if armorPieceHandler then
		armorPieceHandler:Run(p)

		if armorPieceHandler:IsRunning() then
			armorPieceHandler:UpdateStartBezierData(self:_GetStartBezierData())
		end
	end

	self:_RunEarthquake(p)

	if self.SwordTrailTimingHelper then
		self.SwordTrailTimingHelper:Run(p)
	end

	if self.SwordDestroyTimingHelper then
		self.SwordDestroyTimingHelper:Run(p)
	end

	if self.DeathVFX2TimingHelper then
		self.DeathVFX2TimingHelper:Run(p)
	end

	if self.DeathTimingHelper then
		self.DeathTimingHelper:Run(p)
	end
end

function ExoVoidCustomCodeClass:_TeleportAway()
	event:Fire(Enums.VisualEffects.ExoVoidDeathTeleport, self.RootPart.CFrame.Position)

	if self.DeathVFX2Wrapper then
		self.DeathVFX2Wrapper:StopContinuous()
	end

	HideCharacterInstances(self.CharacterModel)
end

function ExoVoidCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.ExoVoidSwordThrow then
		self:_SwitchToDamagedIdle()
	elseif p == Enums.EnemyAbilities.ExoVoidClawEarthquake then
		self:_StartEarthquake()
	end
end

function ExoVoidCustomCodeClass:_StartEarthquake()
	self.EarthquakeRunning = true
	self.EarthquakeElapsed = 0
	self.SwordTrailsSuppressed = true
	self:_ApplySwordTrailState()
end

function ExoVoidCustomCodeClass:_RunEarthquake(p: number)
	if not self.EarthquakeRunning then
		return
	end

	self.EarthquakeElapsed += p
	local earthquakeShakeStrength = GetEarthquakeShakeStrength(self.EarthquakeElapsed) -- inferred equivalent call

	if earthquakeShakeStrength > 0 or self.EarthquakeShaking then
		SetCameraShake(earthquakeShakeStrength)
		self.EarthquakeShaking = earthquakeShakeStrength > 0
	end

	if self.EarthquakeElapsed >= 7.717 then
		self:_StopEarthquake()
	end
end

function ExoVoidCustomCodeClass:_StopEarthquake()
	if not self.EarthquakeRunning then
		return
	end

	self.EarthquakeRunning = false
	self.EarthquakeElapsed = 0

	if self.EarthquakeShaking then
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.CameraOffset = createVector(0, 0, 0)
		end

		self.EarthquakeShaking = false
	end

	self.SwordTrailsSuppressed = false
	self:_ApplySwordTrailState()
end

function ExoVoidCustomCodeClass:_SwitchToDamagedIdle()
	if self.Damaged then
		return
	end

	self.Damaged = true

	if self.IdleSoundWrapper then
		self.IdleSoundWrapper:StopContinuous()
	end

	if self.IdleDamagedSoundWrapper then
		self.IdleDamagedSoundWrapper:PlayContinuous()
	end

	if self.SwordTrailTimingHelper then
		self.SwordTrailTimingHelper:Destroy()
		self.SwordTrailTimingHelper = nil
	end

	if self.SwordIdleVFX then
		SetTrailsEnabled(self.SwordIdleVFX, false)
		self.SwordIdleVFX = nil
	end

	self.SwordDestroyTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 5,
		Callback = function()
			local v = Utilities.TryGetInstanceFromPath(self.CharacterModel, "Armor>Sword")

			if v then
				v:Destroy()
			end
		end
	})
	self.SwordDestroyTimingHelper:Start()
end

function ExoVoidCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function ExoVoidCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function ExoVoidCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	if self.ArmorPieceHandler then
		self.ArmorPieceHandler:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.IdleSoundWrapper then
		self.IdleSoundWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.IdleDamagedSoundWrapper then
		self.IdleDamagedSoundWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.DeathVFXWrapper then
		self.DeathVFXWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.DeathVFX2Wrapper then
		self.DeathVFX2Wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function ExoVoidCustomCodeClass:_StopIdleSounds(flag: boolean?)
	if self.IdleSoundWrapper then
		self.IdleSoundWrapper:StopContinuous(flag)
	end

	if self.IdleDamagedSoundWrapper then
		self.IdleDamagedSoundWrapper:StopContinuous(flag)
	end
end

function ExoVoidCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	self.Dead = true
	self:_StopIdleSounds(flag)
	self:_StopEarthquake()
	DestroyFlaggedInstances(self.CharacterModel)

	if flag then
		if self.ArmorPieceHandler then
			self.ArmorPieceHandler:InstantCleanUp()
		end
	else
		if self.ArmorPieceHandler then
			self.ArmorPieceHandler:BreakOff(1.5)
		end

		if self.DeathVFXWrapper then
			self.DeathVFXWrapper:PlayAll()
		end

		self.DeathVFX2TimingHelper:Start()
		self.DeathTimingHelper:Start()
	end
end

function ExoVoidCustomCodeClass:CharacterCleanedUp()
	self:_StopIdleSounds(true)
	self:_StopEarthquake()

	if self.SwordTrailTimingHelper then
		self.SwordTrailTimingHelper:Destroy()
		self.SwordTrailTimingHelper = nil
	end

	if self.SwordDestroyTimingHelper then
		self.SwordDestroyTimingHelper:Destroy()
		self.SwordDestroyTimingHelper = nil
	end

	if self.DeathVFX2TimingHelper then
		self.DeathVFX2TimingHelper:Destroy()
		self.DeathVFX2TimingHelper = nil
	end

	if self.DeathTimingHelper then
		self.DeathTimingHelper:Destroy()
		self.DeathTimingHelper = nil
	end
end

return ExoVoidCustomCodeClass