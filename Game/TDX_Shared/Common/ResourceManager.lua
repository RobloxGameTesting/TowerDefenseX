local ResourceManager = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("CustomCodeTypes"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("WaveTypes"))
require(common:WaitForChild("MapTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("TowerBuffUtilities"))
require(common:WaitForChild("EnemyBuffUtilities"))
local MapUtilities = require(common:WaitForChild("MapUtilities"))
local isServer = RunService:IsServer()
local isCoreGame = workspace:GetAttribute("IsCoreGame")
local isLobby = workspace:GetAttribute("IsLobby")
local onDemandResources

if isServer then
	onDemandResources = ServerStorage:FindFirstChild("OnDemandResources") or nil
else
	onDemandResources = nil
end

local enemies = {
	CONTAINER_NAME = "OnDemandResources",
	REQUEST_MAX_KEYS = 50,
	RATE = 20,
	BURST = 40,
	TIMEOUT = 15,
	EXPECTED_TIMEOUT = 30,
	MAX_WAIT = 90
}
local v = { ColorSkins = "ColorSkins", MeshPartSkins = "MeshPartSkins", ModelSkins = "ModelSkins" }
local resources = common:WaitForChild("Resources")
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = {}
local v8 = {}
local v9 = {}
local v10 = {}
local v11 = {}
local v12 = {}
local v13 = {}
local v14 = {}
local v15 = {}
local v16 = {}
local childrenByName = {}
local childrenByName2 = {}
local childrenByName3 = {}
local childrenByName4 = {}
local v17 = {}
local v18 = {}
local v19 = {}
local v20 = {}
local childrenByName5 = {}
local childrenByName6 = {}
local childrenByName7 = {}
local v21 = {}
local v22 = {}
local v23 = {}
local v24 = {}
local v25 = {}
local v26 = {}
local v27 = {}
local v28 = {}
local internals = {}
local internals2 = {}
local childrenByName8 = {}
local childrenByName9 = {}
local v29 = {}
local v30 = {}
local v31 = {}
local modulesByName = {}
local childrenByName10 = {}
local childrenByName11 = {}
local mapVotingLobby = nil
local v32 = nil
local v33 = nil
local v34 = nil
local v35 = nil
local v36 = {}
local childrenByName12 = {}
local v37 = {}
local childrenByName13 = {}
local v38 = {}
local v39 = {}
local v40 = {
	TowerSkin = "TowerSkin",
	PathEntitySkin = "PathEntitySkin",
	CutsceneModel = "CutsceneModel",
	Enemy = "Enemy"
}
local v41 = {}
local v42 = {
	Loaded = {},
	Requested = {},
	Unavailable = {},
	Waiters = {},
	Expected = {},
	Queued = {},
	FlushScheduled = false,
	RegisteringEarly = false,
	Container = nil
}
local ListenForTowerSkinSets
local ListenForEnemyModels

local function FlushPendingRegistrations(p: string, childName: string?) -- 2 equivalent calls inferred from this helper
	for k, v43 in pairs(v41[p] or {}) do
		if not (not childName or k.Name == childName or k.Name == "Variants_" .. childName or k:FindFirstChild(childName)) then
			continue
		end

		v43()
	end
end

local function GetRequestKey(p: string, p2: string)
	return p .. ":" .. p2
end

local function ResolveOnDemandWaiters(p: string, flag: boolean)
	local waiter = v42.Waiters[p]

	if not waiter then
		return
	end

	v42.Waiters[p] = nil

	for _, callback in ipairs(table.clone(waiter)) do
		task.spawn(callback, flag)
	end

	table.clear(waiter)
end

local function MarkOnDemandLoaded(p: string) -- 2 equivalent calls inferred from this helper
	if v42.RegisteringEarly then
		return
	end

	v42.Loaded[p] = true
	ResolveOnDemandWaiters(p, true)
end

local function GetTowerKey(name: string, p: number, p2: number, pathLockLevel: number) -- 4 equivalent calls inferred from this helper
	if p2 == 0 then
		return name .. "Base"
	end

	if p2 < pathLockLevel then
		return name .. "L" .. p2
	end

	assert(p ~= nil, "Upgrade path index was not provided")
	assert(p2 ~= nil, "Level was not provided")
	return name .. "P" .. tostring(p) .. "L" .. tostring(p2)
end

local function GetTowerSkinKey(p: string, p2: number, p3: number, p4: number, p5: string) -- 2 equivalent calls inferred from this helper
	return GetTowerKey(p, p2, p3, p4) .. "__" .. p5 -- inferred equivalent call
end

local function GetTowerColorSkinKey(name: string, name2: string) -- 3 equivalent calls inferred from this helper
	return name .. "__" .. name2
end

local function GetStaticEntitySkinKey(name: string, name2: string, p: number?, p2: number?)
	if p then
		name ..= "_" .. tostring(p)
	end

	if p2 then
		name ..= "_" .. tostring(p2)
	end

	return name .. "__" .. name2
end

local function GetStaticEntityColorSkinKey(name: string, name2: string)
	return name .. "__" .. name2
end

local function GetPathEntitySkinKey(p: string, p2: string) -- 2 equivalent calls inferred from this helper
	return p .. "__" .. p2
end

local function GetResource(p, p2: string, p3: string?, p4: number?)
	local v43 = p[p2]

	if v43 then
		if p4 and typeof(v43) == "table" then
			return v43[p4 % #v43 + 1]
		end

		return v43
	elseif p3 then
		warn(p3)
	end
end

local function CloneResource(p, p2: string, p3: string?, value: number?) -- 4 equivalent calls inferred from this helper
	local v43 = p[p2]

	if v43 then
		if typeof(v43) == "table" then
			v43 = v43[(value or 0) % #v43 + 1]
		end

		return v43:Clone()
	elseif p3 then
		warn(p3)
	end
end

function ResourceManager.GetEnemyConfig(p: string)
	return GetResource(v2, p, "Could not find enemy config with name " .. p)
end

function ResourceManager.HasEnemyConfig(p: string)
	return v2[p] ~= nil
end

function ResourceManager.FindEnemyConfig(p: string)
	return v2[p]
end

function ResourceManager.GetEnemyConfigNames()
	local result = {}

	for k in pairs(v2) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetSortedPVPEnemyLoadout(list)
	local result = {}
	local v43 = {}

	for _, v44 in ipairs(list) do
		if v44 == "" then
			continue
		end

		local v45 = v2[v44]
		table.insert(result, v44)
		v43[v44] = {
			UnlockWave = not v45 and 0 or v45.UnlockWave or 0,
			SendCost = v45 and v45.SendCost or 0,
			InputOrder = #result
		}
	end

	table.sort(result, function(a: string, b: string)
		local v44 = v43[a]
		local v45 = v43[b]

		if v44.UnlockWave ~= v45.UnlockWave then
			return v44.UnlockWave < v45.UnlockWave
		end

		if v44.SendCost == v45.SendCost then
			return v44.InputOrder < v45.InputOrder
		end

		return v44.SendCost < v45.SendCost
	end)
	return result
end

function ResourceManager.GetTowerConfig(p: string)
	return GetResource(v3, p, "Could not find tower config with name " .. p)
end

function ResourceManager.HasTowerConfig(p: string)
	return v3[p] ~= nil
end

function ResourceManager.GetTowerConfigNames()
	local result = {}

	for k in pairs(v3) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetStaticEntityConfig(p: string)
	return GetResource(v4, p, "Could not find static entity config with name " .. p)
end

function ResourceManager.HasStaticEntityConfig(p: string)
	return v4[p] ~= nil
end

function ResourceManager.GetStaticEntityConfigNames()
	local result = {}

	for k in pairs(v4) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetPathEntityConfig(p: string)
	return GetResource(v5, p, "Could not find path entity config with name " .. p)
end

function ResourceManager.HasPathEntityConfig(p: string)
	return v5[p] ~= nil
end

function ResourceManager.GetPathEntityConfigNames()
	local result = {}

	for k in pairs(v5) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetAttachmentEntityConfig(p: string)
	return GetResource(v6, p, "Could not find attachment entity config with name " .. p)
end

function ResourceManager.TryGetEnemyClientCustomCodeClass(p: string)
	local v43 = childrenByName[p .. "_CustomCodeClass"]
	return v43 and require(v43)
end

function ResourceManager.TryGetTowerClientCustomCodeClass(p: string)
	local v43 = childrenByName2[p .. "_CustomCodeClass"]
	return v43 and require(v43)
end

function ResourceManager.TryGetPathEntityClientCustomCodeClass(p: string)
	local v43 = childrenByName3[p .. "_CustomCodeClass"]
	return v43 and require(v43)
end

function ResourceManager.TryGetMapClientCustomCodeClass(p: string)
	local v43 = childrenByName4[MapUtilities.GetResourceMapName(p) .. "_CustomCodeClass"]
	return v43 and require(v43)
end

function ResourceManager.GetEnemyAbilityConfig(p: string)
	return GetResource(v10, p, "Could not find enemy ability config with name " .. p)
end

function ResourceManager.HasEnemyAbilityConfig(p: string)
	return v10[p] ~= nil
end

function ResourceManager.GetEnemyAbilityConfigNames()
	local result = {}

	for k in pairs(v10) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetTowerAbilityConfig(p: string)
	return GetResource(v11, p, "Could not find tower ability config with name " .. p)
end

function ResourceManager.HasTowerAbilityConfig(p: string)
	return v11[p] ~= nil
end

function ResourceManager.GetTowerAbilityConfigNames()
	local result = {}

	for k in pairs(v11) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetPathEntityAbilityConfig(p: string)
	return GetResource(v12, p, "Could not find path entity ability config with name " .. p)
end

function ResourceManager.HasPathEntityAbilityConfig(p: string)
	return v12[p] ~= nil
end

function ResourceManager.GetPathEntityAbilityConfigNames()
	local result = {}

	for k in pairs(v12) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetEnemyModel(p: string, p2: number?)
	FlushPendingRegistrations("Enemy", p)
	return CloneResource(v17, p, "Could not find enemy model with name " .. p, p2)
end

function ResourceManager.HasEnemyModel(p: string)
	FlushPendingRegistrations("Enemy", p)
	return v17[p] ~= nil
end

function ResourceManager.GetEnemyModelDerivedHoverHeight(p: string, p2: number?)
	FlushPendingRegistrations("Enemy", p)
	local v44 = "Could not find enemy model with name " .. p
	local v45 = v17[p]

	if v45 then
		if p2 and typeof(v45) == "table" then
			v45 = v45[p2 % #v45 + 1]
		end
	else
		if v44 then
			warn(v44)
		end

		v45 = nil
	end

	return 1.5 * v45.PrimaryPart.Size.Y
end

function ResourceManager.GetPathEntityModelDerivedHoverHeight(p: string, p2: number?)
	local v44 = "Could not find path entity model with name " .. p
	local v45 = v20[p]

	if v45 then
		if p2 and typeof(v45) == "table" then
			v45 = v45[p2 % #v45 + 1]
		end
	else
		if v44 then
			warn(v44)
		end

		v45 = nil
	end

	return 1.5 * v45.PrimaryPart.Size.Y
end

function ResourceManager.GetTowerModel(p: string, p2: number, p3: number, p4: number)
	local towerKey = GetTowerKey(p, p2, p3, p4) -- inferred equivalent call
	return CloneResource(v18, towerKey, "Could not find tower model with name " .. towerKey), internals[towerKey] -- inferred equivalent call
end

function ResourceManager.ViewTowerModel(p: string, p2: number, p3: number, p4: number)
	local towerKey = GetTowerKey(p, p2, p3, p4) -- inferred equivalent call
	local v44 = "Could not find tower model with name " .. towerKey
	local v45 = v18[towerKey]

	if not v45 then
		if v44 then
			warn(v44)
		end

		v45 = nil
	end

	return v45, internals[towerKey]
end

function ResourceManager.GetTowerSkin(p: string, p2: number, p3: number, p4: number, p5: string)
	FlushPendingRegistrations("TowerSkin", p5)
	local towerColorSkinKey = GetTowerColorSkinKey(p, p5) -- inferred equivalent call

	if not (v28[towerColorSkinKey] and towerColorSkinKey) then
		towerColorSkinKey = GetTowerSkinKey(p, p2, p3, p4, p5) -- inferred equivalent call
	end

	local resource = CloneResource(v27, towerColorSkinKey, "Could not find tower skin " .. towerColorSkinKey) -- inferred equivalent call

	if resource then
		return resource, resource:GetAttribute("SkinType"), internals2[towerColorSkinKey]
	end

	return nil, nil, nil
end

function ResourceManager.ViewTowerSkin(p: string, p2: number, p3: number, p4: number, p5: string)
	FlushPendingRegistrations("TowerSkin", p5)
	local towerColorSkinKey = GetTowerColorSkinKey(p, p5) -- inferred equivalent call

	if not (v28[towerColorSkinKey] and towerColorSkinKey) then
		towerColorSkinKey = GetTowerSkinKey(p, p2, p3, p4, p5) -- inferred equivalent call
	end

	local v44 = "Could not find tower skin " .. towerColorSkinKey
	local v45 = v27[towerColorSkinKey]

	if not v45 then
		if v44 then
			warn(v44)
		end

		v45 = nil
	end

	if v45 then
		return v45, v45:GetAttribute("SkinType"), internals2[towerColorSkinKey]
	end

	return nil, nil, nil
end

function ResourceManager.ViewTowerSkinInternalData(p: string, p2: string)
	FlushPendingRegistrations("TowerSkin", p2)
	local v43 = p .. "__" .. p2
	return internals2[v28[v43] and v43 or (p .. "Base") .. "__" .. p2]
end

function ResourceManager.GetTowerSkinCustomViewport(p: string, p2: string)
	local viewTowerSkinInternalData = ResourceManager.ViewTowerSkinInternalData(p, p2)
	local customViewport = viewTowerSkinInternalData and viewTowerSkinInternalData:FindFirstChild("CustomViewport")

	if customViewport then
		return customViewport:Clone()
	end

	return nil
end

function ResourceManager.GetStaticEntitySkin(p: string, p2: string, p3: string, flag: boolean?)
	local v43 = p .. "__" .. p3
	local v44 = v30[v43] and v43 or p2 .. "__" .. p3
	local v45 = "Could not find static entity skin " .. v44

	if flag or not v45 then
		v45 = nil
	end

	local resource = CloneResource(v29, v44, v45) -- inferred equivalent call

	if resource then
		return resource, resource:GetAttribute("SkinType")
	end
end

function ResourceManager.GetStaticEntityModel(p: string, p2: number?)
	return CloneResource(v19, p, "Could not find static entity model with name " .. p, p2)
end

function ResourceManager.GetPathEntitySkin(_: string, p: string, p2: string, flag: boolean?)
	FlushPendingRegistrations("PathEntitySkin", false) -- inferred equivalent call
	local pathEntitySkinKey = GetPathEntitySkinKey(p, p2) -- inferred equivalent call
	local resource = CloneResource( -- inferred equivalent call
		v31,
		pathEntitySkinKey,
		not flag and "Could not find path entity skin " .. pathEntitySkinKey
	)

	if resource then
		return resource, resource:GetAttribute("SkinType")
	end
end

function ResourceManager.GetPathEntityModel(p: string, p2: number?)
	return CloneResource(v20, p, "Could not find path entity model with name " .. p, p2)
end

function ResourceManager.GetAttachmentEntityModel(p: string)
	return CloneResource(childrenByName5, p, "Could not find attachment entity model with name " .. p)
end

function ResourceManager.GetProjectileConfig(p: string)
	return GetResource(v21, p, "Could not find projectile config with name " .. p)
end

function ResourceManager.GetProjectileModel(p: string)
	return CloneResource(v22, p, "Could not find projectile model with name " .. p)
end

function ResourceManager.GetAllProjectileModels()
	return v22
end

function ResourceManager.GetProjectileSkinModel(p: string)
	return CloneResource(v23, p, "Could not find projectile skin model with name " .. p)
end

function ResourceManager.GetAllProjectileSkinModels()
	return v23
end

function ResourceManager.GetEmitOnceEffectConfig(p: string)
	return CloneResource(v24, p, "Could not find emit once effect with name " .. p)
end

function ResourceManager.GetAllEmitOnceEffectConfigs()
	return v24
end

function ResourceManager.GetContinuousEffectConfig(p: string)
	return CloneResource(v25, p, "Could not find continuous effect with name " .. p)
end

function ResourceManager.GetAllContinuousEffectConfigs()
	return v25
end

function ResourceManager.GetDeathEffectConfig(p: string)
	return CloneResource(v26, p, "Could not find death effect with name " .. p)
end

function ResourceManager.GetAllDeathEffectConfigs()
	return v26
end

function ResourceManager.GetEnemyBuffConfig(p: string)
	return GetResource(v13, p, "Could not find enemy buff config with name " .. p)
end

function ResourceManager.GetTowerBuffConfig(p: string)
	return GetResource(v14, p, "Could not find tower buff config with name " .. p)
end

function ResourceManager.HasTowerBuffConfig(p: string)
	return v14[p] ~= nil
end

function ResourceManager.GetTowerBuffConfigNames()
	local result = {}

	for k in pairs(v14) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.HasEnemyBuffConfig(p: string)
	return v13[p] ~= nil
end

function ResourceManager.GetRegularPowerUpConfig(p: string)
	return GetResource(v15, p, "Could not find regular power-up config with name " .. p)
end

function ResourceManager.HasRegularPowerUpConfig(p: string)
	return v15[p] ~= nil
end

function ResourceManager.GetRegularPowerUpConfigNames()
	local result = {}

	for k in pairs(v15) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetCustomPowerUpConfig(p: string)
	return GetResource(v16, p, "Could not find custom power-up config with name " .. p)
end

function ResourceManager.HasCustomPowerUpConfig(p: string)
	return v16[p] ~= nil
end

function ResourceManager.GetCustomPowerUpConfigNames()
	local result = {}

	for k in pairs(v16) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetEnemyBuffConfigNames()
	local result = {}

	for k in pairs(v13) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetTowerViewport(p: string)
	return CloneResource(childrenByName8, p, "Could not find tower viewport with name " .. p)
end

function ResourceManager.GetTowerAbilityViewport(p: string)
	return CloneResource(childrenByName9, p, "Could not find tower ability viewport with name " .. p)
end

function ResourceManager.GetWaveConfig(p: string)
	return GetResource(modulesByName, p, "Could not find waves config with difficulty " .. p)
end

function ResourceManager.GetWaveConfigNames()
	local result = {}

	for k in pairs(modulesByName) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetMiscResource(p: string, flag: boolean?)
	if flag then
		return GetResource(childrenByName10, p, "Could not find misc resource with name " .. p)
	end

	return CloneResource(childrenByName10, p, "Could not find misc resource with name " .. p)
end

function ResourceManager.GetMapVotingLobby()
	assert(isServer, "GetMapVotingLobby should only be called on server")
	return mapVotingLobby
end

function ResourceManager.GetMap(p: string)
	assert(isServer, "GetMap should only be called on server")
	local resourceMapName = MapUtilities.GetResourceMapName(p)
	return GetResource(childrenByName11, resourceMapName, "Could not find map with name " .. resourceMapName)
end

function ResourceManager.GetMapConfig(p: string)
	return GetResource(v7, MapUtilities.GetResourceMapName(p))
end

function ResourceManager.HasMapEntityConfig(p: string)
	return v8[p] ~= nil
end

function ResourceManager.GetMapEntityConfig(p: string)
	return GetResource(v8, p, "Could not find map entity config with name " .. p)
end

function ResourceManager.GetMapEntityConfigNames()
	local result = {}

	for k in pairs(v8) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetMapConfigNames()
	local result = {}

	for k in pairs(v7) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

function ResourceManager.GetMapEntityModel(p: string)
	return CloneResource(childrenByName6, p, "Could not find map entity model with name " .. p)
end

function ResourceManager.GetCutsceneConfig(p: string)
	return GetResource(v9, p, "Could not find cutscene config with name " .. p)
end

function ResourceManager.GetCutsceneModel(childName: string)
	FlushPendingRegistrations("CutsceneModel", childName) -- inferred equivalent call
	return CloneResource(childrenByName7, childName, "Could not find cutscene model with name " .. childName)
end

local function GetOrCreateFolder(parent, name: string) -- 5 equivalent calls inferred from this helper
	local v43 = parent:FindFirstChild(name)

	if not v43 then
		v43 = Instance.new("Folder")
		v43.Name = name
		v43.Parent = parent
	end

	return v43
end

local function CloneWithDescendantCount(instance, parent)
	local clone = instance:Clone()
	local count = 0

	for _, camera in pairs(clone:GetDescendants()) do
		if not (camera:IsA("Camera") or camera:FindFirstAncestorWhichIsA("Camera")) then
			count += 1
		end
	end

	clone:SetAttribute("OnDemandDescendantCount", count)
	clone.Parent = parent
end

local v43 = {
	RATE = 600,
	Queue = {},
	Queued = {},
	Batch = nil,
	BatchSources = {},
	Budget = 0,
	Connection = nil
}

function v43.Step(p: number)
	v43.Budget = math.min(v43.Budget + p * v43.RATE, v43.RATE)

	while v43.Queue[1] and v43.Budget > 0 do
		local v44 = table.remove(v43.Queue, 1)
		v43.Queued[v44.Source] = nil

		if v39[v44.Source] then
			continue
		end

		v39[v44.Source] = true
		v43.Budget -= #v44.Source:GetDescendants()
		CloneWithDescendantCount(v44.Source, v44.MirrorParent)
	end

	if not v43.Queue[1] and v43.Connection then
		v43.Connection:Disconnect()
		v43.Connection = nil
	end
end

local function ReplicateOnDemand(source, mirrorParent)
	if v39[source] then
		return
	end

	local batch = v43.Batch

	if batch then
		if not v43.BatchSources[source] then
			v43.BatchSources[source] = true
			table.insert(batch, { Source = source, MirrorParent = mirrorParent })
		end
	else
		v39[source] = true
		CloneWithDescendantCount(source, mirrorParent)
	end
end

function ResourceManager.ReplicateInBackground(callback, flag: boolean?)
	if v43.Batch then
		callback()
		return
	end

	local v44 = {}
	v43.Batch = v44
	local success, result = pcall(callback)
	v43.Batch = nil
	table.clear(v43.BatchSources)

	if not success then
		warn("ResourceManager: ReplicateInBackground failed:", result)
	end

	if flag then
		local v45 = {}

		for _, v46 in ipairs(v44) do
			v45[v46.Source] = true
			v43.Queued[v46.Source] = true
		end

		for _, v46 in ipairs(v43.Queue) do
			if not v45[v46.Source] then
				table.insert(v44, v46)
			end
		end

		v43.Queue = v44
	else
		for _, v45 in ipairs(v44) do
			if v43.Queued[v45.Source] then
				continue
			end

			v43.Queued[v45.Source] = true
			table.insert(v43.Queue, v45)
		end
	end

	if v43.Queue[1] and not v43.Connection then
		v43.Budget = 0
		v43.Connection = RunService.Heartbeat:Connect(v43.Step)
	end
end

function ResourceManager.CancelBackgroundReplication()
	table.clear(v43.Queue)
	table.clear(v43.Queued)
end

function ResourceManager.ReplicatePathEntitySkins(p: string?, p2: string?, p3: string?)
	if not onDemandResources or not p2 or p2 == "" then
		return
	end

	for k, v44 in pairs(childrenByName12) do
		local match, v45 = k:match("^([^_]+)_(.+)$")

		if v45 ~= p2 then
			continue
		end

		local v46 = not p or match == p or match == p3

		if not v46 and ResourceManager.HasTowerConfig(p) then
			local v47 = v37[p]

			if not v47 then
				v47 = ResourceManager.GetConfigReferencedStrings((ResourceManager.GetTowerConfig(p)))
				v37[p] = v47
			end

			v46 = v47[match] == true
		end

		if v46 then
			ReplicateOnDemand(v44, v33)
		end
	end
end

function ResourceManager.ReplicateTowerSkin(name: string, p: string?)
	if not onDemandResources or not p or p == "" then
		return
	end

	local source = v36[GetTowerColorSkinKey(name, p)] -- inferred equivalent call

	if source then
		local parent = GetOrCreateFolder(v32, name) -- inferred equivalent call
		ReplicateOnDemand(source, GetOrCreateFolder(parent, source.Parent.Name)) -- inferred equivalent call
	end

	ResourceManager.ReplicatePathEntitySkins(name, p)
end

function ResourceManager.ReplicateTowerSkinItem(value: string)
	local v44, v45 = unpack(value:split("_"))

	if v44 and v45 then
		ResourceManager.ReplicateTowerSkin(v44, v45)
	end
end

function ResourceManager.ReplicateCutsceneModel(p: string)
	if not onDemandResources then
		return
	end

	local source = childrenByName13[p]

	if source then
		ReplicateOnDemand(source, v34)
	end
end

function ResourceManager.ReplicateCutsceneSequence(p: string?)
	if not (onDemandResources and p) then
		return
	end

	local v44 = v9[p]

	if v44 then
		for _, v45 in ipairs(v44) do
			ResourceManager.ReplicateCutsceneModel(v45.Name)
		end
	end
end

function ResourceManager.ReplicateEnemyModel(p: string)
	if not onDemandResources then
		return
	end

	local source = v38[p]

	if source then
		ReplicateOnDemand(source, v35)
	end
end

function ResourceManager.ReplicateEnemy(overrideCharacterModelName: string)
	local v44 = v2[overrideCharacterModelName]
	local replicateEnemyModel = ResourceManager.ReplicateEnemyModel

	if v44 then
		overrideCharacterModelName = v44.OverrideCharacterModelName or overrideCharacterModelName
	end

	replicateEnemyModel(overrideCharacterModelName)
end

local function CollectEnemyReferences(p, options, p2)
	local v44 = {}
	local v45 = options or {}
	local v46 = { p }
	local v47 = { v10, v11, v21, v4, v5, v12 }

	local function Visit(value)
		if type(value) == "table" then
			table.insert(v46, value)
		elseif type(value) == "string" then
			if p2 then
				p2[value] = true
			end

			if v2[value] and not v45[value] then
				v45[value] = true
				table.insert(v44, value)
				table.insert(v46, v2[value])
			end

			for _, v48 in ipairs(v47) do
				if v48[value] then
					table.insert(v46, v48[value])
				end
			end
		end
	end

	local v48 = {}

	while #v46 > 0 do
		local v49 = table.remove(v46)

		if v48[v49] then
			continue
		end

		v48[v49] = true

		for k, v50 in pairs(v49) do
			Visit(k)
			Visit(v50)
		end
	end

	return v44
end

function ResourceManager.ReplicateDifficulty(p: string)
	local v44 = onDemandResources and modulesByName[p]

	if not v44 then
		return
	end

	local v45 = {}
	local v46 = {}

	for _, v47 in ipairs(v44.Waves or {}) do
		table.insert(v46, (CollectEnemyReferences(v47, v45)))
	end

	table.insert(v46, (CollectEnemyReferences(v44, v45)))
	ResourceManager.ReplicateCutsceneSequence(v44.IntroCutsceneSequence)

	for _, v47 in ipairs(v46[1]) do
		ResourceManager.ReplicateEnemy(v47)
	end

	ResourceManager.ReplicateInBackground(function()
		for i = 2, #v46 do
			for _, v47 in ipairs(v46[i]) do
				ResourceManager.ReplicateEnemy(v47)
			end
		end

		ResourceManager.ReplicateCutsceneSequence(v44.VictoryCutsceneSeqeuence)
	end)
end

function ResourceManager.GetDifficultyReferencedStrings(p: string)
	local v44 = {}
	local v45 = modulesByName[p]

	if v45 then
		CollectEnemyReferences(v45, nil, v44)
	end

	return v44
end

function ResourceManager.GetConfigReferencedStrings(p)
	local v44 = {}
	CollectEnemyReferences(p, nil, v44)
	return v44
end

function ResourceManager.PrefetchDifficulty(p: string)
	ResourceManager.ReplicateInBackground(function()
		ResourceManager.ReplicateDifficulty(p)
	end)
end

function ResourceManager.GetLoadoutSelectionTowers(p: string)
	local v44 = modulesByName[p]
	local loadoutSelectionData = v44 and v44.LoadoutSelectionData
	local v45 = {}
	local towers = {}

	if not loadoutSelectionData then
		return towers
	end

	for _, loadoutSelectionConfig in pairs(loadoutSelectionData.LoadoutSelectionConfigs) do
		for _, tower in pairs(loadoutSelectionConfig.Towers) do
			if v45[tower] then
				continue
			end

			v45[tower] = true
			table.insert(towers, tower)
		end
	end

	return towers
end

local v44 = {}
ResourceManager.CanRequestUnreleased = nil

local function IsUnreleasedFor(p, match: string, value: string)
	local parent = common.Parent
	local Shared = require(parent:WaitForChild("Modules"):WaitForChild("Shared"))

	if not Shared.IS_PROD_PLACE or RunService:IsStudio() then
		return false
	end

	local v45 = false

	if match == "Enemy" then
		for k, v46 in pairs(v2) do
			if (v46.OverrideCharacterModelName or k) ~= value then
				continue
			end

			if not v46.Unreleased then
				return false
			end

			v45 = true
		end
	elseif match == "TowerSkin" then
		local SkinUtilities = require(parent:WaitForChild("SkinData"):WaitForChild("SkinUtilities"))
		local match2, v46 = value:match("^(.-)__(.+)$")
		local v47 = match2 and SkinUtilities.GetSkinData(match2, v46)

		if v47 == nil then
			v45 = false
		else
			v45 = v47.Unreleased == true
		end
	end

	if not v45 then
		return false
	end

	local canRequestUnreleased = ResourceManager.CanRequestUnreleased
	return not (canRequestUnreleased and canRequestUnreleased(p, match, value))
end

local function GetPlayerOnDemandTarget(instance, value: string, screenGui)
	local match, v45 = value:match("^(%w+):(.+)$")

	if match == "TowerSkin" then
		local v46 = v36[v45]

		if v46 and not IsUnreleasedFor(instance, "TowerSkin", v45) then
			local parent = v46.Parent
			local parent2 = GetOrCreateFolder(screenGui:FindFirstChild("TowerSkins"), parent.Parent.Name) -- inferred equivalent call
			return v46, GetOrCreateFolder(parent2, parent.Name) -- inferred equivalent call
		end
	elseif match == "Enemy" then
		local v46 = v38[v45]

		if v46 and not IsUnreleasedFor(instance, "Enemy", v45) then
			return v46, screenGui:FindFirstChild("EnemyModels")
		end
	end

	return nil, nil
end

local function SetUpPlayerOnDemand(instance)
	if v44[instance] then
		return
	end

	v44[instance] = true
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "OnDemandResources"
	screenGui.ResetOnSpawn = false
	screenGui.Enabled = false

	for _, name in ipairs({ "TowerSkins", "EnemyModels" }) do
		local folder = Instance.new("Folder")
		folder.Name = name
		folder.Parent = screenGui
	end

	local remoteFunction = Instance.new("RemoteFunction")
	remoteFunction.Name = "Request"
	remoteFunction.Parent = screenGui
	local v45 = {}
	local v46 = 40
	local now = os.clock()

	local function TakeToken()
		while true do
			local now2 = os.clock()
			v46 = math.min(40, v46 + (now2 - now) * 20)
			now = now2

			if v46 >= 1 then
				break
			end

			task.wait((1 - v46) / 20)
		end

		v46 -= 1
	end

	remoteFunction.OnServerInvoke = function(p, list)
		local result = {}

		if p ~= instance or typeof(list) ~= "table" then
			return result
		end

		for i, v47 in ipairs(list) do
			if i > 50 then
				break
			end

			if typeof(v47) ~= "string" then
				continue
			end

			local v48, parent = GetPlayerOnDemandTarget(instance, v47, screenGui)

			if v48 and parent then
				if not v45[v48] then
					v45[v48] = true
					TakeToken()

					if not screenGui.Parent then
						return result
					end

					CloneWithDescendantCount(v48, parent)
				end

				result[v47] = true
			else
				result[v47] = false
			end
		end

		return result
	end

	screenGui.Parent = instance:WaitForChild("PlayerGui")
end

local function CanRequestOnDemand() -- 2 equivalent calls inferred from this helper
	return not isServer and resources:GetAttribute("ClientRequestsOnDemand") == true
end

local function GetPlayerOnDemandContainer()
	if v42.Container then
		return v42.Container
	end

	local onDemandResources2 = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("OnDemandResources", 15)

	if onDemandResources2 and not v42.Container then
		v42.Container = onDemandResources2
		ListenForTowerSkinSets(onDemandResources2:WaitForChild("TowerSkins"))
		ListenForEnemyModels(onDemandResources2:WaitForChild("EnemyModels"))
	end

	return v42.Container
end

local function TimeOutOnDemand(p: string, duration: number, fn, value: number?)
	task.delay(duration, function()
		if v42.Loaded[p] then
			return
		end

		local v45 = (value or 0) + duration

		if v45 < 90 then
			for _, v46 in pairs(v41) do
				if not next(v46) then
					continue
				end

				TimeOutOnDemand(p, duration, fn, v45)
				return
			end
		end

		warn(`ResourceManager: timed out waiting for {p}`)
		fn()
	end)
end

local function FlushOnDemandRequests()
	v42.FlushScheduled = false
	local queued = v42.Queued
	v42.Queued = {}
	local playerOnDemandContainer = GetPlayerOnDemandContainer()
	local request = playerOnDemandContainer and playerOnDemandContainer:FindFirstChild("Request")

	for i = 1, #queued, 50 do
		local v46 = table.move(queued, i, math.min(i + 50 - 1, #queued), 1, {})
		local success, result

		if request then
			success, result = pcall(request.InvokeServer, request, v46)
		else
			success = false
		end

		if not success then
			warn("ResourceManager: on-demand request failed:", result or "no request remote")
		end

		for _, v47 in ipairs(v46) do
			if success and typeof(result) == "table" then
				if result[v47] == true then
					local v48 = v47

					local function fn()
						v42.Requested[v48] = nil
						ResolveOnDemandWaiters(v48, false)
					end

					local v49 = nil
					local v50 = 15
					local v51 = v47
					task.delay(15, function()
						if v42.Loaded[v51] then
							return
						end

						local v52 = (v49 or 0) + v50

						if v52 < 90 then
							for _, v53 in pairs(v41) do
								if not next(v53) then
									continue
								end

								TimeOutOnDemand(v51, v50, fn, v52)
								return
							end
						end

						warn(`ResourceManager: timed out waiting for {v51}`)
						fn()
					end)
				else
					v42.Unavailable[v47] = true
					ResolveOnDemandWaiters(v47, false)
				end
			else
				v42.Requested[v47] = nil
				ResolveOnDemandWaiters(v47, false)
			end
		end
	end
end

local function IsOnDemandPending(p: string) -- 3 equivalent calls inferred from this helper
	return not (v42.Loaded[p] or v42.Unavailable[p]) and (CanRequestOnDemand() or v42.Expected[p] == true) -- inferred equivalent call
end

local function RequestOnDemandAsync(p: string)
	if v42.Loaded[p] then
		return true
	end

	if not IsOnDemandPending(p) then -- inferred equivalent call
		return false
	end

	local thread = coroutine.running()
	local threads = v42.Waiters[p] or {}
	v42.Waiters[p] = threads
	table.insert(threads, thread)

	if CanRequestOnDemand() then -- inferred equivalent call
		if not v42.Requested[p] then
			v42.Requested[p] = true
			table.insert(v42.Queued, p)

			if not v42.FlushScheduled then
				v42.FlushScheduled = true
				task.defer(FlushOnDemandRequests)
			end
		end
	elseif not v42.Requested[p] then
		v42.Requested[p] = true

		local function fn()
			v42.Requested[p] = nil
			v42.Expected[p] = nil
			ResolveOnDemandWaiters(p, false)
		end

		local v45 = nil
		local v46 = 30
		task.delay(30, function()
			if v42.Loaded[p] then
				return
			end

			local v47 = (v45 or 0) + v46

			if v47 < 90 then
				for _, v48 in pairs(v41) do
					if not next(v48) then
						continue
					end

					TimeOutOnDemand(p, v46, fn, v47)
					return
				end
			end

			warn(`ResourceManager: timed out waiting for {p}`)
			fn()
		end)
	end

	return coroutine.yield() == true
end

function ResourceManager.IsTowerSkinPending(p: string, p2: string?)
	if not p2 or p2 == "" then
		return false
	end

	return IsOnDemandPending("TowerSkin" .. ":" .. p .. "__" .. p2) -- inferred equivalent call
end

function ResourceManager.ExpectTowerSkin(p: string, p2: string?)
	if p2 and p2 ~= "" then
		v42.Expected["TowerSkin" .. ":" .. p .. "__" .. p2] = true
	end
end

function ResourceManager.RequestTowerSkinAsync(p: string, p2: string)
	return (RequestOnDemandAsync("TowerSkin" .. ":" .. p .. "__" .. p2))
end

function ResourceManager.IsEnemyModelPending(p: string)
	return IsOnDemandPending("Enemy" .. ":" .. p) -- inferred equivalent call
end

function ResourceManager.RequestEnemyModelAsync(p: string)
	return (RequestOnDemandAsync("Enemy" .. ":" .. p))
end

enemies = resources:WaitForChild("Enemies")
local towers = resources:WaitForChild("Towers")
local staticEntities = resources:WaitForChild("StaticEntities")
local pathEntities = resources:WaitForChild("PathEntities")
local attachmentEntities = resources:WaitForChild("AttachmentEntities")
local mapEntities = resources:WaitForChild("MapEntities")
local cutscenes = resources:WaitForChild("Cutscenes")
local projectiles = resources:WaitForChild("Projectiles")
local emitOnceVisualEffects = resources:WaitForChild("EmitOnceVisualEffects")
local continuousVisualEffects = resources:WaitForChild("ContinuousVisualEffects")
local deathEffects = resources:WaitForChild("DeathEffects")
local towerBuffs = resources:WaitForChild("TowerBuffs")
local enemyBuffs = resources:WaitForChild("EnemyBuffs")
local maps = resources:WaitForChild("Maps")
local client = resources:WaitForChild("CustomCode"):WaitForChild("Client")
local enemy = client:WaitForChild("Enemy")
local tower = client:WaitForChild("Tower")
local pathEntity = client:WaitForChild("PathEntity")
local map = client:WaitForChild("Map")
client = enemies:WaitForChild("Configs")
local configs = towers:WaitForChild("Configs")
local configs2 = staticEntities:WaitForChild("Configs")
local configs3 = pathEntities:WaitForChild("Configs")
local configs4 = attachmentEntities:WaitForChild("Configs")
local configs5 = mapEntities:WaitForChild("Configs")
local configs6 = cutscenes:WaitForChild("Configs")
local abilities = enemies:WaitForChild("Abilities")
local abilities2 = towers:WaitForChild("Abilities")
local abilities3 = pathEntities:WaitForChild("Abilities")
local configs7 = projectiles:WaitForChild("Configs")
local models = towers:WaitForChild("Models")
local models2 = staticEntities:WaitForChild("Models")
local models3 = pathEntities:WaitForChild("Models")
local models4 = attachmentEntities:WaitForChild("Models")
attachmentEntities = mapEntities:WaitForChild("Models")

local function GetOnDemandFolders(instance, childName: string)
	local child = onDemandResources and onDemandResources:FindFirstChild(instance.Name)
	local child2 = child and child:FindFirstChild(childName)

	if not onDemandResources then
		return instance:WaitForChild(childName), nil
	end

	return GetOrCreateFolder(instance, childName), child2 -- inferred equivalent call
end

local v45
v45, mapEntities = GetOnDemandFolders(cutscenes, "Models")
cutscenes = projectiles:WaitForChild("Models")
local skins = projectiles:WaitForChild("Skins")
local v46
v46, projectiles = GetOnDemandFolders(towers, "Skins")
local skins2 = staticEntities:WaitForChild("Skins")
local v47
v47, staticEntities = GetOnDemandFolders(pathEntities, "Skins")
v32 = v46
v33 = v47
v34 = v45

if onDemandResources then
	for _, v48 in {
		{ "Towers/Skins", projectiles },
		{ "PathEntities/Skins", staticEntities },
		{ "Cutscenes/Models", mapEntities }
	} do
		if not v48[2] then
			warn(`ResourceManager: ServerStorage.OnDemandResources has no {v48[1]} folder`)
		end
	end
end

local function WhenFullyReplicated(p: string, folder, fn)
	local onDemandDescendantCount = folder:GetAttribute("OnDemandDescendantCount")
	local count = #folder:GetDescendants()

	if not onDemandDescendantCount or onDemandDescendantCount <= count then
		fn()
		return
	end

	local v48 = -1
	local v49 = v41[p] or {}
	v41[p] = v49

	v49[folder] = function()
		if count == v48 then
			return
		end

		v48 = count
		warn(`ResourceManager: {folder:GetFullName()} used before it finished replicating`)
		v42.RegisteringEarly = true
		local success, result = pcall(fn)
		v42.RegisteringEarly = false

		if not success then
			warn(`ResourceManager: could not register partial {folder:GetFullName()}: {result}`)
		end
	end

	local descendantAddedConnection = nil
	descendantAddedConnection = folder.DescendantAdded:Connect(function()
		count += 1

		if onDemandDescendantCount <= count then
			descendantAddedConnection:Disconnect()
			v49[folder] = nil
			fn()
		end
	end)
end

local viewports = towers:WaitForChild("Viewports")
pathEntities = towers:WaitForChild("AbilityViewports")
towers = resources:WaitForChild("Waves")
local misc = resources:WaitForChild("Misc")

if isCoreGame and isServer then
	local LazyResourceSounds = require(common:WaitForChild("LazyResourceSounds"))

	for _, v48 in pairs({ models, models3, viewports }) do
		LazyResourceSounds.Strip(v48)
	end
end

if isLobby and isServer then
	for _, folder in pairs({ resources, onDemandResources }) do
		for _, descendant in pairs(folder:GetDescendants()) do
			if
				not (descendant:IsA("Sound") or descendant:IsA("ParticleEmitter"))
				or descendant:IsDescendantOf(misc)
			then
				continue
			end

			descendant:Destroy()
		end
	end
end

local function AddConfigs(instance, modulesByName2)
	for _, folder in pairs(instance:GetChildren()) do
		if folder:IsA("Folder") then
			for _, moduleScript in pairs(folder:GetChildren()) do
				local name = moduleScript.Name
				local module = require(moduleScript)
				modulesByName2[name] = module
			end
		else
			local name = folder.Name
			local module = require(folder)
			modulesByName2[name] = module
		end
	end
end

AddConfigs(client, v2)
AddConfigs(configs, v3)
AddConfigs(configs2, v4)
AddConfigs(configs3, v5)
AddConfigs(configs4, v6)
AddConfigs(configs5, v8)
AddConfigs(configs6, v9)
AddConfigs(abilities, v10)
AddConfigs(abilities2, v11)
AddConfigs(abilities3, v12)
AddConfigs(configs7, v21)
AddConfigs(towerBuffs, v14)
AddConfigs(enemyBuffs, v13)
AddConfigs(maps, v7)

local function AddPowerUpConfigs(instance, modulesByName2)
	if not instance then
		return
	end

	for _, child in pairs(instance:GetChildren()) do
		local config = child:FindFirstChild("Config")

		if not (config and config:IsA("ModuleScript")) then
			continue
		end

		local name = child.Name
		local module = require(config)
		modulesByName2[name] = module
	end
end

AddPowerUpConfigs(misc:FindFirstChild("RegularPowerUps"), v15)
AddPowerUpConfigs(misc:FindFirstChild("CustomTriggeredPowerUps"), v16)

local function CloneSound(instance, stringValue) -- 1 equivalent call inferred from this helper
	local clone = instance:Clone()
	clone.Parent = stringValue.Parent

	for _, child in pairs(stringValue:GetChildren()) do
		local clone_2 = child:Clone()
		clone_2.Parent = clone
	end

	local rename = stringValue:GetAttribute("Rename")

	if rename then
		clone.Name = rename
	end
end

local function CloneVFX(instance, stringValue)
	CloneSound(instance, stringValue) -- inferred equivalent call
end

local function GeneratePathLevelMapForTowerAutoPlacements(p: string, p2, instance)
	local result = {}

	for _, child in pairs(instance:GetChildren()) do
		local parts = child.Name:split("_")

		if #parts ~= 3 then
			continue
		end

		local part = parts[1]
		local v48 = parts[2]:gsub("P", "")
		local v49 = v48 and tonumber(v48)
		local parts2 = parts[3]:split("-")
		local v50 = tonumber(parts2[1])
		local v51 = tonumber(parts2[2] or parts2[1])

		if not (part and v49 and v50 and v51) then
			continue
		end

		for i = v50, v51 do
			if not result[part] then
				result[part] = {}
			end

			local towerKey = GetTowerKey(p, v49, i, p2.PathLockLevel) -- inferred equivalent call
			result[part][towerKey] = child
		end
	end

	return result
end

local function FindAutoPlacementInstance(p: string, stringValue, p2: string, p3, instance)
	if not instance then
		warn("Sounds folder was not found for " .. p2)
		return
	end

	local value = stringValue.Value
	local child

	if value:find("__Auto") then
		value = value:gsub("__Auto", "")
		local v48 = p3 and p3[value]

		if v48 then
			child = v48[p2]
		else
			warn("No auto-placement " .. p .. " found for " .. p2 .. ": " .. value)
			return
		end
	else
		child = instance:FindFirstChild(value)
	end

	if child then
		return child
	end

	warn(p .. " was not found for " .. p2 .. ": " .. value)
end

local function HandleAutoPlacements(folder, name: string, p: string, upgradePathData, internal)
	if not (isCoreGame and isServer) then
		return
	end

	local placeInAllModels = internal and internal:FindFirstChild("_PlaceInAllModels")
	local sounds = internal and internal:FindFirstChild("Sounds")
	local vfx = internal and internal:FindFirstChild("VFX")
	local v48 = sounds and GeneratePathLevelMapForTowerAutoPlacements(name, upgradePathData, sounds)
	local v49 = vfx and GeneratePathLevelMapForTowerAutoPlacements(name, upgradePathData, vfx)

	if placeInAllModels then
		for _, child in pairs(placeInAllModels:GetChildren()) do
			local clone = child:Clone()
			clone.Parent = folder
		end
	end

	for _, stringValue in pairs(folder:GetDescendants()) do
		if not stringValue:IsA("StringValue") then
			continue
		end

		if stringValue.Name == "SoundName" then
			local instance = FindAutoPlacementInstance("Sound", stringValue, p, v48, sounds)

			if instance then
				if instance:IsA("Sound") then
					CloneSound(instance, stringValue)
				elseif instance:IsA("Folder") then
					for _, child in pairs(instance:GetChildren()) do
						CloneSound(child, stringValue)
					end
				end

				stringValue:Destroy()
			end
		elseif stringValue.Name == "VFXName" then
			local instance = FindAutoPlacementInstance("VFX", stringValue, p, v49, vfx)

			if instance then
				if instance:IsA("ParticleEmitter") then
					CloneVFX(instance, stringValue)
				elseif instance:IsA("Folder") then
					for _, child in pairs(instance:GetChildren()) do
						CloneVFX(child, stringValue)
					end
				end

				stringValue:Destroy()
			end
		end
	end
end

for _, child in pairs(enemy:GetChildren()) do
	childrenByName[child.Name] = child
end

for _, child in pairs(tower:GetChildren()) do
	childrenByName2[child.Name] = child
end

for _, child in pairs(pathEntity:GetChildren()) do
	childrenByName3[child.Name] = child
end

for _, child in pairs(map:GetChildren()) do
	childrenByName4[child.Name] = child
end

local v48
v48, towerBuffs = GetOnDemandFolders(enemies, "Models")
v35 = v48

if onDemandResources and not towerBuffs then
	warn("ResourceManager: ServerStorage.OnDemandResources has no Enemies/Models folder")
end

local function GetEnemyModelName(p) -- 3 equivalent calls inferred from this helper
	return (p.Name:gsub("^Variants_", ""))
end

local function ForEachEnemyModelUnit(instance, fn)
	for _, folder in pairs(instance:GetChildren()) do
		if folder.Name:find("Variants_") then
			fn(folder, GetEnemyModelName(folder)) -- inferred equivalent call
		elseif folder:IsA("Folder") then
			ForEachEnemyModelUnit(folder, fn)
		else
			fn(folder, folder.Name)
		end
	end
end

local function RegisterEnemyModelUnit(instance, p: string)
	if instance.Name:find("Variants_") then
		local children = {}

		for i = 1, #instance:GetChildren() do
			local child = instance:FindFirstChild((tostring(i)))

			if not child then
				error("Could not find variant " .. i .. " for zombie type " .. p)
			end

			children[i] = child
		end

		v17[p] = children
	else
		if v17[p] and v17[p] ~= instance then
			warn("Duplicate enemy model found for " .. p)
		end

		v17[p] = instance
	end

	MarkOnDemandLoaded("Enemy" .. ":" .. p) -- inferred equivalent call
end

ForEachEnemyModelUnit(v48, function(p, p2: string)
	if isServer then
		RegisterEnemyModelUnit(p, p2)
	else
		WhenFullyReplicated("Enemy", p, function()
			RegisterEnemyModelUnit(p, p2)
		end)
	end
end)

if towerBuffs then
	ForEachEnemyModelUnit(towerBuffs, function(p, p2: string)
		v38[p2] = p

		if v17[p2] then
			v39[p] = true
		else
			RegisterEnemyModelUnit(p, p2)
		end
	end)
end

ListenForEnemyModels = function(instance)
	local function OnUnitAdded(p)
		WhenFullyReplicated("Enemy", p, function()
			RegisterEnemyModelUnit(p, GetEnemyModelName(p)) -- inferred equivalent call
		end)
	end

	instance.ChildAdded:Connect(OnUnitAdded)

	if instance ~= v48 then
		for _, child in pairs(instance:GetChildren()) do
			local v49 = child
			WhenFullyReplicated(v40.Enemy, child, function()
				RegisterEnemyModelUnit(v49, GetEnemyModelName(v49)) -- inferred equivalent call
			end)
		end
	end
end

if not isServer then
	ListenForEnemyModels(v48)
end

for _, child in pairs(models:GetChildren()) do
	local name = child.Name
	local towerConfig = ResourceManager.GetTowerConfig(name)

	if not towerConfig then
		continue
	end

	local upgradePathData = towerConfig.UpgradePathData
	local onePathOnly = upgradePathData.OnePathOnly
	local pathLockLevel = upgradePathData.PathLockLevel
	local v49 = #upgradePathData.Path1Data
	local useBaseRigMethod = child:GetAttribute("UseBaseRigMethod") or false
	local internal = child:FindFirstChild("_Internal")

	local function AddAttributes(instance) -- 1 equivalent call inferred from this helper
		instance:SetAttribute("UseBaseRigMethod", useBaseRigMethod)
		return instance
	end

	local function AddTowerModel(p: string, instance)
		HandleAutoPlacements(AddAttributes(instance), name, p, upgradePathData, internal) -- inferred equivalent call
		v18[p] = instance
		internals[p] = internal
	end

	local base = child:FindFirstChild("Base")
	local path1 = child:FindFirstChild("Path1")
	local path2 = not onePathOnly and child:FindFirstChild("Path2")
	assert(base ~= nil, "Base model was nil for " .. name)
	assert(path1 ~= nil, "Path1 folder was nil for " .. name)

	if not onePathOnly then
		assert(path2 ~= nil, "Path2 folder was nil for " .. name)
	end

	assert(pathLockLevel ~= nil, "PathLockLevel was nil for " .. name)
	AddTowerModel(GetTowerKey(name, 1, 0, pathLockLevel), base)

	for i = 1, pathLockLevel - 1 do
		local child2 = child:FindFirstChild((tostring(i)))

		if child2 then
			AddTowerModel(GetTowerKey(name, 1, i, pathLockLevel), child2)
		else
			warn("Did not find model for " .. name .. ": Level " .. tostring(i))
		end
	end

	for i = pathLockLevel, v49 do
		local child2 = path1:FindFirstChild((tostring(i)))

		if child2 then
			AddTowerModel(GetTowerKey(name, 1, i, pathLockLevel), child2)
		else
			warn("Did not find model for " .. name .. ": Path 1 Level " .. tostring(i))
		end

		if onePathOnly then
			continue
		end

		local child3 = path2:FindFirstChild((tostring(i)))

		if child3 then
			AddTowerModel(GetTowerKey(name, 2, i, pathLockLevel), child3)
		else
			warn("Did not find model for " .. name .. ": Path 2 Level " .. tostring(i))
		end
	end
end

local function TryGetSkinType(p, p2)
	if not v[p2.Name] then
		warn(`{p.Name} -> {p2.Name} is not a valid skin class`)
		return
	end

	if p2.Name == "ColorSkins" then
		return Enums.SkinTypes.ColorSkin
	end

	if p2.Name == "MeshPartSkins" then
		return Enums.SkinTypes.MeshPartSkin
	end

	if p2.Name == "ModelSkins" then
		return Enums.SkinTypes.ModelSkin
	end
end

local function RegisterTowerSkinSet(p, skinType: string, instance)
	local name = p.Name
	local upgradePathData = ResourceManager.GetTowerConfig(name).UpgradePathData
	local onePathOnly = upgradePathData.OnePathOnly
	local pathLockLevel = upgradePathData.PathLockLevel
	local v49 = #upgradePathData.Path1Data
	assert(pathLockLevel ~= nil, "PathLockLevel was nil for " .. name)

	if skinType == Enums.SkinTypes.ColorSkin then
		local name2 = instance.Name
		local internal = instance:FindFirstChild("_Internal")

		local function AddAttributes(instance2) -- 1 equivalent call inferred from this helper
			if not instance2:GetAttribute("SkinType") then
				instance2:SetAttribute("SkinType", skinType)
			end

			return instance2
		end

		local function AddTowerSkinModel(p2: string, instance2) -- 1 equivalent call inferred from this helper
			v27[p2] = AddAttributes(instance2) -- inferred equivalent call
			internals2[p2] = internal
			v28[p2] = true
		end

		AddTowerSkinModel(name .. "__" .. name2, instance) -- inferred equivalent call
	else
		local name2 = instance.Name
		local base = instance:FindFirstChild("Base")
		local path1 = instance:FindFirstChild("Path1")
		local path2 = not onePathOnly and instance:FindFirstChild("Path2")
		local useBaseRigMethod = instance:GetAttribute("UseBaseRigMethod") or false
		local internal = instance:FindFirstChild("_Internal")

		local function AddAttributes(instance2) -- 1 equivalent call inferred from this helper
			instance2:SetAttribute("UseBaseRigMethod", useBaseRigMethod)

			if not instance2:GetAttribute("SkinType") then
				instance2:SetAttribute("SkinType", skinType)
			end

			return instance2
		end

		local function AddTowerSkinModel(p2: string, p3: string, instance2) -- 4 equivalent calls inferred from this helper
			HandleAutoPlacements(AddAttributes(instance2), name, p2, upgradePathData, internal) -- inferred equivalent call
			v27[p3] = instance2
			internals2[p3] = internal
		end

		assert(base ~= nil, "Base model was nil for " .. name .. " skin " .. name2)
		assert(path1 ~= nil, "Path1 folder was nil for " .. name .. " skin " .. name2)

		if not onePathOnly then
			assert(path2 ~= nil, "Path2 folder was nil for " .. name .. " skin " .. name2)
		end

		AddTowerSkinModel(name .. "Base", (name .. "Base") .. "__" .. name2, base) -- inferred equivalent call

		for i = 1, pathLockLevel - 1 do
			local child = instance:FindFirstChild((tostring(i)))
			local v50

			if i == 0 then
				v50 = name .. "Base"
			elseif i < pathLockLevel then
				v50 = name .. "L" .. i
			else
				assert(true, "Upgrade path index was not provided")
				assert(i ~= nil, "Level was not provided")
				v50 = name .. "P" .. tostring(1) .. "L" .. tostring(i)
			end

			local v51

			if i == 0 then
				v51 = name .. "Base"
			elseif i < pathLockLevel then
				v51 = name .. "L" .. i
			else
				assert(true, "Upgrade path index was not provided")
				assert(i ~= nil, "Level was not provided")
				v51 = name .. "P" .. tostring(1) .. "L" .. tostring(i)
			end

			local v52 = v51 .. "__" .. name2

			if child then
				AddTowerSkinModel(v50, v52, child) -- inferred equivalent call
			else
				warn("Did not find model for skin with key " .. v52)
			end
		end

		for i = pathLockLevel, v49 do
			local child = path1:FindFirstChild((tostring(i)))
			local v50

			if i == 0 then
				v50 = name .. "Base"
			elseif i < pathLockLevel then
				v50 = name .. "L" .. i
			else
				assert(true, "Upgrade path index was not provided")
				assert(i ~= nil, "Level was not provided")
				v50 = name .. "P" .. tostring(1) .. "L" .. tostring(i)
			end

			local v51

			if i == 0 then
				v51 = name .. "Base"
			elseif i < pathLockLevel then
				v51 = name .. "L" .. i
			else
				assert(true, "Upgrade path index was not provided")
				assert(i ~= nil, "Level was not provided")
				v51 = name .. "P" .. tostring(1) .. "L" .. tostring(i)
			end

			local v52 = v51 .. "__" .. name2

			if child then
				AddTowerSkinModel(v50, v52, child) -- inferred equivalent call
			else
				warn("Did not find model for skin with key " .. v52)
			end

			if onePathOnly then
				continue
			end

			local child2 = path2:FindFirstChild((tostring(i)))
			local v53

			if i == 0 then
				v53 = name .. "Base"
			elseif i < pathLockLevel then
				v53 = name .. "L" .. i
			else
				assert(true, "Upgrade path index was not provided")
				assert(i ~= nil, "Level was not provided")
				v53 = name .. "P" .. tostring(2) .. "L" .. tostring(i)
			end

			local v54

			if i == 0 then
				v54 = name .. "Base"
			elseif i < pathLockLevel then
				v54 = name .. "L" .. i
			else
				assert(true, "Upgrade path index was not provided")
				assert(i ~= nil, "Level was not provided")
				v54 = name .. "P" .. tostring(2) .. "L" .. tostring(i)
			end

			local v55 = v54 .. "__" .. name2

			if child2 then
				AddTowerSkinModel(v53, v55, child2) -- inferred equivalent call
			else
				warn("Did not find model for skin with key " .. v55)
			end
		end
	end

	MarkOnDemandLoaded("TowerSkin" .. ":" .. name .. "__" .. instance.Name) -- inferred equivalent call
end

local function RegisterTowerSkinsFolder(instance)
	local children = {}

	for _, child in pairs((instance:GetChildren())) do
		for _, child2 in pairs((child:GetChildren())) do
			local tryGetSkinType = TryGetSkinType(child, child2)

			if not tryGetSkinType then
				continue
			end

			for _, child3 in pairs((child2:GetChildren())) do
				RegisterTowerSkinSet(child, tryGetSkinType, child3)
				table.insert(children, child3)
			end
		end
	end

	return children
end

if isServer then
	RegisterTowerSkinsFolder(v46)
end

if projectiles then
	for _, v49 in pairs((RegisterTowerSkinsFolder(projectiles))) do
		local parent = v49.Parent
		local parent2 = parent.Parent
		v36[GetTowerColorSkinKey(parent2.Name, v49.Name)] = v49
		local child = v46:FindFirstChild(parent2.Name)
		local child2 = child and child:FindFirstChild(parent.Name)

		if child2 and child2:FindFirstChild(v49.Name) then
			v39[v49] = true
		end
	end
end

ListenForTowerSkinSets = function(folder)
	local function OnSkinSetAdded(descendant)
		local parent = descendant.Parent
		local parent2 = parent and parent.Parent

		if not parent2 or parent2.Parent ~= folder then
			return
		end

		local tryGetSkinType = TryGetSkinType(parent2, parent)

		if tryGetSkinType then
			WhenFullyReplicated("TowerSkin", descendant, function()
				RegisterTowerSkinSet(parent2, tryGetSkinType, descendant)
			end)
		end
	end

	folder.DescendantAdded:Connect(OnSkinSetAdded)

	for _, descendant in pairs(folder:GetDescendants()) do
		OnSkinSetAdded(descendant)
	end
end

if not isServer then
	ListenForTowerSkinSets(v46)
end

for _, child in pairs(skins2:GetChildren()) do
	local name = child.Name

	for _, child2 in pairs((child:GetChildren())) do
		local tryGetSkinType = TryGetSkinType(child, child2)

		if not tryGetSkinType then
			continue
		end

		local function AddAttributes(instance) -- 1 equivalent call inferred from this helper
			if not instance:GetAttribute("SkinType") then
				instance:SetAttribute("SkinType", tryGetSkinType)
			end

			return instance
		end

		local function AddStaticEntitySkinModel(p: string, instance)
			v29[p] = AddAttributes(instance) -- inferred equivalent call
			v30[p] = true
		end

		if tryGetSkinType == Enums.SkinTypes.ColorSkin then
			for _, child3 in pairs((child2:GetChildren())) do
				AddStaticEntitySkinModel(GetStaticEntityColorSkinKey(name, child3.Name), child3)
			end
		else
			for _, folder in pairs((child2:GetChildren())) do
				local name2 = folder.Name

				if folder:IsA("Folder") then
					local base = folder:FindFirstChild("Base")
					local path1 = folder:FindFirstChild("Path1")
					local path2 = folder:FindFirstChild("Path2")
					assert(base ~= nil, "Base model was nil for " .. name .. " skin " .. name2)
					assert(path1 ~= nil, "Path1 folder was nil for " .. name .. " skin " .. name2)
					assert(path2 ~= nil, "Path2 folder was nil for " .. name .. " skin " .. name2)
					AddStaticEntitySkinModel(GetStaticEntitySkinKey(name, name2, nil, 0), base)

					for _, model in pairs(folder:GetChildren()) do
						if model:IsA("Model") and model.Name ~= "Base" then
							AddStaticEntitySkinModel(
								GetStaticEntitySkinKey(name, name2, nil, tonumber(model.Name)),
								model
							)
						end
					end

					for _, child3 in pairs(path1:GetChildren()) do
						AddStaticEntitySkinModel(GetStaticEntitySkinKey(name, name2, 1, tonumber(child3.Name)), child3)
					end

					for _, child3 in pairs(path2:GetChildren()) do
						AddStaticEntitySkinModel(GetStaticEntitySkinKey(name, name2, 2, tonumber(child3.Name)), child3)
					end
				else
					AddStaticEntitySkinModel(GetStaticEntitySkinKey(name, name2), folder)
				end
			end
		end
	end
end

local function RegisterPathEntitySkinsFolder(instance)
	local parts = instance.Name:split("_")
	local _ = parts[1]
	local part = parts[2]

	for _, child in pairs((instance:GetChildren())) do
		local tryGetSkinType = TryGetSkinType(instance, child)

		if not tryGetSkinType then
			continue
		end

		local function AddAttributes(instance2) -- 1 equivalent call inferred from this helper
			if not instance2:GetAttribute("SkinType") then
				instance2:SetAttribute("SkinType", tryGetSkinType)
			end

			return instance2
		end

		local function AddPathEntitySkinModel(p: string, child2) -- 1 equivalent call inferred from this helper
			v31[p] = AddAttributes(child2) -- inferred equivalent call
		end

		if tryGetSkinType == Enums.SkinTypes.ColorSkin then
			for _, _ in pairs((child:GetChildren())) do
				warn("Color skins for path entities are not supported yet")
			end
		else
			for _, child2 in pairs((child:GetChildren())) do
				AddPathEntitySkinModel(GetPathEntitySkinKey(child2.Name, part), child2) -- inferred equivalent call
			end
		end
	end
end

for _, child in pairs((v47:GetChildren())) do
	if isServer then
		RegisterPathEntitySkinsFolder(child)
	else
		local v49 = child
		WhenFullyReplicated("PathEntitySkin", child, function()
			RegisterPathEntitySkinsFolder(v49)
		end)
	end
end

if staticEntities then
	for _, child in pairs((staticEntities:GetChildren())) do
		RegisterPathEntitySkinsFolder(child)
		childrenByName12[child.Name] = child

		if v47:FindFirstChild(child.Name) then
			v39[child] = true
		end
	end
end

if not isServer then
	v47.ChildAdded:Connect(function(child)
		WhenFullyReplicated("PathEntitySkin", child, function()
			RegisterPathEntitySkinsFolder(child)
		end)
	end)
end

local function RetrieveIfValue(objectValue) -- 7 equivalent calls inferred from this helper
	if objectValue:IsA("ObjectValue") then
		return objectValue.Value
	end

	return objectValue
end

local function HandlePathLevelModels(p, folder)
	local name = folder.Name

	if folder.Name:find("Variants_") then
		local v49 = folder.Name:gsub("Variants_", "")
		p[v49] = {}

		for i = 1, #folder:GetChildren() do
			local child = folder:FindFirstChild((tostring(i)))

			if not child then
				error("Could not find variant " .. i .. " for " .. v49)
			end

			local children = p[v49]
			child = RetrieveIfValue(child) -- inferred equivalent call
			children[i] = child
		end
	elseif folder:IsA("Folder") then
		for _, child in pairs(folder:GetChildren()) do
			if child.Name == "_Internal" then
				continue
			end

			if child:IsA("Folder") then
				for _, child2 in pairs(child:GetChildren()) do
					local v49 = name .. "_" .. child.Name:match("Path%s*(%S+)") .. "_" .. child2.Name
					child2 = RetrieveIfValue(child2) -- inferred equivalent call
					p[v49] = child2
				end
			elseif child.Name == "Base" then
				local v49 = name .. "_0"
				p[v49] = RetrieveIfValue(child) -- inferred equivalent call
				child = RetrieveIfValue(child) -- inferred equivalent call
				p[name] = child
			elseif child:IsA("Configuration") and folder.Parent.Name == "DeathEffects" then
				local name2 = child.Name
				child = RetrieveIfValue(child) -- inferred equivalent call
				p[name2] = child
			else
				local v49 = name .. "_" .. child.Name
				child = RetrieveIfValue(child) -- inferred equivalent call
				p[v49] = child
			end
		end
	else
		folder = RetrieveIfValue(folder) -- inferred equivalent call
		p[name] = folder
	end
end

for _, child in pairs(models2:GetChildren()) do
	HandlePathLevelModels(v19, child)
end

for _, child in pairs(models3:GetChildren()) do
	local function AddPathEntityModel(folder, name: string)
		if folder.Name:find("Variants_") then
			local v49 = folder.Name:gsub("Variants_", "")
			v20[v49] = {}

			for i = 1, #folder:GetChildren() do
				local child2 = folder:FindFirstChild((tostring(i)))

				if not child2 then
					error("Could not find variant " .. i .. " for path entity type " .. v49)
				end

				v20[v49][i] = child2
			end
		elseif folder:IsA("Folder") then
			for _, child2 in pairs(folder:GetChildren()) do
				if child2.Name ~= "_Internal" then
					AddPathEntityModel(child2, child2.Name)
				end
			end
		else
			if v20[name] then
				warn("Duplicate path entity model found for " .. name)
			end

			v20[name] = folder
		end
	end

	AddPathEntityModel(child, child.Name)
end

for _, child in pairs(models4:GetChildren()) do
	childrenByName5[child.Name] = child
end

for _, child in pairs(attachmentEntities:GetChildren()) do
	childrenByName6[child.Name] = child
end

for _, child in pairs(v45:GetChildren()) do
	childrenByName7[child.Name] = child
end

if mapEntities then
	for _, child in pairs(mapEntities:GetChildren()) do
		childrenByName7[child.Name] = child
		childrenByName13[child.Name] = child

		if v45:FindFirstChild(child.Name) then
			v39[child] = true
		end
	end
end

if not isServer then
	v45.ChildAdded:Connect(function(child)
		WhenFullyReplicated("CutsceneModel", child, function()
			childrenByName7[child.Name] = child
		end)
	end)
end

if isLobby and onDemandResources then
	resources:SetAttribute("ClientRequestsOnDemand", true)
	Players.PlayerAdded:Connect(SetUpPlayerOnDemand)
	Players.PlayerRemoving:Connect(function(player)
		v44[player] = nil
	end)

	for _, v49 in pairs(Players:GetPlayers()) do
		task.spawn(SetUpPlayerOnDemand, v49)
	end
end

for _, child in pairs(cutscenes:GetChildren()) do
	HandlePathLevelModels(v22, child)
end

for _, child in pairs(skins:GetChildren()) do
	HandlePathLevelModels(v23, child)
end

for _, child in pairs(emitOnceVisualEffects:GetChildren()) do
	HandlePathLevelModels(v24, child)
end

for _, child in pairs(continuousVisualEffects:GetChildren()) do
	HandlePathLevelModels(v25, child)
end

for _, child in pairs(deathEffects:GetChildren()) do
	HandlePathLevelModels(v26, child)
end

for _, childName in pairs(Enums.Towers) do
	local child = viewports:WaitForChild(childName, 5)

	if child then
		childrenByName8[child.Name] = child
	else
		warn("Viewport not found for", childName)
	end
end

for _, child in pairs(pathEntities:GetChildren()) do
	childrenByName9[child.Name] = child
end

for _, moduleScript in pairs(towers:GetChildren()) do
	local name = moduleScript.Name
	local module = require(moduleScript)
	modulesByName[name] = module
end

for _, child in pairs(misc:GetChildren()) do
	childrenByName10[child.Name] = child
end

if isCoreGame and isServer then
	local maps2 = ServerStorage:WaitForChild("Maps")

	for _, child in pairs(maps2:GetChildren()) do
		childrenByName11[child.Name] = child
	end

	mapVotingLobby = ServerStorage:FindFirstChild("MapVotingLobby")
		or workspace:WaitForChild("Game"):FindFirstChild("MapVotingLobby")

	if not mapVotingLobby then
		warn("MapVotingLobby was not found in ServerStorage or workspace.Game")
	end
end

return ResourceManager