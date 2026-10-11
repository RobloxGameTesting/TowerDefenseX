local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	General = {
		Yes = "Yes",
		No = "No",
		Level = "LVL %s",
		Day = "DAY %s",
		DayStreak = "%s DAY STREAK",
		Claimed = "CLAIMED",
		Claim = "CLAIM",
		OpenAnother = "OPEN ANOTHER?",
		AttemptingToRejoin = "Attempting to rejoin...",
		ServerNoExist = "Server no longer exists :(",
		RejoinFailed = "Rejoin failed, unknown error :(",
		WebCallFailed = "API CALL FAILED"
	},
	Codes = {
		Success = "Code redeemed!",
		Redeemed = "Code already redeemed :(",
		Expired = "Code expired :(",
		Unknown = "Code doesn't exist :("
	},
	Shop = {
		UnlockedAt = "UNLOCK AT LVL %s",
		BuyWithRobux = utf8.char(57346) .. "%s",
		BuyForRobux = "BUY FOR " .. utf8.char(57346) .. "%s",
		BuyBundleForRobux = "BUY BUNDLE FOR " .. utf8.char(57346) .. "%s",
		LockedBuyForRobux = "LVL %s, OR " .. utf8.char(57346) .. "%s",
		BuyForGold = "BUY FOR $%s",
		BuyForCrystals = "BUY FOR %s CRYSTALS",
		AlternativeDivide = "OR...",
		NumberOwned = "%s OWNED",
		Owned = "OWNED",
		BuyNow = "BUY NOW",
		YouOwn = "You own %s",
		ShortQuantity = "x%s",
		BuyOneFor = "BUY 1 FOR $%s",
		BuyOneForCrystals = "BUY 1 FOR %s CRYSTALS",
		BuyFiveFor = "BUY 5 FOR " .. utf8.char(57346) .. "%s",
		BuyOneForRobux = "BUY 1 FOR " .. utf8.char(57346) .. "%s",
		SellConfirm = "Are you sure you want to sell %s for $%s?\n\nThis cannot be undone!",
		ComingSoon = "Coming Soon"
	},
	AdvisorNames = {
		Default = "ADVISOR",
		Xenon = "DR. XENON",
		Commander = "COMMANDER",
		Void = "VOID",
		Heretic = "HERETIC",
		Engineer = "ENGINEER",
		JohnHalloweenPart2 = "JOHN",
		OilHalloweenPart3 = "OIL",
		OilHalloweenPart3Nightmare = "OIL",
		AdvisorHalloweenPart4 = "ADVISOR",
		WretchedHalloweenPart4Nightmare = "THE WRETCHED",
		Christmas24Part1_Advisor = "ADVISOR",
		Christmas24Part1Nightmare_Xenon = "DR. XENON",
		Christmas24Part2_Advisor = "ADVISOR",
		Christmas24Part2Nightmare_Xenon = "DR. XENON",
		Halloween25_Advisor = "ADVISOR",
		MLG = "lolsman23",
		GeneralLeah = "GENERAL LEAH"
	},
	BattlePass = {
		TierName = "LEVEL %s REWARD - %s",
		TierRequired = "LEVEL %s REQUIRED",
		RefundLabel = "If you already own this item, %s gold will be awarded instead",
		ActivateLabel = "Enabling this battle pass will pause your current active pass [%s]. You can reenable that pass again at any time. Would you like to still enable this pass?",
		PassNames = {
			HW24 = "Halloween 2024",
			HW25 = "Halloween 2025",
			XMAS24 = "Christmas 2024",
			XMAS25 = "Christmas 2025",
			TB = "Tower Battles",
			TB2 = "Tower Battles 2",
			EASTER26 = "Easter 2026"
		},
		DisplayTypes = {
			Skin = "SKIN",
			Tower = "TOWER",
			PowerUp = "POWER UP",
			Emote = "EMOTE",
			XP = "XP",
			Gold = "GOLD",
			Crystals = "CRYSTALS",
			Cookies = "COOKIES",
			NameTagEffect = "NAME TAG EFFECT",
			Eggs = "EGGS",
			Enemy = "ENEMY"
		},
		TimeRemaining = {
			Days = "%s days left",
			DaysShort = "%sd",
			Hours = "%s hours left",
			HoursShort = "%sh",
			Minutes = "%s minutes left",
			MinutesShort = "%sm"
		},
		ItemNames = {
			Gold = "%s GOLD",
			Crystals = "%s CRYSTALS",
			Cookies = "%s COOKIES",
			Eggs = "%s EGGS",
			XP = "%s XP",
			A10Strike = "A-10 STRIKE (x%s)",
			MOAB = "MOAB (x%s)",
			NuclearMissile = "NUCLEAR MISSILE (x%s)",
			CryoBlast = "CRYO BLAST (x%s)",
			DropPod = "DROP POD (x%s)",
			DamageField = "DAMAGE FIELD (x%s)",
			RangeField = "RANGE FIELD (x%s)",
			UberField = "UBER FIELD (x%s)",
			AirStrike = "AIR STRIKE (x%s)",
			B52Bomber = "B52 BOMBER (x%s)",
			EmergencyCrate = "EMERGENCY CRATE (x%s)",
			MegaZed = "MEGA Z.E.D. (x%s)",
			AC130Support = "AC-130 SUPPORT (x%s)",
			CashCrate = "CASH CRATE (x%s)",
			HealthCrate = "HEALTH CRATE (x%s)",
			EmergencySupplyCrate = "EMERGENCY CRATE (x%s)",
			Punkbuster = "PUNKBUSTER (x%s)",
			RaptorStorm = "RAPTOR STORM (x%s)",
			ReconDrone = "RECON DRONE (x%s)",
			SR71Strike = "SR-71 STRIKE (x%s)",
			TBFragger = "FRAGGER",
			TBFarm = "TOWER BATTLES",
			TBCryoGunner = "CRYOGUNNER",
			TBRailgunner = "TOWER BATTLES",
			StrykerRush = "STRYKER RUSH (x%s)",
			TBRave = "RAVE",
			GoldenZed = "GOLDEN Z.E.D. (x%s)",
			TBBarracks = "TOWER BATTLES",
			TBBenchRest = "BENCH REST",
			TBEndbringer = "ENDBRINGER",
			TBArmoredFactory = "TOWER BATTLES",
			TBGoldenScout = "GOLDEN SCOUT",
			TBRockbandDJ = "ROCKBAND",
			TBCommander = "COMMANDER",
			TBCommanderGDA = "GDA COMMANDER",
			TBZed = "Z.E.D.",
			TBZedGDA = "GDA Z.E.D.",
			TBSubstitute = "SUBSTITUTE",
			TBLifeguard = "LIFEGUARD",
			HW24Cardboard = "CARDBOARD",
			HW24Scarecrow = "SCARECROW",
			HW24Candy = "CANDY",
			HW24Halloween = "HALLOWEEN",
			HW24Astronaut = "ASTRONAUT",
			HW24Pumpkin = "PUMPKIN",
			HW24Toxic = "TOXIC",
			HW24Relic = "RELIC",
			HW24Mysterious = "MYSTERIOUS",
			HW24FlameTrooper = "FLAME TROOPER",
			HW24Head = "HEAD",
			HW24Conga = "CONGA",
			HW24PlagueDoctor = "PLAGUE DOCTOR",
			HW24Patriot = "PATRIOT",
			HW24Pirate = "PIRATE",
			HW24Clown = "CLOWN",
			XMAS24Christmas = "CHRISTMAS",
			XMAS24HotChocolate = "HOT CHOCOLATE",
			XMAS24EradicatorToy = "ERADICATOR TOY",
			XMAS24CryoHelicopter = "CRYO HELICOPTER",
			HW25CandyBucket = "CANDY BUCKET",
			HW25PumpkinRide = "PUMPKIN RIDE",
			HW25Evil = "EVIL",
			HW25Zombie = "ZOMBIE",
			HW25Toy = "TOY",
			HW25Neko = "NEKO",
			HW25Spooky = "SPOOKY",
			HW25FlameBats = "FLAME BATS",
			HW25Halloween = "HALLOWEEN",
			HW25Skeleton = "SKELETON",
			HW25ShockTrooper = "SHOCK TROOPER",
			XMAS25Cool = "COOL",
			XMAS25Gingerbread = "GINGERBREAD",
			XMAS25Santa = "SANTA",
			XMAS25ChristmasLights = "CHRISTMAS LIGHTS",
			XMAS25HotChoccy = "HOT CHOCCY :3",
			XMAS25Aurora = "AURORA",
			XMAS25Cyber = "CYBER",
			EASTER26Easter = "EASTER",
			EASTER26Bunny = "BUNNY",
			VoidCalling = "VOID CALLING (x%s)",
			TB2Void = "VOID",
			TB2GDA = "GDA",
			TB2Red = "RED",
			TB2Statue = "STATUE",
			TB2Purple = "PURPLE",
			TB2Pink = "PINK",
			TB2Biker = "BIKER",
			TB2Hidden = "HIDDEN",
			TB2HotPink = "HOT PINK",
			TB2CrazY = "CRAZY",
			TB2Black = "BLACK",
			TB2DeathKnight = "DEATH KNIGHT"
		},
		QuestDescriptions = {
			BeatEasyMode = "Defeat Easy Mode on any impossible map",
			BeatHardMapsThreeTimes = "Win 3 Hard maps on any mode",
			DefeatPredatorTenTimes = "Defeat Predator 10 times",
			WinThreeGames = "Win 3 games on any mode",
			Kill4kEnemies = "Eliminate 4,000 enemies",
			BeatNightOneNightmareTwice = "Win Night I Nightmare twice",
			DefeatEradicatorThreeTimes = "Defeat Eradicator 3 times",
			DefeatRevivedPlagueDoctorTwoTimes = "Defeat Revived Plague Doctor in Elite mode 2 times",
			WinSevenGames = "Win 7 games on any mode",
			DefeatEradicatorMK2TwoTimes = "Defeat Eradicator MK II twice",
			DefeatPlagueDoctorFourTimes = "Defeat Plague Doctor in Easy mode 3 times",
			Use100TowerAbilities = "Use a Tower Ability 100 times",
			BeatImpossibleMapsThreeTimes = "Win an impossible map 3 times",
			BeatEliteOnSurvival202 = "Win Elite on Survival 202",
			Kill2kEnemies = "Eliminate 2,000 enemies",
			Kill1kEnemies = "Eliminate 1,000 enemies",
			BeatEasyOnBaseplate = "Win Easy on Baseplate",
			Send1000IonGuards = "Send 1,000 Ion Guards in PVP",
			Send3Eradicators = "Send 3 Eradicators in PVP",
			Send2500Fallouts = "Send 2,500 Fallouts in PVP",
			Send200Boss2s = "Send 200 Boss 2s in PVP",
			Send1000HeavyMetals = "Send 1,000 Heavy Metals in PVP",
			Send3CaptainSlimes = "Send 3 Captain Slimes in PVP",
			Send3EradBs = "Send 3 Erad-B's in PVP",
			Send400SlowDroids = "Send 400 Heavy Droids in PVP",
			WinTBPart2Hard = "Win 1 game of TBPart2Hard",
			Deal500kDamageWithScout = "Deal 500,000 Damage with Scout"
		}
	},
	Quests = {
		Daily = {
			WinEasyMode3Times = "Win 3 Easy mode games",
			Deal200kDamage = "Deal 200,000 total damage.",
			Deal150kDamageWithRanger = "Deal 150,000 damage using Ranger",
			Deal150kDamageWithMissileTrooper = "Deal 150,000 damage using Missile Trooper",
			Deal125kDamageWithShotgunner = "Deal 125,000 damage using Shotgunner",
			BeatEasyMapsTwoTimes = "Win 2 games on Easy maps",
			BeatNormalMapsTwoTimes = "Win 2 games Normal maps",
			BeatSimpleMapsTwoTimes = "Win 2 games on Simple maps",
			Use200TowerAbilities = "Use 200 tower abilities",
			Kill500Enemies = "Eliminate 500 enemies",
			Upgrade40RangersTo5_2 = "Upgrade 40 Rangers to 5-2",
			Upgrade40MissileTroopersTo5_2 = "Upgrade 40 Missile Troopers to 5-2",
			WinIntermediateMode3Times = "Win Intermediate mode 3 times",
			Deal500kDamage = "Deal 500,000 total damage",
			Deal250kDamageWithOperator = "Deal 250,000 damage with Operators",
			Deal325kDamageWithMissileTrooper = "Deal 325,000 damage with Missile Troopers",
			Deal150kDamageWithGrenadier = "Deal 150,000 damage with Grenadiers.",
			Win3EasyMapsOnIntermediate = "Win 3 games on Easy maps in Intermediate mode",
			Win2NormalMapsOnIntermediate = "Win 2 games on Normal maps in Intermediate mode",
			Win2SimpleMapsOnIntermediate = "Win 2 games on Simple maps in Intermediate mode",
			WinFiveGames = "Win 5 games on any mode",
			Kill777Enemies = "Eliminate 777 enemies",
			Win1HardMapOnEasy = "Win 1 game on a Hard map in Easy mode",
			Deal100kDamageWithBarracks = "Deal 100,000 damage with Barracks",
			Deal150kDamageWithJohn = "Deal 150,000 damage with John",
			Upgrade50OperatorsTo5_2 = "Upgrade 50 Operators to 5-2",
			Upgrade50MissileTroopersTo5_2 = "Upgrade 50 Missile Troopers to 5-2",
			Upgrade20GrenadiersTo5_2 = "Upgrade 20 Grenadiers to 5-2",
			UseOperatorHumveeAbility15Times = "Use Operator's Spawn Humvee ability 15 times",
			UseJohnAxeAbility5Times = "Use John's Axe ability 5 times",
			UseJohnRageAbility12Times = "Use John's Rage Mode ability 12 times",
			WinEliteMode2Times = "Win Elite mode 2 times",
			Deal1MTotalDamage = "Deal 1,000,000 total damage",
			Deal300kDamageWithLaserGunner = "Deal 300,000 damage with Laser Gunners",
			Deal300kDamageWithGrenadier = "Deal 300,000 damage with Grenadiers",
			Deal300kDamageWithPatrolBoat = "Deal 300,000 damage with Patrol Boats",
			Deal300kDamageWithJohn = "Deal 300,000 damage with Johns",
			Deal300kDamageWithSentry = "Deal 300,000 damage with Sentries",
			Deal300kDamageWithJuggernaut = "Deal 300,000 damage with Juggernauts",
			Deal300kDamageWithRailgunner = "Deal 300,000 damage with Railgunners",
			Deal300kDamageWithMobster = "Deal 300,000 damage with Mobsters",
			Win3NormalMapsOnElite = "Win 3 games on Normal maps in Elite mode",
			WinEliteOnHardMap = "Win 1 game on a Hard map in Elite mode",
			WinEasyOnImpossibleMap = "Win 1 game on an Impossible map in Easy mode",
			UseEDJAbility12Times = "Use EDJ's Encore ability 12 times",
			UseMobsterBountyAbility15Times = "Use Mobster's Place Bounty ability 15 times",
			UseLaserGunnerShockRoundAbility15Times = "Use Laser Gunner's Shock Rounds ability 15 times",
			UseJohnAxeAbility15Times = "Use John's Axe ability 15 times",
			Upgrade20EDJsTo2_5 = "Upgrade 20 EDJs to 2-5",
			Upgrade40JuggernautsTo5_2 = "Upgrade 40 Juggernauts to 5-2",
			Upgrade25JuggernautsTo2_5 = "Upgrade 25 Juggernauts to 2-5",
			Upgrade20JohnsTo2_5 = "Upgrade 20 Johns to 2-5",
			Upgrade10FarmsTo2_5 = "Upgrade 10 Farms to 2-5",
			Upgrade50SentriesTo5_2 = "Upgrade 50 Sentries to 5-2",
			Kill2000Enemies = "Eliminate 2,000 enemies",
			Win3SimpleMapsOnElite = "Win 3 games on Simple maps in Elite mode",
			Win1ExpertGame = "Win 1 game of Expert on any map",
			DefeatDestructor2Times = "Defeat Destructor 2 times",
			PassWave30OnExpert2Times = "Pass Wave 30 on Expert 2 times",
			KillVXDrone3Times = "Defeat VX-Drone 3 times",
			Upgrade20RailgunnersTo2_5 = "Upgrade 20 Railgunners to 2-5",
			Upgrade10RailgunnersTo5_2 = "Upgrade 10 Railgunners to 5-2",
			Upgrade15MobstersTo5_2 = "Upgrade 15 Mobsters to 5-2",
			PassWave80OnEndlessEasyMap = "Pass Wave 80 on any Easy map in Endless mode",
			WinElite3TimesOnNormalMaps = "Win 3 games on Normal maps in Elite mode",
			WinExpertTwiceOnEasyMaps = "Win 2 games on Easy maps in Expert mode",
			DefeatEradicatorMKIVTwice = "Defeat Eradicator MK IV 2 times",
			DefeatEradicatorMKICTwice = "Defeat Eradicator MK I Combat 2 times",
			DefeatApexPredatorTwice = "Defeat Apex Predator 2 times",
			WinExpertTwiceOnNormalMaps = "Win 2 games on Normal maps in Expert mode",
			WinEliteOnceOnHardMap = "Win 1 game on a Hard map in Elite mode",
			Deal2MTotalDamage = "Deal 2,000,000 total damage",
			PassWave80OnEndlessSimpleMap = "Pass Wave 80 on any Simple map in Endless mode",
			Deal1MDamageWithJuggernaut = "Deal 1,000,000 damage with Juggernauts",
			Deal1MDamageWithJohn = "Deal 1,000,000 damage with Johns",
			Deal1MDamageWithXWM = "Deal 1,000,000 damage with XWM Turrets",
			Deal500kDamageWithSlammer = "Deal 500,000 damage with Slammers",
			Kill4000Enemies = "Eliminate 4,000 enemies",
			Deal1MDamageWithSentry = "Deal 1,000,000 damage with Sentries",
			Deal1MDamageWithArtillery = "Deal 1,000,000 damage with Artilleries",
			Deal650kDamageWithAATurret = "Deal 650,000 damage with AA Turrets",
			Deal1MDamageWithMachineGunner = "Deal 1,000,000 damage with Machine Gunners",
			Deal1MDamageWithGhost = "Deal 1,000,000 damage with Ghosts",
			Deal1MDamageWithGoldenRanger = "Deal 1,000,000 damage with Golden Rangers",
			Deal1MDamageWithArmoredFactory = "Deal 1,000,000 damage with Armored Factories",
			Deal1MDamageWithGoldenJuggernaut = "Deal 1,000,000 damage with Golden Juggernauts",
			Deal1MDamageWithRailgunner = "Deal 1,000,000 damage with Railgunners",
			Deal1MDamageWithGoldenMineLayer = "Deal 1,000,000 damage with Golden Mine Layers",
			Deal1MDamageWithPatrolBoat = "Deal 1,000,000 damage with Patrol Boats",
			Upgrade20GoldenJuggernautsTo5_2 = "Upgrade 20 Golden Juggernauts to 5-2",
			Upgrade30GoldenRangersTo5_2 = "Upgrade 30 Golden Rangers to 5-2",
			Upgrade20SlammersTo5_2 = "Upgrade 20 Slammers to 5-2",
			Upgrade20MedicsTo5_2 = "Upgrade 20 Medics to 5-2",
			Upgrade16HelicoptersTo2_5 = "Upgrade 16 Helicopters to 2-5",
			Upgrade16AATurretsTo5_2 = "Upgrade 16 AA Turrets to 5-2",
			Upgrade16ArtilleriesTo5_2 = "Upgrade 16 Artilleries to 5-2",
			Upgrade22ArtilleriesTo2_5 = "Upgrade 22 Artilleries to 2-5",
			Upgrade20SlammersTo2_5 = "Upgrade 20 Slammers to 2-5",
			Upgrade10ToxicnatorsTo2_5 = "Upgrade 10 Toxicnators to 2-5",
			Upgrade20XWMsTo5_2 = "Upgrade 20 XWM Turrets to 5-2",
			Upgrade12XWMsTo2_5 = "Upgrade 12 XWM Turrets to 2-5",
			Upgrade40RailgunnersTo5_2 = "Upgrade 40 Railgunners to 5-2",
			Upgrade20ArmoredFactoriesTo5_2 = "Upgrade 20 Armored Factories to 5-2",
			Upgrade30RailgunnersTo2_5 = "Upgrade 30 Railgunners to 2-5",
			Upgrade10MedicsTo2_5 = "Upgrade 10 Medics to 2-5",
			UseGoldenJuggernautReboot20Times = "Use Golden Juggernaut's Reboot Systems ability 20 times",
			UseGoldenMineLayerSMine35Times = "Use Golden Mine Layer's Hand Throw ability 35 times",
			UseGoldenRangerGrenade25Times = "Use Golden Ranger's Grenade ability 25 times",
			WinEasyModePublic3Times = "Win 3 Easy mode games in public matchmaking",
			WinIntermediateModePublic3Times = "Win 3 Intermediate mode games in public matchmaking",
			WinEliteModePublic3Times = "Win 3 Elite mode games in public matchmaking",
			WinExpertModePublic3Times = "Win 3 Expert mode games in public matchmaking",
			PlayTheTutorial = "Play the tutorial",
			PassWave80OnEndlessNormalMap = "Pass Wave 80 on any Normal map in Endless mode",
			Deal200kDamageWithCryoBlaster = "Deal 200,000 damage with Cryo Blasters",
			UseEDJEncore10Times = "Use EDJ's Encore ability 10 times",
			UseMobsterBounty20Times = "Use Mobster's Place Bounty ability 20 times",
			UseSlammerSlam20Times = "Use Slammer's Grand Slam ability 20 times",
			WinChristmas25Part1Twice = "Win 2 Robot Invasion games in Normal mode",
			WinChristmas25Part1NightmareTwice = "Win 2 Robot Invasion games in Nightmare mode",
			WinChristmas25Part2Twice = "Win 2 Assault Mode games in Normal mode",
			WinChristmas25Part2NightmareTwice = "Win 2 Assault Modes games in Nightmare mode",
			Upgrade10CryoMortarsToMax = "Upgrade 10 Cryo Mortars to max level",
			Deal200kDamageWithCryoMortar = "Deal 200,000 damage with Cryo Mortars"
		},
		Weekly = {
			Deal1M200KDamage = "Deal 1,200,000 total damage",
			WinEasyMode10Times = "Win 10 Easy mode games",
			Kill6000Enemies = "Eliminate 6,000 enemies",
			WinOnBloxOut7Times = "Win 7 games on Blox Out",
			WinTowerBattlesPart1Normal4Times = "Win Tower Battles on Normal mode 4 times",
			WinHalloween24Part1Normal4Times = "Win Halloween 2024 Part 1 on Normal mode 4 times",
			Deal5M500KDamage = "Deal 5,500,000 total damage",
			Kill75kEnemies = "Eliminate 75,000 enemies",
			Kill7500Enemies = "Eliminate 7,500 enemies",
			Kill30Predators = "Defeat Predator 30 times",
			Deal2MDamageWithJohn = "Deal 2,000,000 damage with John",
			Deal3MDamageWithJuggernaut = "Deal 3,000,000 damage with Juggernaut",
			WinHalloween24Part2Normal6Times = "Win Halloween 2024 Part 2 on Normal mode 6 times",
			WinTowerBattlesPart1Normal7Times = "Win Tower Battles on Normal mode 7 times",
			WinHalloween24Part3Normal6Times = "Win Halloween 2024 Part 3 on Normal mode 6 times",
			WinChristmas24Part1Normal6Times = "Win Christmas 2024 Part 1 on Normal mode 6 times",
			WinIntermediateMode9Times = "Win 9 Intermediate mode games",
			Deal12MDamage = "Deal 12,000,000 total damage",
			Kill250kEnemies = "Eliminate 250,000 enemies",
			Kill25kEnemies = "Eliminate 25,000 enemies",
			WinExpertOnEasyMaps5Times = "Win 5 games on Easy maps in Expert mode",
			WinEliteOnNormalMaps4Times = "Win 4 games on Normal maps in Elite mode",
			WinChristmas24Part2Normal6Times = "Win Christmas 2024 Part 2 Normal 6 times",
			WinHalloween24Part3Normal7Times = "Win Halloween 2024 Part 3 Normal 7 times",
			WinIntermediateOnHardMaps8Times = "Win 8 games on Hard maps in Intermediate mode",
			Deal7MDamageWithArtillery = "Deal 7,000,000 damage with Artilleries",
			Deal5MDamageWithRailgunner = "Deal 5,000,000 damage with Railgunners",
			Deal4MDamageWithJohn = "Deal 4,000,000 damage with Johns",
			WinHalloween24Part4Normal6Times = "Win Halloween 2024 Part 4 on Normal 6 times",
			Deal50MDamage = "Deal 50,000,000 total damage",
			Kill500kEnemies = "Eliminate 500,000 enemies",
			Kill50kEnemies = "Eliminate 50,000 enemies",
			WinExpertOnNormalMaps6Times = "Win 6 games on Normal maps in Expert mode",
			WinEliteOnHardMaps7Times = "Win 7 games on Hard maps in Elite mode",
			WinTBNightmareOnBorderlands3Times = "Win 3 games on Borderlands in Tower Battles on Nightmare difficulty",
			WinChristmas24Part2Nightmare5Times = "Win Christmas 2024 Part 2 on Nightmare difficulty 5 times",
			WinHalloween24Part2Nightmare6Times = "Win Halloween 2024 Part 2 on Nightmare difficulty 6 times",
			WinHalloween24Part3Nightmare5Times = "Win Halloween 2024 Part 3 on Nightmare difficulty 5 times",
			WinHalloween24Part4Nightmare5Times = "Win Halloween 2024 Part 4 on Nightmare difficulty 5 times",
			Deal10MDamageWithLaserGunner = "Deal 10,000,000 damage with Laser Gunners",
			Deal5MDamageWithSentry = "Deal 5,000,000 damage with Sentries",
			Deal5MDamageWithToxicnator = "Deal 5,000,000 damage with Toxicnators",
			Deal5MDamageWithJohn = "Deal 5,000,000 damage with Johns",
			DefeatEmperor5Times = "Defeat Emperor 5 times"
		}
	},
	Achievements = {
		Join = {
			DisplayName = "Joined the game",
			Description = "Join the game for the first time. Welcome to TDX!"
		},
		KillTutorialBoss = { DisplayName = "Complete TDX Tutorial", Description = "Defeat Erad-B." },
		KillPlagueDoctor = {
			DisplayName = "Back To The 1300s",
			Description = "Defeat Plague Doctor."
		},
		KillPlagueDoctor2 = {
			DisplayName = "Plague Takedown",
			Description = "Defeat Plague Doctor 6 times."
		},
		KillPlagueDoctor3 = {
			DisplayName = "Plague Conqueror",
			Description = "Defeat Plague Doctor 13 times."
		},
		KillPredator = { DisplayName = "[REDACTED] Down!", Description = "Take down Predator." },
		KillPredator2 = {
			DisplayName = "Predator Knock Down",
			Description = "Take down Predator 10 times."
		},
		KillEradicator = { DisplayName = "ERADICATED!", Description = "Defeat Eradicator." },
		KillEradicator2 = {
			DisplayName = "ERADICATION!",
			Description = "Defeat Eradicator 5 times."
		},
		KillRevivedPlagueDoctor = {
			DisplayName = "Back To The 1300s Again",
			Description = "Defeat Revived Plague Doctor."
		},
		KillRevivedPlagueDoctor2 = {
			DisplayName = "Stay Down Bud",
			Description = "Defeat Revived Plague Doctor 6 times!"
		},
		KillEradicatorMK2 = {
			DisplayName = "That Was An Explosive Event!",
			Description = "Defeat Eradicator MK II."
		},
		KillArtemis = { DisplayName = "Defeat Artemis!", Description = "From the hunt." },
		KillZeus = { DisplayName = "Defeat Zeus!", Description = "From thunder." },
		KillPhobeus = { DisplayName = "Defeat Phoebus!", Description = "From the sun." },
		KillDestructor = {
			DisplayName = "Defeat Destructor!",
			Description = "Destruction no more."
		},
		KillEradicatorMK2Rework = {
			DisplayName = "Defeat Eradicator MK II+",
			Description = "Dr. Xenon did not figure out the core overheating problem."
		},
		KillQueen = {
			DisplayName = "Defeat Queen!",
			Description = "Defeat Queen in the new Elite rework."
		},
		KillKing = {
			DisplayName = "Defeat King!",
			Description = "Defeat King in the new Elite rework."
		},
		KillRevivedPlagueDoctorRework = {
			DisplayName = "Defeat Revived Plague Doctor+",
			Description = "Defeat the new and improved Revived Plague Doctor+."
		},
		KillX2Trooper = {
			DisplayName = "Defeat X-2 Trooper",
			Description = "Defeat the X-2 Trooper in Nightmare mode"
		},
		KillAlphaPredator = {
			DisplayName = "Defeat Alpha Predator",
			Description = "Defeat the Alpha Predator in Nightmare mode"
		},
		KillEmperor = {
			DisplayName = "Defeat Emperor",
			Description = "Defeat the Emperor in Nightmare mode"
		},
		KillEmperorUltra = {
			DisplayName = "Defeat Emperor Ultra",
			Description = "Defeat the Emperor in Ultra Nightmare mode"
		},
		KillNemesis = { DisplayName = "Defeat ???", Description = "Defeat ??? in Nightmare mode" },
		FirstTower = { DisplayName = "First Tower", Description = "Place down your first tower." },
		FirstTowerAbility = {
			DisplayName = "First Tower Ability",
			Description = "Use a tower's ability!"
		},
		AbilitySpammer = {
			DisplayName = "Tower Ability Spammer",
			Description = "Use tower abilities 100 times."
		},
		FirstHardMap = { DisplayName = "First Hard Map", Description = "Triumph on a hard map!" },
		FirstImpossibleMap = {
			DisplayName = "First Impossible Map",
			Description = "Triumph on an impossible map!"
		},
		BeatNightmareMode5Times = {
			DisplayName = "Defeat the Nightmare",
			Description = "Beat Nightmare mode 5 times"
		},
		BeatTB2 = {
			DisplayName = "Raze the Void",
			Description = "Beat Hard difficulty in the Tower Battles 2 event"
		},
		BeatTB2Nightmare = {
			DisplayName = "Void Lands Conquerors",
			Description = "Beat Nightmare difficulty in the Tower Battles 2 event"
		},
		BeatTB2Voidmare = {
			DisplayName = "Impress the Void God",
			Description = "Beat Voidmare difficulty in the Tower Battles 2 event"
		},
		Level1 = {
			DisplayName = "Rank 10",
			Description = "Reach rank 10 in TDX, starting a great journey..."
		},
		Level2 = {
			DisplayName = "Rank 24",
			Description = "Some serious progress, you're getting there."
		},
		Level3 = {
			DisplayName = "Rank 40",
			Description = "You're almost ready for the big leagues..."
		},
		Level4 = { DisplayName = "Level 64", Description = "Some serious grinding there bud." },
		Level5 = { DisplayName = "Level 90", Description = "Golden stars and eagles soaring." },
		Level6 = { DisplayName = "Level 100", Description = "You're ready for the big leagues." },
		Level7 = { DisplayName = "Level 125", Description = "Welcome to the big leagues." },
		Level8 = { DisplayName = "Level 150", Description = "Promoted from commander to General." },
		KillZombies1 = {
			DisplayName = "Novice",
			Description = "Eliminate 1,000 enemies. We're just getting started!"
		},
		KillZombies2 = {
			DisplayName = "Professional",
			Description = "Eliminate 10,000 enemies. Keep it up!"
		},
		KillZombies3 = {
			DisplayName = "Veteran",
			Description = "Eliminate 100,000 enemies. Good work commander!"
		},
		KillZombies4 = {
			DisplayName = "Master",
			Description = "Eliminate 1,000,000 enemies. Stellar work commander!"
		},
		KillZombies5 = {
			DisplayName = "Slayer",
			Description = "Eliminate 10,000,000 enemies. Outstanding work commander!"
		},
		Time1 = { DisplayName = "First Hour", Description = "Play for 1 hour." },
		Time2 = { DisplayName = "5 Hours", Description = "Play for 5 hours." },
		Time3 = { DisplayName = "10 Hours", Description = "Play for 10 hours." },
		Time4 = { DisplayName = "25 Hours", Description = "Play for 25 hours." },
		Time5 = { DisplayName = "50 Hours", Description = "Play for 50 hours." },
		Time6 = { DisplayName = "100 Hours", Description = "Play for 100 hours." },
		Time7 = { DisplayName = "One Whole Week", Description = "Play for 168 hours. Go outside." },
		Time8 = { DisplayName = "One Whole Month", Description = "Play for 720 hours. Get a job." },
		Time9 = { DisplayName = "365 Days", Description = "Play for 8,760 hours. Get a life." },
		Win1 = { DisplayName = "First Triumph", Description = "Congrats on your first win!" },
		Win5 = {
			DisplayName = "Win 5 Rounds",
			Description = "Good job! You're getting the hang of this!"
		},
		Win50 = {
			DisplayName = "Win 50 Rounds",
			Description = "Looks like you're a pretty capable commander!"
		},
		Win200 = { DisplayName = "Win 200 Rounds", Description = "You're an expert at this game!" },
		Win500 = { DisplayName = "Win 500 Rounds", Description = "You're a master at this game!" },
		Win1000 = {
			DisplayName = "Win 1,000 Rounds",
			Description = "You're a legend at this game!"
		}
	},
	AssetInfo = {
		PowerUps = {
			[Enums.PowerUps.A10Strike] = {
				Name = "A-10 Strike",
				Description = "2 A-10s will deal massive damage to a selected area!"
			},
			[Enums.PowerUps.AC130Support] = {
				Name = "AC-130 Support",
				Description = "Deals damage to the first enemy for a total of 45 seconds!"
			},
			[Enums.PowerUps.AirStrike] = {
				Name = "Air Strike",
				Description = "Fighter jets called to deal splash damage to targets!"
			},
			[Enums.PowerUps.B52Bomber] = {
				Name = "B52 Bomber",
				Description = "Call in a carpet bombing run across a large line on the map!"
			},
			[Enums.PowerUps.RaptorStorm] = {
				Name = "Raptor Storm",
				Description = "F-22 raptors fly in with insane fire power!"
			},
			[Enums.PowerUps.ReconDrone] = {
				Name = "Recon Drone",
				Description = "Scan for stealth enemies, revealing for 3 minutes!"
			},
			[Enums.PowerUps.CashCrate] = {
				Name = "Cash Crate",
				Description = "Drops a cash crate, immediately providing $1500!"
			},
			[Enums.PowerUps.HealthCrate] = {
				Name = "Health Crate",
				Description = "Drops a health crate, immediately providing 1000 HP!"
			},
			[Enums.PowerUps.HealingField] = {
				Name = "Healing Field",
				Description = "Deploys a healing field, healing your towers for 15 seconds!"
			},
			[Enums.PowerUps.NuclearMissile] = {
				Name = "Nuclear Missile",
				Description = "The GDA's most powerful asset. Ravage the enemies like never before."
			},
			[Enums.PowerUps.Punkbuster] = {
				Name = "PunkBuster Missile",
				Description = "Stealth jet called in to deal major damage while stunning bosses for 15 seconds!"
			},
			[Enums.PowerUps.MOAB] = {
				Name = "M.O.A.B.",
				Description = "B-2 Stealth Bomber called in to drop a heavy bomb, decimating foes in a large area!"
			},
			[Enums.PowerUps.StrykerRush] = {
				Name = "Stryker Rush",
				Description = "Armored Personnel Carriers called in to ram any foe in the way!"
			},
			[Enums.PowerUps.GoldenZed] = {
				Name = "Golden Z.E.D.",
				Description = "Insane damage and health, used to battle against the Void."
			},
			[Enums.PowerUps.CryoBlast] = {
				Name = "Cryo Blast",
				Description = "Freeze and damage enemies in a large area!"
			},
			[Enums.PowerUps.DropPod] = {
				Name = "Drop Pod",
				Description = "Call in Drop Trooper reinforcements from the sky!"
			},
			[Enums.PowerUps.DamageField] = {
				Name = "Damage Field",
				Description = "Boost your towers in range with 50%% more damage for 30 seconds!"
			},
			[Enums.PowerUps.RangeField] = {
				Name = "Range Field",
				Description = "Boost your towers in range with 50%% more range for 30 seconds!"
			},
			[Enums.PowerUps.UberField] = {
				Name = "Uber Field",
				Description = "Apply UBER to your towers for 30 seconds! It's like you have god mode!"
			},
			[Enums.PowerUps.EmergencySupplyCrate] = {
				Name = "Emergency Crate",
				Description = "Drops health and cash crates, immediately providing 1500 HP and $2400!"
			},
			[Enums.PowerUps.SR71Strike] = {
				Name = "SR-71 Strike",
				Description = "Instantly calls in a fast jet to deliver an EMP payload, stalling bosses!"
			},
			[Enums.PowerUps.MegaZed] = {
				Name = "Mega Z.E.D.",
				Description = "Powercrept version of Golden Z.E.D"
			},
			[Enums.PowerUps.VoidCalling] = {
				Name = "Void Calling",
				Description = "Call a mysterious void ally onto the path to take on the enemies!"
			},
			[Enums.PowerUps.PVPUberField] = {
				Name = "Uber Field",
				Description = "Apply UBER to your towers in range for 30 seconds! It's like you have god mode!"
			},
			[Enums.PowerUps.PVPRangeBoost] = {
				Name = "Range Boost",
				Description = "Boost the range of all your towers by 100%% for 30 seconds!"
			},
			[Enums.PowerUps.PVPGlobalDamageMode] = {
				Name = "Friendly Damage Buff",
				Description = "All your towers deal 50%% more damage for 15 seconds!"
			},
			[Enums.PowerUps.PVPEcoBoost] = {
				Name = "Eco Boost",
				Description = "All your towers earn 20%% more cash per hit for 15 seconds!"
			},
			[Enums.PowerUps.PVPEnemySpeedBoost] = {
				Name = "Enemy Speed Boost",
				Description = "Speed up all enemies on your opponent's board by 50%% for 10 seconds!"
			},
			[Enums.PowerUps.PVPEnemyShieldRegen] = {
				Name = "Enemy Shield Regen",
				Description = "Give all enemies on your opponent's board a shield based on their HP!"
			},
			[Enums.PowerUps.PVPAirStrike] = {
				Name = "Air Strike",
				Description = "Call in an air strike on your opponent's board, damaging their towers and units in range!"
			}
		},
		Emotes = {
			MonsterMash = { Name = "Monster Mash", Description = "It catches on in a flash!" },
			ChainsawDance = { Name = "Chainsaw", Description = "Based from uh, [REDACTED]" },
			SherbertDance = { Name = "Sherbert", Description = "Walkin in style." },
			StockShuffle = { Name = "Stock Shuffle", Description = "Break it down in 3 fps!" },
			Sturdy = { Name = "Sturdy", Description = "Get sturdy with it." },
			Rave = { Name = "Rave", Description = "" },
			["Bench Rest"] = { Name = "Bench Rest", Description = "" },
			Conga = { Name = "Conga", Description = "[TODO]" },
			["Hot Chocolate"] = { Name = "Hot Chocolate", Description = "" },
			["Eradicator Toy"] = { Name = "Eradicator Toy", Description = "" },
			Fireworks = { Name = "Fireworks", Description = "Happy 4th of July!" },
			BBQ = { Name = "BBQ", Description = "" },
			["Candy Bucket"] = { Name = "Candy Bucket", Description = "Halloween2025" },
			["Pumpkin Ride"] = { Name = "Pumpkin Ride", Description = "Halloween2025" },
			["Hot Choccy"] = { Name = "Hot Choccy", Description = "Christmas2025" },
			Mortar = { Name = "Mortar", Description = "NYE2025" },
			Fountain = { Name = "Fountain", Description = "NYE2025" },
			Lantern = { Name = "Lantern", Description = "LNY2026" },
			["Rice Cake Soup"] = { Name = "Rice Cake Soup", Description = "LNY2026" },
			["Bunny Plush"] = { Name = "Bunny Plush", Description = "Easter2026" },
			["Void Gummies"] = { Name = "Void Gummies", Description = "TODO" },
			["Jeep Patrol"] = { Name = "Jeep Patrol", Description = "TODO" },
			["Warship Throw"] = { Name = "Warship Throw", Description = "TODO" },
			["Void Rest Time"] = { Name = "Void Rest Time", Description = "TODO" },
			["Commander Toy"] = { Name = "Commander Toy", Description = "TODO" },
			["Void Plush"] = { Name = "Void Plush", Description = "TODO" }
		},
		Bundles = {
			ChristmasBundle = { Name = "Christmas Bundle", Description = "Festive!" },
			ValentinesBundle = { Name = "Valentine's Bundle", Description = "Lovely!" },
			XenonForcesPVPBundle = {
				Name = "Xenon Forces Pack",
				Description = "Dr. Xenon's elite forces, infamous for their many sieges against the GDA."
			},
			PlagueArmyPVPBundle = {
				Name = "Plague Army Pack",
				Description = "Dr. Xenon's Plague Division, utilizing a mix of technology and the undead to overwhelm your opponent."
			},
			HeavyBossesPVPBundle = {
				Name = "Heavy Bosses Pack",
				Description = "A pack of the most feared bosses found in Dr. Xenon's forces. Demolish your enemy's defenses by sending these heavy hitters."
			},
			LightBossesPVPBundle = {
				Name = "Light Bosses Pack",
				Description = "A squad of formidable bosses that can be used to turn the tide against your opponent."
			},
			BotsPVPBundle = {
				Name = "Bots Pack",
				Description = "A collection of offensive robots, salvaged from the incident at Forge Industries' Northforge base."
			}
		},
		Crates = {
			BasicCrate = {
				Name = "Basic Crate",
				Description = "Contains an assortment of skins for all towers!"
			},
			BasicCrate2 = {
				Name = "Basic Crate 2",
				Description = "Contains an assortment of skins for all towers!"
			},
			JulyCrate = {
				Name = "July 4th Crate",
				Description = "Contains American themed skins for 10 towers!"
			},
			GhostCrate = {
				Name = "Ghost Crate",
				Description = "Ghost Tower arrives with her allies, the Ghost division."
			},
			PartyCrate = { Name = "Party Crate", Description = "Celebrate TDX's anniversary!" },
			SummerCrate = {
				Name = "Summer Crate",
				Description = "Get limited edition summer skins before August 31!"
			},
			ValentinesCrate = {
				Name = "Valentine's Crate",
				Description = "Get limited edition Valentine's skins!"
			},
			ValentinesCrate2 = {
				Name = "Valentine's Crate 2",
				Description = "Get more limited edition Valentine's skins!"
			},
			AprilFoolsCrate = {
				Name = "April Fools Crate",
				Description = "Get limited edition April Fools skins!"
			},
			EliteCrate = { Name = "Elite Crate", Description = "Get medieval themed skins!" },
			WinterOpsCrate = {
				Name = "Winter Ops Crate",
				Description = "Contains limited edition Winter Ops skins!"
			},
			LunarCrate = {
				Name = "Lunar Crate",
				Description = "Contains limited edition Lunar New Year skins!"
			},
			PVPCrate = { Name = "PVP Crate", Description = "Contains PVP-themed skins!" },
			VoidCrate = {
				Name = "Void Crate",
				Description = "Get limited edition Void themed skins!"
			}
		},
		Products = {
			RCUJuggernaut = {
				Name = "RCU Juggernaut",
				Description = "Criminality x TDX! Exclusive skin for Juggernaut!"
			},
			DealerOperator = {
				Name = "Dealer Operator",
				Description = "Criminality x TDX! Exclusive skin for Operator!"
			},
			TBJuggernaut = {
				Name = "TB Juggernaut",
				Description = "Tower Battles x TDX! Exclusive skin for Juggernaut!"
			},
			TBEDJ = {
				Name = "TB EDJ",
				Description = "Tower Battles x TDX! Exclusive skin for EDJ!"
			},
			TBMissileTrooper = {
				Name = "TB Missile Trooper",
				Description = "Tower Battles x TDX! Exclusive skin for Missile Trooper!"
			},
			TBSniper = {
				Name = "TB Sniper",
				Description = "Tower Battles x TDX! Exclusive skin for Sniper!"
			},
			TBOperator = {
				Name = "TB Operator",
				Description = "Tower Battles x TDX! Exclusive skin for Operator!"
			},
			ChristmasBundle = {
				Name = "Christmas Bundle",
				Description = "Merry Christmas! A bundle of 6 exclusive skins! Formerly unlocked via beating the 2023 Christmas event."
			},
			ValentinesBundle = {
				Name = "Valentine's Bundle",
				Description = "A bundle of 8 exclusive skins! You can also earn them by beating Intermediate or Expert."
			},
			GoldenJuggernautGoldenCommando = {
				Name = "Golden Commando",
				Description = "An exclusive Tower Battles skin that started it all. Works on Golden Juggernaut."
			},
			JuggernautEradicator = {
				Name = "Eradicator Juggernaut",
				Description = "Eradicator MK II Juggernaut Skin."
			},
			JohnEradicator = {
				Name = "Eradicator John",
				Description = "Eradicator MK IV John Skin."
			}
		},
		Towers = {
			[Enums.Towers.Ranger] = {
				Name = "Ranger",
				Description = "Starter tower with burst fire and grenades. Great for beginners and can solo Easy and Intermediate modes!"
			},
			[Enums.Towers.Shotgunner] = {
				Name = "Shotgunner",
				Description = "Fire blasts in a wide spread, perfect for clearing hordes! Can heal or unstun nearby towers during intense moments."
			},
			[Enums.Towers.Juggernaut] = {
				Name = "Juggernaut",
				Description = "A DPS powerhouse with a minigun! Perfect for mid-to-late game, mowing down enemies and bosses with high damage output."
			},
			[Enums.Towers.Farm] = {
				Name = "Farm",
				Description = "A helipad that calls in a C-130 each wave to drop cash or health crates! Essential for funding expensive upgrades in tough modes!"
			},
			[Enums.Towers.EDJ] = {
				Name = "EDJ",
				Description = "Support tower that boosts range, firerate, and more for nearby towers! Great for Expert and Endless modes, but doesn't deal damage."
			},
			[Enums.Towers.MissileTrooper] = {
				Name = "Missile Trooper",
				Description = "Explosive tower with great range, splash damage, and armor-piercing power, perfect for dealing with crowds and high-health enemies!"
			},
			[Enums.Towers.Warship] = {
				Name = "Warship",
				Description = "Massive naval power with a huge range! Place it on water and watch it dominate, but be wary of high-cost upgrades!"
			},
			[Enums.Towers.CryoBlaster] = {
				Name = "Cryo Blaster",
				Description = "A debuff tower that freezes enemies solid! Slows them down with each hit and can stun indefinitely with enough freeze buildup!"
			},
			[Enums.Towers.LaserGunner] = {
				Name = "Laser Gunner",
				Description = "A high-tech tower with stealth detection and armor penetration! Stuns enemies and reveals stealth with powerful abilities."
			},
			[Enums.Towers.Sniper] = {
				Name = "Sniper",
				Description = "Long-range, high-damage precision shooter with piercing shots, ideal for taking out enemies that slip past your defense!"
			},
			[Enums.Towers.MineLayer] = {
				Name = "Mine Layer",
				Description = "Places mines on the path to deal with enemies that slip past your defense, perfect for handling bosses and high-health foes!"
			},
			[Enums.Towers.Operator] = {
				Name = "Operator",
				Description = "Equipped with high DPS, stun immunity, and a Humvee for support! Great for dealing with leaks and strong enemies."
			},
			[Enums.Towers.Artillery] = {
				Name = "Artillery",
				Description = "Manually aim and fire powerful long-range blasts! Predict enemy movement for max impact, but beware of jamming and freezing effects!"
			},
			[Enums.Towers.Toxicnator] = {
				Name = "Toxicnator",
				Description = "Launches toxic grenades that deal splash damage over time and increase enemy damage taken! Great for slowing down and weakening foes!"
			},
			[Enums.Towers.PatrolBoat] = {
				Name = "Patrol Boat",
				Description = "A powerful naval tower with splash damage, ideal for maps with water but struggles with stealth enemies."
			},
			[Enums.Towers.John] = {
				Name = "John",
				Description = "A cost-effective early game tower that deals damage and buffs nearby towers, but lacks Stealth Detection. Tribute to TDX's creator GDILIVES."
			},
			[Enums.Towers.Railgunner] = {
				Name = "Railgunner",
				Description = "High-damage single-target tower with a railgun, perfect for slow, high-health enemies, but struggles with crowds and laser-resistant foes."
			},
			[Enums.Towers.Barracks] = {
				Name = "Barracks",
				Description = "A barracks that spawns troops to fight on the path! They stop to attack, shoot through obstacles, and deal damage on collision!"
			},
			[Enums.Towers.CryoRanger] = {
				Name = "Cryo Ranger",
				Description = "A cryo sniper that freezes weaker enemies and crowds! Great for stalling and supporting, but struggles against stronger foes. Event exclusive!",
				ExclusiveText = "-"
			},
			[Enums.Towers.Grenadier] = {
				Name = "Grenadier",
				Description = "Throws grenades for splash damage and stuns enemies! Great for handling crowds of weak enemies but struggles with tougher foes."
			},
			[Enums.Towers.ArmoredFactory] = {
				Name = "Armored Factory",
				Description = "A factory that deploys armored vehicles that move and fire along the path, ignoring enemies and detecting stealth!"
			},
			[Enums.Towers.GoldenRanger] = {
				Name = "Golden Ranger",
				Description = "A powerful upgraded Ranger with more range, DPS, and the ability to stun bosses with grenades! Perfect for early-mid game."
			},
			[Enums.Towers.GoldenJuggernaut] = {
				Name = "Golden Juggernaut",
				Description = "A powerhouse with massive damage, range, and stun resistance! Pricey but unmatched in late-game DPS. Can hit bullet-resistant enemies!"
			},
			[Enums.Towers.XWMTurret] = {
				Name = "XWM Turret",
				Description = "Endure the toughest battles with XWM Turret! Can take 3 hits from bosses, but needs repairs before firing again!"
			},
			[Enums.Towers.Slammer] = {
				Name = "Slammer",
				Description = "The first melee tower! Slams enemies with a powerful hammer and stuns bosses with her special ability!"
			},
			[Enums.Towers.Medic] = {
				Name = "Medic",
				Description = "Heal your towers and boost their damage! Upgrade to grant invulnerability or deal 3X damage with UBER ability."
			},
			[Enums.Towers.Zed] = {
				Name = "Z.E.D.",
				Description = "Zombie Extermination Device: Spawns autocannon units with insane damage and 10,000 HP to crush zombie waves!"
			},
			[Enums.Towers.Commander] = {
				Name = "Commander",
				Description = "Rally for the GDA! Boosts damage and range of nearby towers, stacks with other buffs, and can call in Air Strikes and APCs!"
			},
			[Enums.Towers.Ghost] = {
				Name = "Ghost",
				Description = "A stealthy fighter with an armed drone! Can reveal enemies or stealth herself and allies, preventing bosses from targeting them!"
			},
			[Enums.Towers.GoldenMineLayer] = {
				Name = "Golden Mine Layer",
				Description = "Deploys powerful mines that detect stealthed enemies and deal major damage, perfect for handling leaks and bosses!"
			},
			[Enums.Towers.Helicopter] = {
				Name = "Helicopter",
				Description = "A mobile aerial tower with infinite range, stealth detection, and stun immunity! Avoids damage while attacking from above with full firepower."
			},
			[Enums.Towers.Sentry] = {
				Name = "Sentry",
				Description = "Automated Turret that locks onto any enemy within its field of view! Can rebuild itself upon being destroyed."
			},
			[Enums.Towers.Scarecrow] = {
				Name = "Scarecrow",
				Description = "Cheap bait tower that draws enemy attacks away from your defenses! Can give a small damage boost when fully upgraded."
			},
			[Enums.Towers.FlameTrooper] = {
				Name = "Flame Trooper",
				Description = "A flamethrower unit that burns enemies in a line, dealing damage over time and boosting incoming damage! Struggles with stealth and fire-resistant foes."
			},
			[Enums.Towers.Relic] = {
				Name = "Relic",
				Description = "Summons melee units to block and deal damage to enemies on the path, perfect for slowing down the enemy advance!"
			},
			[Enums.Towers.Mobster] = {
				Name = "Mobster",
				Description = "Spawns mobsters and places bounties on enemies! Recoup tower costs when they're destroyed and boost your economy."
			},
			[Enums.Towers.CryoHelicopter] = {
				Name = "Cryo Helicopter",
				Description = "An airborne support tower that freezes up to 3 enemies at a time! Moves freely but can't receive buffs. Limited-time event tower!"
			},
			[Enums.Towers.IceBreaker] = {
				Name = "Ice Breaker",
				Description = "A melee tower that freezes enemies with each attack! Has powerful abilities at max level like Ice Shard and Snow Storm for crowd control."
			},
			[Enums.Towers.AATurret] = {
				Name = "AA Turret",
				Description = "Quickly destroy any air enemies on the field, for an effective price!"
			},
			[Enums.Towers.TrollTower] = {
				Name = "Troll Tower",
				Description = "Bait tower that distracts enemies! Gains an ability which randomly buffs nearby towers. Limited-time event tower!"
			},
			[Enums.Towers.MachineGunner] = {
				Name = "Machine Gunner",
				Description = "Heavy firepower for crowd control with laser machine guns."
			},
			[Enums.Towers.GoldenMobster] = {
				Name = "Golden Mobster",
				Description = "Summons Golden Troops while being able to reload for money. A good combo of support and damage."
			},
			[Enums.Towers.CombatDrone] = {
				Name = "Combat Drone",
				Description = "Aerial tower that can be controlled FPS-style! Headshots deal 3x damage and ignore resistance."
			},
			[Enums.Towers.JetTrooper] = {
				Name = "Jet Trooper",
				Description = "Early defense from the sky! Can also use incendiary rounds to set fire to enemies!"
			},
			[Enums.Towers.GooGunner] = {
				Name = "Goo Gunner",
				Description = "Traps enemies in goo, halting them in place for a short time!"
			},
			[Enums.Towers.ShieldTower] = {
				Name = "Shield Tower",
				Description = "Provides shields to nearby towers, absorbing damage and protecting them from enemy attacks!"
			},
			[Enums.Towers.Refractor] = {
				Name = "Refractor",
				Description = "Deals massive damage with chain attacks and attacks that get stronger over time!"
			},
			[Enums.Towers.BehemothFactory] = {
				Name = "Behemoth Factory",
				Description = "Spawns Behemoth tanks with enhanced collision resistance and huge damage output!"
			},
			[Enums.Towers.WarMachineFactory] = {
				Name = "War Machine Factory",
				Description = "Spawns heavily armored walkers that can knock back bosses and deal high damage!"
			},
			[Enums.Towers.CombatMedic] = {
				Name = "Combat Medic",
				Description = "Able to revive killed towers and heal nearby towers! Can also spawn in healing drones!"
			},
			[Enums.Towers.ShockTrooper] = {
				Name = "Shock Trooper",
				Description = "Zap and stun enemies with this tower's unique chain attack!"
			},
			[Enums.Towers.OilDerrick] = {
				Name = "Oil Derrick",
				Description = "Constantly generates cash, providing steady income throughout the game!"
			},
			[Enums.Towers.CryoMortar] = { Name = "Cryo Mortar", Description = "I hate my job" },
			[Enums.Towers.PsychoSlayer] = {
				Name = "Psycho Slayer",
				Description = "A mobile tower that has 5 different abilities, including a jump ability that stuns nearby enemies!"
			},
			[Enums.Towers.NoobTuber] = {
				Name = "Noob Tuber",
				Description = "Ensure explosive destruction among hordes of enemies! It will never miss a shot!"
			},
			[Enums.Towers.ScoutHelicopter] = {
				Name = "Scout Helicopter",
				Description = "Reveals stealth enemies to friendly towers, while providing small-arms support from above!"
			},
			[Enums.Towers.Stinger] = {
				Name = "Stinger",
				Description = "Deals bonus damage against air enemies, and has a powerful sidearm for enemies that get too close!"
			},
			[Enums.Towers.ChickenHouse] = {
				Name = "Chicken House",
				Description = "Bait tower, but also sells eggs for a small amount of cash!"
			},
			[Enums.Towers.BubbleBlower] = {
				Name = "Bubble Blower",
				Description = "Blows powerful bubbles that knocks back enemies and can make them float at max level! Some say, he is, Invincible."
			},
			[Enums.Towers.GoldenWarship] = {
				Name = "Golden Warship",
				Description = "WARSHIP BUT BETTER"
			},
			[Enums.Towers.MLRS] = {
				Name = "MLRS",
				Description = "Long range rocket artillery, choose to aim it manually, or automatically! Beware of its huge deadzone."
			},
			[Enums.Towers.Scout] = {
				Name = "Scout",
				Description = "Cheap early game gunner that gains stealth detection and can shoot air enemies with upgrades! At max level, grants stealth detection to nearby towers."
			},
			[Enums.Towers.Phaser] = {
				Name = "Phaser",
				Description = "Fires a continuous laser beam that gets stronger the longer it stays on a target! Can't receive damage buffs."
			},
			[Enums.Towers.VoidTraitor] = {
				Name = "Void Traitor",
				Description = "A forgotten conqueror from the Void Lands who has battled several Calamity forces. Summons Void troops and deals lethal damage with his sword!"
			},
			[Enums.Towers.Aviator] = {
				Name = "Aviator",
				Description = "Flies around in your choice of a circle or figure-eight! Attacks enemies with machine guns, bombs, and missiles."
			}
		},
		Enemies = {
			[Enums.Enemies.Arachnina] = {
				Description = "Fast mover injected with power juice to punch through vehicles."
			},
			[Enums.Enemies.Boss1] = {
				Description = "Slow but tanky, based on the Boss 1 in the Tower Battles era."
			},
			[Enums.Enemies.Boss2] = {
				Description = "Slow but extremely tanky, based on the Boss 2 in the Tower Battles era."
			},
			[Enums.Enemies.Cloaker] = {
				Description = "GDA was succesfully able to replicate stealth tech in enemies, fast mover while having stealth."
			},
			[Enums.Enemies.Crusher] = {
				Description = "GDA's training dummy for Eradicator MK 3, able to stun and pound the ground for debuffs."
			},
			[Enums.Enemies.Disruptor] = {
				Description = "Fast mover that will debuff damage on nearby towers by 25%%"
			},
			[Enums.Enemies.EMP] = {
				Description = "Fast mover that will stun nearby towers for .7 seconds."
			},
			[Enums.Enemies.Fallout] = {
				Description = "Moves at a moderate pace while able to withstand elements such as ice, laser, and energy."
			},
			[Enums.Enemies.FastDroid] = { Description = "Like Normal Droid, but faster." },
			[Enums.Enemies.Flesh] = {
				Description = "[REDACTED] Dr. Xenon's Neural Anchor technology is functional. Further research is no longer authorized due to ethical concerns and the lack of suitable hosts."
			},
			[Enums.Enemies.Gestalt] = {
				Description = "GDA's Prototype guardian for defense against Eradicators, able to pierce towers with its spear and apply debuffs."
			},
			[Enums.Enemies.HeavyDroid] = { Description = "Like Normal Droid, but slow and tanky." },
			[Enums.Enemies.HeavyMetal] = {
				Description = "Made out of some pretty heavy metal, heavily resistant to bullet and melee damage."
			},
			[Enums.Enemies.IonGuard] = {
				Description = "GDA's first breakthrough to develop armor resistant to many damage types, also spawns a Malfunction upon death."
			},
			[Enums.Enemies.Malfunction] = {
				Description = "[REDACTED] However can still be used in the simulator, moves at moderate pace."
			},
			[Enums.Enemies.NightKnight] = {
				Description = "Variant of Cloaker, but slower and more tanky."
			},
			[Enums.Enemies.NormalDroid] = {
				Description = "GDA's first prototype for the simulator, similar to a Normal enemy."
			},
			[Enums.Enemies.OverCharge] = {
				Description = "Fast mover not to be messed with, stronger than Xenon's Abomination."
			},
			[Enums.Enemies.Sturmtruppler] = {
				Description = "GDA's highest stealth divison unit, made to resist Energy and Laser type damage."
			},
			[Enums.Enemies.ToxicWaste2] = {
				Description = "Left over waste from developing enemies in [REDACTED], forming Toxic Waste who is resistant to bullets and explosives."
			},
			[Enums.Enemies.Monstrosity] = {
				Description = "Based on the monster enemy, slow but tanky."
			},
			[Enums.Enemies.MultiplierX] = {
				Description = "First sighted on Christmas 2032, Xenon was able to produce a clone type enemy strong enough to replicate bosses. Exo Santa being affected at the time."
			},
			[Enums.Enemies.XJuggernautPVP] = {
				Description = "Like Juggernaut, but shoots fire from his hands. Has heavy laser and energy resistance."
			},
			[Enums.Enemies.ArtemisPVP] = {
				Description = "She is the strongest aerial enemy in Expert, best sent with other foes to tank for her."
			},
			[Enums.Enemies.E02PVP] = {
				Description = "Mini Eradicator Soldier, will run for a bit then shoot at towers."
			},
			[Enums.Enemies.PhobeusPVP] = {
				Description = "Tanky, can give it self a god shield, and burn towers. All while being extremely annoying for your enemy!"
			},
			[Enums.Enemies.TitanChargerPVP] = {
				Description = "Fast while having heavy resistances to energy and laser damages."
			},
			[Enums.Enemies.PurgatoryPVP] = {
				Description = "These skull guys look weird, deals damage to towers while applying small debuffs."
			},
			[Enums.Enemies.JumperPVP] = {
				Description = "The jumper that could jump, jumps across the path and becomes invulnerable for a brief moment."
			},
			[Enums.Enemies.BuzzardPVP] = {
				Description = "Xenon put a fan on this guy and called it a day, flying enemy at a moderate speed."
			},
			[Enums.Enemies.HeavyTitanPVP] = {
				Description = "Slow and tanky while boasting many resistances, also cheap to send out!"
			},
			[Enums.Enemies.PilotPVP] = {
				Description = "He lived his life flying helicopters, and later jet packs, too bad he got turned into a flying zombie with a jetpack."
			},
			[Enums.Enemies.LavaGolemPVP] = {
				Description = "Big fat hot guy that is heavily resistant to ice and flame type damage, breaks up into smaller guys once killed."
			},
			[Enums.Enemies.KnyghtPVP] = {
				Description = "Old medieval zombie that's surprisingly resistant to bullet type damage."
			},
			[Enums.Enemies.MagePVP] = {
				Description = "Old magic wizard that spawns his fellow minions while debuffing towers!"
			},
			[Enums.Enemies.GoldenKnightPVP] = {
				Description = "Like Knyght but Golden edition, heavily resistant to laser and energy damage."
			},
			[Enums.Enemies.KingPVP] = {
				Description = "The Golden King, slashes nearby towers! All while causing trouble for Golden towers."
			},
			[Enums.Enemies.QueenPVP] = {
				Description = "The Golden Queen, uses her crossbow at a range to shoot at towers! All while causing trouble for Golden towers."
			},
			[Enums.Enemies.TankKnyghtPVP] = {
				Description = "Slow but determined, has heavy resistance to collisions."
			},
			[Enums.Enemies.ResurrectedJohnPVP] = {
				Description = "John was annoying in the GDA, he's annoying here too. Able to boost nearby enemies with a dangerous speed buff!"
			},
			[Enums.Enemies.BatteringRamPVP] = {
				Description = "Slow and dumb, once he charges up he will not stop until he impacts the base! Instantly destroying it no matter the HP!"
			},
			[Enums.Enemies.ResurrectedSlammerPVP] = {
				Description = "She was really nice before, able to stun and damage nearby towers on the move!"
			},
			[Enums.Enemies.EradicatorMKICPVP] = {
				Description = "Sink your teeth in. Close quarters destruction, able to heal itself fully upon rage mode."
			},
			[Enums.Enemies.AlphaPredatorPVP] = {
				Description = "ALPHA PREDATORRR. Super heavy boss, able to eliminate many towers before going down, only to revive himself!"
			},
			[Enums.Enemies.EradicatorMK2ReworkPVP] = {
				Description = "Will you trust a beast like me? Super heavy boss, able to eliminate many towers before going down, on low health he pops a shield and does mega damage!"
			},
			[Enums.Enemies.DestructorPVP] = {
				Description = "From the Predator family, one of the few bosses to pierce towers that have been ubered."
			},
			[Enums.Enemies.EradicatorMKIPVP] = {
				Description = "The classic Eradicator, the first type to invade Earth. His debuffs to towers are persistant!"
			},
			[Enums.Enemies.PlagueDoctorPVP] = {
				Description = "The Plague Doctor, not strong on his own, but his black smoke is useful to globally slow down the rate of fire on towers."
			},
			[Enums.Enemies.CyberSantaPVP] = {
				Description = "Santa claus is coming, to town! Able to throw gift boxes afar to spawn in enemies."
			},
			[Enums.Enemies.EradBPVP] = {
				Description = "Xenon's first iteration of the Eradicator, although weak, it is the foundation for the Eradicator series."
			},
			[Enums.Enemies.CaptainSlimePVP] = {
				Description = "Advisor repeatedly claims he saw this exact troop in his dream, however a random psychological evaluation shows no alarming traits. Captain Slime, although weak on his own, has many stages and is able to spawn his fellow slime buddies!"
			},
			[Enums.Enemies.RangerBot2PVP] = {
				Description = "The backbone of the Forge Bot Army, although not strong on its own, can chip away at towers unaided."
			},
			[Enums.Enemies.MissileBotPVP] = {
				Description = "Based on the Missile Trooper, doing splash damage against units and towers."
			},
			[Enums.Enemies.OperatorBotPVP] = {
				Description = "Fast mover while being able to shoot on the go!"
			},
			[Enums.Enemies.ScoutBotPVP] = {
				Description = "Fast bot, though unarmed, based on the Scout from Barracks."
			},
			[Enums.Enemies.GiantGrenadierBotPVP] = {
				Description = "Based on the Grenadier class, will stop within range of a tower throws grenades nonstop!"
			},
			[Enums.Enemies.GiantRangerBotPVP] = {
				Description = "Bulky and big, armed with a burst machine gun, this bot can apply serious pressure."
			},
			[Enums.Enemies.ShieldBusterPVP] = {
				Description = "SHIELD BUSTER! Runs along on the path and blows up instantly once it's near a Shield Tower."
			},
			[Enums.Enemies.M1BTankPVP] = {
				Description = "Bot class tank, though not as impressive weapon wise, it will destroy only path units!"
			},
			[Enums.Enemies.Shade] = {
				Name = "Shade",
				Description = "Always hidden and moves at a quick pace, heavily resistant to laser and golden damage."
			},
			[Enums.Enemies.Nosowy] = {
				Name = "Nosowy",
				Description = "Very fast mover, has light resistances to most damage types."
			},
			[Enums.Enemies.MysteryV] = {
				Name = "Mystery V",
				Description = "Like Mystery but weaker, nobody knows what's inside until it pops. Completely immune to ice damage!"
			},
			[Enums.Enemies.Neuron] = {
				Name = "Neuron",
				Description = "Extremely fast, completely immune to fire and ice damage. Leaves behind a Slag once killed."
			},
			[Enums.Enemies.Carcin] = {
				Name = "Carcin",
				Description = "Tanky and heavily resistant to melee and collision damage."
			},
			[Enums.Enemies.NormalPVP] = {
				Name = "Normal",
				Description = "The Void's basic enemy, cheap and quick to send out!"
			},
			[Enums.Enemies.SlowPVP] = {
				Name = "Slow",
				Description = "Slow but tanky, has resistance to bullet, toxic and melee damage."
			},
			[Enums.Enemies.MalignantPVP] = {
				Name = "Malignant",
				Description = "Spawns Clots and Mystery Vs while giving nearby enemies a shield!"
			},
			[Enums.Enemies.CystPVP] = {
				Name = "Cyst",
				Description = "Flying void enemy that shoots fireballs at towers, dealing splash damage."
			},
			[Enums.Enemies.MalicePVP] = {
				Name = "Malice",
				Description = "Places a zone on the path that speeds up enemies passing through. Almost immune to laser and golden damage!"
			},
			[Enums.Enemies.VoidWardenPVP] = {
				Name = "Void Warden",
				Description = "Void mini boss, stops to fire a huge barrage of crystals at both ground and air towers."
			},
			[Enums.Enemies.VoidPrimePVP] = {
				Name = "Void Prime",
				Description = "Super heavy boss that rains meteors on towers, once enraged he will EMP and execute your most expensive tower!"
			},
			[Enums.Enemies.MysteryPVP] = {
				Name = "Mystery",
				Description = "Always hidden with a massive shield, pops into a random void boss once killed!"
			},
			[Enums.Enemies.ShadePVP] = {
				Name = "Shade",
				Description = "Always hidden and moves at a quick pace, heavily resistant to laser and golden damage."
			},
			[Enums.Enemies.NosowyPVP] = {
				Name = "Nosowy",
				Description = "Very fast mover, great for eco while pressuring your enemy."
			},
			[Enums.Enemies.MysteryVPVP] = {
				Name = "Mystery V",
				Description = "A cheap gamble, pops into a random void enemy once killed. Completely immune to ice damage!"
			},
			[Enums.Enemies.NeuronPVP] = {
				Name = "Neuron",
				Description = "Extremely fast, has heavy resistance to fire and ice damage."
			},
			[Enums.Enemies.CarcinPVP] = {
				Name = "Carcin",
				Description = "Tanky and heavily resistant to melee and collision damage. Also great for eco!"
			}
		},
		NameTagStyles = {
			Red = { Name = "Red" },
			Blue = { Name = "Blue" }
		},
		NameTagEffects = {
			Lightning = { Name = "Lightning" },
			Calamity = { Name = "Calamity" },
			TDX = { Name = "TDX" },
			FlameBats = { Name = "Flame Bats" },
			Spooky = { Name = "Spooky" },
			Important = { Name = "Important" },
			Glitch = { Name = "Glitch" },
			AnniversaryConfetti2025 = { Name = "Anniversary Confetti" },
			AnniversarySparkler2025 = { Name = "Anniversary Sparkler" },
			Aurora = { Name = "Aurora" },
			NorthPoleStars = { Name = "North Pole Stars" },
			Cookies = { Name = "Cookies :3" },
			ChristmasLights = { Name = "Christmas Lights" },
			LunarNewYear2026 = { Name = "Lucky" },
			EasterEggsplosion = { Name = "Eggsplosion" },
			EasterStickers = { Name = "Xenon's Dream" },
			EasterGlow = { Name = "Easter Glow" },
			EasterBunnies = { Name = "Easter Bunnies" },
			ExoVoidsVision = { Name = "Exo Void's Vision" },
			VoidsVision = { Name = "Void's Vision" },
			UmbrixVision = { Name = "Umbrix Vision" },
			GeneralLeahWorld = { Name = "General Leah's World" },
			VoidDimension = { Name = "Void Dimension" },
			SixSeven = { Name = "Six Seven" },
			TheVoid = { Name = "The Void" },
			VoidStars = { Name = "Void Stars" },
			VoidmareGeneralLeah = { Name = "Voidmare General Leah" }
		}
	},
	Game = {
		Dialogue = {
			Easy = {
				Wave1 = "Welcome to Easy Mode, Commander. Prepare your defenses! Ranger is a great starter tower and can carry you through Easy Mode!",
				Wave2 = "On PC you got some hotkeys, {Keys:SelectTower1-6} select towers, {Key:StopTowerPlacement} cancels placement.",
				Wave3 = "Fast Zombies inbound! Same health as normal Zombies, but much faster.",
				Wave5 = "Heavy Zombies inbound! They're slower, tankier, and their shields don't reward cash when damaged.",
				Wave7 = "Choose your upgrades carefully. Ranger's top path improves stealth detection and range, while the bottom path focuses on ignoring resistances and dealing splash damage.",
				Wave8 = "Armored Zombies detected! They resist bullet damage, Ranger's Level 3 bottom path ignores this resistance.",
				Wave9 = "A powerful enemy arrives next wave. Save your cash for stronger upgrades!",
				Wave10 = "Chained Zombies inbound! Check enemy resistances by hovering over them. Ranger's bottom path counters these foes well.",
				Wave11 = "You can also use other types of towers to deal damage to zombies like Chained, such as Missile Trooper or Juggernaut's top path!",
				Wave12 = "Armored Heavy Zombies inbound! They're even more resistant to bullet damage.",
				Wave13 = "Stealth Zombies arrive next wave. Ranger's Stealth Sight upgrade can detect them.",
				Wave14 = "Stealth Zombies detected! Use Stealth Sight to reveal and eliminate them.",
				Wave15 = "Large enemy groups inbound! Ranger's Grenade upgrade excels against crowds. Don't forget to use the grenade ability!",
				Wave16 = "Mutated Zombies inbound! When defeated, their little parasite guy survives and moves even faster!",
				Wave17 = "Massive stealth wave incoming! Make sure your Rangers can detect stealth enemies, the top path upgrades are needed.",
				Wave18 = "Hazmat Zombies inbound! They explode on death, boosting nearby enemies with radiation. Their health also grants no cash on hits.",
				Wave19 = "Upgrade Ranger's bottom path to M203 Incendiary, it's the last upgrade. It's excellent against large hordes.",
				Wave20 = "Abominations detected! Fast, durable, and sometimes stealthed. A set of M60s from Rangers can chew them down.",
				Wave22 = "Stealth Abominations arrive next wave. Max out Ranger's top path for detection, we need more M60s.",
				Wave23 = "Lots of enemies detected. Final wave is next! Don't forget Ranger's Grenade ability, it can deal big damage to swarms of zombies.",
				Wave24 = "Plague Doctor detected! Keep deploying max Rangers and sell towers that can no longer reach the boss! Keep spending your cash!"
			},
			Elite = {
				Wave1 = "Commander, the Plague Division has been resurrected! We need tons of splash damage and stealth detection. The hordes are coming.",
				Wave2 = "Towers like Grenadier will be vital to survive the hordes. For now, Operator is a great choice to counter these Infected enemies.",
				Wave4 = "On wave 7, our first Stealth enemies will approach, so be sure to have stealth detection. 2 Operators with the Assault Rifle upgrade will do the job.",
				Wave5 = "Skeletons detected! Although they're not too dangerous, they have bullet resistance. Be aware of resistances later on!",
				Wave6 = "Next wave, the first stealth enemies will arrive. Be sure to have at least 2 towers that can detect stealth!",
				Wave7 = "Stealth Infected enemies with Multiplier, don't let them reach the base!",
				Wave9 = "Giant Skeletons! Having enough DPS and splash damage is vital. The Special Forces upgrade from Operator is good to grab.",
				Wave10 = "They're using our own troops against us! Resurrected Rangers detected!",
				Wave11 = "A mage has been spotted! These guys spawn in foes and make our towers slower! They even apply shields! Take him out fast. Try setting targeting to Last to catch him!",
				Wave12 = "Knyghts detected! They have melee and bullet resistance. Operators are less effective. John's Deagles or Shotguns+ upgrades will work great.",
				Wave13 = "Stealth Resurrected Rangers detected! These guys may slip through, so be sure to place defense in the back for them! Don't be afraid to invest into new areas.",
				Wave14 = "Amalgams detected! These guys will leave behind a husk that will still count as an enemy! I swear we fought these guys long ago..",
				Wave15 = "Stealth Giant Skeletons! Next wave there is another Mage. He wont be as easy to target...",
				Wave16 = "The Mage will not stop summoning until he is down; try to target him as best as you can!",
				Wave17 = "Berserkers and Javelins are here, watch out for their spears! Towers hit by them have their firerate lowered!",
				Wave18 = "More Amalgams! Soon their bigger brothers, Lava Golems, will arrive. We need proper splash damage for these foes. Fire/ice-based towers do nothing to lava enemies.",
				Wave19 = "Lots of Knyghts! John's shotguns are effective counters to these foes. Watch out for their bullet resistance!",
				Wave20 = "Mutated zombies! These guys look ugly and split into a new enemy when killed!",
				Wave21 = "Lava Golems detected! They're slow, but when killed, they split into a lot of Amalgams! Not only do we need DPS, but also splash damage for their spawns!",
				Wave22 = "Another Mage inbound along with a horde of Lava Golems. Javelins are great counters, and pairing them with EDJ is a great combo.",
				Wave23 = "Iron Bastion detected! He will keep stunning our towers until he is down! Use long-range towers like Missile Trooper to bring him down!",
				Wave24 = "Bit of a breather wave, next wave a horde of Lava Golems arrive. Grenadier's shock grenades are a strong counter to Lava Golems.",
				Wave25 = "Tons of Lava Golems inbound. Grenader's shock grenades can buy you a lot of time for this wave! Missile Trooper is great at stopping these foes.",
				Wave26 = "Revived bosses are here! Next wave, King and Queen are coming. Javelins are a strong counter to them. Try using EDJ's discount path!",
				Wave27 = "The King, the Queen, and Golden Knights are all here! They have heavy resistance to Energy damage! Bring down the King first to stop his summons!",
				Wave28 = "Not a breather just yet. Tank Knyght- Why are there birds? Are they really this down bad? Get anti-air detection! Javelins can work for now.",
				Wave29 = "Specter detected! He will spawn in enemies from afar! Grenadier's shock grenades are really great at slowing down spawns!",
				Wave30 = "Cyber Dragon detected! His fire will lower the damage of towers! Bring him down! Javelins are extremely effective!",
				Wave31 = "The GDA Resurrected Horde is here. We need tons of splash damage for this. John's Slayer upgrade is a great counter. Watch out for Resurrected Slammer!",
				Wave32 = "Battering Ram is here! Focus fire on him! He will destroy the base instantly if he reaches it! Use EDJ's ability when the time is right!",
				Wave33 = "Stealth Revived Abominations! Next wave, He arrives... Be sure to place backup towers in the back and get some stun grenades from Grenadier!",
				Wave34 = "Revived Plague Doctor is coming! He can summon an army across the map! He also has a shield that caps any damage to 50! End him once and for all!"
			},
			Intermediate = {
				Wave1 = "Welcome to Intermediate mode! This will be more challenging compared to Easy mode, commander. Ranger won't be suitable late-game now...",
				Wave3 = "Everything starts off pretty similarly to Easy mode, but with a \"plus\". They have even more HP and speed now!",
				Wave8 = "Boss 1 enemies incoming! Or should I say... revived. We fought these long ago, but somehow they're back from the dead! Take them down!",
				Wave10 = "Stealth rush next wave, be sure to get some sort of stealth detection. I'd recommend Operator, get his Assault Rifle upgrade when you can.",
				Wave11 = "Stealth rush inbound! Be sure to have towers that can detect stealth, otherwise we're doomed!",
				Wave12 = "Multiplier detected! These guys will multiply zombies in their area upon death, resulting in FASTER cloned versions of the zombies! Get rid of them!",
				Wave13 = "Grenadier! Smarter... but still a zombie. They throw grenades that spawn in zombies!",
				Wave14 = "Bulletproof threats come in next wave, save up money for a Missile Trooper. He will be a great way to counter them!",
				Wave15 = "Bullet resistant enemies are here! Place down Missile Troopers to counter them easily, or other towers that don't deal bullet-type damage.",
				Wave16 = "Good work taking out that threat, they're not bullet proof but take a lot less damage. It's just a better idea to place down other types of towers to counter them!",
				Wave17 = "Super Heavy Zombie detected, he's bullet resistant as well. We need more explosive damage to take him down! Laser gunner with energy cells could be a great counter too.",
				Wave18 = "Nuclear zombies! Although weak on their own they can be overwhelming in numbers. Take them out!",
				Wave19 = "Incoming revived titan! Super beefy and heavily armored. We need more counters against him! Invest into more explosive type towers!",
				Wave21 = "Multiplier 2 detected! They're like multiplier 1s, but multiply zombies by 3! Watch out!",
				Wave23 = "Monster detected! Slow but big. Their health is no joke! Take them down!",
				Wave24 = "Infiltrators detected! They're explosive resistant, missile troopers are ineffective on them! Make sure you have operators down to take them out!",
				Wave25 = "Charger bosses incoming! They're speedy and beefy. In numbers they'll overwhelm us! Destroy them!",
				Wave27 = "Smasher and shockers detected! These guys will stun your towers! Shockers will stun on death and smasher stuns by smashing the ground!",
				Wave29 = "Predator detected! He can take out your towers! Maybe a bit unorthodox, but, place down lots of Rangers to bait his attacks to save your more valuable towers!",
				Wave30 = "Outstanding work taking out Predator! Be aware of the Elite Grenadier and Revived Abomination this wave! Elite throws a nade that spawns in hefty stuff!",
				Wave31 = "Large entity is being detected on radar, Eradicator is coming next wave. I would advise to get a lot of Javelins to take him out!",
				Wave32 = "Eradicator detected! Save your more valuable towers by baiting his attacks with cheaper towers! Use your money wisely!"
			},
			Expert = {
				Wave1_1 = "Commander! Dr. Xenon is sending new forces we have never encountered before! Higher-end Towers like Laser Gunner and Railgunner are needed.",
				Wave2_1 = "Eradicator MK II has been rebuilt and upgraded. Medic is vital to have on the team, along with heavy hitters like Railgunner and XWM Turret.",
				Wave3_1 = "Our intel doesn't show much on Eradicator MK II. However, we know another boss is arriving, Destructor. We need the best defense we can get.",
				Wave4_1 = "Placing towers in the back to catch leaks is not a bad idea. Be sure to upgrade your towers' range!",
				Wave5_1 = "Plenty of Quick enemies, don't let them leak by!",
				Wave7_1 = "X Soldier enemies detected, they will fire upon nearby ground towers! One of them isn't a problem, multiple of them are! Take them out fast.",
				Wave8_1 = "Remember, towers will heal back to full HP over time if left undamaged, and different towers have different HP values!",
				Wave8_2 = "You can also bait enemy attacks with cheaper towers like John so your more valuable towers don't take hits! Medic is also a great counter.",
				Wave9_1 = "Exosuit Zombies detected! These guys have a bunch of resistances, even Energy resistance used by Golden Towers. We need towers that don't use Bullet type to take them down.",
				Wave10_1 = "Heavy Titan detected, Railgunner is a great option to get rid of this big foe. Laser Gunners or Golden Ranger can make quick work of this enemy too!",
				Wave11_1 = "Air Enemies detected! Skull Drone will also attack nearby towers too close to the main path! Laser Gunner is a great counter, buy the \"Advanced Tech\" upgrade to shoot them!",
				Wave12_1 = "Heavy Titans with air enemies, we need a balance of air detection and heavy hitters. Do not forget about your anti-air capabilities!",
				Wave13_1 = "Buzzards inbound! They are more tanky than Skull Drones but don't attack. Don't place down towers too close to the main path! More Skull Drones may be sent.",
				Wave14_1 = "Exosuit Zombies and Grenadiers detected, along with some Buzzards. Laser Gunner's \"Laser BR\" upgrade provides enough range to chew them all down.",
				Wave15_1 = "Buzzard Rush! If air enemies are too problematic, consider investing into the AA turret. Targets and Destroys air enemies effortlessly.",
				Wave16_1 = "Be ready Commander! I have a bad feeling about next wave, a jumping Stealth threat approaches. If you can, purchase the \"Reinforce Tech\" upgrade on Laser Gunner.",
				Wave17_1 = "Jumper Detected! These guys jump across the map and evade all hits while in the air! Don't let them bounce to the end of the map!",
				Wave17_2 = "Jumpers can also jump over your units and mines on the path! These guys are super annoying, Laser Gunner's Shock Rounds are extremely effective at stopping them.",
				Wave18_1 = "Super Heavy Titan detected, we need heavy hitters with range like Railgunners. Towers like Helicopter will struggle due to their bullet resistance.",
				Wave18_2 = "Artillery can also make fine work. The explosive damage is big enough to hit air enemies as well!",
				Wave19_1 = "Always be aware of resistances! Laser Gunners and Golden Towers can work for now, but later there can be new threats that will require other damage types!",
				Wave20_1 = "Speed Deployer detected, these guys will throw a pad that speeds up enemies that walk over it!",
				Wave21_1 = "Revived Smasher spotted! It has way more health and resistance to melee, and his smash now deals attacks! He will also target units on the path!",
				Wave22_1 = "Purgatory enemies are here. They are a big threat to air towers! Pull back your Helicopters before they get shot down!",
				Wave22_2 = "Use ground troops to handle Purgatory enemies! Purgatory enemies shot down many of our aircraft trying to assist another assault in Asia.",
				Wave23_1 = "Jumpers! Laser Gunner Shock Rounds can put a stop to them, or enough high-damage towers like Railgunners or Golden Rangers.",
				Wave24_1 = "Keep in mind for later boss fights, you can sell towers if you see they are about to be killed. You can save some money this way!",
				Wave24_2 = "Towers like Medic are valuable to have as they can heal towers mid-fight, preventing them from being killed!",
				Wave25_1 = "Bounded detected! His arms are locked when he spawns, slowing him down. However, he will be freed shortly and will make a run for the base! Stop him!",
				Wave26_1 = "EDJ is an extremely vital tower to have. EDJ can provide not only firerate buffs, but also discounts. Upgrading to \"Cosplay Party\" will save you lots of money!",
				Wave27_1 = "Revived Monsters detected. They are super tanky and slow; Railgunners make quick work of them. Armored Runners coming in later! Juggernaut's \"Power Minigun\" upgrade can destroy them.",
				Wave28_1 = "Multiplier spotted! Most of these have been eradicated, but some still linger around. Cloned enemies do not provide any cash!",
				Wave29_1 = "It's a rush! Predators and Pilots inbound! Along with dozens of other foes! Don't forget to bait Predator's attacks and have air defense!",
				Wave30_1 = "Phoebus, Zeus, and Artemis are here. Phoebus will charge, using his shield to take no damage. Zeus will shock, Artemis will support. Take out Phoebus first!",
				Wave30_2 = "Be aware of Phoebus, he is highly explosive when he is killed! Sell towers that are too close to him to save some money!",
				Wave30_3 = "Artemis is a flying miniboss, we need heavy anti-air capabilities to take her down! Railgunner's top path max upgrade can target air threats!",
				Wave31_1 = "Good work Commander! A bit of a breather here. Prepare for more air enemies and tankier threats.",
				Wave32_1 = "Titan Chargers! They are heavily resistant to both Laser and Energy damage! Bullet or explosive damage will destroy them!",
				Wave33_1 = "Tons of Revived Monsters! Do not forget about Titan Chargers, I fear there will be more. Juggernauts will be able to counter them effectively.",
				Wave33_2 = "Titan Chargers also punch through our troops and vehicles; they don't lose much health to ramming units on the path!",
				Wave34_1 = "Jumper rush! They're all stealthed. Railgunners and Laser Gunners can handle them. You can also use Laser Gunner's Stealth Sensor ability to uncloak them!",
				Wave35_1 = "VX-Drone detected! There are only aerial enemies this wave! VX-Drone has a powerful laser and a mortar; the mortar targets the most valuable tower in your area!",
				Wave35_2 = "When VX-Drone is killed, sell any towers that are too close! Otherwise they will be killed by the explosion when the VX-Drone crashes.",
				Wave36_1 = "Pilot rush! We need heavy anti-air! Next wave, prepare for heavy resistances that will make Railgunners struggle.",
				Wave37_1 = "X Juggernauts detected! They're heavily resistant to Laser and Energy! Juggernaut or XWM Turret will make quick work of them. Be wary of their flamethrowers!",
				Wave38_1 = "Abominations inbound! It's a rush! Have multiple EDJs and ensure your towers are always buffed with her ability!",
				Wave39_1 = "It's an assault! X Juggernauts and X Ordinals need to be countered by towers that don't use Laser or Energy attacks!",
				Wave40_1 = "Destructor sighted! He has a powerful EMP attack that will destroy any nearby Helicopters! His jetpacks can be used to jump across the map!",
				Wave40_2 = "XRT Railgunners are extremely effective against Destructor. Also be sure to place down Medics if you can!",
				Wave41_1 = "Commander it's another rush! Stealthed Titan Charger-",
				Wave41_2 = "Tsk... so annoying of Advisor to spoil my surprise like this, isn't it, \"Commander\"?",
				Wave41_3 = "I studied how the GDA vanquished my previous Eradicator MK II. It was almost too easy to develop Energy resistance.",
				Wave41_4 = "You won't survive this time, Commander. I've rebuilt him with many new weapons, armor, and abilities. All designed to completely eradicate the GDA.",
				Wave42_1 = "Now, behold my finest creation... the Eradicator MK II+!",
				Wave42_2 = "I finally resolved its... overheating issue. If you somehow manage to breach through his armor, he'll detonate the damaged armor to continue his destruction!",
				Wave42_3 = "Once I'm done with you, I'll deploy more units across the globe, spreading as much carnage as I can. But don't worry, Commander... you won't live to see that."
			},
			Christmas = {
				Wave1 = "Christmas is here! Exo Santa brought along his minions to raid the GDA base here. Bring Missile Trooper and other hefty towers, we must stop him.",
				Wave3 = "Snow Runners inbound, they're fast. Ice immune too, anything that deals ice damage won't affect them.",
				Wave4 = "Frozen Zombies detected, ice immune, but this time, pretty tanky. Destroy them!",
				Wave5 = "Snow Runner rush! We need some splash, perhaps a Shotgunner or two? John Path 2 AK Shotgun isn't a bad choice either.",
				Wave6 = "Summoned Rangers detected, don't know how they keep converting our troops. They have a lot more HP, take them down!",
				Wave8 = "Snow Pals, an odd name for something that's even more tanky.",
				Wave9 = "XMAS Walls detected, they give zero cash. What a shame. Watch out for the next wave, we need serious stealth detection for Trees.",
				Wave10 = "Chimneys detected, they're bulletproof! However, only by 50%%, so we could just overwhelm them . I'd still recommend Missile Trooper.",
				Wave11 = "They're rushing now! However, next wave are those Tree guys again, and a lot of them! We need lots of stealth detection while dealing enough damage!",
				Wave12 = "Trees detected, fast and stealthed, these guys are no joke. Get them!",
				Wave13 = "Coal... zombies detected? They go super fast once enough damage is dealt, watch out for that!",
				Wave14 = "It's a coal rush! Not much of a threat when they're not on fire, but man can they go fast.",
				Wave15 = "Gift box fellas detected, they explode into Toys that book it fast! Using splash damage towers are a great counter to them!",
				Wave17 = "Many Super Naughty zombies inbound, they are big tanky, stupid, and overall annoying. We need heavy hitters to destroy them!",
				Wave18 = "Wendigo enemies detected, theyre fast and mean. They're also fully ice immune!",
				Wave19 = "Keep firing, Exo Santa is coming next wave. Prepare for him.",
				Wave20 = "Exo Santa detected! He is walking to your position now, his attacks cannot be baited. He will target the most expensive towers with his triple burst attack!"
			},
			ChristmasNightmare = {
				Wave1 = "Welcome, I don't think we have met. I am Dr. Xenon, let's just say I'm not a fan of the GDA. I hope you fail my new challenge Commander.",
				Wave2 = "Apparently my first version of Exo Santa was too easy. Well, I'll give you a real nightmare tonight.",
				Wave3 = "I also created those Eradicators you fought before, forgot about MK II's core having a chance to cause a massive chain reaction... MK I will return...",
				Wave4 = "Enough chit chat! Your futile army will bow to my forces!",
				Wave8 = "Here Commander, have some gifts!",
				Wave9 = "Didn't expect you to survive that... how annoying.",
				Wave11 = "Introducing some of my Grenadiers, have fun.",
				Wave12 = "I didn't make these, but have some coal for your stockings.",
				Wave15 = "Why are you not failing?! My simulations have shown me better results! Just give up!",
				Wave16 = "I called in some Elite Grenadiers, let's hope your towers get shocked mkay?",
				Wave17 = ". . . Okay, you're annoying. Calling in Multiplier 3s.",
				Wave18 = "You don't know when to quit do you? Sending over a Snow Predator.",
				Wave19 = "That was just one, you think you're good?! Let's see how you like Nightmare Exo Santa with a Multiplier X! Fall already Commander! GDA will be mine!"
			},
			Endless = {
				Wave1 = "Commander, the GDA is under heavy fire. Hold out for as many waves as you can, we will supply you with power abilities at the end. Good luck.",
				Wave2 = "These appear to be forces from Dr Xenon's Plague division, get ready for anything. Railgunners and Juggernauts are needed in the late waves.",
				Wave4 = "Heavy Containeds inbound, they are at a much faster speed with more health!",
				Wave5 = "Disposalists detected, like Grenadiers, but they have more HP and launch foes further!",
				Wave6 = "Mutant Xcientists are here, bigger threats will come more often later.",
				Wave8 = "Next wave there is an entity known as Prisoner, they are going to emerge as stealth enemies!",
				Wave9 = "Prisoners detected, when they are downed, they come back as stealthed Ghosts!",
				Wave11 = "Xcientists are here, look at their resistances! They even have Laser Resistance. Be sure to use multiple types of damage!",
				Wave13 = "Shockheads detected, stun proof from Grenadier and they have Shields. Shields do not give money, be aware of these later on.",
				Wave14 = "Brutes detected, fat and slow, should be easy.",
				Wave16 = "Stealth Disposalists, if you have artillery, aim it at them! Additionally, they are sending a Stealth Brute.",
				Wave17 = "Guardians in bound, these pesky enemies make other enemies have shields and speed boosts!",
				Wave19 = "Armored Tanks! Laser Weapons are going to be less effective against them, this includes Golden towers!",
				Wave21 = "Revived Mutated Zombie detected, just like before, except they are stronger, better, and Laser resistant.",
				Wave25 = "Plague Doctor detected, this time with Plague Guardians! They spawn hordes of enemies! Check their resistances!",
				Wave26 = "Plague Doctor down, but he will be back.",
				Wave27 = "Specters are here, stronger and more annoying than Grenadiers, they have huge cannons as arms to spawn enemies!",
				Wave28 = "It's a rush! Destroy them quickly!",
				Wave30 = "Revived Plague Doctor detected! He also resurrected our Fallen forces, one being John. He will speed buff enemies, take him down!",
				Wave31 = "Bit of a breather, he's down, watch out for Guardians later on. They will buff speeds, add shields, and buff health of enemies.",
				Wave34 = "Multiplier 3 detected, not many of these, get rid of him!",
				wave35 = "Eradicator and Predators are here, with his Avatars. They deploy mid way into the map! Be sure to place defense in the back!",
				Wave36 = "We're not done yet, Breachers detected, these guys have heavy Laser Resistance and run fast!",
				Wave39 = "Be ready, we are detecting Eradicator MK II and Eradicator entering next wave. Railgunner bottom path max will be your friend.",
				Wave40 = "Eradicator MK II and MK I are here, with more Avatars! Hold the line Commander! Don't forget about baiting their attacks!",
				Wave41 = "It's a Breacher rush!",
				Wave42 = "Ravage detected, these are heavy hitters with saws, they spin and deal damage to towers that are too close to the path!",
				Wave45 = "Grumble detected, no matter your base's HP, this guy will one shot it! Take him out! Grenadier's Stun grenades can help!",
				Wave47 = "Herculeans inbound, big HP and they are running straight to your base!",
				Wave49 = "Another Revived Abomination Rush! With added shields! Take them out!",
				Wave50 = "Who is this? ERADICATOR MK IV detected! His Artillery will completely wipe out our forces! We need heavy hitter towers now!",
				Wave51 = "Great work taking out Eradicator MK IV, our forces are low but we can use the money earned to build them back up!",
				Wave52 = "Anti Golems are here, they walk so smugly, managing to resist the Grenadier's stun grenade!",
				Wave53 = "Grumble detected, Golden Ranger's grenade can also stun him, and any boss!",
				Wave55 = "Ravages and Anti Golems detected, don't forget that the Golems have laser resistance!",
				Wave56 = "Resurrected Laser Gunners detected, they have 90%% Laser Resistance, we need Juggernauts or something that ignores laser armor!",
				Wave57 = "They're back but with Resurrected Johns!",
				Wave58 = "Another Resurrected John! Remember his rage ability speeds up other enemies!",
				Wave59 = "Eradicator MK I Combat is being picked up on Radar, get ready Commander. He wiped out one of our bases in the Europe division.",
				Wave60 = "Eradicator MK I C is here, your best option is to stay away from his extremely dangerous close range attacks with Railgunners!",
				Wave61 = "Great job Commander, looks like he tried to fly away but that didn't work. Dr Xenon isn't so great with that core overheating problem.",
				Wave63 = "Eradidog detected, fast and mean, their damage is no joke! He's rushing us now!",
				Wave64 = "Grumble detected, and he is boosted with speed! Do not let him reach the base!",
				Wave65 = "Ravage rush, remember they deal damage to any tower that is too close to the path! Consider selling some to possibly save them!",
				Wave66 = "Avatar rush! They're everywhere! Deploy defenses in the back NOW!",
				Wave68 = "It's a Resurrected Laser Gunner rush! Our railguns won't do anything to them! We need Juggernauts that can pierce their armor!",
				Wave69 = "What is this? Multiplier 1 with that much health? Who is doing this?",
				Wave70 = "Apex Predator detected, this is a big problem. He has an army of Predators that will spawn and he has hefty attacks! Destroy him!",
				Wave71 = "Outstanding work Commander, we thought you were a goner. Quickly, use this wave to build back up your forces.",
				Wave72 = "Specters return, with heavy shield and health! Take those out first! Use Artillery if you have one!",
				Wave73 = "Anti Golems with Resurrected Johns, what a dangerous combo.",
				Wave74 = "The sky is running red, something big is emerging, get ready.",
				Wave75 = "It's an Eradidog rush! We need as much damage as possible!",
				Wave76 = "Suppressors are here, they give no cash, what a shame.",
				Wave77 = "Grumble is here again, with much more speed! Get him now! Look at his health!",
				Wave78 = "Why is this sky so red? What is going on?!",
				Wave79 = "It's a stealth rush, but I'm sure that's no problem by now, right?",
				Wave80 = "Commander, losing control, what is that thi- -bzzt-",
				Wave121 = "You're not supposed to be here."
			},
			Toilet = { Wave1 = "Ohio, good luck", Wave3 = "Amogus" },
			TowerBattles = {
				Wave1 = "Welcome back Cadet, we need your help defending against this zombie onslaught. Prepare your defenses, the Void will not be easy.",
				Wave3 = "Speedies are here, they can quickly become annoying later on. Be sure to have your areas covered!",
				Wave4 = "Slows inbound! Their skin is thick enough to withstand explosives! Be sure to place down some Operators to counter them easily!",
				Wave6 = "Boss 1 sighted, they're heavily resistant to explosives and have some resistance to bullets!",
				Wave9 = "Necromancers are here, they can summon a huge horde! Try to take them out first and be sure to have some sort of splash damage tower for their spawns!",
				Wave10 = "Hiddens are here! They are stealthed, a great counter is the Assault Rifle upgrade from Operator. Laser type towers wont do much as Hiddens have high amounts of laser resistance.",
				Wave12 = "Mysteries sighted, they can pop anything from regular zombies to Boss 1s, be prepared.",
				Wave14 = "A horde of Mysteries are inbound! Be sure to have stealth detection. As those Hiddens can get pretty far!",
				Wave16 = "Boss2 sighted, they're so slow but they have high resistance to bullets! Missile Trooper wouldn't be a bad option to counter him!",
				Wave17 = "Lavas inbound! Ice and flames won't do anything to them! They leave a husk behind when killed!",
				Wave19 = "Hidden Boss on its way! Highly resistant to laser weapons, Operators with Spec Ops upgrade is a strong counter to them! Javelins are good as well!",
				Wave20 = "Toxics and Lightings sighted, Toxics when killed can debuff your towers fire rate! Lightings are super fast with high laser resistance!",
				Wave23 = "Slimes are here! These guys have so much goo that it withstands explosives! Counter them with Juggernauts or laser type towers!",
				Wave25 = "So many Lavas, don't let their Petrified form distract you! As other bigger enemies may use them as a shield to get to the front lines without taking hits! Setting a tower to strong avoids this issue.",
				Wave27 = "It's a rush! We need Operators more than ever now!",
				Wave28 = "Lots of Boss 2s, and the first Boss 3 is going to enter soon! Railgunners are going to have troubles with him as he has high laser resistance! Juggernaut's Power Minigun is a great counter!",
				Wave29 = "Boss 3 rush is being shown on radar, Juggernaut's Power Minigun upgrade is needed more than ever. It can ignore the bullet resistance and take down bosses!",
				Wave30 = "Boss 4 sighted! Juggernauts can do the work but Railgunner is a great counter to him!",
				Wave31 = "They're not giving up, they will keep sending Boss 3s and Boss 4s, remember that Railgunner is not a great option against Boss 3!",
				Wave32 = "Another form of Mystery detected? Dr. Xenon didn't give any info on this, watch out for what they can spawn out!",
				Wave33 = "Necromancer Boss is here! He can summon a threatening army of enemies while having resistances to all known types! Juggernaut's max upgrade on top path is a strong counter!",
				Wave34 = "The end is near, the next wave will be with the Void. We need to have as many Juggernauts and XRT Railgunners as possible to take down these foes.",
				Wave35 = "The Void is coming! Use your cash wisely and constantly! The Void can convert your towers against your own! Sell them as soon as you can to prevent further casualties!"
			},
			TowerBattlesNightmare = {
				Wave1 = "I sense you Cadet, your forces are weak.",
				Wave16 = "Why bother? The GDA won't last long, we already spoke to her.",
				Wave28 = "Still surviving? Great job.",
				Wave37 = "Still there?",
				Wave38 = "...",
				Wave39 = "Are you sure you're ready for this?",
				Wave40 = "I guess... I'll just have kill you MYSELF!"
			},
			HalloweenPart1 = {
				Wave1 = "Commander, we're attacking this fortress to set up a FOB and the Awakened forces are not too pleased. Get ready to defend this area!",
				Wave3 = "They're sending a lot of villagers, be sure to place those towers as best you can!",
				Wave4 = "Psychos inbound, they will throw knives at our towers! Place down baits to prevent your better troops from going down!",
				Wave6 = "Mr. Saw is coming into play, he deals double the damage to our base! Don't let him reach it!",
				Wave7 = "More of them are coming into this night...",
				Wave9 = "Prowler detected! When she's half health she will start booking it to our base! Have some defenses in the back!",
				Wave11 = "Prowlers and Psychos inbound!",
				Wave13 = "The Judge has arrived. When he rings his bell, the horde will go into a frenzy. Take him down!",
				Wave15 = "Executioners detected! He can damage our towers in a large area with his axe!",
				Wave16 = "The Heretic is coming next wave. Be ready.",
				Wave17 = "Take out the Heretic! He will summon Fanatics that heal him constantly as long as they're alive!"
			},
			HalloweenNightmarePart1 = {
				Wave1 = "Welcome Commander. Is my time at an end? Let us find out if you're strong enough to withstand my horde.",
				Wave3 = "These were once non-believers, believing in such nonsense from this world. I have shown them the truth; let me help you see Commander.",
				Wave7 = "The Saw men you see before you were once workers here, enslaved to your world. They now see the ways from our world, Calamity is all.",
				Wave10 = "How many more Innocent lives will you take? You will not save them from their judgement!",
				Wave14 = "Can you see it brothers? His will grows weak! Eat his soul! One man cannot stop us!",
				Wave17 = "... I do not fear you, Commander. O'rise o Horde!"
			},
			HalloweenPart2 = {
				Wave1 = "Commander this is John, short for John. I am leading an assault else where in this region, but these fools are like bot lobbies, so this won't be too bad.",
				Wave2 = "The Engineer should be arriving to your location through that portal, his base is huge. Barracks and Sniper will make fine work of this.",
				Wave4 = "Mr. Saw? He deals DOUBLE the damage if he touches our base! Do not let him do that.",
				Wave5 = "I see some Workers, these guys have bullet resistance! Thankfully they're not too tanky, we should be fine. Place down some Barracks.",
				Wave8 = "Prowlers detected, don't get distracted and let them rush you! One of those almost got me.",
				Wave9 = "Skulltists are here, they have heavy resistances to almost everything! AP ammo on Sniper or Ranger's Assault upgrade are great ways to counter!",
				Wave11 = "Executioners spotted, bait them with attacks so you can save your better towers! Odd thing to say out loud but you know, it's just business bro. I know it too well..",
				Wave12 = "Next wave is going to be a Stealth rush, have towers that can detect stealth and you're fine.",
				Wave14 = "Nailheads are inbound! These guys carry a stone that keeps giving them shield! The sooner these are down the better. Set towers to Weakest to target them!",
				Wave15 = "Fast movers sighted, Twitching Viles. I have seen these guys rush our tanks. Stood no chance against our Behemoths though.",
				Wave17 = "Nailheads sighted again! Do not let them generate that much shield over time or you will be in for a bad time.",
				Wave18 = "Corrupted Predators?! They have conversion beams and leeches that convert your towers! Sell them when they're infected! Don't forget to bait their attacks!",
				Wave19 = "Corrupted Predator destroyed! Nice one Commander, but the Engineer is still coming. Prepare your defenses.",
				Wave20 = "He has arrived, don't forget to bait his attacks. He has a powerful EMP blast that destroys Helicopters, it's best to move them out the way. Destroy him!"
			},
			HalloweenNightmarePart2 = {
				Wave1 = "I put myself together with the pieces of your fallen, and I will add you to my collection now.",
				Wave5 = "We could work together Commander, there is still time for the non believers, they can still be saved.",
				Wave9 = "So stubborn Commander, just like her. I admire the works she brings forth, but, I heed to my calling.",
				Wave14 = "Your efforts are in vain, futile, Calamity is all. The Awakened cannot be deterred from our vision. We shall claim you.",
				Wave18 = "Enjoy what is undoubtedly my finest work, I will soon descend to finish you off.",
				Wave23 = "Borrowed them from her, don't mind. I arrive soon.",
				Wave24 = "MAKE WAY FOR THY HOLYNESS! CALAMITY IS ALL."
			},
			HalloweenPart3 = {
				Wave1 = "Commander, this is the last GDA Artillery crew. It's not much, but we can use it to take out that Citadel! Just defend this objective, and don't forget to repair us!",
				Wave2 = "The hordes will keep coming... They never stop. Most of them have been blown out by our air support, but those Diabolists are ruthless.",
				Wave3 = "Halfway there! This is a nightmare, but once we take out this Citadel the region will be freed from much of the invasion. Don't forget to repair us Commander!",
				Wave4 = "Radar is showing signs of armored enemies soon... Big, armored enemies. They clashed and took out our main army here. Start deploying those medics.",
				Wave5 = "COMMANDER! Hopefully you have Medics, otherwise we're doomed. They are coming...",
				Wave6 = "Eradicator MK II? I thought we destroyed this guy?! This is the last wave Commander, bring it home!"
			},
			HalloweenNightmarePart3 = {},
			HalloweenPart4 = {
				Wave1 = "Commander, this is our last base in the region. Defending this area is key to the GDA's survival. Bring it home, this is our final stand.",
				Wave2 = "Hordes will keep coming, they overran our base while you were taking out the Engineer. His production has stopped, but his final creations are here.",
				Wave3 = "Dreadnoughts detected, they're being teleported in soon! Ubering the tower Ravager is targeting is a great way to stall it!",
				Wave4 = "Predators... they're not from Dr. Xenon. They're stolen from the Engineer, and I fear he has something far greater than what our intel tells.",
				Wave5 = "Commander, dear god. Commander we are detecting a large incoming signal, he is here."
			},
			HalloweenNightmarePart4 = {
				Wave1 = "... You feel you are ready now, for this?",
				Wave2 = "You will walk among us soon, alongside her idiotic creations. Your kind should have not interfered with our energy, for it is ours only.",
				Wave3 = "The Awakened cannot be stopped. The Calamity you battled was merely a scout, we are your armageddon.",
				Wave4 = "They lied to you Commander. You're not fighting a war for freedom, only for control of our resources. No matter, I will end you here.",
				Wave5 = "It looks like it's time for me to end this."
			},
			Christmas24Part1 = {
				Wave1 = "Commander, Dr. Xenon has decided to raid this Arctic research base after many years. She wants our crystals; let's give her a war instead!",
				Wave3 = "Intel reports the crystals could be used against Calamity's forces, and she wants her hands on these for some reason.",
				Wave5 = "Lots of Snow Runners, don't forget to spread out your towers! You can place some in the middle to cover both paths if they have enough range!",
				Wave6 = "HEY! Those our are Cryoblasters! They are emitting a snow ring and will lower the fireate of nearby towers!",
				Wave8 = "Ungifteds detected, they can randomly debuff your towers upon dying! From lower range, firerate, or damage!",
				Wave9 = "Resurrected Cryo Rangers detected, poor girl. She can freeze your towers with her, well... our grenades!",
				Wave10 = "Lumberjacks inbound! They have a high amount of health, start placing down Juggernauts soon!",
				Wave11 = "Ice Capwns detected! They have a mean mobster look and can attack our towers! Placing down bait towers like John are a great way to distract them!",
				Wave12 = "You can also place down baits just to prepare for later, just be sure not to over do it!",
				Wave13 = "Keep up the pressure! This looks like her scout force rather than her full army, but intel has no idea what is coming.",
				Wave14 = "These big blobs can smash the ground damaging our troops and towers! Take them down! Don't forget to place down bait towers for the Capwns!",
				Wave15 = "She brought back Super Naughty, his voice is so annoying. It sounds familiar though.",
				Wave17 = "Super Naughty spam, silence their laughter. Ginger D.R.E.A.D. is being brought in a few waves. He is going to take the path with the raised platform!",
				Wave18 = "Predators detected! Be sure to bait their attacks with cheap towers like John or Ranger!",
				Wave19 = "This is a breather, replace your baits for D.R.E.A.D. next wave, and heal up! Medic is a great tower to heal your troops even in combat!",
				Wave20 = "Ginger D.R.E.A.D. detected! Remember he is going on the path with the raised platform! He has a devastating laser cannon, watch out for it!"
			},
			Christmas24Part1Nightmare = {
				Wave1 = "So, Commander, you're still around? I'm surprised the GDA hasn't gotten rid of you as well.",
				Wave2 = "I thought I had destroyed all my files back at GDA HQ... seems this one slipped through. I know exactly what these crystals can do for me.",
				Wave6 = "Is this one of your little soldiers? Don't worry, I'm just borrowing him!",
				Wave9 = "Converting your little Cryo Ranger was so easy—she was the most naive of them all.",
				Wave12 = "You trust Advisor so much, Commander... one day, you'll understand what it was like for me.",
				Wave15 = "I don't understand why you're so stubborn about this research base. Building this pathetic super fortress just to keep me away from it... how pitiful.",
				Wave18 = "I love my Predators. So many of them scattered across the region, constantly on patrol. Perfect for dealing with vermin like you.",
				Wave19 = "I see... I actually didn't expect that...",
				Wave23 = "Long believed to be destroyed, I kept additional units in reserve for a special occasion... one you've now proven yourself worthy of, Commander.",
				Wave24 = "Hmpf! Fine then, Commander! Sending in the Eradidogs now!",
				Wave25 = "Well, Commander, you fought well for this scout force... but let's see if you can survive my latest invention!"
			},
			Christmas24Part2 = {
				Wave1 = "Commander, Dr. Xenon is sending her full invasion. Try to place your towers near the edge of the fog! It's our best chance to survive.",
				Wave2 = "Medic is an extremely useful tower on this battlefield since enemies can directly attack our troops. Place down a Medic for the Wendigo Hunters!",
				Wave3 = "Some upgrades increase health more than others such as John's Deagles upgrade. Take advantage of this with Medic. Smart move is to place medic behind offense towers.",
				Wave4 = "So many Toys, if some leak past the front line be sure to place troops near the base to catch leaks! You can also repair the base by walking up to it and holding F.",
				Wave5 = "Resurrected Cryo Rangers, they will throw grenades non-stop. Better to have a few more Johns lying around. Don't forget about Medics!",
				Wave6 = "Large force inbound, Medic is more vital than ever. Placing down Medics behind towers is a great way to increase your survivability! Place down multiple!",
				Wave7 = "Air enemies detected, Missile Trooper's Javelin will destroy them! Railgunner's top path can work as well.",
				Wave8 = "2 Ginger D.R.E.A.D.s incoming, be sure to have upgraded Juggernauts and Railgunners deployed in mass numbers! Don't forget Medics.",
				Wave9 = "Commander we are suffering casualties! We deposited a large sum of cash to aid, this wave is a breather. Rebuild your army!",
				Wave10 = "This is the last wave, Railgunner's max bottom path XRT is a great counter to bosses. Be sure to place down additional units like Juggernaut for smaller foes."
			},
			Christmas24Part2Nightmare = {
				Wave1 = "I want you to survive, Commander, so I can execute you myself. Watch you suffer, just as I have.",
				Wave3 = "Frosty's army wasn't killed; they kept themselves hidden in this arctic region after Frosty fell to the GDA. Waiting to be saved.",
				Wave4 = "I remember Frosty when he was alive. I was tasked to find a weakness. Now I exploited his army to work for me.",
				Wave5 = "General Celgar is a dull-witted brute that thinks Frosty is still alive. He seeks vengeance, and all I had to do was pin the blame on you. To him, Frosty is alive, but doesn't matter to me.",
				Wave6 = "Those power crystals are mine, Commander. Just surrender and you can save your men from falling to my forces.",
				Wave8 = "Struggling yet Commander? I am sending in my forces; Snow Predators are here along with upgraded versions of my D.R.E.A.D.",
				Wave9 = "You're going to suffer for that...",
				Wave10 = "You thought there was only one Apex Predator built? I tasked one in this region to keep guard of Frosty's frozen army. Modified him a bit just for you.",
				Wave11 = "... I want to crush the GDA so much, just to avenge him. I am willing to do anything to quench my thirst for revenge. Even if that means destroying this ENTIRE BASE I DESIGNED.",
				Wave12 = "Why don't you just let me have it!? If the GDA almost failed to the Void, then General Celgar will crush you, once and for all."
			},
			Tutorial = {
				Wave1_1 = "Welcome to the GDA, Cadet. My name is Dr. Xenon, and I will personally assist you in familiarizing yourself with the battlefield.",
				Wave1_2 = "I have designed these enemy units to help train your troops. Let's put them to the test! You can place your towers anywhere, but be mindful of their line of sight!",
				Wave1_3 = "Towers must have a clear view of the enemy path, since most of them cannot shoot through obstacles or walls!",
				Wave1_4 = "Why don't you deploy a few rangers to get started?",
				Wave2_1 = "Great work! As you might've noticed, each tower has two upgrade paths: a top path and a bottom path, both specializing in their own fields.",
				Wave2_2 = "You can view an upgrade's effects by hovering over its icon and reading the stats. Which upgrade best suits each situation is up to you to determine.",
				Wave2_3 = "Try upgrading a Ranger to level 3 on the top path to detect stealth!",
				Wave3_1 = "Stealth enemies can be quite common, so stay alert in future missions!",
				Wave3_2 = "Now, brace yourself, I am sending in a real wave of enemies! Upgrade your Ranger to level 2 on the bottom path.",
				Wave4_1 = "Well done! Some enemies are able to stun your towers, temporarily disabling them.",
				Wave4_2 = "Fortunately, certain towers, like John, can develop stun immunity, making them resistant to these effects.",
				Wave4_3 = "I'm deploying a Smasher prototype, he will autonomously seek out a nearby tower and smash the floor to stun it. Get ready!",
				Wave4_4 = "Upgrade your ranger to level 4 on the top path!",
				Wave5_1 = "Bosses often have the ability to stun too, creating openings for weaker enemies to slip by. Be sure to place towers in the back to catch leaks like this in future missions.",
				Wave5_2 = "For this wave, I'm introducing an armored enemy that can resist bullet-based towers, such as Rangers. Some towers can upgrade to bypass this, try fully upgrading a Rangers bottom path!",
				Wave5_3 = "These effects not only ignore bullet resistance, but also come equipped with a grenade ability that can be used to damage these types of enemies!",
				Wave6_1 = "Good, now let's focus on dealing with airborne enemies. The best defense against them is the Missile Trooper's Javelin upgrade, which is the last upgrade on the top path.",
				Wave6_2 = "You'll be able to tell if a tower can detect air enemies by looking for the flight icon in the UI once it's upgraded.",
				Wave7_1 = "Javelins are excellent for general defense against bosses and other high-HP enemies thanks to their massive range.",
				Wave7_2 = "However, be mindful. They're explosive weapons, which certain enemies can resist.",
				Wave7_3 = "For this wave I am sending out a fleet of enemies, along with a prototype Crush-O-Tron I created.",
				Wave7_4 = "Don't let them reach the base, Cadet! It's always more effective to rely on a diverse set of towers than a single one.",
				Wave8_1 = "Prepare to deploy more Javelins and maxxing out your towers, I am going to send out another boss-like enemy. This is something I've been working on for a few years now.",
				Win_1 = "Ah, sorry about that big explosion... I'm still working on getting my robots' core overheating issue under control.",
				Win_2 = "As you just saw there, your towers can take damage and even taken out of action permanently. Towers like the Medic can help keep them in the fight!",
				Win_3 = "Aside from that little setback, excellent work, Cadet! You've proven yourself on the battlefield and I am confident you will be a useful asset to the organization.",
				Win_4 = "Who knows, I might even see you as a Commander on the front lines some day. Good luck!"
			},
			MLG = {
				Wave1 = "hey guys it's lolsman23, i found this controller and i found this game a bit ago. can you beat my obby??",
				Wave2 = "my mom said i can stay up late and play games. i just got done watching mlg antivirus it was really cool.",
				Wave3 = "there's a lot of little troll guys, you should do something about that. -eats chips-",
				Wave4 = "i like to troll a lot, me when i walk up to the oder to like, idk just rekt them.",
				wave5 = "i like using splash towers, i think it's good for this mode",
				Wave7 = "i hated these things in old expert",
				Wave8 = "my mom n dad thinks my sense of humor is weird, this won't have an affect on me 10 years down the road though.",
				Wave9 = "those buff guys have a lot of hp, i like to use mine layers x mines to beam these guys when they get to the middle of the map or something",
				Wave10 = "i used to go to school with him but he kept drinking too many of those dew drinks and now he's here",
				Wave11 = "i like spooky scary skeleton song a lot, he also made my towers that did explosive stuff useless.",
				Wave13 = "my mom got really mad at me for listening to this meme on loop",
				Wave15 = "it's the get no scoped guy, he will shoot ur towers and make their range basically nothing, you should stop him.",
				Wave16 = "it's eradicator but he's like, way harder now. you should stop him or something.",
				Wave17 = "robert, he walks",
				Wave19 = "this guy is like the spooky scary skeleton but he is epic, he still has 100%% explosive resistance.",
				Wave21 = "what is this toliet thing? i only know illuminati, i think this is dumb. destreoy him, i dont remmeber putting him in here",
				Wave22 = "there is cheese, i like cheese",
				Wave24 = "did you see that? illuminati spotted...",
				Wave25 = "i remember some kid in 10th grade had a shirt of him and he got memed for it basically, by the entire classroom",
				Wave27 = "more of this furry thing",
				Wave28 = "hey that's troll physics and epic troll, we need anti air to beam him",
				Wave29 = "it's spooky scary skeleton mlg remix!!",
				Wave30 = "i like this guy, he looks like he is from tower battles, i like tower battles. MASTER FROSTY WE ARE BOUND. HEAR THE THUMP!",
				Wave31 = "he looked mean, also there is bethyva chip guy coming in soon",
				Wave33 = "hey i know those guys, one of them is 24 yrs old and plays roblox. haha, couldn't be me in 10 years. i hope.",
				Wave34 = "you're almost there gamer, the next wave is the last one. also don't let grumbles reach the end of the base or u die",
				Wave35 = "what a great time it has been with you, but our time is nearing an end. beat the illuminati. i hope you win!!! btw u cant stun him"
			},
			MLGNightmare = { Wave1 = "what is that" },
			SlimeEvent = {
				Wave1 = "Commander! The Slimes have invaded! Prepare your defenses and take advantage of smart map placements! This map loops around multiple times!",
				Wave2 = "No idea where these guys came from, or who I even am. Is this a dream?",
				Wave3 = "Slime Soldiers detected. Operator is a great tower to start with, his range can cover other lanes once upgraded!",
				Wave4 = "Operator's top path has a lot more range compared to the bottom path. Take advantage of this!",
				Wave5 = "Lots of Slimes! John's bottom path shotgun upgrade would be a great choice to clear them out!",
				Wave6 = "Slime Mob detected! This guy will break down into even more Slimes when taken down!",
				Wave7 = "Be smart with your placements. Try to cover multiple lanes with the same tower by upgrading its range!",
				Wave8 = "Slime Absorbers detected! When low on health, these guys will throw themselves on the ground to speed up others!",
				Wave10 = "Slime Bloats detected! Fat and slow, but they break into many foes!",
				Wave12 = "Slime Wizard detected! He will summon Purple Slimes that can be a real problem, get rid of him!",
				Wave13 = "Try placing one Operator in each loop that has the Special Forces upgrade. You'll thank me later.",
				Wave14 = "Swarm inbound! Placing down a Juggernaut wouldn't be a bad idea, just make sure it's in a good spot!",
				Wave15 = "Lots of Slimes.. You could use Grenadier's bottom path stun grenades to slow them down!",
				Wave16 = "Slime Chargers... I feel like I've seen big blue guys running before...",
				Wave17 = "Prepare your defenses for the next wave. Missile Trooper's top path Javelin upgrade will be a great addition.",
				Wave18 = "Slime Captain detected! He can summon many foes — be sure to place defenses at the back! Use Javelins to destroy him!",
				Wave19 = "Nice work, Commander! Slime King appears at Wave 25. We can make it!",
				Wave20 = "Slime Brutes detected! Big and mean, these guys can throw Slimes at your towers, slowing them down!",
				Wave21 = "Magma Slime detected! Just like the little red ones, they'll throw themselves upon low health to give a speed boost.",
				Wave22 = "Lots of Brutes! Be sure to upgrade Juggernauts to the top path — range is vital on this map!",
				Wave24 = "Slime King is coming next wave! Be sure to utilize as many Javelins and Juggernauts as you can!",
				Wave25 = "Slime King detected! Use your money wisely, and don't forget to max out your upgrades!"
			},
			SlimeEventNightmare = {
				Wave1 = "Commander, if you chose this mode by mistake, let it be your last. Good luck.",
				Wave10 = "Nightmare.. Nightmare.. Is this one I am in now?",
				Wave20 = "Nightmare Mode..? Nightmare..",
				Wave24 = "Who are these guys?!?!"
			},
			Nightmare = {
				Wave1_1 = "Heya, Commander! I'm General Leah. Advisor is currently out on his own mission, so I'll be here to assist you as I am second in command!",
				Wave1_2 = "Dr. Xenon lured Advisor away and is now committing to a global invasion. We'll have to do our best and defend this region!",
				Wave2_1 = "We need towers like Golden Ranger and AA Turret to survive her onslaught. May the GDA be with you, Commander!",
				Wave2_2 = "With the GDA on our side, we have base defenses set up but they're offline. Please hold your position until we can bring them online!",
				Wave3_1 = "Advisor is making his way back to Earth after we sent out a distress call, but it will take about 10 hours. Don't worry, Commander we've got this.",
				Wave4_1 = "Air enemies inbound, Commander! We need to get air defenses set up ASAP!",
				Wave5_1 = "Heavy Titans! Golden Rangers are a must, they're capable of holding the line for an extended period!",
				Wave6_1 = "It's believed Dr. Xenon has developed new tech to further harness Calamity Crystals. We have no intel on Alpha Predator or the Emperor.",
				Wave6_2 = "We got this intel through our satellites near her moon base. She has no idea we're onto her!",
				Wave6_3 = "Although she destroyed those first before coming here... The GDA ORCUS was sent to investigate, but we were too late.",
				Wave7_1 = "Chariots! They drop turrets randomly and upon death. Their turrets fire back constantly from a distance, destroy them!",
				Wave8_1 = "A Super Heavy Titan already? Hmph, Dr. Xenon is not playing around.",
				Wave8_2 = "Thankfully, we've deployed what used to be experimental units onto the battlefield! Refractor is capable of massive damage.",
				Wave9_1 = "Give us a bit more time, Commander. I promise we're working on rerouting power for the base defenses!",
				Wave10_1 = "When damaged enough, Lurch's cores overheat, and they go insanely fast with added shields!",
				Wave11_1 = "I wonder if Dr. Xenon was able to resolve the core overheating issue? Her experiments always blew up on her... That one didn't. Interesting.",
				Wave12_1 = "It's a stealth rush with those annoying Jumpers! I hate them so much. And their brothers, Thumpers, are even worse.",
				Wave13_1 = "There they are, Thumpers! End them as soon as you can.",
				Wave14_1 = "Invest in more anti-air countermeasures. They'll be a problem soon, Commander!",
				Wave16_1 = "Breachers?! Dr. Xenon really is desperate, huh? We handled them before, we can do it again!",
				Wave17_1 = "Avatars and pilots, what a combo.",
				Wave19_1 = "Hang on, Commander, the base defenses should come online next wave! We're detecting larger hostiles on radar!",
				Wave20_1 = "Base defenses online, Commander! Give them what they came for!",
				Wave21_1 = "Awesome work, Commander! Keep up this energy for the GDA! Her invasion force won't go down easily.",
				Wave23_1 = "Xenon Tanks?! We've never encountered these before! Drop pods are being deployed!",
				Wave24_1 = "Grumble... Grumble Grumble. This bulky guy will blow up our base instantly upon contact. Try not to let that happen.",
				Wave25_1 = "Aerial Juggernauts sighted! Big flying units with lots of health and can launch rockets on the move!",
				Wave26_1 = "Eradicator MK4? Didn't we beat this guy? Commander, his artillery wiped out our naval division last invasion! Destroy him!",
				Wave27_1 = "Eradicator MK4 taken down! We didn't know she had multiple copies. Keep up the pressure Commander!",
				Wave28_1 = "Nuclear Tanks! If they enter your base, they'll instantly explode and leave behind nasty radiation!",
				Wave30_1 = "Two Destructors incoming Commander! Along with two VX Drones, take them out!",
				Wave31_1 = "Destructors down, but don't give up just yet Commander. This will be our final stand.",
				Wave33_1 = "How did she develop so many Thumpers? We really should investigate her factories back at the base.",
				Wave35_1 = "Eradicator MK I C detected. Thankfully, we've developed Shield Tower after his invasion in the Europe division to counter him!",
				Wave36_1 = "Nice one Commander! J-X is here! He has knives for hands and is super tanky against bullet-type towers!",
				Wave37_1 = "Commander we're detecting a large force inbound. This is going to be a long one. Spawn Deployers are calling reinforcements!",
				Wave38_1 = "Multipliers? Heh, haven't seen these guys in a while!",
				Wave39_1 = "Commander, it's an air raid! We need heavy anti-air now!",
				Wave40_1 = "X2 Trooper and his X2 Fighter minions are here! They may look dumb, but they can deal serious damage once they switch modes!",
				Wave41_1 = "Way to go Commander! Keep up the good work, I believe in you!",
				Wave43_1 = "Thumpers. They're sending every drop pod they've got, end them.",
				Wave44_1 = "Commander! Alpha Predator is approaching! Get ready for anything, we have no idea what he's capable of. We only know his name from the files.",
				Wave44_2 = "We know he's based on Apex Predator. There seem to be no more copies of Apex alive. The last one was documented back at Fortress Snowlyn.",
				Wave44_3 = "Interestingly, the explosion of Apex Predator's core during her initial invasion was strong enough to attract Calamity. Intel isn't certain if that was the cause.",
				Wave44_4 = "We don't know much about the Calamity forces, other than they're from another dimension. Dr. Xenon and Dr. Malory did extensive research on the rocks before... well...",
				Wave44_5 = "I'd rather not say what happened to Dr. Malory...",
				Wave44_6 = "Anyway, I remember how excited Dr. Xenon was to finally solve her core overheating issue which she never actually did! Good news for us!",
				Wave44_7 = "No doubt Alpha Predator will do the same. Be sure to clear your towers out of the way when he rips out his core! Get ready Commander, let's blow him to pieces!",
				Wave45_1 = "Alpha Predator detected! Should be the same deal as before. Take him down and clear the area when he rips out his core!",
				Wave46_1 = "M-My gosh... Dr. Xenon... solved the core overheating issue?! Commander, I'm so sorry... I thought we knew...",
				Wave46_2 = "We're in for a rude awakening if Dr. Xenon really solved that core over heating issue after all these years...",
				Wave47_1 = "Two Eradicator MK2s?! And their predecessors are even showing up on radar! Hold the line Commander!",
				Wave48_1 = "Wow, what a fight. Keep up the pressure, we're detecting a large entity incoming. It could be anything. Calamity energy signals are off the charts!",
				Wave49_1 = "How does this Grumble guy have so much health?!",
				Wave49_2 = "Commander, the Emperor arrives next wave. Be brave. Be strong. Be, invincible.",
				Wave50_1 = "The Emperor is here... The bigger they are, the harder they fall! Bring the pain, Commander!"
			},
			UltraNightmare = {},
			Halloween2025 = {
				Wave1 = "Commander! Thank God you are here... We sought refuge in this abandoned castle. I fear they've found us though.",
				Wave2 = "Prepare your defenses Commander! Most of the world is in ruins, don't let this region fall as well.",
				Wave3 = "Ghosts spotted! Air detection is needed Commander. Sniper or AA Turret will shred these things!",
				Wave4 = "We need to have a good balance of ground and air defense. The path on this map is huge, so take advantage of this.",
				Wave6 = "Tomb Raiders! They have resistance to bullet-type towers, so be aware! John's Deagle upgrade can make quick work of them.",
				Wave7 = "So many of these Ghost guys... We need anti-air towers! Snipers have long range weapons, you can place them in the back if needed.",
				Wave8 = "Curse Vine spotted. This guy will entangle your towers for a brief moment!",
				Wave9 = "Bigger air enemy threat! Lost Souls have more health than the Ghosts. Remember to upgrade the range of your Sniper and AA Turrets.",
				Wave10 = "Tormented Souls! Commander, for some reason, our friendly units on the path cannot see or detect them. Be aware! They can phase through our troops!",
				Wave11 = "It's a soul rush! Hold the line!",
				Wave12 = "Vine Golem spotted! These hefty foes have heavy bullet resistances. Juggernaut's top path upgrade to ignore bullet resistance will shred him! Javelins are also good!",
				Wave13 = "Skeleton Air Barrels! Upon dying, they fall to the floor to summon a horde of skeletons!",
				Wave14 = "Tormentor detected! He summons a huge wave of Tormented souls, stop him!",
				Wave15 = "More Skeleton Air Barrels! Having splash damage will help a lot! Javelins from the Missile Trooper are great for both air and splash!",
				Wave16 = "This is a big push! It isn't as bad from what I've seen at the other bases, but I'd rather not talk about that right now. Focus on this!",
				Wave17 = "Apostle spotted. These funny looking guys will spawn a horde of Tormented Souls upon their demise! Javelins and other splash damage towers are needed!",
				Wave18 = "It's that Ghoul again! They're fast movers and devastating to our troops on the path. I've seen these guys run through an Abrams walker like it was butter.",
				Wave19 = "It's nice to have a mix of defenses. Javelins are great, but don't rely on them! Place down some bullet type towers as well!",
				Wave20 = "Coffin Head spotted! These big mean foes deal damage with their mace and have a ton of health! Juggernauts and Javelins will shred him!",
				Wave21 = "Apostle Rush! They may get far, but as long as you have long-range towers deployed like Javelins or top path Juggernauts, we're good.",
				Wave22 = "Grave Guardians! Remember what I said earlier? They have high explosive resistance! We need towers like Juggernauts or Snipers to pick at them! Their shield charge is coming!",
				Wave23 = "Air raid! Giant bats incoming! I have no idea how they got this big... Probably Dr. Xenon's latest experiment when she tried to find a cure. Take them down!",
				Wave24 = "Another Air Raid! We need heavy anti-air! Sniper, Missile Trooper, and AA Turret are all good options to take down these foes!",
				Wave25 = "Harvest Witch! She can buff nearby enemies with shield and make them move much more quickly! The next wave may be our last fight with these guys. Win it Commander!,",
				Wave26 = "There he is! A long forgotten dragon, somehow revived... We need heavy anti-air and ground troops! He summons hordes of foes as well! Get him before he gets us!"
			},
			Halloween2025Nightmare = {},
			Christmas25Part1Easy = {
				Wave1_1 = "Commander! Forge's forces are turning against us! Quickly upgrade your towers through the upgrade shop! Invest wisely and keep an eye on it.",
				Wave1_2 = "We also need multiple medics, be sure to deploy plenty of medics to keep your towers in good shape! Without them, we will surely lose.",
				Wave2_1 = "These robots look exactly like our troops. I don't know why Mr. Forge would turn against us, but we have to assume he is hostile!",
				Wave2_2 = "Don't forget about that upgrade shop Commander. It's important to keep upgrading stats like damage, range, and sometimes even health!",
				Wave3_1 = "They're sending in giant versions of our troops?! Invest heavily in juggernauts, we need as many as possible supported by multiple medics!",
				Wave4_1 = "It's a rush! Scout bots detected! We need some form of splash damage to take out the swarm! Slammer, Grenadier, anything! Get rid of them!",
				Wave5_1 = "Still using the upgrade shop? Good. You made it this far because of it, so keep investing. There's a short breather between each wave. Use it wisely.",
				Wave6_1 = "This is the last wave! Defend the helicopter at all costs! We need to transport our trapped scientists! Good luck, Commander!"
			},
			Christmas25Part1 = {
				Wave1_1 = "Commander! Forge's forces are turning against us! Quickly upgrade your towers through the upgrade shop! Invest wisely and keep an eye on it.",
				Wave1_2 = "We also need multiple medics, be sure to deploy plenty of medics to keep your towers in good shape! Without them, we will surely lose.",
				Wave2_1 = "These robots look exactly like our troops. I don't know why Mr. Forge would turn against us, but we have to assume he is hostile!",
				Wave2_2 = "Don't forget about that upgrade shop Commander. It's important to keep upgrading stats like damage, range, and sometimes even health!",
				Wave3_1 = "They're sending in giant versions of our troops?! Invest heavily in juggernauts, we need as many as possible supported by multiple medics!",
				Wave4_1 = "It's a rush! Scout bots detected! We need some form of splash damage to take out the swarm! Slammer, Grenadier, anything! Get rid of them!",
				Wave5_1 = "Still using the upgrade shop? Good. You made it this far because of it, so keep investing. There's a short breather between each wave. Use it wisely.",
				Wave6_1 = "This is the last wave! Defend the helicopter at all costs! We need to transport our trapped scientists! Good luck, Commander!"
			},
			Christmas25Part1Nightmare = {},
			Christmas25Part2Easy = {
				Wave1_1 = "Commander! This is the last stop for the robots. We can use our missile silo to bring down their shield, exposing their radar station.",
				Wave1_2 = "Always use the upgrade shop! And keep guard of those flags! If robots capture them, they will spawn closer each time!",
				Wave2_1 = "You need to place down more medics, be sure to upgrade them! You can also upgrade their healing ability in the shop.",
				Wave2_2 = "Without some medics, this battle would surely be over quickly. Do not forget about them!",
				Wave3_1 = "The robots are starting to push in more. Do not let up, Commander! Use the upgrade shop to keep them in check!",
				Wave4_1 = "It's a horde! We need splash damage towers like Flame Trooper to make sure these guys rust away!",
				Wave5_1 = "Stronger bots and tanks are being called in! Make sure all of your medics are fully upgraded by now, especially the healing upgrade.",
				Wave6_1 = "One more missile and their shield is down, ending the life signal for the robots sent by that building.",
				Wave6_2 = "After this, I will make sure Forge pays dearly. Keep up the pressure Commander. I fear they will not go down easy.",
				Wave7_1 = "Their shield is down! Wait for the silo to reload and watch them all fall. This will be the end of their assault.",
				Wave7_2 = "Ironclad MK II detected. This behemoth will not stop until he reaches the base! Watch out for his supports!",
				Wave7_3 = "Remember, Commander, keep your medics alive and fully upgraded with towers to ensure victory!"
			},
			Christmas25Part2 = {
				Wave1_1 = "Commander! This is the last stop for the robots. We can use our missile silo to bring down their shield, exposing their radar station.",
				Wave1_2 = "Always use the upgrade shop! And keep guard of those flags! If robots capture them, they will spawn closer each time!",
				Wave2_1 = "You need to place down more medics, be sure to upgrade them!",
				Wave2_2 = "Without some medics, this battle would surely be over quickly. Do not forget about them! You can also upgrade their healing ability in the shop.",
				Wave3_1 = "The robots are starting to push in more. Do not let up, Commander! Use the upgrade shop to keep them in check!",
				Wave4_1 = "It's a horde! We need splash damage towers like Flame Trooper to make sure these guys rust away!",
				Wave5_1 = "Stronger bots and tanks are being called in! Make sure all of your medics are fully upgraded by now, especially the healing upgrade.",
				Wave6_1 = "One more missile and their shield is down, ending the life signal for the robots sent by that building.",
				Wave6_2 = "After this, I will make sure Forge pays dearly. Keep up the pressure Commander. I fear they will not go down easy.",
				Wave7_1 = "Their shield is down! Wait for the silo to reload and watch them all fall. This will be the end of their assault.",
				Wave7_2 = "Ironclad MK II detected. This behemoth will not stop until he reaches the base! Watch out for his supports!",
				Wave7_3 = "Remember, Commander, keep your medics alive and fully upgraded with towers to ensure victory!"
			},
			Christmas25Part2Nightmare = {},
			Easter26Part1Easy = {
				Wave1_1 = "Commander! Get those defenses ready and prepare for the eggs, bunnies, and, uh... trees?",
				Wave1_2 = "We have somehow been teleported here... General Leah has our location. We're still on Earth in a remote area.",
				Wave2_1 = "Red Eggs detected! Upon their deaths, they will throw themselves onto your towers! Placing a few baits wouldn't hurt!",
				Wave2_2 = "Intel has just told us that, apparently, the Engineer has brought us here. But why are these toy-like enemies here? And how isn't the Engineer dead?!",
				Wave3_1 = "Be aware, the first flying enemies are here! Those ducks will break out of their shells and fly! Stingers are a great counter to them!",
				Wave4_1 = "Those ducks called for their mamas! Get more Stingers just in case. She can summon even more ducks!",
				Wave4_2 = "Invest more into explosive-type damage, those trees will be annoying. Javelins are a great counter!",
				Wave5_1 = "Bunny-O-Tron detected! We need as many Javelins as we can buy! Keep placing towers as cash comes in!"
			},
			Easter26Part1 = {
				Wave1_1 = "Commander! Get those defenses ready and prepare for the eggs, bunnies, and, uh... trees?",
				Wave1_2 = "We have somehow been teleported here... General Leah has our location. We're still on Earth in a remote area.",
				Wave2_1 = "Red Eggs detected! Upon their deaths, they will throw themselves onto your towers! Placing a few baits wouldn't hurt!",
				Wave2_2 = "Intel has just told us that, apparently, the Engineer has brought us here. But why are these toy-like enemies here? And how isn't the Engineer dead?!",
				Wave3_1 = "Be aware, the first flying enemies are here! Those ducks will break out of their shells and fly! Stingers are a great counter to them!",
				Wave4_1 = "Those ducks called for their mamas! Get more Stingers just in case. She can summon even more ducks!",
				Wave4_2 = "Invest more into explosive-type damage, those trees will be annoying. Javelins are a great counter!",
				Wave5_1 = "Bunny-O-Tron detected! We need as many Javelins as we can buy! Keep placing towers as cash comes in!"
			},
			Easter26Part2Easy = {
				Wave1_1 = "Commander! ASUS Engineer has, oddly, agreed to let our forces leave the area if we can survive his arena fight.",
				Wave1_2 = "I don't know what this guy's issue is, and I don't care. Bring our forces home, Commander!",
				Wave1_3 = "Be sure to place down towers to defend both paths. Don't forget your medics! Place at least 4 at base level around your towers.",
				Wave2_1 = "Be aware, Commander, Duck Hunters give no cash, and they engage both ground and air units!",
				Wave3_1 = "The Judges are back. They can buff nearby enemies with speed boosts!",
				Wave4_1 = "Terry the Bunnies, they can throw their axes at your towers. Be sure to upgrade some of your medics to counter their damage!",
				Wave4_2 = "If your medics are constantly healing your towers, you should upgrade them. They should heal in patterns, not constantly.",
				Wave5_1 = "The old mob is here, along with Nail Heads. Nail Heads can buff nearby enemies with shields and can be very powerful if left alone for too long!",
				Wave7_1 = "Corrupted Predators detected! They can convert your towers to fight against themselves! Deploy multiple medics with strong healing, and sell any converted towers!",
				Wave7_2 = "Ravaged Predators detected! They're popping up throughout the map and will jump to the back! Be sure to place Javelins in the back!",
				Wave8_1 = "Papa Ducks inbound. They give no cash! This wave barely provides any cash!",
				Wave9_1 = "So many Ravaged Predators they're popping up everywhere! Deploy Javelins in the back! Pairing them with bottom-path EDJ is a strong move!",
				Wave10_1 = "Tarnished Clergymen and Nail Heads inbound a nasty combo. Using Juggernaut's top path HE rounds ability will make quick work of them if timed right!",
				Wave11_1 = "Hatchlings! These guys are heading straight to the base! Do as much damage as you can! Javelins in the back now!",
				Wave12_1 = "Wall Pushers detected. If they reach the base with their wall, we will fall. Hit them hard!",
				Wave13_1 = "The last of the Hatchlings. Juggernauts will shred their HP, and Javelins will clean them up in the back!",
				Wave14_1 = "It's a horde! Watch out for the Shadys! They are stealthed and can phase through tanks, mechas, and troops on the path!",
				Wave15_1 = "Multipliers! They're going to multiply the Duck Hunters! Juggernaut's HE rounds will destroy this instantly time it correctly!",
				Wave16_1 = "Shady swarm detected! Remember, spawner towers cannot affect them, we need stealth detection towers to hit them!",
				Wave17_1 = "Wall Pushers with Speed Deployers. As long as you have enough DPS, you'll be fine.",
				Wave18_1 = "Bunny Zilla and Bunny Tank 900s inbound! They're rushing to the back! Deal as much damage as you can in the front and focus on the backside!",
				Wave19_1 = "ASUS Engineer is being deployed. He thinks this is a game and is testing some sort of experimental aerial pod. Deploy your forces to the back NOW!",
				Wave19_2 = "Max out both EDJs, and don't forget Medics! Have a few maxed out for the best healing output!"
			},
			Easter26Part2 = {
				Wave1_1 = "Commander! ASUS Engineer has, oddly, agreed to let our forces leave the area if we can survive his arena fight.",
				Wave1_2 = "I don't know what this guy's issue is, and I don't care. Bring our forces home, Commander!",
				Wave1_3 = "Be sure to place down towers to defend both paths. Don't forget your medics! Place at least 4 at base level around your towers.",
				Wave2_1 = "Be aware, Commander, Duck Hunters give no cash, and they engage both ground and air units!",
				Wave3_1 = "The Judges are back. They can buff nearby enemies with speed boosts!",
				Wave4_1 = "Terry the Bunnies, they can throw their axes at your towers. Be sure to upgrade some of your medics to counter their damage!",
				Wave4_2 = "If your medics are constantly healing your towers, you should upgrade them. They should heal in patterns, not constantly.",
				Wave5_1 = "The old mob is here, along with Nail Heads. Nail Heads can buff nearby enemies with shields and can be very powerful if left alone for too long!",
				Wave7_1 = "Corrupted Predators detected! They can convert your towers to fight against themselves! Deploy multiple medics with strong healing, and sell any converted towers!",
				Wave7_2 = "Ravaged Predators detected! They're popping up throughout the map and will jump to the back! Be sure to place Javelins in the back!",
				Wave8_1 = "Papa Ducks inbound. They give no cash! This wave barely provides any cash!",
				Wave9_1 = "So many Ravaged Predators they're popping up everywhere! Deploy Javelins in the back! Pairing them with bottom-path EDJ is a strong move!",
				Wave10_1 = "Tarnished Clergymen and Nail Heads inbound a nasty combo. Using Juggernaut's top path HE rounds ability will make quick work of them if timed right!",
				Wave11_1 = "Hatchlings! These guys are heading straight to the base! Do as much damage as you can! Javelins in the back now!",
				Wave12_1 = "Wall Pushers detected. If they reach the base with their wall, we will fall. Hit them hard!",
				Wave13_1 = "The last of the Hatchlings. Juggernauts will shred their HP, and Javelins will clean them up in the back!",
				Wave14_1 = "It's a horde! Watch out for the Shadys! They are stealthed and can phase through tanks, mechas, and troops on the path!",
				Wave15_1 = "Multipliers! They're going to multiply the Duck Hunters! Juggernaut's HE rounds will destroy this instantly time it correctly!",
				Wave16_1 = "Shady swarm detected! Remember, spawner towers cannot affect them, we need stealth detection towers to hit them!",
				Wave17_1 = "Wall Pushers with Speed Deployers. As long as you have enough DPS, you'll be fine.",
				Wave18_1 = "Bunny Zilla and Bunny Tank 900s inbound! They're rushing to the back! Deal as much damage as you can in the front and focus on the backside!",
				Wave19_1 = "ASUS Engineer is being deployed. He thinks this is a game and is testing some sort of experimental aerial pod. Deploy your forces to the back NOW!",
				Wave19_2 = "Max out both EDJs, and don't forget Medics! Have a few maxed out for the best healing output!"
			},
			PVP_1V1 = {
				Wave1 = "Welcome to the PVP Simulator, Commander! This is a 1v1 battle against another player, not your usual simulation!",
				Wave2 = "You'll need to send enemies for eco! The best ones to send are Normal Droid and Heavy Droid for now. You'll get more cash every 7 seconds.",
				Wave3 = "Don't forget about your defense! You'll need to create a balance of offense and defense. If you don't have enough defense, you'll lose!",
				Wave4 = "Later on, you can send more powerful enemies like the Eradicator-B and Crusher. For now, focus on your eco.",
				Wave5 = "You are able to send Heavy Droid now. It's important to constantly send eco enemies to keep your cash flow up.",
				Wave7 = "Don't forget about sending your eco enemies, Heavy Droid being the baseline for now.",
				Wave8 = "You also have 2 power ups on the right side, offense and defense. Time them right to change the game's outcome!",
				Wave10 = "We have deployed an X-Soldier as a reminder that medics are needed in this mode!",
				Wave11 = "Fallouts are being sent. They have heavy resistance to Calamity type damage and Laser type damage. Keep this in mind!",
				Wave12 = "You can now send Fallouts. Although more expensive, they increase your eco more! Send these instead of Heavy Droids!",
				Wave13 = "Don't forget about medics, but be careful not to overinvest in them too soon! Otherwise you're wasting money.",
				Wave17 = "Boss 2 sent, slow but bulky, with heavy resistance to Bullet type damage. Railgunners or Golden Juggernaut will shred him.",
				Wave19 = "Our first stealth type, Cloaker, is being sent. Operator or Ghost will be able to counter this enemy!",
				Wave20 = "Erad-B is deployed. Get a few medics with uber charges to increase your healing power, though using uber isn't needed just yet!",
				Wave23 = "You're making it quite far, impressive! The waves will get difficult as time goes on. Heads up, Heavy Metal should be your go-to send for eco now.",
				Wave25 = "Eradicator deployed. Don't forget about your medics, and deploy proper defenses to take him down.",
				Wave28 = "Don't forget to keep sending eco enemies, Heavy Metal being the best choice for the rest of the simulation.",
				Wave30 = "Crusher type mini bosses deployed. Although they don't deal much damage, they are tanky!",
				Wave32 = "Dreadcubus spawned! Make sure your medics are upgraded to heal your towers more!",
				Wave35 = "King and Queen! Not much of a threat on their own; however, they heavily counter Calamity type damage!",
				Wave37 = "We are approaching the late game in this simulation. The difficulty will increase, stay alert.",
				Wave40 = "X2-Trooper deployed, we need more medics! Have a few maxed out, especially when he transforms!",
				Wave42 = "Sending in heavy units.",
				Wave43 = "Impressive, Commander, making it this far is not easy. Watch out for heavy bosses that may be sent by your foe!",
				Wave47 = "Cranking up the difficulty.",
				Wave50 = "Excellent, sending in more enemies.",
				Wave53 = "You're an outlier for sure, Commander. Increasing the difficulty now.",
				Wave56 = "Difficulty being increased.",
				Wave59 = "Impressive, survive this.",
				Wave60 = "Excellent, you've come this far. Let's see how long you can last now. The Simulation doesn't show mercy at this point in the game.",
				Wave61 = "We didn't forget about her."
			},
			TBPart2Casual = {
				Wave1 = "Cadet! Dr. Xenon's Portal was a success, and you're all in one piece. Prepare your defenses. Medic will be viable here.",
				Wave2 = "Malice detected. Their behavior is odd. They are 100%% resistant to Calamity type damage and Laser. They are also able to buff enemies passing through.",
				Wave3 = "Grenadier is a great option here, able to throw his Stiel grenades at Malices while dealing fire damage to the horde!",
				Wave4 = "Cyst detected, a flying enemy able to damage towers! Although the damage it deals is very low, get air detection!",
				Wave5 = "Nowsowys inbound, an odd combination of slow, normal, and fast speeds.",
				Wave6 = "Boss 1 detected, with heavy bullet resistance! You can either use towers like Railgunner or Grenadier's ability to lower its resistances!",
				Wave7 = "A combo of everything. The Void army is strange, and intel doesn't show much. Thankfully, the Nukes we sent in first hammered most of the forces here.",
				Wave8 = "More Malices. Try to get rid of them first before they start boosting the rest of the enemies!",
				Wave9 = "Stealth enemies inbound! Operator Ghost or Juggernaut's bottom path upgrades with an EDJ will chew them down.",
				Wave10 = "Mystery V detected. It's like the ones we've seen before, but different enemies are summoned upon its demise.",
				Wave11 = "Malignants. They can summon and give shields to their fellow enemies!",
				Wave12 = "Carcin detected, with heavy collision resistances. It also moves fast for its size.",
				Wave13 = "Good work so far, Cadet. Keeping a mix of Grenadiers, Railgunners, Medics, and Juggernauts will be your best bet for survival!",
				Wave14 = "Lots of enemies detected. Grenadiers and Top Path Railgunners are a strong counter!",
				Wave15 = "More Malices. Remember, they have 100%% Laser and Calamity resistance. Grenadier can lower this, or you can use other towers!",
				Wave16 = "Slags, quick enemies that lower the range of nearby towers upon their demise.",
				Wave17 = "More Cyst flying enemies inbound. Their forces are slowly increasing over time. Surely there shouldn't be this much resistance after a few nukes...",
				Wave18 = "Void Lich! It's the first boss! Get more Medics and be prepared for his summons!",
				Wave19 = "That was a smaller boss. Surely there are bigger ones lying around here in this dimension... Be ready.",
				Wave20 = "There are some floating islands on the edge of this area. Perhaps they would be great for some XRT Railgunners down the road with a discount EDJ.",
				Wave21 = "Radar is detecting a planet sized bogey. It could be interference from the radiation, or more than likely the Void dimension we are in. No way it's an enemy.",
				Wave22 = "Sludge Boss. It can summon other Sludge Bosses and be a nonstop nightmare! Heavily resistant to Explosive type damage.",
				Wave23 = "Neurons. These seem very similar to the ones seen on Earth, but purple. I wonder if the Void and the Zombies on Earth are two different factions.",
				Wave24 = "Tons of Slags. Top Path Railgunner's pierce upgrade will shred them.",
				Wave25 = "Void Berserker! Able to deal debuffs to nearby towers, and it's fast with a lot of health!",
				Wave26 = "The Voids are back! However, there are TWO of them at once! Hopefully, them dying in this dimension is permanent!",
				Wave27_1 = "Nice one, Cadet. That confirms there are multiple of these entities. This could be a hive mind collection we are dealing with here.",
				Wave27_2 = "The Void has dangling bodies from its torso, implying this is a collection of minds of some sort. Further research is needed on this.",
				Wave28 = "Void Tank inbound! Super tanky guy, heavily resistant to bullet type towers!",
				Wave29 = "Super Slow detected. Tons of HP. Grenadier's stunning and Napalm Bombs can make it a lot easier to deal with.",
				Wave30 = "Void Prime! We have no idea what he does, but I'm sure some XRT Railgunners can destroy him! We need to outrange his sword!",
				Wave31 = "Void Prime... He was able to drag towers down into another dimension. May we honor our fallen and press on to victory.",
				Wave33 = "Blisters, fat and slow but annoying aerial enemies. Top Path Railgunner can bring them down.",
				Wave35 = "Blister rush! They can also slam the ground and deal damage to your towers. Be aware.",
				Wave36 = "The next wave is bringing in another Void Boss. Prepare your defenses.",
				Wave37 = "Exo Void detected. He's armed with a deadly arm cannon that can pierce Ubers! Fight!",
				Wave38 = "Exo Void has been defeated! It seems he has teleported away somewhere else, though. Hopefully, he isn't coming back.",
				Wave40 = "This world is truly strange. I don't understand some of the readings on these charts. Something big is coming.",
				Wave41 = "Void Crystalizer detected. He summons a crystal that won't stop spawning enemies. Be sure to move your defenses up.",
				Wave42 = "A big entity is going to enter the area next wave. Be ready.",
				Wave43 = "Void Devastator! We need long range hitters now!"
			},
			TBPart2Hard = {
				Wave1 = "Cadet! Dr. Xenon's Portal was a success, and you're all in one piece. Prepare your defenses. Medic will be viable here.",
				Wave2 = "Malice detected. Their behavior is odd. They are 100%% resistant to Calamity type damage and Laser. They are also able to buff enemies passing through.",
				Wave3 = "Grenadier is a great option here, able to throw his Stiel grenades at Malices while dealing fire damage to the horde!",
				Wave4 = "Cyst detected, a flying enemy able to damage towers! Although the damage it deals is very low, get air detection!",
				Wave5 = "Nowsowys inbound, an odd combination of slow, normal, and fast speeds.",
				Wave6 = "Boss 1 detected, with heavy bullet resistance! You can either use towers like Railgunner or Grenadier's ability to lower its resistances!",
				Wave7 = "A combo of everything. The Void army is strange, and intel doesn't show much. Thankfully, the Nukes we sent in first hammered most of the forces here.",
				Wave8 = "More Malices. Try to get rid of them first before they start boosting the rest of the enemies!",
				Wave9 = "Stealth enemies inbound! Operator Ghost or Juggernaut's bottom path upgrades with an EDJ will chew them down.",
				Wave10 = "Mystery V detected. It's like the ones we've seen before, but different enemies are summoned upon its demise.",
				Wave11 = "Malignants. They can summon and give shields to their fellow enemies!",
				Wave12 = "Carcin detected, with heavy collision resistances. It also moves fast for its size.",
				Wave13 = "Good work so far, Cadet. Keeping a mix of Grenadiers, Railgunners, Medics, and Juggernauts will be your best bet for survival!",
				Wave14 = "Lots of enemies detected. Grenadiers and Top Path Railgunners are a strong counter!",
				Wave15 = "More Malices. Remember, they have 100%% Laser and Calamity resistance. Grenadier can lower this, or you can use other towers!",
				Wave16 = "Slags, quick enemies that lower the range of nearby towers upon their demise.",
				Wave17 = "More Cyst flying enemies inbound. Their forces are slowly increasing over time. Surely there shouldn't be this much resistance after a few nukes...",
				Wave18 = "Void Lich! It's the first boss! Get more Medics and be prepared for his summons!",
				Wave19 = "That was a smaller boss. Surely there are bigger ones lying around here in this dimension... Be ready.",
				Wave20 = "There are some floating islands on the edge of this area. Perhaps they would be great for some XRT Railgunners down the road with a discount EDJ.",
				Wave21 = "Radar is detecting a planet sized bogey. It could be interference from the radiation, or more than likely the Void dimension we are in. No way it's an enemy.",
				Wave22 = "Sludge Boss. It can summon other Sludge Bosses and be a nonstop nightmare! Heavily resistant to Explosive type damage.",
				Wave23 = "Neurons. These seem very similar to the ones seen on Earth, but purple. I wonder if the Void and the Zombies on Earth are two different factions.",
				Wave24 = "Tons of Slags. Top Path Railgunner's pierce upgrade will shred them.",
				Wave25 = "Void Berserker! Able to deal debuffs to nearby towers, and it's fast with a lot of health!",
				Wave26 = "The Voids are back! However, there are TWO of them at once! Hopefully, them dying in this dimension is permanent!",
				Wave27_1 = "Nice one, Cadet. That confirms there are multiple of these entities. This could be a hive mind collection we are dealing with here.",
				Wave27_2 = "The Void has dangling bodies from its torso, implying this is a collection of minds of some sort. Further research is needed on this.",
				Wave28 = "Void Wardens inbound! They can attack both air and ground units!",
				Wave29 = "Super Slow detected. Tons of HP. Grenadier's stunning and Napalm Bombs can make it a lot easier to deal with.",
				Wave30 = "Void Prime! We have no idea what he does, but I'm sure some XRT Railgunners can destroy him! We need to outrange his sword!",
				Wave31 = "Void Prime... He was able to drag towers down into another dimension. May we honor our fallen and press on to victory.",
				Wave33 = "Blisters, fat and slow but annoying aerial enemies. Top Path Railgunner can bring them down.",
				Wave35 = "Blister rush! They can also slam the ground and deal damage to your towers. Be aware.",
				Wave36 = "The next wave is bringing in another Void Boss. Prepare your defenses.",
				Wave37 = "Exo Void detected. He's armed with a deadly arm cannon that can pierce Ubers! Fight!",
				Wave38 = "Exo Void has been defeated! It seems he has teleported away somewhere else, though. Hopefully, he isn't coming back.",
				Wave40 = "This world is truly strange. I don't understand some of the readings on these charts. Something big is coming up. It's still planet sized.",
				Wave41 = "Void Crystalizer detected. He summons a crystal that won't stop spawning enemies. Be sure to move your defenses up.",
				Wave42 = "A big entity is going to enter the area next wave. Be ready.",
				Wave43 = "Void Devastator! We need long range hitters now!",
				Wave44_1 = "Cadet, you still there?! The whole area has been blown up by Devastator! We're sending in a massive fund influx. Stay strong!",
				Wave44_2 = "We have no idea what we're going against. TB forces were sent into another area in this region. Void Devastator's explosion cut off their radio comms!",
				Wave45_1 = "Dr. Xenon, are you able to make contact with the remaining forces?",
				Wave45_2 = "Negative, Advisor. But Void Devastator... his design seemed so simple, yet dangerously effective. Further research is needed on these Void entities.",
				Wave47 = "Cadet, you have held up well. Do not let up. However, that same planet sized entity is coming closer now. Be ready, be brave, and be ready to fight.",
				Wave48 = "... May God have mercy on us all."
			}
		},
		LoadoutSelectionSubtitles = {
			Christmas = "Available in Christmas Event - Normal",
			MLG = "Available in MLG Event - Normal",
			Halloween = "Available in Halloween Event - Normal",
			Easter = "Available in Easter Event - Normal",
			TowerBattles = "Available in Tower Battles Event - Normal",
			SlimeEvent = "Available in Slime Event",
			SkipPenalty = "Using your own loadout will cause -%d%% gold reduction"
		},
		LoadoutSelectionTitles = {
			Assault = "Assault Loadout",
			Support = "Support Loadout",
			HeavyWeapons = "Heavy Weapons Loadout",
			SpecialForces = "Special Forces",
			MLGScarecrow = "GOLDEN STUFF"
		},
		LoadoutSelectionDescriptions = {
			Empty = "",
			Assault = "Jack of all trades - easy early game with Operator & Grenadier and strong in boss fights with maxed top path Missile Trooper",
			Support = "Heal your allies with Medic and buff with EDJ while deploying units on the path with Barracks and Armored Factory",
			HeavyWeapons = "Weaker early game with Toxinator and John, but unrivaled firepower during late game with Railgunner, Juggernaut, and Artillery",
			SpecialForces = "A taste of GDA's powerful weaponry. Use Golden Ranger and Flamethrower early game, save XWM Turret for later.",
			Assault2 = "Jack of all trades - easy early game with Laser Gunner & Medic and strong in boss fights with maxed top path Missile Trooper",
			HeavyWeapons2 = "Weaker early game with John, but unrivaled firepower during late game with Railgunner, Juggernaut, and Artillery",
			MLGScarecrow = "ALL GOLD STUFF FOR YOU TO USE!!!!",
			MLGSupport = "MEDIC",
			MLGHeavyWeapons = "SUB META",
			MLGSpecialForces = "P2P SLOP, ISN'T EVEN GOOD BC IDC TO CHANGE UP THE STATS THIS YEAR"
		},
		WaveTop = "WAVE %d",
		WaveBonus = "Wave Bonus: +$%s",
		GroupStartingCashBonus = "Group Starting Cash Bonus: +$%s",
		DifficultySelected = "Difficulty Selected: %s",
		RewindOpenButton = "REWIND TO WAVE %d",
		RewindGoldCost = "%d GOLD",
		RewindGoldFree = "FREE REWIND",
		RewindRobuxOnly = "ROBUX ONLY",
		RewindRobuxCost = utf8.char(57346) .. "%d",
		RewindWave = "REWIND TO WAVE %d",
		RewindCash = "+%d CASH SPLIT EVENLY",
		RewindHP = "+%d HP ADDED TO BASE",
		RewindGoldBalance = "Gold balance: $%d",
		RewindInsufficientGold = "Insufficient gold!",
		RewindServerError = "Server error :(",
		ValentinesInfoPercentage = "Win for <font weight='900'>%d%%</font> chance to get 1 of 8 Valentine's skins!",
		ValentinesInfoEmpty = "Play <font weight='900'>Intermediate</font> or <font weight='900'>Expert</font> for a chance to get Valentine's skins!",
		RebuildsLeft = "REBUILDS LEFT: %d",
		FirstWinNotificationCenterText = "First %s mode win on %s",
		FirstWinNotificationBottomText = "+%d%% gold/crystal reward"
	}
}