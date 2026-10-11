local GameClass = {}
GameClass.__index = GameClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local ProfilerClass = require(common:WaitForChild("ProfilerClass"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PathHandler = require(common:WaitForChild("PathHandler"))
local PlacementHandler = require(common:WaitForChild("PlacementHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local UserInterfaceHandler = require(script.Parent:WaitForChild("UserInterfaceHandler"))
local UserInputHandler = require(script.Parent:WaitForChild("UserInputHandler"))
local CameraHandler = require(script.Parent:WaitForChild("CameraHandler"))
local BaseClasses = script:WaitForChild("BaseClasses")
local CharacterClass = require(BaseClasses:WaitForChild("CharacterClass"))
local EnemyClass = require(script:WaitForChild("EnemyClass"))
local TowerClass = require(script:WaitForChild("TowerClass"))
local StaticEntityClass = require(script:WaitForChild("StaticEntityClass"))
local PathEntityClass = require(script:WaitForChild("PathEntityClass"))
local MapEntityClass = require(script:WaitForChild("MapEntityClass"))
require(script:WaitForChild("LoadoutSoundsHandler"))
local ProjectileHandler = require(script:WaitForChild("ProjectileHandler"))
local VisualEffectHandler = require(script:WaitForChild("VisualEffectHandler"))
local VisualSequenceHandler = require(script:WaitForChild("VisualSequenceHandler"))
require(script:WaitForChild("BurnEffectHandler"))
local AmbienceHandler = require(script:WaitForChild("AmbienceHandler"))
local PowerUpsHandler = require(script:WaitForChild("PowerUpsHandler"))
require(script:WaitForChild("BombardmentHandler"))
local DropCoinsHandler = require(script:WaitForChild("DropCoinsHandler"))
local CutsceneHandler = require(script:WaitForChild("CutsceneHandler"))
local TutorialHandler = require(script:WaitForChild("TutorialHandler"))
local DialogueAudioPreloader = require(script:WaitForChild("DialogueAudioPreloader"))
local VoidGodAirstrikeStationHandler = require(script:WaitForChild("VoidGodAirstrikeStationHandler"))
local PRINT_CLIENT_LOOP_TIME = _G.PRINT_CLIENT_LOOP_TIME
local DEFAULT_DIFFICULTY = _G.DEFAULT_DIFFICULTY
local GameStates = Enums.GameStates
local v = { [Enums.Maps.Genesis] = true, [Enums.Maps.Exegesis] = true }
local event = NetworkingHandler.GetEvent("GameMapChanged")
local event2 = NetworkingHandler.GetEvent("GameStateChanged")
local event3 = NetworkingHandler.GetEvent("SpeedMultiplierChanged")
local event4 = NetworkingHandler.GetEvent("AdditionalSpeedMultiplierChanged")
local event5 = NetworkingHandler.GetEvent("DifficultyChanged")
local event6 = NetworkingHandler.GetEvent("WaveStateChanged")
local event7 = NetworkingHandler.GetEvent("LivesChanged")
local event8 = NetworkingHandler.GetEvent("TotalLivesChanged")
local event9 = NetworkingHandler.GetEvent("MapVoteTimeLeftChanged")
local event10 = NetworkingHandler.GetEvent("DifficultyVoteTimeLeftChanged")
local event11 = NetworkingHandler.GetEvent("LoadoutSelectionTimeLeftChanged")
local event12 = BindableHandler.GetEvent("WaveChanged")
local event13 = BindableHandler.GetEvent("TimeLeftChanged")
local event14 = BindableHandler.GetEvent("LivesChanged")
local event15 = BindableHandler.GetEvent("SetSpeedMultiplier")
local event16 = BindableHandler.GetEvent("SetDifficulty")
local event17 = BindableHandler.GetEvent("SetMapDifficulty")
local v2 = nil
local v3 = ProfilerClass.New("Client game loop", 120)
local v4 = false
local LocalPlayer = Players.LocalPlayer
local flag = false
local callbacks = {}

local function DispatchGameEvent(fn) -- 11 equivalent calls inferred from this helper
	if flag then
		table.insert(callbacks, fn)
	elseif v2 then
		fn(v2)
	end
end

local function AdjustTimeLeft(p: number, p2: number) -- 3 equivalent calls inferred from this helper
	return p - Utilities.GetTimeOffset(p2)
end

local function TeleportPlayerToSpawn(mapName: string)
	local spawnLocation = MapHandler.GetSpawnLocation()

	if not spawnLocation then
		warn("Spawn location not found for map", mapName)
		return
	end

	local part = Instance.new("Part")
	part.Size = Vector3.new(8, math.max(0.25, spawnLocation.Size.Y), 8)
	part.Position = spawnLocation.Position
	part.Anchored = true
	part.CanCollide = true
	part.Transparency = 1
	part.Parent = workspace
	local character = LocalPlayer.Character

	if not character then
		return
	end

	local primaryPart = character.PrimaryPart

	if not primaryPart then
		return
	end

	primaryPart.Anchored = true
	primaryPart.CFrame = spawnLocation.CFrame + Vector3.new(0, math.random(250, 300) / 10, 0)
	task.delay(0.25, function()
		primaryPart.Anchored = false
	end)
	task.delay(5, function()
		part:Destroy()
	end)
end

local function InitializeTeamDataTable(data)
	local result = {}

	for k, v5 in pairs(data.TeamDataTable) do
		result[k] = { Lives = v5.Lives, TotalLives = v5.TotalLives }
	end

	return result
end

function GameClass.New(data)
	flag = true
	local currentStateData

	if data.State == GameStates.Running then
		currentStateData = data.CurrentStateData
	end

	local teamDataTable = InitializeTeamDataTable(data)
	local v5 = {
		State = nil,
		SpeedMultiplier = data.SpeedMultiplier,
		AdditionalSpeedMultiplier = data.AdditionalSpeedMultiplier,
		Difficulty = DEFAULT_DIFFICULTY,
		MapName = nil,
		MapDifficulty = nil,
		IsPVP = data.IsPVP,
		PVPTeamCount = data.PVPTeamCount,
		PVPTeamIndices = data.PVPTeamIndices,
		TeamDataTable = teamDataTable,
		WaveNumber = 0,
		TimeLeft = 0
	}
	local waveNumber

	if currentStateData then
		waveNumber = currentStateData.WaveNumber
	end

	v5.WaveNumber = waveNumber
	local timeLeft

	if currentStateData then
		timeLeft = AdjustTimeLeft(currentStateData.TimeLeft, currentStateData.ServerTime) -- inferred equivalent call
	end

	v5.TimeLeft = timeLeft
	setmetatable(v5, GameClass)

	if data.GameMapData then
		v5:SetMapData(data.GameMapData, nil, data.IsPVP)
	end

	v5:SetState(data.State, data.CurrentStateData)
	v2 = v5

	if
		data.State == GameStates.Running
		or data.State == GameStates.LoadoutSelection
		or data.State == GameStates.SeizureWarning
		or data.State == GameStates.Cutscene
	then
		v5:SetDifficulty(data.Difficulty)
	end

	v5:SetSpeedMultiplier(data.SpeedMultiplier)
	EnemyClass.SpawnExistingEnemies(data.EnemyInitData)
	TowerClass.SpawnExistingTowers(data.TowerInitData)
	StaticEntityClass.SpawnExistingStaticEntities(data.StaticEntityInitData)
	PathEntityClass.SpawnExistingPathEntities(data.PathEntityInitData)
	MapEntityClass.SpawnExistingMapEntities(data.MapEntityInitData)

	if not v4 then
		EnemyClass.Initialize()
		TowerClass.Initialize(data.PlayerNameToDynamicPriceScalingDataMap)
		StaticEntityClass.Initialize()
		PathEntityClass.Initialize()
		MapEntityClass.Initialize()
		ProjectileHandler.Initialize()
		PowerUpsHandler.Initialize()
		DropCoinsHandler.Initialize()
		v4 = true
	end

	event12:Fire(v5.WaveNumber)
	event13:Fire(v5.TimeLeft)
	event14:Fire(v5.TeamDataTable)
	flag = false
	local v6 = callbacks
	callbacks = {}

	for _, v7 in ipairs(v6) do
		v7(v5)
	end

	return v5
end

function GameClass.GetTowerCostMultiplier(p: string)
	if not v2 then
		return 1
	end

	local towerCostMultiplierMap = ResourceManager.GetWaveConfig(v2.Difficulty).TowerCostMultiplierMap

	if towerCostMultiplierMap and towerCostMultiplierMap[p] then
		return towerCostMultiplierMap[p]
	end

	return 1
end

function GameClass:SetMapData(p, flag2: boolean?, flag3: boolean?)
	self.MapName = p.MapName
	self.MapDifficulty = p.MapDifficulty
	MapHandler.ClientMapLoaded()
	PathHandler.Initialize()
	PlacementHandler.Initialize()
	AmbienceHandler.Initialize()
	UserInputHandler.Initialize()
	SoundHandler.Initialize()

	if v[self.MapName] then
		VoidGodAirstrikeStationHandler.Initialize()
	else
		VoidGodAirstrikeStationHandler.Reset()
	end

	event17:Fire(self.MapName, self.MapDifficulty)

	if flag2 or flag3 then
		TeleportPlayerToSpawn(p.MapName)
	end
end

function GameClass.GetState(p)
	return p.State
end

function GameClass:SetState(state: string, data)
	local state2 = self.State
	self.State = state

	if state2 == GameStates.Cutscene then
		CutsceneHandler.End()
	end

	if state == GameStates.MapVoting then
		MapHandler.ClientMapVotingLobbyLoaded()
		self:SetTimeLeft(data.VoteTimeRemaining, data.ServerTime)
	elseif state == GameStates.DifficultyVoting then
		self:SetTimeLeft(data.VoteTimeRemaining, data.ServerTime)
	elseif state == GameStates.LoadoutSelection then
		self:SetTimeLeft(data.TimeLeft, data.ServerTime)
	elseif state == GameStates.Cutscene then
		CutsceneHandler.Start(data, state2 == GameStates.SeizureWarning)
	elseif state == GameStates.Running then
		EnemyClass.Restart()
		AmbienceHandler.Restart()
		VisualSequenceHandler.Restart()

		if data then
			self:SetWaveState(data)
		end
	end

	UserInterfaceHandler.SetState(state2, state, data)
	UserInputHandler.GameStateChanged(state)
	CameraHandler.SetState(state)
end

function GameClass.Tick(p, p2: number)
	local lastTime = os.clock()
	local speedMultiplier = p.SpeedMultiplier
	local additionalSpeedMultiplier = p.AdditionalSpeedMultiplier
	local v5 = p2 * speedMultiplier
	local v6 = v5 * additionalSpeedMultiplier
	AmbienceHandler.Run(v6)
	PowerUpsHandler.Run(v6)
	ProjectileHandler.Run(v6)
	VisualEffectHandler.Run(v6)
	VisualSequenceHandler.Run(v6)
	DropCoinsHandler.Run(v6)
	CutsceneHandler.Run(p2)
	EnemyClass.LogicLoop(v6, v5)
	TowerClass.LogicLoop(v6, p2)
	StaticEntityClass.LogicLoop(v6, p2)
	PathEntityClass.LogicLoop(v6, p2)
	MapEntityClass.LogicLoop(v6, p2)
	CharacterClass.Tick(v6, p2)
	MapHandler.Run_Client(v6)
	VoidGodAirstrikeStationHandler.Run(v6)
	TutorialHandler:Run(p2, v6)

	if PRINT_CLIENT_LOOP_TIME then
		v3:Log(os.clock() - lastTime)
	end
end

function GameClass:GetSpeedMultiplier()
	return self.SpeedMultiplier
end

function GameClass:GetFinalSpeedMultiplier()
	return self.SpeedMultiplier * self.AdditionalSpeedMultiplier
end

function GameClass:SetSpeedMultiplier(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
	self:_SpeedMultiplierChanged()
end

function GameClass:SetAdditionalSpeedMultiplier(additionalSpeedMultiplier: number)
	self.AdditionalSpeedMultiplier = additionalSpeedMultiplier
	self:_SpeedMultiplierChanged()
end

function GameClass:_SpeedMultiplierChanged()
	local speedMultiplier = self:GetSpeedMultiplier()
	local finalSpeedMultiplier = self:GetFinalSpeedMultiplier()
	event15:Fire(finalSpeedMultiplier)
	PowerUpsHandler.SetSpeedMultiplier(finalSpeedMultiplier)
	VisualSequenceHandler.SetSpeedMultiplier(finalSpeedMultiplier)
	ProjectileHandler.SetSpeedMultiplier(finalSpeedMultiplier)
	VisualEffectHandler.SetSpeedMultiplier(finalSpeedMultiplier)
	DropCoinsHandler.SetSpeedMultiplier(finalSpeedMultiplier)
	EnemyClass.SetSpeedMultiplier(finalSpeedMultiplier, speedMultiplier)
	TowerClass.SetSpeedMultiplier(finalSpeedMultiplier)
	StaticEntityClass.SetSpeedMultiplier(finalSpeedMultiplier)
	PathEntityClass.SetSpeedMultiplier(finalSpeedMultiplier)
	MapEntityClass.SetSpeedMultiplier(finalSpeedMultiplier)
	UserInputHandler.SetSpeedMultiplier(finalSpeedMultiplier)
	MapHandler.SetSpeedMultiplier_Client(finalSpeedMultiplier)
end

function GameClass:SetDifficulty(difficulty: string)
	self.Difficulty = difficulty
	AmbienceHandler.DifficultyChanged(difficulty)
	DialogueAudioPreloader.DifficultyChanged(difficulty)
	TutorialHandler:DifficultyChanged(difficulty)
	VoidGodAirstrikeStationHandler.DifficultyChanged(difficulty)
	event16:Fire(difficulty)
	event14:Fire(self.TeamDataTable)
	EnemyClass.SetDifficulty(difficulty)
end

function GameClass:SetWaveState(data)
	self.WaveNumber = data.WaveNumber
	self.TimeLeft = AdjustTimeLeft(data.TimeLeft, data.ServerTime) -- inferred equivalent call

	if data.WaveJustStarted then
		SoundHandler.Play("WaveCashBonus")
		AmbienceHandler.WaveReached(self.WaveNumber)
	end

	event12:Fire(self.WaveNumber, data.FromRewind, data.WaveJustStarted)
	event13:Fire(self.TimeLeft)
end

function GameClass:SetTimeLeft(p: number, p2: number)
	self.TimeLeft = AdjustTimeLeft(p, p2) -- inferred equivalent call
	event13:Fire(self.TimeLeft)
end

function GameClass:SetLives(p: number, lives: number, flag2: boolean?, flag3: boolean?)
	local v5 = self.TeamDataTable[p]

	if not v5 then
		warn("GameClass:SetLives - invalid PVP team index", p)
		return
	end

	if p == TeamUtilities.GetLocalPlayerTeamIndex() and lives < v5.Lives and not (flag2 or flag3) then
		SoundHandler.Play("LostLife")
	end

	v5.Lives = lives
	local teamDataTable = self.TeamDataTable

	if flag2 then
		p = nil
	end

	event14:Fire(teamDataTable, p)
end

function GameClass:SetTotalLives(p: number, totalLives: number)
	local v5 = self.TeamDataTable[p]

	if not v5 then
		warn("GameClass:SetTotalLives - invalid PVP team index", p)
		return
	end

	v5.TotalLives = totalLives
	event14:Fire(self.TeamDataTable)
end

function GameClass.GetCurrentGame()
	return v2
end

function GameClass.Reset()
	for _, v5 in pairs(EnemyClass.GetEnemies()) do
		v5:Destroy(true)
	end

	for _, v5 in pairs(TowerClass.GetTowers()) do
		v5:Destroy(true)
	end

	for _, v5 in pairs(StaticEntityClass.GetStaticEntities()) do
		v5:Destroy(true)
	end

	for _, v5 in pairs(PathEntityClass.GetPathEntities()) do
		v5:Destroy(true)
	end

	for _, v5 in pairs(MapEntityClass.GetMapEntities()) do
		v5:Destroy(true)
	end

	UserInterfaceHandler.Reset()
end

event3:AttachCallback(function(p: number)
	local function fn(object)
		object:SetSpeedMultiplier(p)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event4:AttachCallback(function(p: number)
	local function fn(object)
		object:SetAdditionalSpeedMultiplier(p)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event6:AttachCallback(function(p)
	local function fn(object)
		object:SetWaveState(p)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event7:AttachCallback(function(p: number, p2: number, flag2: boolean?, flag3: boolean?)
	local function fn(object)
		object:SetLives(p, p2, flag2, flag3)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event8:AttachCallback(function(p: number, p2: number)
	local function fn(object)
		object:SetTotalLives(p, p2)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event:AttachCallback(function(p, flag2: boolean?, flag3: boolean?)
	local function fn(object)
		object:SetMapData(p, flag2, flag3)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event2:AttachCallback(function(p: string, p2)
	local function fn(object)
		object:SetState(p, p2)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event5:AttachCallback(function(p: string)
	local function fn(object)
		object:SetDifficulty(p)
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event9:AttachCallback(function(p: number, p2: number)
	local function fn(object)
		if object.State == GameStates.MapVoting then
			object:SetTimeLeft(p, p2)
		end
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event10:AttachCallback(function(p: number, p2: number)
	local function fn(object)
		if object.State == GameStates.DifficultyVoting then
			object:SetTimeLeft(p, p2)
		end
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
event11:AttachCallback(function(p: number, p2: number)
	local function fn(object)
		if object.State == GameStates.LoadoutSelection then
			object:SetTimeLeft(p, p2)
		end
	end

	DispatchGameEvent(fn) -- inferred equivalent call
end)
return GameClass