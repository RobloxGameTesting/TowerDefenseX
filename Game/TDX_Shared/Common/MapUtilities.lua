local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local MapData = require(common:WaitForChild("MapData"))
local v = {
	[Enums.MapDifficulties.Simple] = {
		Color = Color3.fromRGB(142, 234, 255),
		BorderColor = Color3.fromRGB(35, 58, 63)
	},
	[Enums.MapDifficulties.Easy] = {
		Color = Color3.fromRGB(127, 255, 88),
		BorderColor = Color3.fromRGB(38, 75, 26)
	},
	[Enums.MapDifficulties.Normal] = {
		Color = Color3.fromRGB(255, 207, 84),
		BorderColor = Color3.fromRGB(69, 71, 34)
	},
	[Enums.MapDifficulties.Hard] = {
		Color = Color3.fromRGB(255, 120, 58),
		BorderColor = Color3.fromRGB(97, 45, 22)
	},
	[Enums.MapDifficulties.Impossible] = {
		Color = Color3.fromRGB(255, 106, 106),
		BorderColor = Color3.fromRGB(83, 12, 12)
	},
	[Enums.MapDifficulties.Nightmare] = {
		Color = Color3.fromRGB(156, 107, 255),
		BorderColor = Color3.fromRGB(43, 30, 71)
	}
}
local v2 = {
	Enums.Maps.VolcanicMishap,
	Enums.Maps.ObscureIsland,
	Enums.Maps.AncientSkyIsland,
	Enums.Maps.WinterFort,
	Enums.Maps.SecretForest,
	Enums.Maps.Apocalypse,
	Enums.Maps.OilRig,
	Enums.Maps.BloxOut,
	Enums.Maps.DangerBeach,
	Enums.Maps.SFOTH,
	Enums.Maps.UnforgivingWinter,
	Enums.Maps.MilitaryHarbor,
	Enums.Maps.DesertedIsland,
	Enums.Maps.VaporCity,
	Enums.Maps.MisleadingPond,
	Enums.Maps.MoonOutpost,
	Enums.Maps.Chalet,
	Enums.Maps.FortSummit,
	Enums.Maps.Vinland,
	Enums.Maps.CowAnnoyance,
	Enums.Maps.TreasureCove,
	Enums.Maps.Purgatory,
	Enums.Maps.Limbo,
	Enums.Maps.SorrowsHarbor,
	Enums.Maps.Singularity,
	Enums.Maps.AssemblyLine,
	Enums.Maps.ScorchedPassage,
	Enums.Maps.BladeWorks,
	Enums.Maps.ResearchBase,
	Enums.Maps.Highrise,
	Enums.Maps.DeadEndValley,
	Enums.Maps.Asteroid,
	Enums.Maps.Anchor,
	Enums.Maps.Baseplate,
	Enums.Maps.GasStation,
	Enums.Maps.GDIPortCity,
	Enums.Maps.HakureiShrine,
	Enums.Maps.Junction,
	Enums.Maps.OutpostForge,
	Enums.Maps.Route,
	Enums.Maps.Simulation,
	Enums.Maps.Survival202,
	Enums.Maps.OilField,
	Enums.Maps.CoastalDefense,
	Enums.Maps.ResearchAndDevelopment,
	Enums.Maps.CastleValley,
	Enums.Maps.Cathedral,
	Enums.Maps.SuperSecretForest,
	Enums.Maps.BaseplateToilet,
	Enums.Maps.Headquarters,
	Enums.Maps.CyberQuarters,
	Enums.Maps.MidnightRoad
}
local MapUtilities = {}

function MapUtilities.GetMainModeMaps()
	return v2
end

function MapUtilities.GetResourceMapName(baseMap: string)
	local v3 = MapData[baseMap]

	if v3 then
		baseMap = v3.BaseMap or baseMap
	end

	return baseMap
end

function MapUtilities.GetDisplayName(displayName: string)
	local v3 = MapData[displayName]

	if v3 then
		displayName = v3.DisplayName or displayName
	end

	return displayName
end

function MapUtilities.GetColorDataForMapDifficulty(p: string)
	return v[p]
end

return MapUtilities