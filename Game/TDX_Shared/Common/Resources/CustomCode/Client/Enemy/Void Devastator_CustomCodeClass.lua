local createVector = vector.create
local VoidDevastatorCustomCodeClass = {}
VoidDevastatorCustomCodeClass.__index = VoidDevastatorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local ReplacementPieceHandlerClass = require(common:WaitForChild("ReplacementPieceHandlerClass"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local numberRange = NumberRange.new(-300, 300)
local color = Color3.fromRGB(202, 103, 230)
local LocalPlayer = Players.LocalPlayer
local whiteoutFrame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("WhiteoutFrame")

local function HideInstances(folder)
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

local function ShowInstances(folder)
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

local function CollectEffects(folder, className: string)
	local descendants = {}

	for _, descendant in pairs(folder:GetDescendants()) do
		if descendant:IsA(className) then
			table.insert(descendants, descendant)
		end
	end

	return descendants
end

local function SetEffectsEnabled(items, enabled: boolean) -- 7 equivalent calls inferred from this helper
	if not items then
		return
	end

	for _, item in pairs(items) do
		item.Enabled = enabled
	end
end

function VoidDevastatorCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		RootPart = nil,
		ArmorPieces = nil,
		ArmorPieceHandler = nil,
		ArmorFlyStarted = false,
		LauncherModel = nil,
		SwordModel = nil,
		SwordEmitterWrapper = nil,
		SwordTrails = nil,
		SwordShown = false,
		CrystalInfectionRunning = false,
		CrystalInfectionElapsed = 0,
		CrystalInfectionTintStarted = false,
		CrystalInfectionColorCorrection = nil,
		CrystalInfectionBeams = nil,
		_DeathTimingHelpers = {},
		_DeathWrappers = {},
		Dead = false
	}, VoidDevastatorCustomCodeClass))
end

function VoidDevastatorCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local characterModel = self.CharacterModel
	self.RootPart = characterModel.PrimaryPart
	local armor = characterModel:FindFirstChild("Armor")

	if armor then
		self.ArmorFolder = armor
		HideInstances(armor)
		local children = {}

		for _, child in pairs(armor:GetChildren()) do
			if child:GetAttribute("AttachTime") then
				table.insert(children, child)
			end
		end

		if #children > 0 then
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
		else
			warn("Void Devastator Armor folder has no pieces with an AttachTime attribute")
		end
	else
		warn("Void Devastator Armor folder not found")
	end

	self:_SetUpWeapons(characterModel)
	local crystalInfection = characterModel:FindFirstChild("CrystalInfection", true)

	if crystalInfection then
		self.CrystalInfectionBeams = CollectEffects(crystalInfection, "Beam")
		SetEffectsEnabled(self.CrystalInfectionBeams, false) -- inferred equivalent call
	else
		warn("Void Devastator CrystalInfection model not found")
	end

	self:_SetUpDeath()
end

function VoidDevastatorCustomCodeClass:_SetUpDeath()
	local characterModel = self.CharacterModel
	local v = Utilities.TryGetInstanceFromPath(characterModel, "Death>Death1")
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(v, self.SpeedMultiplier)
	table.insert(self._DeathWrappers, emitterAndSoundWrapper)
	self._DeathTimingHelpers.Death1Start = TimingHelperClass.New({
		TimeUntilCallback = 0,
		Callback = function()
			emitterAndSoundWrapper:PlayAll()
		end
	})
	self._DeathTimingHelpers.Death1End = TimingHelperClass.New({
		TimeUntilCallback = 10.05,
		Callback = function()
			emitterAndSoundWrapper:StopContinuous()
		end
	})
	self._DeathTimingHelpers.DeathExplosion = TimingHelperClass.New({
		TimeUntilCallback = 10.05,
		Callback = function()
			self:_DeathExplosion()
		end
	})
end

function VoidDevastatorCustomCodeClass:_DeathExplosion()
	for _, effect in pairs(self.CharacterModel:GetDescendants()) do
		if effect:IsA("Trail") or effect:IsA("Beam") then
			effect:Destroy()
		end
	end

	if self.SwordEmitterWrapper then
		self.SwordEmitterWrapper:StopContinuous()
	end

	for _, deathWrapper in pairs(self._DeathWrappers) do
		deathWrapper:StopContinuous()
	end

	whiteoutFrame.Visible = true
	whiteoutFrame.BackgroundTransparency = 1
	task.delay(0.15, function()
		TweenService:Create(whiteoutFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0
		}):Play()
		task.wait(5.1)
		local tween = TweenService:Create(
			whiteoutFrame,
			TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ BackgroundTransparency = 1 }
		)
		tween.Completed:Once(function()
			if whiteoutFrame.BackgroundTransparency >= 1 then
				whiteoutFrame.Visible = false
			end
		end)
		tween:Play()
	end)
end

function VoidDevastatorCustomCodeClass:_GetStartBezierData()
	local position = self.RootPart.CFrame.Position
	return {
		P1 = position + createVector(0, 120, 0),
		P2 = position + createVector(0, 20, 0)
	}
end

function VoidDevastatorCustomCodeClass:_StartArmorFly()
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

	ShowInstances(self.ArmorFolder)
	self.ArmorPieceHandler:Start(self:_GetStartBezierData())
end

function VoidDevastatorCustomCodeClass:_SetUpWeapons(instance)
	self.LauncherModel = instance:FindFirstChild("devastatorlauncher", true)

	if not self.LauncherModel then
		warn("Void Devastator devastatorlauncher model not found")
	end

	local devestatorsword = instance:FindFirstChild("devestatorsword", true)

	if not devestatorsword then
		warn("Void Devastator devestatorsword model not found")
		return
	end

	self.SwordModel = devestatorsword
	self.SwordTrails = CollectEffects(devestatorsword, "Trail")
	self.SwordEmitterWrapper = WrapperFactory.NewEmitterWrapper(devestatorsword, self.SpeedMultiplier)
	HideInstances(devestatorsword)
	SetEffectsEnabled(self.SwordTrails, false) -- inferred equivalent call
end

function VoidDevastatorCustomCodeClass:_ShowSword()
	if self.SwordShown then
		return
	end

	self.SwordShown = true

	if not self.SwordModel then
		return
	end

	ShowInstances(self.SwordModel)
	SetEffectsEnabled(self.SwordTrails, true) -- inferred equivalent call

	if self.SwordEmitterWrapper then
		self.SwordEmitterWrapper:PlayAll()
	end
end

function VoidDevastatorCustomCodeClass:_StartCrystalInfection()
	self:_CleanUpCrystalInfection(true)
	self.CrystalInfectionRunning = true
	self.CrystalInfectionElapsed = 0
	self.CrystalInfectionTintStarted = false
end

function VoidDevastatorCustomCodeClass:_RunCrystalInfection(p: number)
	if not self.CrystalInfectionRunning then
		return
	end

	self.CrystalInfectionElapsed += p
	local crystalInfectionElapsed = self.CrystalInfectionElapsed

	if not self.CrystalInfectionTintStarted and crystalInfectionElapsed >= 2.833 then
		self.CrystalInfectionTintStarted = true
		self:_ShowCrystalInfectionTint()
	end

	if self.CrystalInfectionTintStarted then
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * 0.35
		end
	end

	if crystalInfectionElapsed >= 17.3 then
		self:_StopCrystalInfection()
	end
end

function VoidDevastatorCustomCodeClass:_ShowCrystalInfectionTint()
	local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "VoidDevastatorCrystalInfection"
	colorCorrectionEffect.TintColor = Color3.new(1, 1, 1)
	colorCorrectionEffect.Parent = Lighting
	self.CrystalInfectionColorCorrection = colorCorrectionEffect
	TweenService:Create(colorCorrectionEffect, TweenInfo.new(2), {
		TintColor = color,
		Contrast = 0.7,
		Brightness = 0,
		Saturation = -0.7
	}):Play()
end

function VoidDevastatorCustomCodeClass:_StopCrystalInfection()
	self.CrystalInfectionRunning = false
	self.CrystalInfectionTintStarted = false
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.CameraOffset = createVector(0, 0, 0)
	end

	local crystalInfectionColorCorrection = self.CrystalInfectionColorCorrection
	self.CrystalInfectionColorCorrection = nil

	if crystalInfectionColorCorrection then
		local tween = TweenService:Create(crystalInfectionColorCorrection, TweenInfo.new(2), {
			TintColor = Color3.new(1, 1, 1),
			Contrast = 0,
			Brightness = 0,
			Saturation = 0
		})
		tween.Completed:Once(function()
			crystalInfectionColorCorrection:Destroy()
		end)
		tween:Play()
	end
end

function VoidDevastatorCustomCodeClass:_CleanUpCrystalInfection(flag: boolean?)
	if not (self.CrystalInfectionRunning or self.CrystalInfectionColorCorrection) then
		return
	end

	if flag then
		self.CrystalInfectionRunning = false
		self.CrystalInfectionTintStarted = false
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.CameraOffset = createVector(0, 0, 0)
		end

		if self.CrystalInfectionColorCorrection then
			self.CrystalInfectionColorCorrection:Destroy()
			self.CrystalInfectionColorCorrection = nil
		end
	else
		self:_StopCrystalInfection()
	end
end

function VoidDevastatorCustomCodeClass:Run_FromCharacter(p: number)
	local armorPieceHandler = self.ArmorPieceHandler

	if armorPieceHandler then
		armorPieceHandler:Run(p)

		if armorPieceHandler:IsRunning() then
			armorPieceHandler:UpdateStartBezierData(self:_GetStartBezierData())
		end
	end

	self:_RunCrystalInfection(p)

	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Run(p)
	end
end

function VoidDevastatorCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.VoidDevastatorAwakening then
		self:_StartArmorFly()

		if self.LauncherModel then
			HideInstances(self.LauncherModel)
		end
	elseif p == Enums.EnemyAbilities.VoidDevastatorCrystalInfection then
		self:_StartCrystalInfection()
	end
end

function VoidDevastatorCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.VoidDevastatorAwakening then
		if p2 == "ShowSword" then
			self:_ShowSword()
		end
	elseif p == Enums.EnemyAbilities.VoidDevastatorCrystalInfection then
		if p2 == "StormLightning" then
			SetEffectsEnabled(self.CrystalInfectionBeams, true) -- inferred equivalent call
		elseif p2 == "StormLightning_Stop" then
			SetEffectsEnabled(self.CrystalInfectionBeams, false) -- inferred equivalent call
		end
	end
end

function VoidDevastatorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function VoidDevastatorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, deathWrapper in pairs(self._DeathWrappers) do
		deathWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.ArmorPieceHandler then
		self.ArmorPieceHandler:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.SwordEmitterWrapper then
		self.SwordEmitterWrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function VoidDevastatorCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	self.Dead = true

	if not (flag or flag2) then
		for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
			deathTimingHelper:Start()
		end
	end

	self:_CleanUpCrystalInfection(flag)

	if self.SwordEmitterWrapper then
		self.SwordEmitterWrapper:StopContinuous()
	end

	SetEffectsEnabled(self.SwordTrails, false) -- inferred equivalent call
	SetEffectsEnabled(self.CrystalInfectionBeams, false) -- inferred equivalent call

	if not self.ArmorPieceHandler then
		return
	end

	if flag then
		self.ArmorPieceHandler:InstantCleanUp()
	else
		self.ArmorPieceHandler:Stop(true)
	end
end

function VoidDevastatorCustomCodeClass:CharacterCleanedUp()
	for _, deathTimingHelper in pairs(self._DeathTimingHelpers) do
		deathTimingHelper:Destroy()
	end

	self:_CleanUpCrystalInfection(true)
end

return VoidDevastatorCustomCodeClass