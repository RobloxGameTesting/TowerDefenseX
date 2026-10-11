local UmbrixCustomCodeClass = {}
UmbrixCustomCodeClass.__index = UmbrixCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))

function UmbrixCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		FreezeRunning = false,
		FreezeElapsed = 0,
		FreezeTintStarted = false,
		FreezeColorCorrection = nil
	}, UmbrixCustomCodeClass))
end

function UmbrixCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
end

function UmbrixCustomCodeClass:_StartFreezeEffect()
	self:_CleanUpFreezeEffect(true)
	self.FreezeRunning = true
	self.FreezeElapsed = 0
	self.FreezeTintStarted = false
end

function UmbrixCustomCodeClass:_RunFreezeEffect(p: number)
	if not self.FreezeRunning then
		return
	end

	self.FreezeElapsed += p
	local freezeElapsed = self.FreezeElapsed

	if not self.FreezeTintStarted and freezeElapsed >= 53 / 30 then
		self.FreezeTintStarted = true
		self:_ShowFreezeTint()
	end

	if freezeElapsed >= 13 / 3 then
		self:_StopFreezeEffect()
	end
end

function UmbrixCustomCodeClass:_ShowFreezeTint()
	local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "UmbrixTimeFreezeColorCorrection"
	colorCorrectionEffect.Parent = Lighting
	self.FreezeColorCorrection = colorCorrectionEffect
	TweenService:Create(colorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Saturation = -0.5
	}):Play()
end

function UmbrixCustomCodeClass:_StopFreezeEffect()
	self.FreezeRunning = false
	self.FreezeTintStarted = false
	local freezeColorCorrection = self.FreezeColorCorrection
	self.FreezeColorCorrection = nil

	if freezeColorCorrection then
		local tween = TweenService:Create(
			freezeColorCorrection,
			TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Saturation = 0 }
		)
		tween.Completed:Once(function()
			freezeColorCorrection:Destroy()
		end)
		tween:Play()
	end
end

function UmbrixCustomCodeClass:_CleanUpFreezeEffect(flag: boolean?)
	if not (self.FreezeRunning or self.FreezeColorCorrection) then
		return
	end

	if flag then
		self.FreezeRunning = false
		self.FreezeTintStarted = false

		if self.FreezeColorCorrection then
			self.FreezeColorCorrection:Destroy()
			self.FreezeColorCorrection = nil
		end
	else
		self:_StopFreezeEffect()
	end
end

function UmbrixCustomCodeClass:Run_FromCharacter(p: number)
	self:_RunFreezeEffect(p)
end

function UmbrixCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.UmbrixCrystalCopy then
		self:_StartFreezeEffect()
	end
end

function UmbrixCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function UmbrixCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function UmbrixCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function UmbrixCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	self:_CleanUpFreezeEffect(flag)
end

function UmbrixCustomCodeClass:CharacterCleanedUp()
	self:_CleanUpFreezeEffect(true)
end

return UmbrixCustomCodeClass