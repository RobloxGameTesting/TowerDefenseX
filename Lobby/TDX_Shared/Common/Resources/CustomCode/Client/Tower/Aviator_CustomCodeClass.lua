local AviatorCustomCodeClass = {}
AviatorCustomCodeClass.__index = AviatorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local DroneDeath = Enums.VisualEffects.DroneDeath
local event = BindableHandler.GetEvent("NewVisualEffectBindable")

function AviatorCustomCodeClass.New(_: number)
	return (setmetatable(
		{
			Tower = nil,
			Platform = nil,
			HiddenPartTransparencies = nil,
			DisabledEffectInstances = nil
		},
		AviatorCustomCodeClass
	))
end

function AviatorCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self:_SetUpPlatform()
end

function AviatorCustomCodeClass:_SetUpPlatform()
	local tower = self.Tower
	local characterModel = tower.Character:GetCharacterModel()
	local primaryPart = characterModel.PrimaryPart

	if not primaryPart then
		warn("Aviator: character model has no PrimaryPart")
		return
	end

	local platform = characterModel:FindFirstChild("Platform")
	local primaryPart2 = platform and platform.PrimaryPart

	if not (platform and primaryPart2) then
		warn("Aviator: Platform model (with PrimaryPart) not found in character model")
		return
	end

	if platform == self.Platform then
		return
	end

	local platformRoot = primaryPart:FindFirstChild("Platform.Root")

	if not platformRoot then
		warn("Aviator: Platform.Root weld not found in character model")
		return
	end

	primaryPart2.Anchored = true
	platformRoot:Destroy()
	local pylonMovementHandler = tower.PylonMovementHandler

	if pylonMovementHandler and pylonMovementHandler.GetParkedCFrame then
		local torso = tower.Character:GetTorso()
		primaryPart2.CFrame = pylonMovementHandler:GetParkedCFrame() * torso.CFrame:Inverse() * primaryPart2.CFrame
	else
		warn("Aviator: movement handler not available to position the platform")
	end

	self.Platform = platform

	if not tower.IsAlive then
		self.HiddenPartTransparencies = nil
		self.DisabledEffectInstances = nil
		self:_SetPlaneHidden(true)
	end
end

function AviatorCustomCodeClass.Run_FromCharacter(_, _: number) end

function AviatorCustomCodeClass.AbilityUsed(_, _) end

function AviatorCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function AviatorCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function AviatorCustomCodeClass:Upgraded(_)
	self:_SetUpPlatform()
end

function AviatorCustomCodeClass.CharacterCleanedUp(_) end

function AviatorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function AviatorCustomCodeClass.Attacked(_, _, _: boolean?) end

function AviatorCustomCodeClass:Death()
	local tower = self.Tower

	if not tower or tower.HelicopterCrashLocation then
		return
	end

	if tower.CanRebuild then
		event:Fire(DroneDeath, tower.CFrame.Position)
	end

	self:_SetPlaneHidden(true)
end

function AviatorCustomCodeClass:HelicopterCrashFinished()
	self:_SetPlaneHidden(true)
end

function AviatorCustomCodeClass:Rebuilt()
	self:_SetPlaneHidden(false)
end

function AviatorCustomCodeClass:_SetPlaneHidden(flag: boolean)
	local tower = self.Tower

	if not tower then
		return
	end

	local characterModel = tower.Character:GetCharacterModel()
	local platform = self.Platform

	if flag then
		if self.HiddenPartTransparencies then
			return
		end

		local transparenciesByDescendant = {}
		local disabledEffectInstances = {}

		for _, descendant in pairs(characterModel:GetDescendants()) do
			if not (not platform or descendant ~= platform and not descendant:IsDescendantOf(platform)) then
				continue
			end

			if descendant:IsA("BasePart") then
				if descendant.Transparency < 1 then
					transparenciesByDescendant[descendant] = descendant.Transparency
					descendant.Transparency = 1
				end
			elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
				if descendant.Transparency < 1 then
					transparenciesByDescendant[descendant] = descendant.Transparency
					descendant.Transparency = 1
				end
			elseif
				(descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("Light"))
				and descendant.Enabled
			then
				disabledEffectInstances[descendant] = true
				descendant.Enabled = false
			end
		end

		self.HiddenPartTransparencies = transparenciesByDescendant
		self.DisabledEffectInstances = disabledEffectInstances
	else
		if self.HiddenPartTransparencies then
			for k, hiddenPartTransparency in pairs(self.HiddenPartTransparencies) do
				if k.Parent then
					k.Transparency = hiddenPartTransparency
				end
			end

			self.HiddenPartTransparencies = nil
		end

		if self.DisabledEffectInstances then
			for k in pairs(self.DisabledEffectInstances) do
				if k.Parent then
					k.Enabled = true
				end
			end

			self.DisabledEffectInstances = nil
		end
	end
end

return AviatorCustomCodeClass