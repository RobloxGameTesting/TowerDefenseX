local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Shared = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Shared"))
local Enums = require(Common:WaitForChild("Enums"))
local RunService2 = game:GetService("RunService")
local isStudio = RunService2:IsStudio()
_G.BUILD_VERSION = "6.1.0"
_G.ANNOUNCEMENT_VERSION_HISTORY = {
	"6.1.0",
	"6.0.0",
	"5.3.1",
	"5.3.0",
	"5.2.1",
	"5.2.0",
	"5.1.9",
	"5.1.8",
	"5.1.7",
	"5.1.6",
	"5.1.5",
	"5.1.4",
	"5.1.3",
	"5.1.2",
	"5.1.1",
	"5.1.0",
	"5.0.0",
	"4.5.2",
	"4.5.1",
	"4.5.0",
	"4.4.2",
	"4.4.1",
	"4.4.0",
	"4.3.1",
	"4.3.0",
	"4.2.0",
	"4.1.0",
	"4.0.0",
	"3.0.0",
	"2.5.1",
	"2.4.1",
	"2.4.0",
	"2.3.4",
	"2.2.3",
	"2.2.2",
	"2.2.1",
	"2.2.0",
	"2.1.1",
	"2.1.0",
	"2.0.0"
}
_G.DATA_ITERATION = 7
_G.MAX_TOWER_COUNT_SETTINGS = { 140, 70, 50, 40, 32 }
_G.MAX_AIR_TOWERS_PER_PLAYER = 12
_G.FPS_MODE_STRONG_BOSS_THRESHOLD = 1000000
_G.VIP_POWERUP_COUNT = 6
_G.NON_VIP_POWERUP_COUNT = 4
_G.ENABLE_POWER_UP_CONFIG_REWORK = true
_G.GROUP_EXTRA_STARTING_CASH = 125
_G.TOWER_SELL_RETURN = 0.5
_G.TOWER_SELL_RETURN_CONVERTED = 0.8
_G.DEFAULT_TIME_BETWEEN_WAVES = 60
_G.DELAY_ONCE_WAVE_CLEARED = 5
_G.WAVE_MIN_DURATION_BEFORE_SKIP_VOTE = 15
_G.DIFFICULTY_VOTE_TIME = 35
_G.MAX_REWINDS = 5
_G.DEFAULT_BODY_HEAT = 5
_G.DEFAULT_BODY_HEAT_REGENERATION_RATE = 2.5
_G.DEFAULT_THAW_TIME = 1.2
_G.FROZEN_MAXIMUM_TIME = 6
_G.FROZEN_DEBOUNCE_TIME = 3.5
_G.FROZEN_REWORK_ENABLED = true
_G.FIRST_MAP_AND_DIFFICULTY_WIN_BONUS = 0.8
local _g = _G
_g.FIRST_MAP_AND_DIFFICULTY_WIN_BONUS_CUSTOM_MAP = {
	[Enums.Difficulties.Nightmare] = 0.67,
	[Enums.Difficulties.UltraNightmare] = 0.67
}
_G.DIFFICULTIES_WITH_FIRST_TIME_BONUS = {
	Enums.Difficulties.Easy,
	Enums.Difficulties.Intermediate,
	Enums.Difficulties.Elite,
	Enums.Difficulties.Expert,
	Enums.Difficulties.Party2025,
	Enums.Difficulties.Nightmare,
	Enums.Difficulties.UltraNightmare
}
_G.MAP_DIFFICULTIES_WITH_DISABLED_POWERUPS = { Enums.MapDifficulties.Impossible, Enums.MapDifficulties.Nightmare }
_G.XP_MULTIPLIER = 1
_G.TOKEN_MULTIPLIER = 1
_G.GOLD_MULTIPLIER = 1
_G.CRYSTAL_MULTIPLIER = 1
_G.CASH_PER_DAMAGE_MULTIPLIER_MAX = 0.3
_G.GOLD_WIN_BONUS_MAX = 200
_G.DEV_CASH = 8000000
_G.DEV_STARTING_LIVES = 800000
_G.DEV_DISABLE_DIALOGUE = false
_G.DEV_MAP_NAME = isStudio and Enums.Maps.AtrazineTestMap or Enums.Maps.BloxOut
_G.DEV_AUTO_START_DIFFICULTY = Enums.Difficulties.Test
_G.DEV_MAX_ABILITY_COOLDOWN = 1e999
_G.DEV_UNLIMITED_POWERUPS = true
_G.DEV_PVP_STACK_OPPONENTS = false
_G.DEV_FALLBACK_USER_ID = 5489039
_G.DEBUG_EMOTE_TESTING = false
_G.EMOTE_OVERRIDE_LOADOUT = {
	"Rice Cake Soup",
	"Fountain",
	"Void Gummies",
	"Commander Toy",
	"Void Plush",
	"Eradicator Toy"
}
_G.STUDIO_LOADOUT = {
	Enums.Towers.GoldenMobster,
	Enums.Towers.VoidTraitor,
	Enums.Towers.Aviator,
	Enums.Towers.Juggernaut,
	Enums.Towers.CombatDrone,
	Enums.Towers.Phaser,
	Enums.Towers.CryoHelicopter,
	Enums.Towers.Refractor,
	Enums.Towers.WarMachineFactory,
	Enums.Towers.Artillery
}
_G.DEV_OVERRIDE_SKINS = {}
_G.STUDIO_POWERUP_LOADOUT = {
	Enums.PowerUps.RaptorStorm,
	Enums.PowerUps.AirStrike,
	Enums.PowerUps.B52Bomber,
	Enums.PowerUps.SR71Strike,
	Enums.PowerUps.UberField,
	Enums.PowerUps.VoidCalling
}
_G.STUDIO_PVP_POWERUP_LOADOUT = {
	Offensive = Enums.PowerUps.PVPEnemySpeedBoost,
	Defensive = Enums.PowerUps.PVPGlobalDamageMode
}
_G.LOBBY_PLACE_ID = 9503261072
_G.DEV_LOBBY_PLACE_ID = 11275324362
_G.PERF_TESTING_LOBBY_PLACE_ID = 122629334167147
_G.GAME_PLACE_ID = 11739766412
_G.DEV_GAME_PLACE_ID = 15433423608
_G.VIP_GAMEPASS_ID = 655796534
_G.SPEED_CONTROL_GAMEPASS_ID = 655578581
_G.STARTERPACK_DEV_PRODUCT_ID = 3226725475
_G.STARTER_PACK_PRICE_IN_ROBUX = 325
_G.STARTERPACK_TIME = 86400
_G.STARTERPACK_GOLD = 1750
_G.STARTERPACK_TOWERS = {
	Enums.Towers.John,
	Enums.Towers.MissileTrooper,
	Enums.Towers.Operator,
	Enums.Towers.Grenadier
}
_G.VIP_GOLD_REWARD = 1250
_G.VIP_XP_MULTIPLIER = 1.1
_G.SPEED_CONTROL_FAST_SPEED = 1.5
_G.SPEED_CONTROL_SLOW_SPEED = 0.5
_G.SPEED_CONTROL_COOLDOWN = 3
_G.SPEED_CONTROL_VOTE_COOLDOWN = 15
_G.REPLICATION_RATE = 20
_G.CLIENT_DEFAULT_FPS = 60
_G.ENTITY_DEFAULT_RADIUS = 1
_G.PARTITIONING_CELL_SIZE = 16
_G.SPLASH_RADIUS_TO_TRANSFER_TO_AIR = 7
_G.PATH_TURN_RADIUS = 3
_G.RAMP_LEAN_RADIUS = 1
_G.RAMP_MIN_ELEVATION = 0.1
_G.MAX_PATH_OFFSET = 0.75
_G.AIR_TOWER_HOVER_HEIGHT = 12
_G.AIR_ENEMY_HOVER_HEIGHT = 8
_G.DISABLE_BLOOD_CONSOLE = true
_G.KNOCKBACK_TWEEN_TIME = 0.7
_G.KNOCKBACK_HEIGHT = 2
_G.TDX_GROUP_ID = 14733518
_G.GAME_ANALYTICS_GAME_KEY = "b867c443af064eeb822e77a20f756fbf"
_G.PRINT_ENEMY_COUNT = false
_G.PRINT_CLIENT_LOOP_TIME = false
_G.FILL_PATH_WITH_ENEMIES = false
_G.FILL_ENEMY_TYPE = Enums.Enemies.Abomination
_G.FILL_SPAWN_RATE = 0.15
_G.TEST_SPAWN_ENEMIES = {}
_G.CORRUPTED_ERADICATOR_MK2_JUMPSCARE_TIME = 117
_G.BATTLEPASS_REWORK_ENABLED = true
_G.BATTLEPASS_GIFTING_ENABLED = true
_G.ALLOW_FREE_BATTLEPASS_UNLOCKING = false
_G.TOKENS_TO_KEEP_FREE_BATTLEPASSES = 8000
_G.ALLOW_FREE_ACCESS_TO_BATTLEPASS_MAPS = true
_G.LOBBY_PUZZLE_ENABLED = true
_G.CHRISTMAS_2025_EVENT_ENABLED = false
_G.LUNAR_NEW_YEAR_EVENT_ENABLED = false
_G.EASTER_2026_EVENT_ENABLED = false
_G.APRIL_FOOLS_2026_EVENT_ENABLED = false
_G.FOURTH_OF_JULY_2026_EVENT_ENABLED = false
_G.TB2_EVENT_ENABLED = true
_G.CUSTOM_ANALYTICS_ENABLED = game.PlaceId == Shared.GAME_PLACE_ID
_G.EVENT_CURRENCY_ENABLED = {
	Eggs = _G.EASTER_2026_EVENT_ENABLED,
	Burgers = _G.FOURTH_OF_JULY_2026_EVENT_ENABLED,
	Envelopes = _G.LUNAR_NEW_YEAR_EVENT_ENABLED,
	Cookies = _G.CHRISTMAS_2025_EVENT_ENABLED
}
_G.SHOP_V3_ENABLED = true
_G.PVP_TEAM_NAMES = { "Blue", "Red", "Green", "Yellow" }
_G.PVP_TEAM_COLORS = { "Bright blue", "Bright red", "Bright green", "Bright yellow" }
_G.SPECTATOR_TEAM_NAME = "Spectators"
_G.SPECTATOR_TEAM_COLOR = "Pearl"
_G.SPECTATOR_ADMIN_BUTTONS = {
	SpeedToggle = true,
	Pause = true,
	Pause2 = true,
	SkipWave = true,
	Lives = true,
	Restart = true,
	Difficulty = true,
	KillAll = true,
	Falter = true,
	WinLose = true,
	StealthAll = true,
	ResetAbilities = true,
	ResetAbilitiesEnemy = true,
	ResetAttacks = true,
	Stasis = true,
	MapEntity = true,
	SecretWave = true,
	Circle = true,
	ToggleOscillation = true,
	ToggleTurretAiming = true
}
_G.PVP_TEAM_BAR_COLORS = {
	{
		Fill = { Color3.fromRGB(63, 95, 255), Color3.fromRGB(0, 49, 96) },
		Cap = { Color3.fromRGB(211, 226, 255), Color3.fromRGB(52, 113, 192) }
	},
	{
		Fill = { Color3.fromRGB(255, 26, 26), Color3.fromRGB(118, 2, 2) },
		Cap = { Color3.fromRGB(255, 160, 160), Color3.fromRGB(223, 88, 88) }
	},
	{
		Fill = { Color3.fromRGB(40, 230, 60), Color3.fromRGB(2, 92, 20) },
		Cap = { Color3.fromRGB(176, 255, 186), Color3.fromRGB(72, 190, 96) }
	},
	{
		Fill = { Color3.fromRGB(255, 214, 26), Color3.fromRGB(128, 92, 0) },
		Cap = { Color3.fromRGB(255, 240, 176), Color3.fromRGB(222, 176, 52) }
	}
}
_G.DEADZONE_DASHED_CIRCLE_COLOR = Color3.fromRGB(160, 31, 31)
_G.PVP_SHOP_ENABLED = true
_G.PVP_ENABLED = true
_G.PVP_DAILY_BONUS_ENABLED = true
_G.PVP_DAILY_BONUS_MULTIPLIER = 2
_G.STUDIO_TEST_PVP = true
_G.USE_PVP_TEST_ENEMY_LOADOUT = RunService:IsStudio() or Shared.IS_DEV_PLACE
_G.PVP_ENEMY_LOADOUT_MAX_SIZE = 12
_G.PVP_ENEMY_QUEUE_MAX_SIZE = 8
_G.PVP_ELO_CLIENT_VISIBLE = RunService:IsStudio() or Shared.IS_DEV_PLACE
_G.PVP_ELO_DEFAULT = 1000
_G.PVP_ELO_INITIAL_PER_RANK = 1
_G.PVP_ELO_INITIAL_RANK_CAP = 200
_G.PVP_ELO_MIN = 100
_G.PVP_ELO_K_FACTOR = 32
_G.PVP_ELO_PLACEMENT_K_FACTOR = 64
_G.PVP_ELO_PLACEMENT_GAMES = 10
_G.PVP_ABANDON_WINDOW = 86400
_G.PVP_ABANDON_MAX_TRACKED = 20
_G.PVP_ABANDON_QUEUE_COOLDOWNS = { 0, 300, 1800, 7200, 28800 }
local PVPEconomyConfig = require(Common:WaitForChild("PVPEconomyConfig"))
_G.PVP_CASH_ECO_TICK_INTERVAL = PVPEconomyConfig.TickInterval
_G.PVP_STARTING_CASH_ECO = PVPEconomyConfig.StartingCashEco
_G.PVP_CASH_ECO_INCREASE_DURATION = PVPEconomyConfig.IncreaseDuration
_G.PVP_CASH_ECO_INCREASE = PVPEconomyConfig.IncreaseAmount
_G.PVP_TEST_ENEMY_LOADOUT = {
	Enums.Enemies.NormalDroid,
	Enums.Enemies.FastDroid,
	Enums.Enemies.HeavyDroid,
	Enums.Enemies.Boss1,
	Enums.Enemies.Fallout,
	Enums.Enemies.ToxicWaste2,
	Enums.Enemies.Cloaker,
	Enums.Enemies.Boss2,
	Enums.Enemies.Crusher,
	Enums.Enemies.Malfunction,
	Enums.Enemies.Monstrosity,
	Enums.Enemies.NightKnight
}
_G.TOWERS_BAR_COUNT = isStudio and not _G.STUDIO_TEST_PVP and 11 or 6
_G.DEFAULT_DIFFICULTY = isStudio and Enums.Difficulties.Test or Enums.Difficulties.Easy
_G.DEFAULT_SPEED_MULTIPLIER = 1
_G.CUTSCENE_FAST_FORWARD_TIME = isStudio and 0 or nil
_G.DEBUG_CUTSCENE_CONTROLS = isStudio
_G.NEW_PLAY_BUTTONS_ENABLED = true
_G.PVP_ENEMY_LOADOUT_MAX_SIZE = 12
return nil