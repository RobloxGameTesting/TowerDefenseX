local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Types"))
require(TDX_Shared:WaitForChild("Modules").MagicShop)
local isStudio = RunService:IsStudio()
local v = {
	Streak = 0,
	LongestStreak = 0,
	LastStreak = 0,
	StreakBroken = false,
	LastQuestCompletionTime = 0,
	NextRefreshTime = 0,
	Quests = {},
	HasSeenNewQuests = false
}
local DataTemplate = {
	LastSeenUpdate = "N/A",
	DoubleTokenTimer = 0,
	Quests = { Daily = table.clone(v), Weekly = table.clone(v) },
	Passes = { Version = 0, ActivePass = nil, Progress = {} },
	Settings = {
		AutoSkip = false,
		LowGraphics = false,
		Blood = true,
		Dialogue = true,
		NameTagEffects = true,
		UI = 5,
		Music = isStudio and 0 or 5,
		SFX = 5,
		Ambient = 5,
		EDJMusic = 5,
		Emotes = 5
	},
	Keybinds = {},
	Inventory = {
		Towers = { [Enums.Towers.Ranger] = true },
		Skins = {},
		Emotes = {},
		PowerUps = {},
		NameTagStyles = {},
		NameTagEffects = {}
	},
	NameTagEffect = "Default",
	NameTagStyle = "Default",
	Loadout = { Enums.Towers.Ranger, "", "", "", "", "" },
	LoadoutPresets = {
		{ "", "", "", "", "", "" },
		{ "", "", "", "", "", "" },
		{ "", "", "", "", "", "" }
	},
	PowerUpsLoadout = { "", "", "", "", "", "" },
	Emotes = { "", "", "", "", "", "" },
	TowerSkins = {},
	RedeemedCodes = {},
	Achievements = {},
	FreeCrates = {},
	Gifts = {},
	VIPGoldAwarded = false,
	Gold = 0,
	Crystals = 0,
	Cookies = 0,
	Envelopes = 0,
	Eggs = 0,
	Burgers = 0,
	XP = 0,
	RobuxDonated = 0,
	GamesPlayed = 0,
	Wins = 0,
	SoloWins = 0,
	Losses = 0,
	WavesSurvived = 0,
	HighestWavesSurvived = 0,
	Kills = 0,
	GameplayTime = 0,
	JoinsSinceTutorialAdded = 0,
	GamesPlayedPerMap = {},
	GamesPlayedPerMode = {},
	GamesPlayedPerMapDifficulty = {},
	WinsPerMode = {},
	SoloWinsPerMode = {},
	WinsPerMapDifficulty = {},
	SoloWinsPerMapDifficulty = {},
	LossesPerMode = {},
	LossesPerMapDifficulty = {},
	WavesSurvivedPerMode = {},
	HighestWavesSurvivedPerMode = {},
	KillsPerMode = {},
	MapAndDifficultyWins = {},
	PreEliteMedalReset_MapAndDifficultyWins = {},
	EliteMedalResetDone = false,
	PreNightmareMedalReset_MapAndDifficultyWins = {},
	NightmareMedalResetDone = false,
	PreEasyMedalReset_MapAndDifficultyWins = {},
	EasyMedalResetDone = false,
	LatestSoloWinPerMode = {},
	PowerUpsUsed = {},
	LastJoinTime = 0,
	LastDailyReward = 0,
	LastDailyPVPReward = 0,
	DailySeed = 0,
	DailyStreak = 0,
	StarterPackTimer = 0,
	PurchasedStarterPack = false,
	TowersPlaced = 0,
	TowerAbilitiesUsed = 0,
	BossKillMap = {},
	FirstPersonCheatGames = 0,
	FirstPersonCheatRemoteFires = 0,
	AnticheatTrackedGames = 0,
	AnticheatVersionGames = {},
	WarMachineEarnedInFirst24h = false,
	RefractorEarnedInFirst24h = false,
	MagicShop = { Timestamp = 0, Entries = {} }
}

if _G.LOBBY_PUZZLE_ENABLED then
	DataTemplate.LobbyPuzzle = { HasTranslator = false }
end

if _G.PVP_SHOP_ENABLED then
	local inventory = DataTemplate.Inventory
	inventory.Enemies = {
		[Enums.Enemies.Boss2] = true,
		[Enums.Enemies.Cloaker] = true,
		[Enums.Enemies.Disruptor] = true,
		[Enums.Enemies.Fallout] = true,
		[Enums.Enemies.FastDroid] = true,
		[Enums.Enemies.HeavyDroid] = true,
		[Enums.Enemies.NormalDroid] = true,
		[Enums.Enemies.ToxicWaste2] = true,
		[Enums.Enemies.EradBPVP] = true
	}
	DataTemplate.EnemiesLoadout = table.create(_G.PVP_ENEMY_LOADOUT_MAX_SIZE, "")
	DataTemplate.PVPPowerUpsLoadout = {
		[Enums.PowerUpCategories.Offensive] = "",
		[Enums.PowerUpCategories.Defensive] = ""
	}
end

if _G.PVP_ENABLED then
	DataTemplate.PVPElo = {}
	DataTemplate.PVPAbandonTimes = {}
end

return DataTemplate