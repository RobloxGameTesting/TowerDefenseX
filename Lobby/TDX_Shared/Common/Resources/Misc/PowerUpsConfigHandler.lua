local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
local v = {
	Enums.Difficulties.Easy,
	Enums.Difficulties.Intermediate,
	Enums.Difficulties.Elite,
	Enums.Difficulties.Expert,
	Enums.Difficulties.Nightmare,
	Enums.Difficulties.UltraNightmare,
	Enums.Difficulties.Expert,
	Enums.Difficulties.Test
}
local v2 = {}
local v3 = {}
local v4 = nil
local flag = false

local function log(_, ...) end

function _DoTableMerge(items, items2)
	local result = {}

	for k, item in items do
		if k == "DifficultyOverrides" then
			continue
		end

		if items2[k] then
			if typeof(item) == "table" then
				result[k] = _DoTableMerge(item, items2[k])
			else
				result[k] = items2[k]
			end
		else
			result[k] = item
		end
	end

	for k, item in items2 do
		if items[k] then
			continue
		end

		if typeof(item) == "table" then
			warn(`Should not try to override with a table {k} that does not exist in the base config!`)
		else
			result[k] = items2[k]
		end
	end

	return result
end

function _ComputeConfigForDifficulty(p, p2: string)
	local difficultyOverrides = p.DifficultyOverrides

	if difficultyOverrides and difficultyOverrides[p2] then
		return _DoTableMerge(p, difficultyOverrides[p2])
	end

	return p
end

function _OnDifficultyChanged(p: string)
	if v4 == p or not _G.ENABLE_POWER_UP_CONFIG_REWORK then
		return
	end

	v4 = p
	log(print, `Difficulty changed to {p}`)

	for k, v5 in v2 do
		local v6 = _ComputeConfigForDifficulty(v5, p)
		log(print, `Computed merged config for PowerUp {k}`, v6)
		v3[k] = v6
	end

	if RunService:IsClient() then
		BindableHandler.GetEvent("PowerUpConfigsChanged"):Fire()
	end
end

local PowerUpsConfigHandler = {}

function PowerUpsConfigHandler.Initialize()
	if flag then
		warn("Duplicate initialization of PowerUpsConfigHandler")
	end

	flag = true

	for _, childName in pairs(Enums.PowerUps) do
		local child = script.Parent.RegularPowerUps:FindFirstChild(childName)

		if child then
			local config = child:FindFirstChild("Config")

			if config then
				local v5 = v2
				local module = require(config)
				v5[childName] = module
				log(print, `Loaded base config for {childName}`)
			else
				log(warn, "Config module not found for PowerUp", childName)
			end
		else
			log(warn, "Config folder not found for PowerUp", childName)
		end
	end

	if RunService:IsClient() then
		BindableHandler.GetEvent("SetDifficulty"):AttachCallback(function(p: string)
			_OnDifficultyChanged(p)
		end)
	end

	_OnDifficultyChanged(Enums.Difficulties.Easy)
	log(print, "Initialized!")
end

function PowerUpsConfigHandler.GetConfig(p: string)
	if not Enums.PowerUps[p] then
		error(`Could not get config for unknown PowerUp {p}`)
	end

	if not _G.ENABLE_POWER_UP_CONFIG_REWORK then
		return v2[p]
	end

	if v3[p] then
		return v3[p]
	end

	log(warn, `No merged config for {p}, there is probably an issue somewhere`)
	return v2[p]
end

function PowerUpsConfigHandler.SetDifficulty(p: string)
	_OnDifficultyChanged(p)
end

function PowerUpsConfigHandler.ForEachMainDifficulty(p)
	local result = {}

	for _, v5 in v do
		result[v5] = p
	end

	return result
end

return PowerUpsConfigHandler