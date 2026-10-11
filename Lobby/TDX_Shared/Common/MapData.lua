local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local Maps = Enums.Maps
local MapDifficulties = Enums.MapDifficulties
local _ = {
	Veer = "V_eeer",
	EpicDJGameKing = "epicdjgameking",
	Scrufus = "Scrufus",
	JohnRoblox = "JOHN ROBLOX :3",
	ExtremelyHugeBadger = "ExtremelyHugeBadger",
	Arch = "archmaestros",
	Rikaforge = "rikaforge",
	Atrazine = "Atrazine",
	NoelleXD = "NoelleXD"
}
return {
	[Maps.VolcanicMishap] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://14762424541"
	},
	[Maps.ObscureIsland] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://14762424172"
	},
	[Maps.AncientSkyIsland] = {
		Creator = "epicdjgameking",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://14762424368"
	},
	[Maps.WinterFort] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://13747204507"
	},
	[Maps.SecretForest] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://14005150270"
	},
	[Maps.Apocalypse] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://12968961477"
	},
	[Maps.OilRig] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://12381094725"
	},
	[Maps.BloxOut] = {
		Creator = "ExtremelyHugeBadger",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://12381095833"
	},
	[Maps.DangerBeach] = {
		Creator = "ExtremelyHugeBadger",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://12381096186"
	},
	[Maps.SFOTH] = {
		Creator = "ExtremelyHugeBadger",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://12381095407"
	},
	[Maps.UnforgivingWinter] = {
		Creator = "ExtremelyHugeBadger",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://14005165044"
	},
	[Maps.MilitaryHarbor] = {
		Creator = "Scrufus",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://12968961228"
	},
	[Maps.DesertedIsland] = {
		Creator = "JOHN ROBLOX :3",
		Difficulty = MapDifficulties.Impossible,
		Image = "rbxassetid://14762424065"
	},
	[Maps.VaporCity] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://15360245792"
	},
	[Maps.MisleadingPond] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://15360246041"
	},
	[Maps.CowAnnoyance] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://15360245910"
	},
	[Maps.MoonOutpost] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://15638522013"
	},
	[Maps.Chalet] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "http://www.roblox.com/asset/?id=15728751031"
	},
	[Maps.Vinland] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Normal,
		Image = "http://www.roblox.com/asset/?id=15728754287"
	},
	[Maps.FortSummit] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Simple,
		Image = "http://www.roblox.com/asset/?id=15728752874"
	},
	[Maps.TreasureCove] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://16283237864"
	},
	[Maps.Purgatory] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://17224115263"
	},
	[Maps.Limbo] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://17224114862"
	},
	[Maps.SorrowsHarbor] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Hard,
		Image = "http://www.roblox.com/asset/?id=17224089112"
	},
	[Maps.Singularity] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://17224114428"
	},
	[Maps.AssemblyLine] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://17224097562"
	},
	[Maps.ScorchedPassage] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://17224095196"
	},
	[Maps.BladeWorks] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Impossible,
		Image = "rbxassetid://17221050497"
	},
	[Maps.ResearchBase] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://17310102408"
	},
	[Maps.Highrise] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://17683669972"
	},
	[Maps.DeadEndValley] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://18570868504"
	},
	[Maps.Asteroid] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Impossible,
		Image = "rbxassetid://81519037839373"
	},
	[Maps.Anchor] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://94390594102421"
	},
	[Maps.Baseplate] = {
		Creator = "JOHN ROBLOX :3",
		Difficulty = MapDifficulties.Impossible,
		Image = "rbxassetid://131913672135346"
	},
	[Maps.GasStation] = {
		Creator = "V_eeer",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://121077544385568"
	},
	[Maps.GDIPortCity] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://85903767805845"
	},
	[Maps.HakureiShrine] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://129342615598802"
	},
	[Maps.Junction] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://83022637561332"
	},
	[Maps.OutpostForge] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://108249868569924"
	},
	[Maps.Route] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://89557375840987"
	},
	[Maps.Simulation] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://126572351510197"
	},
	[Maps.Survival202] = {
		Creator = "JOHN ROBLOX :3",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://134760156216140"
	},
	[Maps.OilField] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://125965218740970"
	},
	[Maps.CoastalDefense] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://74553987759974"
	},
	[Maps.ResearchAndDevelopment] = {
		Creator = "rikaforge",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://127096242567278"
	},
	[Maps.CastleValley] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://87528742614570"
	},
	[Maps.Cathedral] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://125186890691207"
	},
	[Maps.Headquarters] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://98447733806779"
	},
	[Maps.CyberQuarters] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://130004205988099",
		IsNew = true
	},
	[Maps.MidnightRoad] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://98283315556465",
		IsNew = true
	},
	[Maps.CastellanReach] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://123467208526531",
		CustomMedalDifficulties = { Enums.Difficulties.Nightmare, Enums.Difficulties.UltraNightmare }
	},
	[Maps.SupremacyPrime] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://72158254681278",
		CustomMedalDifficulties = { Enums.Difficulties.Nightmare, Enums.Difficulties.UltraNightmare }
	},
	[Maps.PacificaRuins] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		Image = "rbxassetid://131174333941661",
		CustomMedalDifficulties = { Enums.Difficulties.Nightmare, Enums.Difficulties.UltraNightmare }
	},
	[Maps.GUNFacility] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		Image = "rbxassetid://139266072553390",
		CustomMedalDifficulties = { Enums.Difficulties.Nightmare, Enums.Difficulties.UltraNightmare }
	},
	[Maps.Finality] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		Image = "rbxassetid://77716888360639",
		CustomMedalDifficulties = { Enums.Difficulties.Nightmare, Enums.Difficulties.UltraNightmare }
	},
	[Maps.Tutorial] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = ""
	},
	[Maps.MapVoting] = {
		Creator = "NoelleXD",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://121033464976362"
	},
	[Maps.SantasStronghold] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://15657682478"
	},
	[Maps.MilitaryBase] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229669382"
	},
	[Maps.Pond] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229668930"
	},
	[Maps.Borderlands] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229668764"
	},
	[Maps.Grasslands] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229669213"
	},
	[Maps.Western] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Simple,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229668570"
	},
	[Maps.CyberQuartersTB] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		IsNew = true,
		Image = "rbxassetid://130004205988099",
		DisplayName = Maps.CyberQuarters,
		BaseMap = Maps.CyberQuarters
	},
	[Maps.MidnightRoadTB] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		IsNew = true,
		Image = "rbxassetid://98283315556465",
		DisplayName = Maps.MidnightRoad,
		BaseMap = Maps.MidnightRoad
	},
	[Maps.Calamity] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://114328197269384"
	},
	[Maps.Factorium] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://114767155807126"
	},
	[Maps.Hellspire] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://98729090058422"
	},
	[Maps.Ragnarok] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://102820695103360"
	},
	[Maps.ArcticResearchBase] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://116939353847398"
	},
	[Maps.FortressSnowlyn] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://138450250998980"
	},
	[Maps.RetroRoad] = {
		Creator = "NoelleXD",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://109666899099890"
	},
	[Maps.CartRideIntoAZombie] = {
		Creator = "NoelleXD",
		Difficulty = MapDifficulties.Hard,
		IsEventOnlyMap = true,
		Image = "rbxassetid://117087161010051"
	},
	[Maps.EvilObby] = {
		Creator = "NoelleXD",
		Difficulty = MapDifficulties.Impossible,
		IsEventOnlyMap = true,
		Image = "rbxassetid://121986647440159"
	},
	[Maps.SlimeCity] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://119219657218064"
	},
	[Maps.ShatteredMoon] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://95641456736249"
	},
	[Maps.WinterContingency] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://117153551933661"
	},
	[Maps.Northforge] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://122605602910479"
	},
	[Maps.EasterCastrum] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://127395528719441"
	},
	[Maps.Manufactorum] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://97768743867654"
	},
	[Maps.Genesis] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Impossible,
		IsEventOnlyMap = true,
		Image = "rbxassetid://134481500354405"
	},
	[Maps.Exegesis] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = "rbxassetid://102497578082903"
	},
	[Maps.SuperSecretForest] = {
		Creator = "JOHN ROBLOX :3",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://16944726028"
	},
	[Maps.BaseplateToilet] = {
		Creator = "JOHN ROBLOX :3",
		Difficulty = MapDifficulties.Simple,
		Image = "rbxassetid://16944745433"
	},
	[Maps.Incursion] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://134599422737390"
	},
	[Maps.Spire] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Hard,
		IsEventOnlyMap = true,
		Image = "rbxassetid://92671371273025"
	},
	[Maps.Factory] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://76290883318387"
	},
	[Maps.MilitaryBasePVP] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229669382"
	},
	[Maps.GrasslandsPVP] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Normal,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229669213"
	},
	[Maps.WesternPVP] = {
		Creator = "archmaestros",
		Difficulty = MapDifficulties.Simple,
		IsEventOnlyMap = true,
		Image = "rbxassetid://18229668570"
	},
	[Maps.AtrazineTestMap] = {
		Creator = "Atrazine",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = ""
	},
	[Maps.AtrazineTestMapShort] = {
		Creator = "Atrazine",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = ""
	},
	[Maps.AtrazinePVPTestMap] = {
		Creator = "Atrazine",
		Difficulty = MapDifficulties.Easy,
		IsEventOnlyMap = true,
		Image = ""
	}
}