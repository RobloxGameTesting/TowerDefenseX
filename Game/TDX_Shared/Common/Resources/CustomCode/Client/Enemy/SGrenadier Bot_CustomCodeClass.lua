local SGrenadierBotCustomCodeClass = {}
SGrenadierBotCustomCodeClass.__index = SGrenadierBotCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("TimingHelperClass"))

local function HideInstances(animatedWeaponInstances)
	for _, instance in ipairs(animatedWeaponInstances) do
		if instance:IsA("BasePart") then
			instance.Transparency = 1
			instance.CanQuery = false
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 1
		end
	end
end

local function ShowInstances(animatedWeaponInstances)
	for _, instance in ipairs(animatedWeaponInstances) do
		if instance:IsA("BasePart") then
			instance.Transparency = 0
			instance.CanQuery = true
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 0
		end
	end
end

function SGrenadierBotCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		AnimatedWeaponInstances = nil,
		_TimingHelpers = {}
	}, SGrenadierBotCustomCodeClass))
end

function SGrenadierBotCustomCodeClass:Initialize(enemy, config)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	self.Config = config
	local animatedWeaponInstances

	if self.CharacterModel:FindFirstChild("AnimatedWeapon") then
		animatedWeaponInstances = self.CharacterModel:FindFirstChild("AnimatedWeapon"):GetDescendants()
	end

	self.AnimatedWeaponInstances = animatedWeaponInstances
end

function SGrenadierBotCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function SGrenadierBotCustomCodeClass.AbilityUsed(_, _: string) end

function SGrenadierBotCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function SGrenadierBotCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function SGrenadierBotCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function SGrenadierBotCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function SGrenadierBotCustomCodeClass.AnimationStateChanged(p, p2: string, _)
	if p2 == "Move" then
		HideInstances(p.AnimatedWeaponInstances)
	else
		ShowInstances(p.AnimatedWeaponInstances)
	end
end

return SGrenadierBotCustomCodeClass