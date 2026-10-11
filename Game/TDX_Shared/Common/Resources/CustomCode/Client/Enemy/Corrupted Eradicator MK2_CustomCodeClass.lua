local createVector = vector.create
local CorruptedEradicatorMK2CustomCodeClass = {}
CorruptedEradicatorMK2CustomCodeClass.__index = CorruptedEradicatorMK2CustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local LightAnimationHandlerClass = require(common:WaitForChild("LightAnimationHandlerClass"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(190, 190, 190)
local color3 = Color3.fromRGB(99, 0, 0)
local event = BindableHandler.GetEvent("LockTowerDirectControlForTime")
local LocalPlayer = Players.LocalPlayer
local corruptedEradicatorMK2Jumpscare = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("CorruptedEradicatorMK2Jumpscare")
local viewportFrame = corruptedEradicatorMK2Jumpscare:FindFirstChildOfClass("ViewportFrame")
local camera = Instance.new("Camera")
local cameraPosition = viewportFrame:WaitForChild("CameraPosition")
local worldModel = viewportFrame:WaitForChild("WorldModel")
local root = worldModel:WaitForChild("Root")
local v = nil
local colorCorrectionEffect = nil
local blurEffect = nil
local v2 = false
local flag = false
local flag2 = false

local function InitializeJumpscare(p: number)
	corruptedEradicatorMK2Jumpscare.Visible = true
	viewportFrame.Visible = false
	camera.FieldOfView = 50
	local enemyModel = ResourceManager.GetEnemyModel(Enums.Enemies.CorruptedEradicatorMK2)
	enemyModel:PivotTo(root:GetPivot())
	enemyModel.Parent = worldModel
	v = LightAnimationHandlerClass.New(enemyModel, p, true)
	colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "JumpscareColorCorrection"
	colorCorrectionEffect.Parent = Lighting
	blurEffect = Instance.new("BlurEffect")
	blurEffect.Name = "JumpscareBlurEffect"
	blurEffect.Parent = Lighting
	v2 = true
end

local function StartJumpscare() -- 1 equivalent call inferred from this helper
	viewportFrame.Visible = false
	viewportFrame.ImageTransparency = 0
	camera.FieldOfView = 50
	colorCorrectionEffect.Contrast = 0
	colorCorrectionEffect.TintColor = color
	colorCorrectionEffect.Enabled = true
	blurEffect.Size = 0
	blurEffect.Enabled = true
	flag = true
end

local function CleanupJumpscare() -- 3 equivalent calls inferred from this helper
	flag2 = false
	viewportFrame.Visible = false
	colorCorrectionEffect.Enabled = false
	blurEffect.Enabled = false
	corruptedEradicatorMK2Jumpscare.BackgroundTransparency = 1
	flag = false
end

function CorruptedEradicatorMK2CustomCodeClass.New(speedMultiplier: number)
	if not v2 then
		InitializeJumpscare(speedMultiplier)
	end

	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		ShieldTimeLeft = 35,
		ShieldActive = false,
		PreviousAbilityName = nil,
		_TimingHelpers = {
			DeathTimingHelper = nil,
			SkyDarkenSlow = nil,
			SkyDarkenFast = nil,
			JumpscareStart = nil,
			BlackScreenStart = nil,
			BlackScreenEnd = nil,
			JumpscareCleanup = nil
		},
		_Wrappers = { DeathExplode = nil }
	}, CorruptedEradicatorMK2CustomCodeClass))
end

function CorruptedEradicatorMK2CustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	local leftArmCollider = characterModel:FindFirstChild("LeftArmCollider")
	local rightArmCollider = characterModel:FindFirstChild("RightArmCollider")
	local deathAnimationVFX = characterModel:FindFirstChild("DeathAnimationVFX")
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._Wrappers.DeathExplode:AddFrom(leftArmCollider, speedMultiplier)
	self._Wrappers.DeathExplode:AddFrom(rightArmCollider, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 4.9,
		Callback = function()
			deathAnimationVFX:Destroy()
			self._Wrappers.DeathExplode:PlayAll()
			self.Character:ExplodeParts(2)
		end
	})

	if not flag then
		self._TimingHelpers.SkyDarkenSlow = TimingHelperClass.New({
			TimeUntilCallback = 73,
			Callback = function()
				TweenService:Create(
					colorCorrectionEffect,
					TweenInfo.new(42, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
					{ TintColor = color2 }
				):Play()
			end
		})
		self._TimingHelpers.SkyDarkenFast = TimingHelperClass.New({
			TimeUntilCallback = 115,
			Callback = function()
				event:Fire(3.9000000000000057)
				TweenService:Create(
					colorCorrectionEffect,
					TweenInfo.new(2.200000000000003, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
					{ TintColor = color3, Contrast = 10 }
				):Play()
			end
		})
		self._TimingHelpers.JumpscareStart = TimingHelperClass.New({
			TimeUntilCallback = 117.2,
			Callback = function()
				flag2 = true
				viewportFrame.Visible = true
				v:Play("Jumpscare")
				SoundHandler.Play("CorruptedEradicatorMK2Jumpscare")
				TweenService:Create(blurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
					Size = 36
				}):Play()
				TweenService:Create(camera, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					FieldOfView = 35
				}):Play()
			end
		})
		self._TimingHelpers.BlackScreenStart = TimingHelperClass.New({
			TimeUntilCallback = 117.6,
			Callback = function()
				flag2 = false
				TweenService:Create(
					corruptedEradicatorMK2Jumpscare,
					TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ BackgroundTransparency = 0 }
				):Play()
				task.delay(0.2, function()
					TweenService:Create(
						viewportFrame,
						TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ ImageTransparency = 1 }
					):Play()
				end)
				TweenService:Create(
					colorCorrectionEffect,
					TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ TintColor = color }
				):Play()
				TweenService:Create(
					colorCorrectionEffect,
					TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ Contrast = 0 }
				):Play()
				TweenService:Create(blurEffect, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = 0
				}):Play()
				task.delay(6, function()
					viewportFrame.Visible = false
					colorCorrectionEffect.Enabled = false
					blurEffect.Enabled = false
				end)
			end
		})
		self._TimingHelpers.BlackScreenEnd = TimingHelperClass.New({
			TimeUntilCallback = 118.4,
			Callback = function()
				TweenService:Create(
					corruptedEradicatorMK2Jumpscare,
					TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ BackgroundTransparency = 1 }
				):Play()
			end
		})
		self._TimingHelpers.JumpscareCleanup = TimingHelperClass.New({
			TimeUntilCallback = 122,
			Callback = function()
				if flag then
					CleanupJumpscare() -- inferred equivalent call
				end
			end
		})
		self._TimingHelpers.SkyDarkenSlow:Start()
		self._TimingHelpers.SkyDarkenFast:Start()
		self._TimingHelpers.JumpscareStart:Start()
		self._TimingHelpers.BlackScreenStart:Start()
		self._TimingHelpers.BlackScreenEnd:Start()
		self._TimingHelpers.JumpscareCleanup:Start()
		StartJumpscare() -- inferred equivalent call
	end
end

function CorruptedEradicatorMK2CustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.ShieldActive then
		self.ShieldTimeLeft -= p

		if self.ShieldTimeLeft <= 0 then
			self.ShieldActive = false
			self.Character:ToggleShieldIfExists(false)
		end
	end
end

function CorruptedEradicatorMK2CustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName

	if
		previousAbilityName == Enums.EnemyAbilities.CorruptedEradicatorMK2PreJumpscareShield
		and not self.ShieldActive
	then
		self.ShieldActive = true
		self.ShieldTimeLeft = 35
		self.Character:ToggleShieldIfExists(true)
	end
end

function CorruptedEradicatorMK2CustomCodeClass.AbilityAnimationKeyframeReached(p, _: string, p2: string)
	local characterModel = p.CharacterModel
	local primaryPart = characterModel.PrimaryPart
	local v3 = nil
	local v4 = nil

	if p2 == "ExplodeRight" then
		v3 = Utilities.TryGetInstanceFromPath(characterModel, "UpperTorso>UpperRightArm")
		v4 = Utilities.TryGetInstanceFromPath(characterModel, "RightArmCollider")
	elseif p2 == "ExplodeLeft" then
		v3 = Utilities.TryGetInstanceFromPath(characterModel, "UpperTorso>UpperLeftArm")
		v4 = Utilities.TryGetInstanceFromPath(characterModel, "LeftArmCollider")
	end

	if v3 then
		v3.Enabled = false
	end

	if v4 then
		v4.CanCollide = true
		local unit = (v4.Position - primaryPart.Position + createVector(0, 1.5, 0)).Unit
		local mass = v4:GetMass()
		v4:ApplyImpulse(110 * unit * mass)
	end
end

function CorruptedEradicatorMK2CustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function CorruptedEradicatorMK2CustomCodeClass:EnemyDestroyed(_: boolean?, _: boolean?)
	self._TimingHelpers.DeathTimingHelper:Start()
	self.Character:ToggleShieldIfExists(false)

	if flag then
		CleanupJumpscare() -- inferred equivalent call
	end

	self._TimingHelpers.SkyDarkenSlow = nil
	self._TimingHelpers.SkyDarkenFast = nil
	self._TimingHelpers.JumpscareStart = nil
	self._TimingHelpers.BlackScreenStart = nil
	self._TimingHelpers.BlackScreenEnd = nil
	self._TimingHelpers.JumpscareCleanup = nil
end

function CorruptedEradicatorMK2CustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end

	if flag then
		CleanupJumpscare() -- inferred equivalent call
	end
end

function CorruptedEradicatorMK2CustomCodeClass.AnimationStateChanged(_, _: string, _) end

camera.CFrame = cameraPosition.CFrame
camera.FieldOfView = 50
camera.Parent = viewportFrame
viewportFrame.CurrentCamera = camera
task.spawn(function()
	while true do
		if flag2 then
			local humanoid = LocalPlayer and LocalPlayer.Character and LocalPlayer.Character.Humanoid

			if not humanoid then
				break
			end

			local vector = Vector3.new(math.random(-1.8, 1.8), math.random(-1.8, 1.8), math.random(-1.8, 1.8))
			local cameraOffset = humanoid.CameraOffset
			local tween = TweenService:Create(humanoid, TweenInfo.new(0.05, Enum.EasingStyle.Quad), {
				CameraOffset = cameraOffset + vector
			})
			tween:Play()
			tween.Completed:Wait()
			humanoid.CameraOffset = cameraOffset
		else
			task.wait()
		end
	end
end)
return CorruptedEradicatorMK2CustomCodeClass