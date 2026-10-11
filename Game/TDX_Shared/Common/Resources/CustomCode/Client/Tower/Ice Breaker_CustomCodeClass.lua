local IceBreakerCustomCodeClass = {}
IceBreakerCustomCodeClass.__index = IceBreakerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
local Utilities = require(common:WaitForChild("Utilities"))

function IceBreakerCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Tower = nil,
		Character = nil,
		CharacterModel = nil,
		SpawnCFrame = nil,
		Root = nil,
		SnowStormTimeLeft = 0,
		SnowStormVisible = false,
		IceVFXPart = nil,
		SnowStormPart = nil,
		Drill = nil,
		DecorDrill = nil
	}, IceBreakerCustomCodeClass))
end

function IceBreakerCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self.Character = tower.Character
	self.SpawnCFrame = tower.CFrame
	self:_Initialize2()
end

function IceBreakerCustomCodeClass:_Initialize2()
	self.CharacterModel = self.Tower.Character:GetCharacterModel()
	self.Root = self.CharacterModel.PrimaryPart
	self.IceVFXPart = Utilities.TryGetInstanceFromPath(self.CharacterModel, "Weapon>IceVFXPart")
	self.SnowStormPart = Utilities.TryGetInstanceFromPath(self.CharacterModel, "SnowStorm>SnowStorm")

	if self.SnowStormPart then
		self.SnowStormPart.Transparency = 1
		local snowStorm = self.Root:FindFirstChild("SnowStorm")

		if snowStorm then
			snowStorm:Destroy()
		end

		self.SnowStormPart.Anchored = true
	end

	self:_TryInitializeDrill()
end

function IceBreakerCustomCodeClass:Run_FromCharacter(p: number)
	self.SnowStormTimeLeft = math.max(0, self.SnowStormTimeLeft - p)

	if self.SnowStormPart then
		if self.SnowStormTimeLeft > 0 then
			if not self.SnowStormVisible then
				local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
				TweenService:Create(self.SnowStormPart, tweenInfo, { Transparency = 0 }):Play()
				self.SnowStormVisible = true
			end
		elseif self.SnowStormVisible then
			local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
			TweenService:Create(self.SnowStormPart, tweenInfo, { Transparency = 1 }):Play()
			self.SnowStormVisible = false
		end
	end
end

function IceBreakerCustomCodeClass:AbilityUsed(object)
	if object:GetName() == "Snow Storm" then
		self.SnowStormTimeLeft = object.Config.ContinuousForTime
	end
end

function IceBreakerCustomCodeClass.AbilityAnimationKeyframeReached(player, p: string, p2: string)
	if p == "Ice Shard" then
		if p2 == "DrillShow" then
			player.Character:ShowModelWithName("Drill")
			player.Character:HideModelWithName("DecorDrill")
		elseif p2 == "DrillHide" then
			player.Character:HideModelWithName("Drill")
			player.Character:ShowModelWithName("DecorDrill")
		end
	end
end

function IceBreakerCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function IceBreakerCustomCodeClass:Upgraded(_)
	self:_Initialize2()
end

function IceBreakerCustomCodeClass.CharacterCleanedUp(_) end

function IceBreakerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function IceBreakerCustomCodeClass.Attacked(p, object, _: boolean?)
	local position = object:GetPosition()
	local iceVFXPart = p.IceVFXPart
	local v = 0.5 * (math.random() - 0.5)
	local v2 = 0.5 * (math.random() - 0.5)
	iceVFXPart.CFrame = CFrame.new(position.X + v, position.Y + 0.03, position.Z + v2)
end

function IceBreakerCustomCodeClass:Death()
	self.SnowStormTimeLeft = 0

	if self.Drill then
		self.Drill:Destroy()
	end
end

function IceBreakerCustomCodeClass:_TryInitializeDrill()
	self.Drill = self.CharacterModel:FindFirstChild("Drill")
	self.DecorDrill = self.CharacterModel:FindFirstChild("DecorDrill")
	self:_HideDrill()
end

function IceBreakerCustomCodeClass:_HideDrill()
	if self.Drill then
		self.Character:HideModelWithName("Drill")
	end
end

return IceBreakerCustomCodeClass