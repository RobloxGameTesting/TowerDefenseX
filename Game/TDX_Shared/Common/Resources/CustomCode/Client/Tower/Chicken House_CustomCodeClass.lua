local ChickenHouseCustomCodeClass = {}
ChickenHouseCustomCodeClass.__index = ChickenHouseCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local Utilities = require(common:WaitForChild("Utilities"))

function ChickenHouseCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Tower = nil,
		FXPart = nil,
		CashTickDuration = nil,
		RemainingCashTickDuration = nil
	}, ChickenHouseCustomCodeClass))
end

function ChickenHouseCustomCodeClass:Initialize(tower, p)
	local characterModel = tower.Character:GetCharacterModel()
	self.Tower = tower
	self.FXPart = Utilities.TryGetInstanceFromPath(characterModel, "FXPart")
	self.CashTickDuration = p.UpgradePathData.BaseLevelData.CashTickDuration
	self.RemainingCashTickDuration = 0
	self.CashTickFX = WrapperFactory.NewEmitterAndSoundWrapper(self.FXPart, self.SpeedMultiplier)
end

function ChickenHouseCustomCodeClass:Run_FromCharacter(p: number)
	self:_UpdateCashPerTickFX(p)
end

function ChickenHouseCustomCodeClass.AbilityUsed(_, _) end

function ChickenHouseCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function ChickenHouseCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	if self.CashTickFX then
		self.CashTickFX:SpeedMultiplierChanged(speedMultiplier)
	end
end

function ChickenHouseCustomCodeClass:_UpdateCashPerTickFX(p: number)
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

function ChickenHouseCustomCodeClass:Upgraded(p)
	local characterModel = self.Tower.Character:GetCharacterModel()
	self.CashTickDuration = p.CashTickDuration
	self.FXPart = Utilities.TryGetInstanceFromPath(characterModel, "FXPart")
	self.CashTickFX = WrapperFactory.NewEmitterAndSoundWrapper(self.FXPart, self.SpeedMultiplier)
end

function ChickenHouseCustomCodeClass.CharacterCleanedUp(p)
	if p.CashTickFX then
		p.CashTickFX:StopContinuous()
	end
end

function ChickenHouseCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function ChickenHouseCustomCodeClass.Attacked(_, _, _: boolean?) end

function ChickenHouseCustomCodeClass.Death(_) end

return ChickenHouseCustomCodeClass