local RevivedPlagueDoctorReworkCustomCodeClass = {}
RevivedPlagueDoctorReworkCustomCodeClass.__index = RevivedPlagueDoctorReworkCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))

function RevivedPlagueDoctorReworkCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		MaximumDamageOn = false
	}, RevivedPlagueDoctorReworkCustomCodeClass))
end

function RevivedPlagueDoctorReworkCustomCodeClass:Initialize(enemy, _)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
end

function RevivedPlagueDoctorReworkCustomCodeClass:Run_FromCharacter(_: number)
	local enemy = self.Enemy

	if enemy and enemy:Alive() then
		local maximumDamageOn = enemy.MaximumDamage >= 0

		if maximumDamageOn ~= self.MaximumDamageOn then
			self.MaximumDamageOn = maximumDamageOn

			if maximumDamageOn then
				self.Character:ToggleShieldIfExists(true)
			else
				self.Character:ToggleShieldIfExists(false)
			end
		end
	end
end

function RevivedPlagueDoctorReworkCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function RevivedPlagueDoctorReworkCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function RevivedPlagueDoctorReworkCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function RevivedPlagueDoctorReworkCustomCodeClass.EnemyDestroyed(player, flag: boolean?, _: boolean?)
	player.Character:ToggleShieldIfExists(false)

	if flag then
	end
end

function RevivedPlagueDoctorReworkCustomCodeClass.CharacterCleanedUp(_) end

function RevivedPlagueDoctorReworkCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return RevivedPlagueDoctorReworkCustomCodeClass