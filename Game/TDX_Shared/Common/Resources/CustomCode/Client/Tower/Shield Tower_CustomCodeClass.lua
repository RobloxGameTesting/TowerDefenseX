local ShieldTowerCustomCodeClass = {}
ShieldTowerCustomCodeClass.__index = ShieldTowerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local miscResource = ResourceManager.GetMiscResource("ShieldBlueRing", true)
local miscResource2 = ResourceManager.GetMiscResource("ShieldBlueRingMax", true)
local miscResource3 = ResourceManager.GetMiscResource("ShieldOrangeRing", true)
local miscResource4 = ResourceManager.GetMiscResource("ShieldOrangeRingMax", true)

function ShieldTowerCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		Tower = nil,
		Character = nil,
		Torso = nil,
		SpeedMultiplier = speedMultiplier,
		CurrentRange = -1,
		CurrentRingIsBlue = false,
		CurrentShieldRing = nil,
		CurrentShieldParts = {},
		CurrentShieldTransparency = 1,
		CurrentShieldEffectWrapper = nil,
		PreviousShield = -1,
		ShieldEffectWrapperOn = false
	}, ShieldTowerCustomCodeClass))
end

function ShieldTowerCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self.Character = tower.Character
	self.Torso = self.Character.Torso
	self:_InitializeShieldRing()
end

function ShieldTowerCustomCodeClass:_InitializeShieldRing()
	local levelHandler = self.Tower.LevelHandler
	local v = levelHandler:GetLevelStats().ShieldSharedGrant > 0
	local v2 = levelHandler:GetOverallLevel() == levelHandler:GetMaxLevel()
	local v3

	if v then
		if v2 then
			v3 = miscResource2
		else
			v3 = miscResource
		end
	elseif v2 then
		v3 = miscResource4
	else
		v3 = miscResource3
	end

	if not self.CurrentShieldRing or v3.Name ~= self.CurrentShieldRing.Name then
		if self.CurrentShieldRing then
			self.CurrentShieldRing:Destroy()
			self.CurrentShieldRing = nil
			self.CurrentShieldParts = {}
			self.CurrentShieldTransparency = 1
			self.CurrentShieldEffectWrapper = nil
		end

		self.CurrentShieldRing = v3:Clone()
		self.CurrentShieldRing:PivotTo(self.Torso.CFrame)
		self.CurrentShieldRing.Parent = raycastIgnore

		for _, child in pairs(self.CurrentShieldRing:GetChildren()) do
			if child.Name ~= "ShieldPart" then
				continue
			end

			table.insert(self.CurrentShieldParts, child)
			child:SetAttribute("InitialTransparency", child.Transparency)
			child.Transparency = 1
		end

		self.CurrentShieldEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(
			self.CurrentShieldRing,
			self.SpeedMultiplier
		)
		self.CurrentRange = -1
		self.PreviousShield = -1
		self.ShieldEffectWrapperOn = false
	end

	self:_HandleShieldRingRadius()
	self:_HandleShieldVisibility(0)
end

function ShieldTowerCustomCodeClass:_HandleShieldRingRadius()
	local currentRange = self.Tower:GetCurrentRange()

	if currentRange ~= self.CurrentRange then
		self.CurrentRange = currentRange
		local currentShieldRing = self.CurrentShieldRing

		if currentShieldRing then
			currentShieldRing:ScaleTo(currentRange / (currentShieldRing:GetAttribute("InitialRadius") or 3))
		end
	end
end

function ShieldTowerCustomCodeClass:_ToggleShieldEffectWrapper(shieldEffectWrapperOn: boolean)
	if shieldEffectWrapperOn ~= self.ShieldEffectWrapperOn then
		self.ShieldEffectWrapperOn = shieldEffectWrapperOn

		if shieldEffectWrapperOn then
			self.CurrentShieldEffectWrapper:PlayContinuous()
		else
			self.CurrentShieldEffectWrapper:StopContinuous()
		end
	end
end

function ShieldTowerCustomCodeClass:_HandleShieldVisibility(p: number)
	local shield = self.Tower.HealthHandler:GetShield()
	local v = shield > 0

	if shield ~= self.PreviousShield then
		self:_ToggleShieldEffectWrapper(v)
		self.PreviousShield = shield
	end

	if v and self.CurrentShieldTransparency > 0 then
		local currentShieldTransparency = math.clamp(self.CurrentShieldTransparency - p / 1.3, 0, 1)

		for _, currentShieldPart in pairs(self.CurrentShieldParts) do
			local initialTransparency = currentShieldPart:GetAttribute("InitialTransparency")
			currentShieldPart.Transparency = initialTransparency + currentShieldTransparency * (1 - initialTransparency)
		end

		self.CurrentShieldTransparency = currentShieldTransparency
	elseif not v and self.CurrentShieldTransparency < 1 then
		local currentShieldTransparency = math.clamp(self.CurrentShieldTransparency + p / 1.3, 0, 1)

		for _, currentShieldPart in pairs(self.CurrentShieldParts) do
			local initialTransparency = currentShieldPart:GetAttribute("InitialTransparency")
			currentShieldPart.Transparency = initialTransparency + currentShieldTransparency * (1 - initialTransparency)
		end

		self.CurrentShieldTransparency = currentShieldTransparency
	end
end

function ShieldTowerCustomCodeClass:Run_FromCharacter(p: number)
	self:_HandleShieldRingRadius()
	self:_HandleShieldVisibility(p)
end

function ShieldTowerCustomCodeClass.AbilityUsed(_, _) end

function ShieldTowerCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function ShieldTowerCustomCodeClass.SpeedMultiplierChanged_FromCharacter(p, p2: number)
	if p.CurrentShieldEffectWrapper then
		p.CurrentShieldEffectWrapper:SpeedMultiplierChanged(p2)
	end
end

function ShieldTowerCustomCodeClass:Upgraded(_)
	self:_InitializeShieldRing()
end

function ShieldTowerCustomCodeClass:CharacterCleanedUp()
	if self.CurrentShieldRing then
		self.CurrentShieldRing:Destroy()
		self.CurrentShieldRing = nil
		self.CurrentShieldEffectWrapper = nil
	end
end

function ShieldTowerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function ShieldTowerCustomCodeClass.Attacked(_, _, _: boolean?) end

function ShieldTowerCustomCodeClass.Death(p)
	if p.CurrentShieldEffectWrapper then
		p.CurrentShieldEffectWrapper:StopContinuous()
	end
end

function ShieldTowerCustomCodeClass.TriggerShieldRefresh(p)
	if p.CurrentShieldEffectWrapper then
		p.CurrentShieldEffectWrapper:PlayTriggered()
	end
end

return ShieldTowerCustomCodeClass