local FirstPersonSoundHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("FirstPersonTypes"))
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local CurrentCamera = workspace.CurrentCamera
local characterModel = nil
local fpsModeSFX = nil
local v = 1
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = 1

local function PlayRandomSound(list)
	local v6 = list[math.random(1, #list)]

	if v6 then
		v6:Play()
	end
end

local function AdjustPlaybackSpeed(instance) -- 1 equivalent call inferred from this helper
	if not instance:GetAttribute("OriginalPlaybackSpeed") then
		instance:SetAttribute("OriginalPlaybackSpeed", instance.PlaybackSpeed)
	end

	instance.PlaybackSpeed = instance:GetAttribute("OriginalPlaybackSpeed") * v5
end

local function InsertSoundToMap(p, k: number, child) -- 3 equivalent calls inferred from this helper
	if not p[k] then
		p[k] = {}
	end

	table.insert(p[k], child)
	GameSoundHandler.AddSoundToSoundGroup(child, "SFX")
	AdjustPlaybackSpeed(child) -- inferred equivalent call
end

local function ForEachSound(fn)
	for _, v6 in pairs(v2) do
		for _, v7 in pairs(v6) do
			fn(v7)
		end
	end

	for _, v6 in pairs(v3) do
		for _, v7 in pairs(v6) do
			fn(v7)
		end
	end

	for _, v6 in pairs(v4) do
		for _, v7 in pairs(v6) do
			fn(v7)
		end
	end
end

function FirstPersonSoundHandler.SetTower(player, p)
	characterModel = player.Character:GetCharacterModel()
	fpsModeSFX = characterModel:FindFirstChild("FPSModeSFX")
	v2 = {}
	v3 = {}
	v4 = {}

	if fpsModeSFX then
		local attacks = fpsModeSFX:FindFirstChild("Attacks")
		local abilities = fpsModeSFX:FindFirstChild("Abilities")

		if attacks then
			for k in pairs(p.AttackConfigs) do
				local child = attacks:FindFirstChild((tostring(k)))

				if not child then
					continue
				end

				local attack = child:FindFirstChild("Attack")

				if attack then
					for _, child2 in pairs(attack:GetChildren()) do
						InsertSoundToMap(v2, k, child2) -- inferred equivalent call
					end
				end

				local reload = child:FindFirstChild("Reload")

				if not reload then
					continue
				end

				for _, child2 in pairs(reload:GetChildren()) do
					InsertSoundToMap(v3, k, child2) -- inferred equivalent call
				end
			end
		end

		if abilities then
			for k in pairs(p.AbilityNames) do
				local child = abilities:FindFirstChild((tostring(k)))

				if not child then
					continue
				end

				for _, child2 in pairs(child:GetChildren()) do
					InsertSoundToMap(v4, k, child2) -- inferred equivalent call
				end
			end
		end

		fpsModeSFX.Parent = CurrentCamera
	end

	ForEachSound(function(instance)
		if instance:GetAttribute("OriginalVolume") then
			instance.Volume = instance:GetAttribute("OriginalVolume")
		end
	end)
end

function FirstPersonSoundHandler.RemoveTower()
	if fpsModeSFX then
		fpsModeSFX.Parent = characterModel
		fpsModeSFX = nil
	end

	ForEachSound(function(instance)
		if not instance:GetAttribute("OriginalVolume") then
			instance:SetAttribute("OriginalVolume", instance.Volume)
		end

		instance.Volume = 0
	end)
	characterModel = nil
	v2 = {}
	v3 = {}
	v4 = {}
end

function FirstPersonSoundHandler.SwitchAttackHandler(p: number)
	v = p
end

function FirstPersonSoundHandler.ShotFired()
	local v6 = v2[v]
	local v7 = v6 and v6[math.random(1, #v6)]

	if v7 then
		v7:Play()
	end
end

function FirstPersonSoundHandler.Reloaded()
	local v6 = v3[v]
	local v7 = v6 and v6[math.random(1, #v6)]

	if v7 then
		v7:Play()
	end
end

function FirstPersonSoundHandler.AbilityUsed(p: number)
	local v6 = v4[p]
	local v7 = v6 and v6[math.random(1, #v6)]

	if v7 then
		v7:Play()
	end
end

function FirstPersonSoundHandler.SetSpeedMultiplier(p: number)
	v5 = p
	ForEachSound(function(instance)
		if not instance:GetAttribute("OriginalPlaybackSpeed") then
			instance:SetAttribute("OriginalPlaybackSpeed", instance.PlaybackSpeed)
		end

		instance.PlaybackSpeed = instance:GetAttribute("OriginalPlaybackSpeed") * v5
	end)
end

return FirstPersonSoundHandler