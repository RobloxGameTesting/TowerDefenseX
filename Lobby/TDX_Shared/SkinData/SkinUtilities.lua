local SkinUtilities = {}
require(script.Parent:WaitForChild("SkinTypes"))
local SkinEnums = require(script.Parent:WaitForChild("SkinEnums"))
local Skins = script.Parent:WaitForChild("Skins")
local v = {}

local function GetSkinType(k: string) -- 1 equivalent call inferred from this helper
	if k == "ColorSkins" then
		return SkinEnums.SkinTypes.ColorSkin
	elseif k == "MeshPartSkins" then
		return SkinEnums.SkinTypes.MeshPartSkin
	elseif k == "ModelSkins" then
		return SkinEnums.SkinTypes.ModelSkin
	end

	error("Invalid skin type")
end

function SkinUtilities.ValidateTowerSkinCombination(p: string, p2: string)
	local v2 = v[p]

	if not v2 then
		warn(`Tower "{p}" does not exist, or doesn't have any skins`)
		return false
	end

	if v2[p2] or p2 == "" then
		return true
	end

	warn(`Tower "{p}" does not have a skin named "{p2}"`)
	return false
end

function SkinUtilities.GetAllSkinsForTower(p: string)
	return v[p]
end

function SkinUtilities.GetSkinData(p: string, p2: string)
	return v[p] and v[p][p2]
end

for _, moduleScript in pairs(Skins:GetChildren()) do
	local name = moduleScript.Name
	local module = require(moduleScript)
	local v2 = {}

	for k, v3 in pairs(module) do
		local skinType = GetSkinType(k) -- inferred equivalent call

		for _, v4 in pairs(v3) do
			local v5 = {
				Name = v4.Name,
				DisplayName = v4.DisplayName or v4.Name,
				Type = skinType,
				Unreleased = v4.Unreleased
			}
			v2[v4.Name] = v5
		end
	end

	v[name] = v2
end

return SkinUtilities