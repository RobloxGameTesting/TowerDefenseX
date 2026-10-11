local HealthHandlerClass = {}
HealthHandlerClass.__index = HealthHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local miscResource = ResourceManager.GetMiscResource("DirectShield", true)

function HealthHandlerClass.New(health: number, maxHealth: number, shield: number, maxShield: number, hasSharedShield: boolean, flag: boolean, vector: Vector3, directShieldRadius: number, vector2: Vector3?, flag2: boolean)
	return (setmetatable({
		Health = health,
		MaxHealth = maxHealth,
		Shield = shield,
		MaxShield = maxShield,
		HasSharedShield = hasSharedShield,
		HasDirectShield = flag,
		SpawnPosition = vector,
		DirectShieldRadius = directShieldRadius,
		DirectShieldOffset = vector2 or Vector3.new(),
		CanMove = flag2,
		ShieldModel = nil,
		ShieldModelEffectWrapper = nil,
		ShieldModelActive = false
	}, HealthHandlerClass))
end

function HealthHandlerClass.GetHealth(p)
	return p.Health
end

function HealthHandlerClass.GetMaxHealth(p)
	return p.MaxHealth
end

function HealthHandlerClass:SetHealth(health: number)
	self.Health = health
end

function HealthHandlerClass:SetMaxHealth(maxHealth: number)
	self.MaxHealth = maxHealth
end

function HealthHandlerClass.GetShield(p)
	return p.Shield
end

function HealthHandlerClass.GetMaxShield(p)
	return p.MaxShield
end

function HealthHandlerClass:SetShield(shield: number)
	self.Shield = shield
end

function HealthHandlerClass:SetMaxShield(maxShield: number)
	self.MaxShield = maxShield
end

function HealthHandlerClass:SetHasSharedShield(hasSharedShield: boolean)
	self.HasSharedShield = hasSharedShield
end

function HealthHandlerClass:SetHasDirectShield(hasDirectShield: boolean)
	self.HasDirectShield = hasDirectShield
end

function HealthHandlerClass.LevelStatsChanged(_, _) end

function HealthHandlerClass:Run(_: number, p: number, p2)
	if self.HasDirectShield and self.Shield > 0 then
		if self.ShieldModel then
			if self.CanMove then
				self.ShieldModel:PivotTo(CFrame.new(p2.CFrame.Position + self.DirectShieldOffset))
			end
		else
			self:_SetUpShieldModel(p, p2)
		end

		if not self.ShieldModelActive then
			self.ShieldModelEffectWrapper:PlayAll()
			self.ShieldModelActive = true
		end
	elseif self.ShieldModelActive then
		self.ShieldModelEffectWrapper:StopContinuous()
		self.ShieldModelActive = false
	end
end

function HealthHandlerClass:Death()
	if self.ShieldModel then
		self.ShieldModel:Destroy()
		self.ShieldModel = nil
	end
end

function HealthHandlerClass.SetSpeedMultiplier(p, p2: number)
	if p.ShieldModelEffectWrapper then
		p.ShieldModelEffectWrapper:SpeedMultiplierChanged(p2)
	end
end

function HealthHandlerClass:_SetUpShieldModel(p: number, p2)
	local clone = miscResource:Clone()
	local v = (self.CanMove and p2.CFrame.Position or self.SpawnPosition) + self.DirectShieldOffset
	clone:PivotTo(CFrame.new(v))
	clone:ScaleTo(1.15 * self.DirectShieldRadius / (clone:GetAttribute("InitialRadius") or 3))
	clone.Parent = raycastIgnore
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(clone, p)
	self.ShieldModel = clone
	self.ShieldModelEffectWrapper = emitterAndSoundWrapper
end

return HealthHandlerClass