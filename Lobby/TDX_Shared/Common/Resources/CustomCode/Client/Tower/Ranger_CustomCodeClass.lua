local RangerCustomCodeClass = {}
RangerCustomCodeClass.__index = RangerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

local function AddSparkles(ownerName: string, realTorso) -- 2 equivalent calls inferred from this helper
	local child = Players:FindFirstChild(ownerName)

	if child and child:GetAttribute("TDXRealPlayerBadge") then
		if child:GetAttribute("Developer") then
			return
		end

		local sparkles = Instance.new("Sparkles")
		sparkles.Name = "RangerSparkles"
		sparkles.Parent = realTorso
		sparkles.Enabled = true
	end
end

function RangerCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable(
		{ SpeedMultiplier = speedMultiplier, Tower = nil, Character = nil, OwnerName = nil },
		RangerCustomCodeClass
	))
end

function RangerCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self.Character = tower.Character
	self.OwnerName = tower.OwnerName
	local realTorso = self.Character:GetRealTorso()
	AddSparkles(self.OwnerName, realTorso) -- inferred equivalent call
end

function RangerCustomCodeClass.Run_FromCharacter(_, _: number) end

function RangerCustomCodeClass.AbilityUsed(_, _) end

function RangerCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function RangerCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function RangerCustomCodeClass.Upgraded(player, _)
	local realTorso = player.Character:GetRealTorso()

	if not realTorso:FindFirstChild("RangerSparkles") then
		AddSparkles(player.OwnerName, realTorso) -- inferred equivalent call
	end
end

function RangerCustomCodeClass.CharacterCleanedUp(_) end

function RangerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function RangerCustomCodeClass.Attacked(_, _, _: boolean?) end

function RangerCustomCodeClass.Death(_) end

return RangerCustomCodeClass