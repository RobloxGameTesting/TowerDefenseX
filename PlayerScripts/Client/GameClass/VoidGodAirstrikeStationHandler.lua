local VoidGodAirstrikeStationHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local MapHandler = require(common:WaitForChild("MapHandler"))
local Config = require(common.Resources.Misc.VoidGodAirstrike.Config)
local folder = nil
local parts = {}
local parts2 = {}
local v = false
local v2 = false
local total = 0
local v3 = {}
local v4 = false

local function SetPartsLit(parts3, flag: boolean) -- 2 equivalent calls inferred from this helper
	local stationLitColor

	if flag then
		stationLitColor = Config.StationLitColor
	else
		stationLitColor = Config.StationUnlitColor
	end

	local stationLitMaterial

	if flag then
		stationLitMaterial = Config.StationLitMaterial
	else
		stationLitMaterial = Config.StationUnlitMaterial
	end

	for _, v5 in ipairs(parts3) do
		v5.Color = stationLitColor
		v5.Material = stationLitMaterial
	end
end

local function IsAirstrikePrompt(descendant) -- 1 equivalent call inferred from this helper
	local promptType = descendant:GetAttribute("PromptType")

	if type(promptType) == "string" and promptType ~= "" then
		return promptType == "VoidGodAirstrike"
	end

	if descendant:GetAttribute("MapEntityTurret") then
		return true
	end

	return false
end

local function AddWarning(descendant, folder2)
	local emitters = {}

	for _, emitter in ipairs(folder2:GetDescendants()) do
		if not emitter:IsA("ParticleEmitter") then
			continue
		end

		emitter.Enabled = false
		table.insert(emitters, emitter)
	end

	table.insert(v3, { ProximityPrompt = descendant, Emitters = emitters, PromptEnabled = false })
end

local function EmitWarning(p)
	for _, emitter in ipairs(p.Emitters) do
		local emitCount = emitter:GetAttribute("EmitCount")
		local emitDelay = emitter:GetAttribute("EmitDelay")

		if type(emitCount) ~= "number" then
			emitCount = emitter.Rate
		end

		if type(emitDelay) == "number" and emitDelay > 0 then
			local v5 = emitter
			task.delay(emitDelay, function()
				v5:Emit(emitCount)
			end)
		else
			emitter:Emit(emitCount)
		end
	end
end

local function RunStations(p: number)
	if not folder or #parts == 0 and #parts2 == 0 then
		return
	end

	local v5 = folder:GetAttribute(Config.AvailableMapAttribute) == true

	if v ~= v5 then
		v = v5
		SetPartsLit(parts, v5) -- inferred equivalent call
	end

	if v5 then
		total += p
	else
		total = 0
	end

	local v6 = v5 and math.floor(total / Config.StationFlashInterval) % 2 == 0

	if v2 ~= v6 then
		v2 = v6
		SetPartsLit(parts2, v6) -- inferred equivalent call
	end
end

local function RunWarnings()
	for _, v5 in ipairs(v3) do
		local enabled = v5.ProximityPrompt.Enabled

		if enabled == v5.PromptEnabled then
			continue
		end

		v5.PromptEnabled = enabled

		if enabled and v4 then
			EmitWarning(v5)
		end
	end
end

function VoidGodAirstrikeStationHandler.Run(p: number)
	RunStations(p)
	RunWarnings()
end

function VoidGodAirstrikeStationHandler.DifficultyChanged(p: string)
	v4 = Config.WarningDifficulties[p] == true
end

function VoidGodAirstrikeStationHandler.Reset()
	folder = nil
	parts = {}
	parts2 = {}
	v3 = {}
end

function VoidGodAirstrikeStationHandler.Initialize()
	VoidGodAirstrikeStationHandler.Reset()
	folder = MapHandler.GetCurrentMap()

	if not folder then
		return
	end

	for _, descendant in ipairs(folder:GetDescendants()) do
		if descendant:IsA("ProximityPrompt") then
			if IsAirstrikePrompt(descendant) and descendant.Parent then -- inferred equivalent call
				local attachment = descendant.Parent:FindFirstChild(Config.WarningAttachmentName)

				if attachment and attachment:IsA("Attachment") then
					AddWarning(descendant, attachment)
				end
			end
		elseif descendant.Name == "AirstrikeStation" and descendant:IsA("Model") then
			for _, part in ipairs(descendant:GetDescendants()) do
				if not part:IsA("BasePart") then
					continue
				end

				if part.Name == "Button" then
					table.insert(parts, part)
				elseif part.Name == "Neon" then
					table.insert(parts2, part)
				end
			end
		end
	end

	v = false
	v2 = false
	total = 0
	local v5 = parts
	local stationUnlitColor = Config.StationUnlitColor
	local stationUnlitMaterial = Config.StationUnlitMaterial

	for _, v6 in ipairs(v5) do
		v6.Color = stationUnlitColor
		v6.Material = stationUnlitMaterial
	end

	local v6 = parts2
	local stationUnlitColor2 = Config.StationUnlitColor
	local stationUnlitMaterial2 = Config.StationUnlitMaterial

	for _, v7 in ipairs(v6) do
		v7.Color = stationUnlitColor2
		v7.Material = stationUnlitMaterial2
	end
end

return VoidGodAirstrikeStationHandler