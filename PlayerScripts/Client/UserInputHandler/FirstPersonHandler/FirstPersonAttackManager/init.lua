local FirstPersonAttackManager = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("TowerBuffUtilities"))
local FirstPersonAttackHandlerClass = require(script:WaitForChild("FirstPersonAttackHandlerClass"))
local v = nil
local v2 = {}
local v3 = 1
local v4 = nil
local v5 = false

function FirstPersonAttackManager.SetTower(p, p2)
	v = p
	v2 = {}
	v4 = nil

	for i in ipairs(p2.AttackConfigs) do
		v2[i] = FirstPersonAttackHandlerClass.New(i, p, p2)
	end
end

function FirstPersonAttackManager.RemoveTower()
	for i, v6 in ipairs(v2) do
		v.DirectControlHandler:SetStateData(i, v6:GetStateData())
	end

	v = nil
	v2 = {}
	v4 = nil
end

function FirstPersonAttackManager:OnRenderStepped(p: number)
	if not v then
		return
	end

	for _, v6 in pairs(v2) do
		v6:OnRenderStepped(self, p)
	end
end

function FirstPersonAttackManager:Run()
	if not v then
		return
	end

	for _, v6 in pairs(v2) do
		v6:Run(self)
	end
end

function FirstPersonAttackManager:ToggleTryAttacking()
	v5 = self

	if v4 then
		v4:ToggleTryAttacking(self)
	end
end

function FirstPersonAttackManager.SwitchAttackHandler(p: number)
	for _, v6 in pairs(v2) do
		v6:ToggleTryAttacking(false)
	end

	v3 = p
	v4 = v2[p]

	if v4 then
		v4:ToggleTryAttacking(v5)
	end
end

function FirstPersonAttackManager.Reload()
	if not v4 then
		return
	end

	v4:Reload()
end

function FirstPersonAttackManager.GetAttackHandlerData(p: number)
	local v6 = v2[p]

	if v6 then
		return v6:GetData()
	end

	warn("FirstPersonAttackManager.GetAttackHandlerData - Invalid attack handler index: " .. tostring(p))
	return nil
end

return FirstPersonAttackManager