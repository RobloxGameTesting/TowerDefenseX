local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local MapData = require(common:WaitForChild("MapData"))
local LobbyTypeUtilities = { LOBBY_TYPES = Enums.LobbyTypes }
local v = {
	[LobbyTypeUtilities.LOBBY_TYPES.Christmas] = {
		Icon = "rbxassetid://127460911963409",
		MapName = Enums.Maps.SantasStronghold,
		Disabled = true
	},
	[LobbyTypeUtilities.LOBBY_TYPES.TowerBattles] = {
		VotingScreenMusicName = "TBIntermissionMusic",
		Icon = "rbxassetid://114854294679766",
		MapIcon = "rbxassetid://18229669382",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true,
		RandomMapNames = {
			Enums.Maps.MilitaryBase,
			Enums.Maps.Pond,
			Enums.Maps.Borderlands,
			Enums.Maps.Grasslands,
			Enums.Maps.Western,
			Enums.Maps.CyberQuartersTB,
			Enums.Maps.MidnightRoadTB
		},
		AllowMapOverrideForMapVoting = true,
		RequiredBattlePass = "TB"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart1] = {
		VotingScreenMusicName = "HalloweenIntermissionMusic",
		VictoryScreenMusicName = "HalloweenVictoryMusic",
		DefeatScreenMusicName = "HalloweenDefeatMusic",
		Icon = "rbxassetid://127460911963409",
		MapName = Enums.Maps.Calamity,
		RequiredBattlePass = "HW24"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart2] = {
		VotingScreenMusicName = "HalloweenIntermissionMusic",
		VictoryScreenMusicName = "HalloweenVictoryMusic",
		DefeatScreenMusicName = "HalloweenDefeatMusic",
		Icon = "rbxassetid://125915544454340",
		MapName = Enums.Maps.Factorium,
		RequiredBattlePass = "HW24"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart3] = {
		VotingScreenMusicName = "HalloweenIntermissionMusic",
		VictoryScreenMusicName = "HalloweenVictoryMusic",
		DefeatScreenMusicName = "HalloweenDefeatMusic",
		Icon = "rbxassetid://96888615715325",
		MapName = Enums.Maps.Hellspire,
		RequiredBattlePass = "HW24"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart4] = {
		VotingScreenMusicName = "HalloweenIntermissionMusic",
		VictoryScreenMusicName = "HalloweenVictoryMusic",
		DefeatScreenMusicName = "HalloweenDefeatMusic",
		Icon = "rbxassetid://70581156671962",
		MapName = Enums.Maps.Ragnarok,
		RequiredBattlePass = "HW24"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Christmas24Part1] = {
		VotingScreenMusicName = "Christmas24IntermissionMusic",
		DefeatScreenMusicName = "Christmas24DefeatMusicNormal",
		DisplayName = "Christmas Part 1",
		Icon = "rbxassetid://90734664112215",
		MapName = Enums.Maps.ArcticResearchBase,
		RequiredBattlePass = "XMAS24",
		PreloadCutsceneNames = { Enums.Cutscenes.Christmas24Part1Intro }
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Christmas24Part2] = {
		VotingScreenMusicName = "Christmas24IntermissionMusic",
		DefeatScreenMusicName = "Christmas24DefeatMusicNormal",
		DisplayName = "Christmas Part 2",
		Icon = "rbxassetid://129534485291587",
		MapName = Enums.Maps.FortressSnowlyn,
		RequiredBattlePass = "XMAS24",
		PreloadCutsceneNames = { Enums.Cutscenes.Christmas24Part2Intro, Enums.Cutscenes.Christmas24Part2Victory }
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Halloween2025] = {
		VotingScreenMusicName = "Halloween2025IntermissionMusic",
		VictoryScreenMusicName = "Halloween2025VictoryMusic",
		DefeatScreenMusicName = "Halloween2025DefeatMusic",
		DisplayName = "Shattered Moon",
		Icon = "rbxassetid://124534633640721",
		MapName = Enums.Maps.ShatteredMoon,
		RequiredBattlePass = "HW25"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Christmas25Part1] = {
		VotingScreenMusicName = "Christmas25IntermissionMusic",
		VictoryScreenMusicName = "Christmas25VictoryMusic",
		DefeatScreenMusicName = "Christmas25DefeatMusic",
		DisplayName = "Robot Invasion",
		Icon = "rbxassetid://98754153572174",
		MapName = Enums.Maps.WinterContingency,
		RequiredBattlePass = "XMAS25",
		PreloadCutsceneNames = { Enums.Cutscenes.Christmas25Part1Victory }
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Christmas25Part2] = {
		VotingScreenMusicName = "Christmas25IntermissionMusic",
		VictoryScreenMusicName = "Christmas25VictoryMusic",
		DefeatScreenMusicName = "Christmas25DefeatMusic",
		DisplayName = "Assault Mode",
		Icon = "rbxassetid://135276361770461",
		MapIcon = "rbxassetid://122605602910479",
		MapName = Enums.Maps.Northforge,
		RequiredBattlePass = "XMAS25",
		PreloadCutsceneNames = { Enums.Cutscenes.Christmas25Part2Intro }
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Tutorial] = {
		DisplayName = "Tutorial",
		Icon = "",
		MapName = Enums.Maps.Tutorial
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Easy] = {
		DisplayName = "Easy",
		OverrideDifficulty = Enums.Difficulties.Easy,
		Icon = "rbxassetid://75538279716034",
		MapIcon = "rbxassetid://104111514264524",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Intermediate] = {
		DisplayName = "Intermediate",
		OverrideDifficulty = Enums.Difficulties.Intermediate,
		Icon = "rbxassetid://89562492653125",
		MapIcon = "rbxassetid://111340099343897",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Elite] = {
		DisplayName = "Elite",
		OverrideDifficulty = Enums.Difficulties.Elite,
		Icon = "rbxassetid://119517289579208",
		MapIcon = "rbxassetid://131642189886331",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Expert] = {
		DisplayName = "Expert",
		OverrideDifficulty = Enums.Difficulties.Expert,
		Icon = "rbxassetid://87540818959443",
		MapIcon = "rbxassetid://89638765159943",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Party2025] = {
		DisplayName = "Party!",
		OverrideDifficulty = Enums.Difficulties.Party2025,
		Icon = "rbxassetid://71238521842350",
		MapIcon = "rbxassetid://130624841762914",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true,
		Disabled = true
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Endless] = {
		DisplayName = "Endless",
		OverrideDifficulty = Enums.Difficulties.Endless,
		Icon = "rbxassetid://130945192658943",
		MapIcon = "rbxassetid://78791014166144",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true
	},
	[LobbyTypeUtilities.LOBBY_TYPES.MLG] = {
		VictoryScreenMusicName = "MLGVictoryMusic",
		DefeatScreenMusicName = "MLGDefeatMusic",
		DisplayName = "MLG",
		Icon = "rbxassetid://130333954555214",
		MapIcon = "rbxassetid://109666899099890",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true,
		RandomMapNames = { Enums.Maps.RetroRoad, Enums.Maps.CartRideIntoAZombie, Enums.Maps.EvilObby },
		Disabled = not _G.APRIL_FOOLS_2026_EVENT_ENABLED
	},
	[LobbyTypeUtilities.LOBBY_TYPES.SlimeEvent] = {
		VictoryScreenMusicName = "SlimeEventVictoryMusic",
		DefeatScreenMusicName = "SlimeEventDefeatMusic",
		DisplayName = "Slime Event",
		Icon = "",
		MapName = Enums.Maps.SlimeCity
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Nightmare] = {
		DisplayName = "Nightmare",
		Icon = "rbxassetid://109177608469617",
		MapIcon = "rbxassetid://83890032803175",
		MapName = Enums.Maps.Finality,
		RandomMapNames = {
			Enums.Maps.CastellanReach,
			Enums.Maps.SupremacyPrime,
			Enums.Maps.PacificaRuins,
			Enums.Maps.GUNFacility,
			Enums.Maps.Finality
		},
		AllowMapOverrideForMapVoting = true,
		PreloadCutsceneNames = { Enums.Cutscenes.NightmareIntro, Enums.Cutscenes.NightmareSecretWaveVictory }
	},
	[LobbyTypeUtilities.LOBBY_TYPES.NightmareWithMapVoting] = {
		DisplayName = "Nightmare",
		VotingScreenName = "Nightmare",
		Icon = "rbxassetid://109177608469617",
		MapIcon = "rbxassetid://83890032803175",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true,
		RandomMapNames = {
			Enums.Maps.CastellanReach,
			Enums.Maps.SupremacyPrime,
			Enums.Maps.PacificaRuins,
			Enums.Maps.GUNFacility,
			Enums.Maps.Finality
		},
		AllowMapOverrideForMapVoting = true,
		PreloadCutsceneNames = { Enums.Cutscenes.NightmareIntro, Enums.Cutscenes.NightmareSecretWaveVictory }
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Easter26Part1] = {
		VotingScreenMusicName = "Easter26IntermissionMusic",
		VictoryScreenMusicName = "Easter26VictoryMusic",
		DefeatScreenMusicName = "Easter26DefeatMusic",
		DisplayName = "Easter Day",
		Icon = "rbxassetid://95150940430380",
		MapName = Enums.Maps.EasterCastrum,
		RequiredBattlePass = "EASTER26"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.Easter26Part2] = {
		VotingScreenMusicName = "Easter26IntermissionMusic",
		VictoryScreenMusicName = "Easter26VictoryMusic",
		DefeatScreenMusicName = "Easter26DefeatMusic",
		DisplayName = "Easter Night",
		Icon = "rbxassetid://115686931300582",
		MapName = Enums.Maps.Manufactorum,
		RequiredBattlePass = "EASTER26"
	},
	[LobbyTypeUtilities.LOBBY_TYPES.PVP_1V1] = {
		DisplayName = "PVP 1V1",
		OverrideDifficulty = Enums.Difficulties.PVP_1V1,
		Icon = "",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true,
		RandomMapNames = {
			Enums.Maps.Incursion,
			Enums.Maps.Spire,
			Enums.Maps.Factory,
			Enums.Maps.WesternPVP
		},
		AllowMapOverrideForMapVoting = true,
		IsPVP = true,
		Disabled = not _G.PVP_ENABLED
	},
	[LobbyTypeUtilities.LOBBY_TYPES.TBPart2] = {
		UseDifficultyVoteScreenV2 = true,
		DifficultyVoteScreenV2Difficulties = {
			Enums.Difficulties.TBPart2Casual,
			Enums.Difficulties.TBPart2Hard,
			Enums.Difficulties.TBPart2Nightmare,
			Enums.Difficulties.TBPart2Voidmare
		},
		VotingScreenMusicName = "TB2IntermissionMusic",
		VictoryScreenMusicName = "TB2VictoryMusic",
		DefeatScreenMusicName = "TB2DefeatMusic",
		DisplayName = "Tower Battles Part 2",
		Icon = "rbxassetid://82616107332218",
		MapName = Enums.Maps.MapVoting,
		BeginMapVoting = true,
		RandomMapNames = { Enums.Maps.Genesis, Enums.Maps.Exegesis },
		ShowSeizureWarning = true
	}
}

function LobbyTypeUtilities.VerifyLobbyTypeEnabled(p: string)
	local v2 = v[p]

	if v2 then
		return not v2.Disabled
	end

	return false
end

function LobbyTypeUtilities.GetLobbyTypeData(name: string)
	local v2 = v[name]

	if not v2 then
		return
	end

	local mapData = MapData[v2.MapName]

	if mapData then
		local overrideDifficulty = v2.OverrideDifficulty
		return {
			Name = name,
			DisplayName = v2.DisplayName or name,
			VotingScreenName = v2.VotingScreenName or not overrideDifficulty and name,
			UseDifficultyVoteScreenV2 = v2.UseDifficultyVoteScreenV2 or false,
			DifficultyVoteScreenV2Difficulties = v2.DifficultyVoteScreenV2Difficulties,
			VotingScreenMusicName = v2.VotingScreenMusicName,
			VictoryScreenMusicName = v2.VictoryScreenMusicName,
			DefeatScreenMusicName = v2.DefeatScreenMusicName,
			OverrideDifficulty = overrideDifficulty,
			Icon = v2.Icon,
			MapIcon = v2.MapIcon or mapData.Image,
			MapName = v2.MapName,
			RandomMapNames = v2.RandomMapNames,
			AllowMapOverrideForMapVoting = v2.AllowMapOverrideForMapVoting,
			MapData = mapData,
			BeginMapVoting = v2.BeginMapVoting or false,
			IsPVP = v2.IsPVP or false,
			ShowSeizureWarning = v2.ShowSeizureWarning or false,
			RequiredBattlePass = v2.RequiredBattlePass,
			PreloadCutsceneNames = v2.PreloadCutsceneNames
		}
	else
		warn("No map data found for lobby type:", name, "with map name:", v2.MapName)
	end
end

return LobbyTypeUtilities