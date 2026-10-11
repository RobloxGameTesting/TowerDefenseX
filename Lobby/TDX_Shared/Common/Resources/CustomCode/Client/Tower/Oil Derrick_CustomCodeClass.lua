local OilDerrickCustomCodeClass = {}
OilDerrickCustomCodeClass.__index = OilDerrickCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local Utilities = require(common:WaitForChild("Utilities"))

function OilDerrickCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Tower = nil,
		FXPart = nil,
		CashTickDuration = nil,
		RemainingCashTickDuration = nil
	}, OilDerrickCustomCodeClass))
end

function OilDerrickCustomCodeClass:Initialize(tower, p)
	local characterModel = tower.Character:GetCharacterModel()
	self.Tower = tower
	self.FXPart = Utilities.TryGetInstanceFromPath(characterModel, "FXPart")
	self.CashTickDuration = p.UpgradePathData.BaseLevelData.CashTickDuration
	self.RemainingCashTickDuration = 0
	self.CashTickFX = WrapperFactory.NewEmitterAndSoundWrapper(self.FXPart, self.SpeedMultiplier)
end

function OilDerrickCustomCodeClass:Run_FromCharacter(p: number)
	self:_UpdateCashPerTickFX(p)
end

function OilDerrickCustomCodeClass.AbilityUsed(_, _) end

function OilDerrickCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function OilDerrickCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	if self.CashTickFX then
		self.CashTickFX:SpeedMultiplierChanged(speedMultiplier)
	end
end

function OilDerrickCustomCodeClass:_UpdateCashPerTickFX(p: number)
	local cashTickDuration = self.CashTickDuration

	if not (cashTickDuration and self.RemainingCashTickDuration) then
		return
	end

	local remainingCashTickDuration = self.RemainingCashTickDuration - p
	local v = math.abs(remainingCashTickDuration)

	if not (remainingCashTickDuration <= 0) then
		self.RemainingCashTickDuration = remainingCashTickDuration
		return
	end

	if self.CashTickFX then
		self.CashTickFX:PlayAll()
	end

	self.RemainingCashTickDuration = cashTickDuration - v
end

function OilDerrickCustomCodeClass:Upgraded(p)
	local characterModel = self.Tower.Character:GetCharacterModel()
	self.CashTickDuration = p.CashTickDuration
	self.RemainingCashTickDuration = 0
	self.FXPart = Utilities.TryGetInstanceFromPath(characterModel, "FXPart")
	self.CashTickFX = WrapperFactory.NewEmitterAndSoundWrapper(self.FXPart, self.SpeedMultiplier)
end

function OilDerrickCustomCodeClass.CharacterCleanedUp(p)
	if p.CashTickFX then
		p.CashTickFX:StopContinuous()
	end
end

function OilDerrickCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function OilDerrickCustomCodeClass.Attacked(_, _, _: boolean?) end

function OilDerrickCustomCodeClass.Death(_) end

return OilDerrickCustomCodeClass