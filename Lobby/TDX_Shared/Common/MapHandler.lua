local createVector = vector.create
local MapHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
require(common:WaitForChild("CustomCodeTypes"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local MapUtilities = require(common:WaitForChild("MapUtilities"))
local isStudio = RunService:IsStudio()
local isServer = RunService:IsServer()
local v = true
local mapVoting = nil
local map = nil
local v2 = nil
local isPVP = false
local pvpTeamCount = 2
local zones = nil
local raycastIgnore = nil
local normalRaycastIgnore = nil
local losIgnore = nil
local rangeDisplayHeight = nil
local map2 = nil
local Terrain = workspace.Terrain
local Gravity = workspace.Gravity
local Game = workspace:WaitForChild("Game")
local SpaceOccupiers = Game:WaitForChild("SpaceOccupiers")
local PlacementProbes = Game:WaitForChild("PlacementProbes")
local v3 = nil
local water = nil
local y = nil
local y2 = nil
local y3 = 1e999
local v4 = nil
local vector = Vector3.new()
local v5 = -10000
local v6 = 10000
local v7 = 10000
local v8 = -10000
local v9 = 10000
local v10 = -10000
local ambient = nil
local v11 = nil
local tintColor = nil
local disableWaterPlacement = false
local disableSmallShips = false
local disableAirplaneAbilities = false
local v12 = 0
local raycastParams = nil
local v13 = nil
local freeAimForPathTargeting = false
local children = {}
local lightingEffects = nil
local v14 = nil
local v15 = 1
local spawnLocations = {}
local v16 = {}

local function CalculateMapCenter(p: number, p2: number, p3: number, p4: number) -- 2 equivalent calls inferred from this helper
	return (Vector3.new((p + p2) / 2, v4, (p3 + p4) / 2))
end

local function CalculateGlobalMapCenter()
	local v17 = 1e999
	local v18 = -1e999
	local v19 = 1e999
	local v20 = -1e999

	for _, v21 in pairs(v16) do
		v17 = math.min(v17, v21.MinX)
		v18 = math.max(v18, v21.MaxX)
		v19 = math.min(v19, v21.MinZ)
		v20 = math.max(v20, v21.MaxZ)
	end

	return CalculateMapCenter(v17, v18, v19, v20) -- inferred equivalent call
end

local function TryGetMapCustomCodeClass(mapName: string)
	if not isServer then
		return ResourceManager.TryGetMapClientCustomCodeClass(mapName)
	end

	local resourceMapName = MapUtilities.GetResourceMapName(mapName)
	local child = ServerScriptService.Server.GameClass.ServerCustomCode.Maps:FindFirstChild(`{resourceMapName}_CustomCodeClass`)

	if child then
		return require(child)
	end

	return nil
end

local function LoadTerrainProperty(waterProperties, childName: string) -- 5 equivalent calls inferred from this helper
	local child = waterProperties:FindFirstChild(childName)

	if child then
		Terrain[childName] = child.Value
	end
end

local function AttemptSetMaterialColor(p, value: Color3) -- 1 equivalent call inferred from this helper
	return pcall(function()
		Terrain:SetMaterialColor(p, value)
	end)
end

local function LoadTerrain()
	if not isServer then
		warn("Loading terrain does not work on client")
	end

	local terrainRegion = map:FindFirstChildOfClass("TerrainRegion")

	if not terrainRegion then
		Terrain:Clear()
		return
	end

	if typeof(terrainRegion) ~= "Instance" or not terrainRegion:IsA("TerrainRegion") then
		warn("Expected TerrainRegion object as argument to Load")
		return
	end

	Terrain:PasteRegion(
		terrainRegion,
		Vector3int16.new(
			-math.floor(terrainRegion.SizeInCells.X / 2),
			-math.floor(terrainRegion.SizeInCells.Y / 2),
			-math.floor(terrainRegion.SizeInCells.Z / 2)
		),
		true
	)
	local waterProperties = terrainRegion:FindFirstChild("WaterProperties")

	if waterProperties then
		LoadTerrainProperty(waterProperties, "WaterColor") -- inferred equivalent call
		LoadTerrainProperty(waterProperties, "WaterReflectance") -- inferred equivalent call
		LoadTerrainProperty(waterProperties, "WaterTransparency") -- inferred equivalent call
		LoadTerrainProperty(waterProperties, "WaterWaveSize") -- inferred equivalent call
		LoadTerrainProperty(waterProperties, "WaterWaveSpeed") -- inferred equivalent call
	end

	local materialColors = terrainRegion:FindFirstChild("MaterialColors")

	if materialColors then
		for _, v17 in Enum.Material:GetEnumItems() do
			local child = materialColors:FindFirstChild(v17.Name)

			if child then
				AttemptSetMaterialColor(v17, child.Value) -- inferred equivalent call
			end
		end
	end
end

local function LoadLightingValues(object)
	for k, v17 in object:GetAttributes() do
		if Lighting[k] then
			Lighting[k] = v17
		else
			warn(tostring(k) .. " not found in Lighting")
		end
	end
end

local function LoadLightingServer()
	local lightingData = map:FindFirstChild("LightingData")

	if lightingData then
		LoadLightingValues(lightingData)
	end

	for _, child in pairs(Lighting:GetChildren()) do
		if not (child:IsA("Atmosphere") or child:IsA("Sky") or child:IsA("BloomEffect") or child:IsA("DepthOfFieldEffect") or child:IsA("SunRaysEffect")) then
			continue
		end

		child:Destroy()
	end

	local lightingEffects2 = map:FindFirstChild("LightingEffects")

	if not lightingEffects2 then
		return
	end

	lightingEffects2.Parent = Lighting
end

local function LoadLightingClient()
	for _, v17 in pairs(children) do
		local v18 = v17

		if pcall(function()
			v18.Parent = lightingEffects
		end) then
			continue
		end

		local v19 = v17
		pcall(function()
			v19.Parent = nil
		end)
	end

	children = {}
	lightingEffects = Lighting:FindFirstChild("LightingEffects")

	if lightingEffects then
		for _, child in pairs(lightingEffects:GetChildren()) do
			child.Parent = Lighting
			table.insert(children, child)
		end
	end
end

local function LoadEmittersClient()
	local emitters = {}

	for _, emitter in pairs(map:GetDescendants()) do
		if emitter:IsA("ParticleEmitter") and emitter.Enabled then
			table.insert(emitters, emitter)
		end
	end

	local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
	v14 = WrapperFactory.NewEmitterWrapper(nil, v15)
	v14:AddEmitters(emitters, v15, nil, true)
	v14:PlayContinuous()
end

local function LoadClouds() -- 2 equivalent calls inferred from this helper
	local cloudsConfig = map:FindFirstChild("CloudsConfig")

	if cloudsConfig then
		local clouds = Instance.new("Clouds")

		for k, v17 in cloudsConfig:GetAttributes() do
			clouds[k] = v17
		end

		clouds.Parent = workspace.Terrain
	end
end

local function RemoveDevelopmentStuff()
	local v17 = { "Game", "Terrain", "Camera" }

	for _, child in pairs(workspace:GetChildren()) do
		if not table.find(v17, child.Name) then
			child:Destroy()
		end
	end
end

local function LoadColorCorrectionEffect()
	local count = 0

	for _, colorCorrectionEffect in pairs(Lighting:GetChildren()) do
		if not (colorCorrectionEffect:IsA("ColorCorrectionEffect") and colorCorrectionEffect.Enabled) then
			continue
		end

		v11 = colorCorrectionEffect
		count += 1
	end

	if not v11 then
		v11 = Instance.new("ColorCorrectionEffect", Lighting)
		v11.TintColor = Color3.fromRGB(255, 255, 255)
	end

	tintColor = v11.TintColor
end

local function GetPathZoneInstances()
	local path = zones:WaitForChild("Path")

	for _, part in pairs(path:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		part.CanCollide = false
		part.AudioCanCollide = false
		part.CanTouch = false
		part.Transparency = 1
		part.Anchored = true
	end

	local children2 = path:GetChildren()

	if not path:GetAttribute("UsePathHighlight") then
		return children2
	end

	for _, v17 in pairs(v16) do
		if not v17.PathHighlightModel then
			continue
		end

		for _, child in pairs(v17.PathHighlightModel:GetChildren()) do
			table.insert(children2, child)
		end
	end

	return children2
end

local function GetRangeDisplayHeight() -- 1 equivalent call inferred from this helper
	local rangeDisplayHeight2 = zones:FindFirstChild("RangeDisplayHeight")

	if not rangeDisplayHeight2 then
		return v5 + 0.1
	end

	rangeDisplayHeight2.Transparency = 1
	return rangeDisplayHeight2.Position.Y
end

local function ProcessRangeDisplayHeightFolder()
	for _, part in pairs(rangeDisplayHeight:GetChildren()) do
		if not part:IsA("BasePart") then
			continue
		end

		part.CanCollide = false
		part.AudioCanCollide = false
		part.CanTouch = false
		part.Transparency = 1
		part.Anchored = true
	end

	raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = { rangeDisplayHeight }
	return raycastParams
end

local function GetOscillationData()
	local oscillationData = map2:FindFirstChild("OscillationData")

	if not oscillationData then
		return
	end

	v13 = {}

	for _, child in pairs(oscillationData:GetChildren()) do
		local weld = nil
		local weldPointer = child:FindFirstChild("WeldPointer")

		if weldPointer then
			if weldPointer:IsA("StringValue") then
				weld = Utilities.TryGetInstanceFromPath(map2, weldPointer.Value)
			elseif weldPointer:IsA("ObjectValue") then
				weld = weldPointer.Value
			end
		end

		local c0AnglePerSecond = Utilities.TryReadChildValue(child, "C0AnglePerSecond", (Vector3.new()))
		local c1AnglePerSecond = Utilities.TryReadChildValue(child, "C1AnglePerSecond", (Vector3.new()))

		if weld then
			table.insert(v13, {
				Weld = weld,
				C0AnglePerSecond = c0AnglePerSecond,
				C1AnglePerSecond = c1AnglePerSecond
			})
		else
			warn("GetOscillationData: weld not found")
		end
	end
end

local function LoadSpawnLocationsBase()
	table.clear(spawnLocations)

	for _, spawnLocation in pairs(map:GetChildren()) do
		if spawnLocation:IsA("SpawnLocation") then
			table.insert(spawnLocations, spawnLocation)
		end
	end
end

local function LoadSpawnLocationsServer()
	LoadSpawnLocationsBase()

	for _, v17 in pairs(spawnLocations) do
		local originalPosition = v17:GetAttribute("OriginalPosition")

		if not originalPosition then
			originalPosition = v17.Position
			v17:SetAttribute("OriginalPosition", originalPosition)
		end

		if isStudio then
			continue
		end

		local vector2 = Vector3.new(Utilities.ApplyVariance(0, 2), 0, Utilities.ApplyVariance(0, 2))
		v17.CFrame = CFrame.new(originalPosition + vector2) * CFrame.Angles(0, math.rad((math.random(0, 360))), 0)
	end
end

local function LoadSpawnLocationsClient()
	LoadSpawnLocationsBase()

	for _, v17 in pairs(spawnLocations) do
		local originalPosition = v17:GetAttribute("OriginalPosition")

		if originalPosition then
			v17.CFrame = CFrame.new(originalPosition)
		else
			print("LoadSpawnLocationsClient: OriginalPosition attribute not found")
		end
	end
end

local function GetChildWithTeam(instance, childName: string, p: number, flag: boolean?) -- 6 equivalent calls inferred from this helper
	return instance:FindFirstChild(childName .. "_Team" .. tostring(p))
		or not flag and instance:FindFirstChild(childName)
end

local function GenerateMapData(value: number?)
	local teamIndex = value or 1
	local folder = GetChildWithTeam(map, "Path", teamIndex, false) -- inferred equivalent call
	local stasisSpawnsFolder = GetChildWithTeam(map, "StasisSpawns", teamIndex, false) -- inferred equivalent call
	local proximityPromptsFolder = GetChildWithTeam(map, "ProximityPrompts", teamIndex, false) -- inferred equivalent call
	local nodesMinX = 1e999
	local nodesMaxX = -1e999
	local nodesMinZ = 1e999
	local nodesMaxZ = -1e999
	local nodesMinY = 1e999
	local nodesMaxY = -1e999

	for _, part in folder:GetDescendants() do
		if not part:IsA("BasePart") then
			continue
		end

		nodesMinX = math.min(nodesMinX, part.Position.X)
		nodesMaxX = math.max(nodesMaxX, part.Position.X)
		nodesMinZ = math.min(nodesMinZ, part.Position.Z)
		nodesMaxZ = math.max(nodesMaxZ, part.Position.Z)
		nodesMinY = math.min(nodesMinY, part.Position.Y)
		nodesMaxY = math.max(nodesMaxY, part.Position.Y)
	end

	v6 = math.min(v6, nodesMinY)
	v5 = math.max(v5, nodesMaxY)
	v12 = math.max(v12, nodesMaxY + (map:GetAttribute("CliffHeight") or 0))
	local childWithTeam = GetChildWithTeam(zones, "MapBounds", teamIndex, false) -- inferred equivalent call
	local minX, maxX, minZ, maxZ

	if childWithTeam then
		minX, maxX, minZ, maxZ = Utilities.GetBoundsXZ(childWithTeam)
	else
		minX = nodesMinX - 25
		maxX = nodesMaxX + 25
		minZ = nodesMinZ - 25
		maxZ = nodesMaxZ + 25
	end

	v7 = math.min(v7, minX)
	v8 = math.max(v8, maxX)
	v9 = math.min(v9, minZ)
	v10 = math.max(v10, maxZ)
	local mapCenter = CalculateMapCenter(nodesMinX, nodesMaxX, nodesMinZ, nodesMaxZ) -- inferred equivalent call
	local pathHighlightModel = GetChildWithTeam(map, "PathHighlight", teamIndex, false) -- inferred equivalent call
	local v17 = map:FindFirstChild("SpawnLocation" .. "_Team" .. tostring(teamIndex)) or false

	if v17 then
		v17.Neutral = false
		v17.TeamColor = TeamUtilities.GetTeamColor(teamIndex)
		v17.BrickColor = v17.TeamColor
	end

	v16[teamIndex] = {
		TeamIndex = teamIndex,
		NodesFolder = folder,
		StasisSpawnsFolder = stasisSpawnsFolder,
		ProximityPromptsFolder = proximityPromptsFolder,
		NodesMinX = nodesMinX,
		NodesMaxX = nodesMaxX,
		NodesMinZ = nodesMinZ,
		NodesMaxZ = nodesMaxZ,
		NodesMinY = nodesMinY,
		NodesMaxY = nodesMaxY,
		MinX = minX,
		MaxX = maxX,
		MinZ = minZ,
		MaxZ = maxZ,
		MapCenter = mapCenter,
		PathHighlight = nil,
		PathHighlightModel = pathHighlightModel,
		PathHighlightVisible = false,
		PathHighlightTransparencyMap = {}
	}
end

local function MapLoaded()
	isPVP = map:GetAttribute("IsPVP") or false
	pvpTeamCount = workspace:GetAttribute("PVPTeamCount") or 2
	zones = map:WaitForChild("Zones")
	raycastIgnore = map:FindFirstChild("RaycastIgnore")
	normalRaycastIgnore = map:FindFirstChild("NormalRaycastIgnore")
	losIgnore = map:FindFirstChild("LOSIgnore")
	rangeDisplayHeight = map:FindFirstChild("RangeDisplayHeight")
	map2 = map:WaitForChild("Map")
	ambient = map:FindFirstChild("Ambient")

	if isPVP then
		for i = 1, pvpTeamCount do
			GenerateMapData(i)
		end
	else
		GenerateMapData()
	end

	v3 = GetPathZoneInstances()

	if isServer then
		water = zones:WaitForChild("Water")
	else
		water = map:WaitForChild("Water")
	end

	local minHeight = zones:FindFirstChild("MinHeight")
	local maxHeight = zones:FindFirstChild("MaxHeight")
	local airUnitMaxHeight = zones:FindFirstChild("AirUnitMaxHeight")
	y = minHeight.Position.Y
	y2 = maxHeight.Position.Y
	minHeight.Transparency = 1
	maxHeight.Transparency = 1

	if airUnitMaxHeight then
		y3 = airUnitMaxHeight.Position.Y or 1e999
		airUnitMaxHeight.Transparency = 1
	end

	if rangeDisplayHeight then
		ProcessRangeDisplayHeightFolder()
	end

	v4 = GetRangeDisplayHeight() -- inferred equivalent call
	vector = CalculateGlobalMapCenter()
	disableWaterPlacement = map:GetAttribute("DisableWaterPlacement")
	disableSmallShips = map:GetAttribute("DisableSmallShips")
	disableAirplaneAbilities = map:GetAttribute("DisableAirplaneAbilities")
	freeAimForPathTargeting = map:GetAttribute("FreeAimForPathTargeting")

	if map:GetAttribute("Gravity") then
		workspace.Gravity = map:GetAttribute("Gravity")
	end

	if isServer then
		water.Parent = map
		LoadTerrain()
		LoadLightingServer()
		LoadClouds() -- inferred equivalent call
		LoadSpawnLocationsServer()
	else
		LoadColorCorrectionEffect()
		LoadLightingClient()
		GetOscillationData()
		LoadEmittersClient()
		LoadSpawnLocationsClient()
	end

	local mapName = workspace:GetAttribute("MapName")
	local tryGetMapCustomCodeClass = TryGetMapCustomCodeClass(mapName)

	if tryGetMapCustomCodeClass then
		local v17 = tryGetMapCustomCodeClass.New()

		if not isServer then
			v17:OnLoaded(map, ResourceManager.GetMapConfig(mapName), v15)
		end

		v2 = v17
	end
end

function MapHandler.LoadMapVotingLobby()
	mapVoting = ResourceManager.GetMapVotingLobby()
	assert(mapVoting, "Map voting lobby not found")
	mapVoting.Name = "MapVoting"
	mapVoting.Parent = Game
end

function MapHandler.LoadMap(mapName: string, flag: boolean)
	assert(isServer, "Map should be loaded on server")

	if mapVoting then
		mapVoting:Destroy()
		mapVoting = nil
	end

	map = Game:FindFirstChild(MapUtilities.GetResourceMapName(mapName))

	if not map then
		map = ResourceManager.GetMap(mapName)
		assert(map, "Map not found by resource manager")
		map.Parent = Game
	end

	map.Name = "Map"
	workspace:SetAttribute("MapName", mapName)
	MapLoaded()

	if flag ~= isPVP then
		warn(`Map {mapName} IsPVP attribute does not match loaded IsPVP value`)
	end
end

function MapHandler.UnloadMap()
	assert(isServer, "Map should be unloaded on server")

	if not map then
		return
	end

	if water and zones then
		water.Parent = zones
	end

	local lightingEffects2 = Lighting:FindFirstChild("LightingEffects")

	if lightingEffects2 then
		lightingEffects2.Parent = map
	end

	local clouds = Terrain:FindFirstChildOfClass("Clouds")

	if clouds then
		clouds:Destroy()
	end

	Terrain:Clear()
	workspace.Gravity = Gravity
	local mapName = workspace:GetAttribute("MapName")

	if mapName then
		map.Name = MapUtilities.GetResourceMapName(mapName)
	end

	local v17 = map
	local ServerStorage = game:GetService("ServerStorage")
	v17.Parent = ServerStorage:WaitForChild("Maps")
	map = nil
end

function MapHandler.GetIgnoreInstances()
	local result = { zones, raycastIgnore, SpaceOccupiers, PlacementProbes }

	for _, v17 in pairs(v16) do
		if v17.NodesFolder then
			table.insert(result, v17.NodesFolder)
		end
	end

	if rangeDisplayHeight then
		table.insert(result, rangeDisplayHeight)
	end

	if normalRaycastIgnore then
		table.insert(result, normalRaycastIgnore)
	end

	return result
end

function MapHandler.GetMapInstances()
	local result = { map2, Terrain, water }

	for _, v17 in pairs(v16) do
		if v17.PathHighlightModel then
			table.insert(result, v17.PathHighlightModel)
		end
	end

	if losIgnore then
		table.insert(result, losIgnore)
	end

	if normalRaycastIgnore then
		table.insert(result, normalRaycastIgnore)
	end

	return result
end

function MapHandler.GetLOSInstances()
	local result = { map2, Terrain, water }

	for _, v17 in pairs(v16) do
		if v17.PathHighlightModel then
			table.insert(result, v17.PathHighlightModel)
		end
	end

	if normalRaycastIgnore then
		table.insert(result, normalRaycastIgnore)
	end

	return result
end

function MapHandler.GetPlacementProbeInstances()
	local v17 = { map2, SpaceOccupiers }

	if losIgnore then
		table.insert(v17, losIgnore)
	end

	if normalRaycastIgnore then
		table.insert(v17, normalRaycastIgnore)
	end

	return v17
end

function MapHandler.GetPathZoneInstances()
	return v3
end

function MapHandler.GetWaterFolder()
	return water
end

function MapHandler.GetMinMaxHeight()
	return y, y2
end

function MapHandler.GetAirUnitMaxHeight()
	return y3
end

function MapHandler.GetRangeDisplayHeight()
	return v4
end

function MapHandler.GetRangeDisplayHeightAtXZ(p: number, p2: number)
	if not rangeDisplayHeight then
		return v4
	end

	local raycastResult = workspace:Raycast(Vector3.new(p, v4 + 200, p2), createVector(0, -400, 0), raycastParams)

	if raycastResult then
		return raycastResult.Position.Y
	end

	return v4
end

function MapHandler.GetPartitioningBounds()
	return v7, v8, v9, v10
end

function MapHandler.IsWithinTeamBounds(vector2: Vector3, p: number?)
	if not isPVP then
		return true
	end

	if not p then
		if isServer then
			return true
		else
			p = TeamUtilities.GetLocalPlayerTeamIndex()
		end
	end

	local v17 = v16[p]

	if not v17 then
		return true
	end

	return vector2.X >= v17.MinX and vector2.X <= v17.MaxX and vector2.Z >= v17.MinZ and vector2.Z <= v17.MaxZ
end

function MapHandler.GetCenter(flag: boolean?, p: number?)
	if not flag then
		return vector
	end

	local v17

	if isServer and not p then
		warn("MapHandler.GetCenter - Defaulting PVPTeamIndex to 1")
		v17 = 1
	else
		v17 = p or TeamUtilities.GetLocalPlayerTeamIndex()
	end

	local v18 = v16[v17]

	if v18 then
		return v18.MapCenter
	end

	return vector
end

function MapHandler.GetNodesMaxY()
	return v5
end

function MapHandler.GetNodesMinY()
	return v6
end

function MapHandler.ShowPathHighlight()
	local v17 = v16[TeamUtilities.GetLocalPlayerTeamIndex()]

	if not v17 or v17.PathHighlightVisible then
		return
	end

	if v17.PathHighlightModel then
		for _, part in pairs(v17.PathHighlightModel:GetDescendants()) do
			if not part:IsA("BasePart") then
				continue
			end

			if not v17.PathHighlightTransparencyMap[part] then
				v17.PathHighlightTransparencyMap[part] = part.Transparency
			end

			part.Transparency = 0
		end

		if not v17.PathHighlight then
			v17.PathHighlight = ResourceManager.GetMiscResource("PathHighlight")
		end

		v17.PathHighlight.Parent = v17.PathHighlightModel
		v17.PathHighlight.Enabled = true
	end

	v17.PathHighlightVisible = true
end

function MapHandler.HidePathHighlight()
	local v17 = v16[TeamUtilities.GetLocalPlayerTeamIndex()]

	if not (v17 and v17.PathHighlightVisible) then
		return
	end

	if v17.PathHighlightModel then
		for _, part in pairs(v17.PathHighlightModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Transparency = v17.PathHighlightTransparencyMap[part]
			end
		end

		v17.PathHighlight.Enabled = false
	end

	v17.PathHighlightVisible = false
end

function MapHandler.GetAmbientSound()
	return ambient
end

function MapHandler.CanPlaceOnWater()
	return not disableWaterPlacement
end

function MapHandler.CanPlaceSmallShip()
	return not disableSmallShips
end

function MapHandler.CanUseAirplaneAbilities()
	return not disableAirplaneAbilities
end

function MapHandler.GetFreeAimForPathTargeting()
	return freeAimForPathTargeting
end

function MapHandler.GetColorCorrectionEffect()
	if not v11 then
		warn("ColorCorrectionEffect not initialized")
	end

	return v11
end

function MapHandler.GetColorCorrectionDefaultTint()
	if not tintColor then
		warn("OriginalTintColor not initialized")
	end

	return tintColor
end

function MapHandler.GetAirspaceHeight()
	return v12
end

function MapHandler.GetNodesDataTable()
	local result = {}

	for _, v17 in pairs(v16) do
		local nodeParts = {}

		for _, child in pairs(v17.NodesFolder:GetChildren()) do
			if child:IsA("BasePart") then
				table.insert(nodeParts, child)
			elseif child:IsA("Model") or child:IsA("Folder") then
				local name = tonumber(child.Name)

				if name then
					for _, part in pairs(child:GetChildren()) do
						if not part:IsA("BasePart") then
							continue
						end

						if isServer then
							part.Name ..= name
						end

						table.insert(nodeParts, part)
					end
				else
					warn("Invalid item found in Nodes folder")
				end
			end
		end

		table.insert(result, { PVPTeamIndex = v17.TeamIndex, NodeParts = nodeParts })
	end

	return result
end

function MapHandler.GetOverrideActiveSpawns(value: number?)
	local activeSpawns = v16[value or 1].NodesFolder:GetAttribute("ActiveSpawns")

	if not activeSpawns then
		return
	end

	local v17 = string.split(activeSpawns, ",")
	local result = {}

	for _, v18 in pairs(v17) do
		table.insert(result, (tonumber(v18)))
	end

	return result
end

function MapHandler.GetStasisSpawns()
	local result = nil

	for k, v17 in pairs(v16) do
		if not v17.StasisSpawnsFolder then
			continue
		end

		result = result or {}

		for _, child in pairs(v17.StasisSpawnsFolder:GetChildren()) do
			local name = child.Name
			local v18 = result[name]

			if not v18 then
				v18 = {}
				result[name] = v18
			end

			table.insert(v18, {
				CFrame = child:GetPivot(),
				ExcludeDifficulties = string.split(child:GetAttribute("ExcludeDifficulties") or ""),
				PVPTeamIndex = k,
				PathIndex = child:GetAttribute("PathIndex")
			})
		end
	end

	return result
end

function MapHandler.GetSpawnLocation()
	local v17 = map
	local localPlayerTeamIndex, v18 = TeamUtilities.GetLocalPlayerTeamIndex()
	return GetChildWithTeam(v17, "SpawnLocation", localPlayerTeamIndex, v18) -- inferred equivalent call
		or map:FindFirstChildOfClass("SpawnLocation")
end

function MapHandler.GetCurrentMap()
	return map
end

function MapHandler.GetMapVotingLobby()
	return mapVoting
end

function MapHandler.GetProximityPrompts()
	local proximityPrompts = {}

	for _, v17 in pairs(v16) do
		if not v17.ProximityPromptsFolder then
			continue
		end

		for _, proximityPrompt in pairs(v17.ProximityPromptsFolder:GetDescendants()) do
			if proximityPrompt:IsA("ProximityPrompt") then
				table.insert(proximityPrompts, proximityPrompt)
			end
		end
	end

	return proximityPrompts
end

function MapHandler.DisableLightingEffects_Client()
	for _, v17 in pairs(children) do
		v17.Parent = lightingEffects
	end
end

function MapHandler.EnableLightingEffects_Client()
	for _, v17 in pairs(children) do
		v17.Parent = Lighting
	end
end

function MapHandler.DisableColorCorrectionEffects_Client()
	for _, colorCorrectionEffect in pairs(children) do
		if not (colorCorrectionEffect:IsA("ColorCorrectionEffect") and colorCorrectionEffect.Enabled) then
			continue
		end

		colorCorrectionEffect.Enabled = false
		colorCorrectionEffect:SetAttribute("OriginalEnabled", true)
	end

	if v11 then
		v11.Enabled = false
	end
end

function MapHandler.EnableColorCorrectionEffects_Client()
	for _, colorCorrectionEffect in pairs(children) do
		if
			colorCorrectionEffect:IsA("ColorCorrectionEffect")
			and colorCorrectionEffect:GetAttribute("OriginalEnabled")
		then
			colorCorrectionEffect.Enabled = true
		end
	end

	if v11 then
		v11.Enabled = true
	end
end

function MapHandler.Run_Client(p: number)
	if v13 then
		for _, v17 in pairs(v13) do
			local v18 = p * v17.C0AnglePerSecond
			local v19 = p * v17.C1AnglePerSecond
			v17.Weld.C0 *= CFrame.Angles(v18.X, v18.Y, v18.Z)
			v17.Weld.C1 *= CFrame.Angles(v19.X, v19.Y, v19.Z)
		end
	end

	if v2 then
		v2:ClientTick(p)
	end
end

function MapHandler.SetSpeedMultiplier_Client(p: number)
	v15 = p

	if v14 then
		v14:SpeedMultiplierChanged(p)
	end

	if v2 then
		v2:SpeedMultiplierChanged(p)
	end
end

function MapHandler.ToggleGameForCutscene_Client(flag: boolean)
	if not Game then
		warn("ToggleGameForCutscene_Client: GameFolder is nil")
	elseif flag ~= v then
		if flag then
			Game.Parent = workspace
		else
			Game.Parent = Lighting
			Terrain:Clear()
			local clouds = Terrain:FindFirstChildOfClass("Clouds")

			if clouds then
				clouds:Destroy()
			end
		end

		v = flag
	end
end

function MapHandler.LoadCutsceneLightingConfig_Client(p)
	LoadLightingValues(p)
end

function MapHandler.RemoveCutsceneLightingConfig_Client()
	local lightingData = map:FindFirstChild("LightingData")

	if lightingData then
		LoadLightingValues(lightingData)
	end
end

function MapHandler.ReloadTerrainAndClouds_Server()
	Terrain:Clear()
	LoadTerrain()
	local clouds = Terrain:FindFirstChildOfClass("Clouds")

	if clouds then
		clouds:Destroy()
	end

	LoadClouds() -- inferred equivalent call
end

function MapHandler.Restarted_Server()
	if v2 then
		v2:ServerRestarted()
	end
end

function MapHandler.MapInitialized_Server(p: string, p2: number)
	if v2 then
		v2:OnLoaded(map, ResourceManager.GetMapConfig(p), p2)
	end
end

function MapHandler.DifficultyChanged_Server(p: string)
	if v2 then
		v2:ServerDifficultyChanged(p)
	end
end

function MapHandler.Run_Server(p: number)
	if v2 then
		v2:ServerTick(p)
	end
end

function MapHandler.GameStateChanged_Server(p: string)
	if v2 then
		v2:ServerGameStateChanged(p)
	end
end

function MapHandler.GetMapCustomCodeStateData_Server()
	if v2 then
		return v2:ServerGetRewindStateData()
	end
end

function MapHandler.Rewinded_Server(p)
	if v2 then
		v2:ServerRewinded(p)
	end
end

function MapHandler.WaveChanged_Server(p: number)
	if v2 then
		v2:ServerWaveChanged(p)
	end
end

function MapHandler.EnemySpawned_Server(p)
	if v2 and v2.ServerEnemySpawned then
		v2:ServerEnemySpawned(p)
	end
end

if isServer then
	RemoveDevelopmentStuff()
else
	function MapHandler.ClientMapVotingLobbyLoaded()
		mapVoting = Game:WaitForChild("MapVoting")
	end

	function MapHandler.ClientMapLoaded()
		map = Game:WaitForChild("Map")
		MapLoaded()
	end
end

return MapHandler