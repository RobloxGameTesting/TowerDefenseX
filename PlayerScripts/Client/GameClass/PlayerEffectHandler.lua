local PlayerEffectHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local playerEffects = common:WaitForChild("Resources"):WaitForChild("PlayerEffects")
local event = BindableHandler.GetEvent("SetSpeedMultiplier")
local LocalPlayer = Players.LocalPlayer
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER
local v = {}
local v2 = {}

local function GetEffectModule(playerEffectName: string)
	local v3 = v2[playerEffectName]

	if v3 ~= nil then
		return v3 or nil
	end

	local moduleScript = playerEffects:FindFirstChild(playerEffectName)
	local v4 = nil

	if moduleScript and moduleScript:IsA("ModuleScript") then
		local success, result = pcall(require, moduleScript)

		if success and typeof(result) == "table" and typeof(result.Start) == "function" then
			v4 = result
		else
			warn(`PlayerEffectHandler: {playerEffectName} is not a valid effect module`)
		end
	else
		warn(`PlayerEffectHandler: no effect module named {playerEffectName} in Resources/PlayerEffects`)
	end

	v2[playerEffectName] = v4 or false
	return v4
end

local function StopEffect(p: string) -- 4 equivalent calls inferred from this helper
	local v3 = v[p]

	if not v3 then
		return
	end

	v[p] = nil
	local stop = v3.Module.Stop

	if stop then
		local success, result = pcall(stop, v3.Context)

		if not success then
			warn(`PlayerEffectHandler: {p} Stop errored: {tostring(result)}`)
		end
	end
end

function PlayerEffectHandler.Trigger(enemy, data, targetPlayerNames)
	local playerEffectName = data.PlayerEffectName

	if not playerEffectName then
		warn("PlayerEffectHandler: EnemyToPlayerRangedData has no PlayerEffectName")
		return
	end

	local module = GetEffectModule(playerEffectName)

	if not module then
		return
	end

	local formatted = `{enemy.Hash}:{playerEffectName}`
	StopEffect(formatted) -- inferred equivalent call
	local context = {
		Enemy = enemy,
		Data = data,
		Parameters = data.EffectParameters or {},
		Duration = data.Duration,
		TargetPlayerNames = targetPlayerNames,
		IsLocalPlayerTargeted = table.find(targetPlayerNames, LocalPlayer.Name) ~= nil,
		State = nil
	}
	local v3 = { Module = module, Context = context, TimeLeft = nil }
	v[formatted] = v3
	local success, result = pcall(module.Start, context)

	if success then
		if data.Duration then
			v3.TimeLeft = data.Duration
		end
	else
		warn(`PlayerEffectHandler: {playerEffectName} Start errored: {tostring(result)}`)
		v[formatted] = nil
	end
end

function PlayerEffectHandler.StopEffectsForEnemy(p: number)
	local formatted = `{p}:`

	for k in pairs(v) do
		if string.sub(k, 1, #formatted) == formatted then
			StopEffect(k) -- inferred equivalent call
		end
	end
end

function PlayerEffectHandler.StopAll()
	for k in pairs(v) do
		StopEffect(k) -- inferred equivalent call
	end
end

event:AttachCallback(function(p: number)
	DEFAULT_SPEED_MULTIPLIER = p
end)
RunService.Heartbeat:Connect(function(dt: number)
	if next(v) == nil then
		return
	end

	local v3 = dt * DEFAULT_SPEED_MULTIPLIER

	for k, v4 in pairs(v) do
		local timeLeft = v4.TimeLeft

		if not timeLeft then
			continue
		end

		local timeLeft2 = timeLeft - v3
		v4.TimeLeft = timeLeft2

		if timeLeft2 <= 0 then
			StopEffect(k) -- inferred equivalent call
		end
	end
end)
return PlayerEffectHandler