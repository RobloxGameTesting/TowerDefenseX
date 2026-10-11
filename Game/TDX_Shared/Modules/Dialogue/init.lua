local Lang = require(game.ReplicatedStorage.TDX_Shared.Modules.Lang)
require(script.DialogueTypes)
local v = {}
local Dialogue = {}

local function handleChild(moduleScript)
	local module, v2, v3 = require(moduleScript)

	for k, v4 in module, v2, v3 do
		if v[k] ~= nil then
			error(`DIALOGUE SEQUENCE COLLISION -> {k}`)
		end

		v[k] = v4
	end
end

function Dialogue.GetSequence(p: string)
	return v[p]
end

function Dialogue.GetDefaults(p: string?)
	return p and v[`_{p}Defaults`] or nil
end

local function getWaveLangIndices(p: string?, p2: number?)
	local result = {}

	if not (p and p2) then
		return result
	end

	local v2 = Lang.Strings.Game.Dialogue[p]

	if Lang.Get(v2[`Wave{p2}_1`]) then
		local v3 = 1

		while Lang.Get(v2[`Wave{p2}_{v3}`]) do
			table.insert(result, v2[`Wave{p2}_{v3}`])
			v3 += 1
		end
	elseif Lang.Get(v2[`Wave{p2}`]) then
		table.insert(result, v2[`Wave{p2}`])
	end

	return result
end

function Dialogue.ResolveLines(p: string, p2: string?, p3: number?)
	local v2 = v[p]
	local v3 = Dialogue.GetDefaults(p2) or {}
	local v4 = not v2 and {} or v2.Dialogue or {}
	local waveLangIndices = getWaveLangIndices(p2, p3)
	local count = #waveLangIndices

	for k, v5 in v4 do
		if v5.Text and count < k then
			count = k
		end
	end

	if count == 0 then
		return nil
	end

	local v5 = {}

	for i = 1, count do
		local v6 = v4[i] or {}
		local text = v6.Text or waveLangIndices[i]
		local text2 = text and Lang.Get(text)

		if not text2 then
			continue
		end

		local name = v6.Name or v2 and v2.DefaultName or v3.DefaultName
		table.insert(v5, {
			Text = text2,
			Name = name and Lang.Get(name) or "",
			Image = v6.Image or v2 and v2.DefaultImage or v3.DefaultImage,
			ImageSize = v6.ImageSize or v2 and v2.DefaultSize or v3.DefaultSize,
			ImageRatio = v6.ImageRatio or v2 and v2.DefaultImageRatio or v3.DefaultImageRatio,
			Pitch = v6.Pitch or v2 and v2.DefaultPitch or v3.DefaultPitch,
			AfterTextDuration = v6.AfterTextDuration or i ~= count and 3 or v3.LastInSequenceAfterTextDuration or 3,
			SoundId = v6.SoundId,
			PlayTypingSound = v3.VolumeOn == true
		})
	end

	return #v5 > 0 and v5 or nil
end

script.DescendantAdded:Connect(function(moduleScript)
	if moduleScript:IsA("ModuleScript") and moduleScript.Name ~= "DialogueTypes" then
		handleChild(moduleScript)
	end
end)

for _, moduleScript in script:GetDescendants() do
	if moduleScript:IsA("ModuleScript") and moduleScript.Name ~= "DialogueTypes" then
		handleChild(moduleScript)
	end
end

return Dialogue