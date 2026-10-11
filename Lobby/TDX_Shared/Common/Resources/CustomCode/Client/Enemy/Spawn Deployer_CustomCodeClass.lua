local SpawnDeployerCustomCodeClass = {}
SpawnDeployerCustomCodeClass.__index = SpawnDeployerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
require(common:WaitForChild("Utilities"))

function SpawnDeployerCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		ForceFieldActive = false,
		ForceFieldTimeLeft = 0
	}, SpawnDeployerCustomCodeClass))
end

function SpawnDeployerCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
end

function SpawnDeployerCustomCodeClass:Run_FromCharacter(p: number)
	if self.ForceFieldActive then
		self.ForceFieldTimeLeft -= p

		if self.ForceFieldTimeLeft <= 0 then
			self.Character:ToggleShieldIfExists(false)
			self.ForceFieldActive = false
		end
	end
end

function SpawnDeployerCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.DeployerInitialShield then
		local ResourceManager = require(common:WaitForChild("ResourceManager"))
		local gainDamageReductionData = ResourceManager.GetEnemyAbilityConfig(p).GainDamageReductionData

		if gainDamageReductionData then
			self.Character:ToggleShieldIfExists(true)
			self.ForceFieldActive = true
			self.ForceFieldTimeLeft = gainDamageReductionData.Time
		end
	end
end

function SpawnDeployerCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function SpawnDeployerCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function SpawnDeployerCustomCodeClass.EnemyDestroyed(player, flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	player.Character:StopStealthShimmer()
	player.Character:ToggleShieldIfExists(false)
end

function SpawnDeployerCustomCodeClass.CharacterCleanedUp(_) end

function SpawnDeployerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return SpawnDeployerCustomCodeClass