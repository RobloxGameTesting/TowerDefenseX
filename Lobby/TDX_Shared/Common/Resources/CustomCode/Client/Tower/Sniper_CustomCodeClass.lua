local createVector = vector.create
local SniperCustomCodeClass = {}
SniperCustomCodeClass.__index = SniperCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local raycastIgnore = workspace:WaitForChild("Game"):FindFirstChild("RaycastIgnore")

function SniperCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Tower = nil,
		Character = nil,
		SpawnCFrame = nil,
		OriginEffectWrapper = nil,
		FlareEffectWrapper = nil,
		FlareOriginPart = nil,
		FlareActive = false,
		FlareProjectilePart = nil,
		CurrentFlareVelocity = nil,
		TimeLeftForFlare = 0,
		FlareDefaultTime = 3.85
	}, SniperCustomCodeClass))
end

function SniperCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self.Character = tower.Character
	self.SpawnCFrame = tower.CFrame
end

function SniperCustomCodeClass:Run_FromCharacter(p: number)
	if self.FlareActive then
		self.TimeLeftForFlare -= p

		if self.TimeLeftForFlare <= 0 then
			self.FlareEffectWrapper:StopContinuous()
			self.FlareActive = false
		else
			self.CurrentFlareVelocity -= Vector3.new(0, p * 15, 0)
			self.FlareProjectilePart.Position += self.CurrentFlareVelocity * p
		end
	end
end

function SniperCustomCodeClass.AbilityUsed(_, _) end

function SniperCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	local character = self.Tower.Character

	if p == "FlareGun" then
		if p2 == "FlareGunShow" then
			character:HideModelWithName("FlareGunIdle")
			character:ShowModelWithName("FlareGunActive")
			character:HideModelWithName("Sniper")
		elseif p2 == "FlareGunHide" then
			character:HideModelWithName("FlareGunActive")
			character:ShowModelWithName("FlareGunIdle")
			character:ShowModelWithName("Sniper")
		elseif p2 == "FlareGunFire" then
			if self.OriginEffectWrapper then
				self.OriginEffectWrapper:PlayAll()
			end

			if self.FlareEffectWrapper then
				self.FlareEffectWrapper:PlayAll()
			end

			local flareOriginPart = self.FlareOriginPart

			if flareOriginPart then
				local cframe = flareOriginPart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
				local lookVector = cframe.LookVector
				local currentFlareVelocity = 35 * (1 / lookVector.Unit.Y) * lookVector.Unit * createVector(0.3, 1, 0.3)
				self.FlareProjectilePart.CFrame = cframe
				self.CurrentFlareVelocity = currentFlareVelocity
				self.TimeLeftForFlare = self.FlareDefaultTime
				self.FlareActive = true
			end
		end
	end
end

function SniperCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	if self.OriginEffectWrapper then
		self.OriginEffectWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.FlareEffectWrapper then
		self.FlareEffectWrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function SniperCustomCodeClass:Upgraded(_)
	local tower = self.Tower

	if not tower.AbilityHandler:GetAbility("FlareGun") then
		return
	end

	local character = tower.Character
	local characterModel = character:GetCharacterModel()
	local flareOrigin = characterModel:FindFirstChild("FlareOrigin")
	local flareProjectile = characterModel:FindFirstChild("FlareProjectile")
	self.OriginEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(flareOrigin, self.SpeedMultiplier)
	self.FlareOriginPart = flareOrigin.PrimaryPart

	if self.FlareProjectilePart then
		if flareProjectile then
			flareProjectile:Destroy()
		end
	else
		self.FlareEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(flareProjectile, self.SpeedMultiplier)
		self.FlareProjectilePart = flareProjectile.PrimaryPart
		self.FlareProjectilePart.Anchored = true
		self.FlareProjectilePart.Parent = raycastIgnore
	end

	character:HideModelWithName("FlareGunActive")
end

function SniperCustomCodeClass.CharacterCleanedUp(data)
	if data.FlareActive then
		data.FlareEffectWrapper:StopContinuous()
	end

	task.delay(data.FlareDefaultTime + 1, function()
		if data.FlareProjectilePart then
			data.FlareProjectilePart:Destroy()
		end
	end)
end

function SniperCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function SniperCustomCodeClass.Attacked(_, _, _: boolean?) end

function SniperCustomCodeClass.Death(_) end

return SniperCustomCodeClass