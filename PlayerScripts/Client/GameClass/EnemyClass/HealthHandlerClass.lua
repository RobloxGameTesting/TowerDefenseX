local HealthHandlerClass = {}
HealthHandlerClass.__index = HealthHandlerClass

function HealthHandlerClass.New(health: number, maxHealth: number, shield: number, maxShield: number)
	return (setmetatable(
		{ Health = health, MaxHealth = maxHealth, Shield = shield, MaxShield = maxShield },
		HealthHandlerClass
	))
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

function HealthHandlerClass.IsShieldActive(p)
	return p.Shield > 0
end

function HealthHandlerClass.HasShield(p)
	return p.MaxShield > 0
end

return HealthHandlerClass