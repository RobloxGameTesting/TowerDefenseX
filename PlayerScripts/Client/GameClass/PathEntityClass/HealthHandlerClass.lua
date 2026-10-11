local HealthHandlerClass = {}
HealthHandlerClass.__index = HealthHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))

function HealthHandlerClass.New(health: number, maxHealth: number)
	return (setmetatable({ Health = health, MaxHealth = maxHealth }, HealthHandlerClass))
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

return HealthHandlerClass