local AmbienceHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WaveTypes"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local EnemyClass = script.Parent:WaitForChild("EnemyClass")
local color = Color3.fromRGB(255, 139, 139)
local event = BindableHandler.GetEvent("TryStartNextWaveAmbientPlaylist")
local event2 = BindableHandler.GetEvent("CreateColorCorrectionEffect")
local event3 = BindableHandler.GetEvent("ClearCreatedColorCorrectionEffects")
local v = false
local v2 = {}
local v3 = 1
local v4 = 0
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = {}

local function LerpToDefaultTint(p: number) -- 1 equivalent call inferred from this helper
	local tintColor = v7.TintColor
	v7.TintColor = tintColor:Lerp(v6, p / 15)
end

local function LerpToCalamityTint(p: number, p2: number) -- 1 equivalent call inferred from this helper
	local tintColor = v7.TintColor
	local lerped = v6:Lerp(color, p2)
	v7.TintColor = tintColor:Lerp(lerped, p / 15)
end

local function GetCalamityAliveCount()
	local module = require(EnemyClass)
	local count = 0

	for _, v9 in pairs(module.GetEnemies()) do
		if v9.Type == Enums.Enemies.Calamity then
			count += 1
		end
	end

	return count
end

local function HandleAmbientPlaylist(value: number?) -- 2 equivalent calls inferred from this helper
	if v5 then
		local ambientPlaylist = v5.AmbientPlaylist
		local wave = v5.Waves[v4 + (value or 0)]
		local v9

		if wave and wave.OverrideAmbientPlaylist then
			ambientPlaylist = wave.OverrideAmbientPlaylist
			v9 = true
		else
			v9 = false
		end

		SoundHandler.SetAmbientPlaylist(ambientPlaylist, v9 and 0.5)
	end
end

function AmbienceHandler.WaveReached(p: number)
	v4 = p
	HandleAmbientPlaylist() -- inferred equivalent call
end

function AmbienceHandler.EnemyKilled(p: string, flag: boolean)
	if p == Enums.Enemies.Calamity and not flag then
		v3 += 1
	end
end

function AmbienceHandler.Run(p: number)
	if not v then
		return
	end

	local v9 = v2[v3]
	local calamityAliveCount = GetCalamityAliveCount()

	if v9 and v4 <= v9 or calamityAliveCount > 0 then
		LerpToCalamityTint(p, (1 - math.clamp((v9 - v4) / 10, 0, 1)) ^ 2) -- inferred equivalent call
	else
		LerpToDefaultTint(p) -- inferred equivalent call
	end
end

function AmbienceHandler.Restart()
	v3 = 1

	for _, v9 in pairs(v8) do
		v9:Destroy()
	end

	table.clear(v8)
end

function AmbienceHandler.DifficultyChanged(p: string)
	local waveConfig = ResourceManager.GetWaveConfig(p)

	if not waveConfig then
		warn("No wave config found for difficulty " .. p)
		return
	end

	v5 = waveConfig
	SoundHandler.KeepMusicLoaded("Difficulty", ResourceManager.GetDifficultyReferencedStrings(p))
	HandleAmbientPlaylist() -- inferred equivalent call
	v2 = {}

	for i, wave in ipairs(waveConfig.Waves) do
		for _, spawnSequence in pairs(wave.SpawnSequences) do
			if spawnSequence.EnemyType ~= Enums.Enemies.Calamity then
				continue
			end

			for _ = 1, spawnSequence.Count do
				table.insert(v2, i)
			end
		end
	end
end

function AmbienceHandler.Initialize()
	v6 = MapHandler.GetColorCorrectionDefaultTint()
	v7 = MapHandler.GetColorCorrectionEffect()
	event:AttachCallback(function()
		if v5 then
			local ambientPlaylist = v5.AmbientPlaylist
			local wave = v5.Waves[v4 + 1]
			local v9

			if wave and wave.OverrideAmbientPlaylist then
				ambientPlaylist = wave.OverrideAmbientPlaylist
				v9 = true
			else
				v9 = false
			end

			SoundHandler.SetAmbientPlaylist(ambientPlaylist, v9 and 0.5)
		end
	end)
	event2:AttachCallback(function(name: string, tintColor: Color3)
		local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
		colorCorrectionEffect.Name = name
		colorCorrectionEffect.TintColor = tintColor
		colorCorrectionEffect.Enabled = true
		colorCorrectionEffect.Parent = Lighting
		table.insert(v8, colorCorrectionEffect)
	end)
	event3:AttachCallback(function()
		for _, v9 in pairs(v8) do
			v9:Destroy()
		end

		table.clear(v8)
	end)
	v = true
end

return AmbienceHandler