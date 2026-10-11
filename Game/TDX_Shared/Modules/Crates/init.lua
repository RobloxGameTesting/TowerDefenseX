local Crates = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SkinUtilities = require(TDX_Shared:WaitForChild("SkinData").SkinUtilities)
local Enums = require(Common:WaitForChild("Enums"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
require(script.CrateTypes)
local v = {
	Beige = Color3.fromHex("f5c99a"),
	Black = Color3.new(0.1, 0.1, 0.1),
	Brown = Color3.fromHex("7c5a46"),
	Cyan = Color3.fromHex("5effff"),
	["Deep Blue"] = Color3.fromRGB(54, 58, 247),
	["Forest Green"] = Color3.fromRGB(4, 110, 13),
	Green = Color3.fromHex("afff63"),
	["Light Blue"] = Color3.fromHex("71d6ff"),
	["Light Pink"] = Color3.fromRGB(255, 171, 245),
	Orange = Color3.fromRGB(250, 150, 10),
	Pink = Color3.fromRGB(232, 65, 221),
	Purple = Color3.fromRGB(174, 19, 240),
	Red = Color3.fromRGB(240, 19, 19),
	White = Color3.new(1, 1, 1),
	Yellow = Color3.fromRGB(252, 205, 18),
	["Hot Pink"] = Color3.fromRGB(255, 105, 180),
	CrazY = Color3.fromRGB(255, 255, 255)
}
local v2 = {
	[Enums.Towers.Farm] = "rbxassetid://15595832452",
	[Enums.Towers.Barracks] = "rbxassetid://15595967449"
}
local v3 = {
	["Digital Urban Camo"] = "rbxassetid://16291106165",
	["Woodlands Camo"] = "rbxassetid://16291105693",
	["Digital Desert Camo"] = "rbxassetid://16291106485",
	["Forest Camo"] = "rbxassetid://16291105890",
	["Blue Tiger Camo"] = "rbxassetid://16291105693",
	["Desert Camo"] = "rbxassetid://16291105693",
	["Digital Camo"] = "rbxassetid://16291105693",
	["Red Tiger Camo"] = "rbxassetid://16291105693",
	["Urban Red Camo"] = "rbxassetid://16291105693",
	["Winter Camo"] = "rbxassetid://16291105693",
	["Woodland Camo"] = "rbxassetid://16291105693",
	["Autumn Camo"] = "rbxassetid://16291105693",
	["Urban Camo"] = "rbxassetid://16291105693",
	["Digital Gulf Camo"] = "rbxassetid://16291105693",
	["Digital Army Camo"] = "rbxassetid://16291105693",
	["Woodland Urban Camo"] = "rbxassetid://16291105693",
	["Digital Navy Camo"] = "rbxassetid://16291105693",
	["Sea Camo"] = "rbxassetid://16291105693",
	["Digital Forest Camo"] = "rbxassetid://16291105693",
	["Digital Snow Camo"] = "rbxassetid://16291105693"
}
local random = Random.new(tick())
local modulesByName = {}
local v4 = {}
local skinsByName = {}

local function handleCrateData(moduleScript)
	local module = require(moduleScript)
	local skinsByName2 = {}

	for _, skin in module.Skins do
		local v5 = string.split(skin.Name, "_")
		local v6 = v5[1]
		local v7 = v5[2]

		if not v6 then
			warn(`Could not find tower name for skin {skin.Name}`)
		end

		if not v7 then
			warn(`Could not find skin name for skin {skin.Name}`)
		end

		local color = v[v7]

		if color then
			skin.Color = color
		end

		local textureImageId = v3[v7]

		if textureImageId then
			skin.TextureImageId = textureImageId
		end

		if not skin.Image then
			local towerConfig = ResourceManager.GetTowerConfig(v6)
			local image = v2[v6] or towerConfig.UpgradePathData.BaseLevelData.Icon

			if image then
				skin.Image = image
			else
				warn(`Could not find image ID for tower {v6}`)
			end
		end

		if not skin.DisplayName then
			local skinData = SkinUtilities.GetSkinData(v6, v7)

			if skinData then
				skin.DisplayName = skinData.DisplayName
			else
				skin.DisplayName = v7 .. " " .. v6
			end
		end

		skin.CrateName = moduleScript.Name
		skinsByName2[skin.Name] = skin
		skinsByName[skin.Name] = skin
	end

	v4[moduleScript.Name] = skinsByName2
	modulesByName[moduleScript.Name] = module
end

function Crates.GetSkinData(p: string)
	return skinsByName[p]
end

function Crates.GetAllSkins()
	return skinsByName
end

function Crates.GetSkinsAndOdds(p: string)
	local result = {}
	local v5 = modulesByName[p]

	if not v5 then
		error(`Could not find crate data for {p}`)
	end

	for _, skin in v5.Skins do
		table.insert(result, {
			Name = skin.Name,
			DisplayName = skin.DisplayName,
			Rarity = skin.Rarity,
			Chance = v5.Odds[skin.Rarity]
		})
	end

	return result
end

function Crates.GetCrateData(p: string)
	local v5 = modulesByName[p]

	if not v5 then
		error(`Could not find crate data for {p}`)
	end

	return v5
end

function Crates.GetCrates()
	return modulesByName
end

function Crates.RollCrate(p: string, options)
	local crateData = Crates.GetCrateData(p)
	local v5 = table.create(100)
	local v6 = 1
	local v7 = options or {}

	for k, odd in crateData.Odds do
		for _ = 1, odd do
			v5[v6] = k
			v6 += 1
		end
	end

	local v8 = v5[random:NextInteger(1, 100)]
	local v9 = table.create(32)

	for _, v10 in Crates.GetSkinsAndOdds(p) do
		if v10.Rarity == v8 and table.find(v7, v10.Name) == nil then
			table.insert(v9, v10)
		end
	end

	local v10 = v9[random:NextInteger(1, #v9)]

	if v10 == nil then
		v10 = Crates.RollCrate(p, v7)
	end

	return v4[p][v10.Name]
end

for _, moduleScript in script:WaitForChild("List"):GetChildren() do
	if moduleScript:IsA("ModuleScript") then
		handleCrateData(moduleScript)
	end
end

script.List.ChildAdded:Connect(function(moduleScript)
	if moduleScript:IsA("ModuleScript") then
		handleCrateData(moduleScript)
	end
end)
Crates.COMMON_TOWERNAME_TO_IMAGE_MAP = v2
return Crates