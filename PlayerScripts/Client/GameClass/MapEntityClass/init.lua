local MapEntityClass = {}
MapEntityClass.__index = MapEntityClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local NetworkingUtilities = require(common:WaitForChild("NetworkingUtilities"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("WrapperFactory"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local DashedCircleUtilities = require(common:WaitForChild("DashedCircleUtilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local BaseClasses = script.Parent:WaitForChild("BaseClasses")
local CharacterClass = require(BaseClasses:WaitForChild("CharacterClass"))
local TowerClass = require(script.Parent:WaitForChild("TowerClass"))
local EnemyClass = require(script.Parent:WaitForChild("EnemyClass"))
require(script.Parent:WaitForChild("ProjectileHandler"))
local VisualEffectHandler = require(script.Parent:WaitForChild("VisualEffectHandler"))
local HealthHandlerClass = require(script:WaitForChild("HealthHandlerClass"))
local color = Color3.fromRGB(255, 158, 158)
local color2 = Color3.fromRGB(137, 255, 129)
local event = NetworkingHandler.GetEvent("MapEntityFactoryQueueUpdated")
local event2 = NetworkingHandler.GetEvent("MapEntityAliveStateChanged")
local event3 = NetworkingHandler.GetEvent("MapEntityHealthChanged")
local event4 = NetworkingHandler.GetEvent("MapEntityVisualEffect")
local v = {
	NetworkingHandler.GetEvent("MapEntityTargetChanged1"),
	NetworkingHandler.GetEvent("MapEntityTargetChanged2"),
	NetworkingHandler.GetEvent("MapEntityTargetChanged3"),
	NetworkingHandler.GetEvent("MapEntityTargetChanged4"),
	NetworkingHandler.GetEvent("MapEntityTargetChanged5")
}
local v2 = {
	NetworkingHandler.GetEvent("MapEntityAttack1"),
	NetworkingHandler.GetEvent("MapEntityAttack2"),
	NetworkingHandler.GetEvent("MapEntityAttack3"),
	NetworkingHandler.GetEvent("MapEntityAttack4"),
	NetworkingHandler.GetEvent("MapEntityAttack5")
}
local v3 = {}
local v4 = {}
local v5 = 0
local mapEntities = workspace:WaitForChild("Game"):WaitForChild("MapEntities")
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER
local v6 = false
local v7 = nil
local v8 = nil

local function MakeAttackClientDataTable(mapEntityConfig)
	if not mapEntityConfig.HasAttack then
		return
	end

	local result = {}

	for i, v9 in ipairs(mapEntityConfig.AttackData) do
		local projectileName = v9.IsProjectile and v9.ProjectileName
		result[i] = {
			AimTime = v9.AimTime or 0,
			IsBurst = v9.IsBurst or false,
			BurstSize = v9.BurstSize,
			BurstInterval = v9.BurstInterval,
			IsPiercing = v9.IsPiercing,
			Range = v9.Range,
			ReloadTime = v9.ReloadTime,
			DamageDelay = v9.DamageDelay,
			AttackIsProjectile = v9.IsProjectile,
			AttackProjectileConfig = projectileName and ResourceManager.GetProjectileConfig(projectileName),
			AttackAnimationSpeedMultiplier = 1,
			AttackBurstIndex = 1,
			TimeUntilResetAttackBurstIndex = 0,
			ClientHitEffectData = v9.ClientHitEffectData,
			CurrentTarget = nil,
			LatestAttackedTarget = nil,
			TimeSinceLastAttack = 1e999,
			CurrentTargetIsTower = false,
			TimeSinceLastHadTarget = 0
		}
	end

	return result
end

local function GetCharacter(hash: number, p: string, mapEntityConfig, cframe: CFrame) -- 1 equivalent call inferred from this helper
	local v9 = {
		Hash = hash,
		Type = p,
		EntityClass = "MapEntity",
		Config = mapEntityConfig,
		SpawnCFrame = cframe,
		Parent = mapEntities,
		NoSpawnTween = mapEntityConfig.NoTweenOnSpawn,
		TurretConfigs = mapEntityConfig.TurretConfigs
	}
	return CharacterClass.New(v9)
end

function MapEntityClass.New(list)
	assert(list, "InitData not provided")
	local hash = list[1]
	local v9 = list[2]
	local cframe = list[3]
	local isAlive = list[4]
	local v10 = list[5]
	local v11 = list[6]
	local uniqueId = list[7]
	local pvpTeamIndex = list[8]
	local v12 = v3[hash]

	if v12 then
		print("MapEntity already exists with hash", hash)
		v12:Destroy(true)
	end

	assert(hash, "MapEntity hash not provided")
	assert(v9, "MapEntity type not provided")
	assert(cframe, "SpawnCFrame not provided")
	local mapEntityConfig = ResourceManager.GetMapEntityConfig(v9)
	assert(mapEntityConfig, "MapEntity config not found for type " .. v9)
	local character = GetCharacter(hash, v9, mapEntityConfig, cframe) -- inferred equivalent call
	local healthHandler = mapEntityConfig.HasHealth and HealthHandlerClass.New(v10, v11)
	local v13 = mapEntityConfig.AttackData and mapEntityConfig.AttackData[1]
	local v14 = {
		UniqueId = uniqueId,
		Hash = hash,
		PVPTeamIndex = pvpTeamIndex,
		Type = v9,
		Position = cframe.Position,
		Config = mapEntityConfig,
		DisplayName = mapEntityConfig.OverrideDisplayName or v9,
		NoHoverTooltip = mapEntityConfig.NoHoverTooltip,
		CFrame = cframe,
		Character = character,
		Destroyed = false,
		IsAirUnit = false,
		NoRestartAttackAnimationIfPlaying = mapEntityConfig.NoRestartAttackAnimationIfPlaying,
		AttackerShouldFaceMovementDirection = mapEntityConfig.AttackerShouldFaceMovementDirection,
		TurretNoTrackTarget = mapEntityConfig.TurretNoTrackTarget,
		IsAlive = isAlive,
		ClientsideAttackTargetPathPosition = mapEntityConfig.ClientsideAttackTargetPathPosition,
		ClientsideAttackTargetTorsoPosition = mapEntityConfig.ClientsideAttackTargetTorsoPosition,
		HasTurret = character:HasTurret(),
		AttackClientDataTable = MakeAttackClientDataTable(mapEntityConfig),
		Range = v13 and v13.Range,
		DeathEffectInstanceNames = mapEntityConfig.DeathEffectInstanceNames,
		HealthHandler = healthHandler,
		PlacementDashedCircleData = nil,
		NearbyTowerBuffRadius = mapEntityConfig.NearbyTowerBuffRadius,
		NoDisplayBuffRadius = mapEntityConfig.NoDisplayBuffRadius,
		UserInputHovered = false
	}
	v3[v14.Hash] = v14
	v4[character:GetTorso()] = v14
	v5 += 1
	character:SetAnimationState("Idle")
	setmetatable(v14, MapEntityClass)
	return v14
end

function MapEntityClass.SpawnExistingMapEntities(list)
	for _, v9 in ipairs(list) do
		if not v3[v9[1]] then
			MapEntityClass.New(v9)
		end
	end
end

function MapEntityClass.GetMapEntity(p: number)
	return v3[p]
end

function MapEntityClass.GetMapEntities()
	return v3
end

function MapEntityClass.GetMapEntityByTorso(p)
	return v4[p]
end

function MapEntityClass.PlacementStarted()
	v6 = true
end

function MapEntityClass.PlacementStopped()
	v6 = false
end

function MapEntityClass.PlacementChanged(vector: Vector3, p: number)
	v7 = vector
	v8 = p
end

function MapEntityClass:SetSpeedMultiplier()
	DEFAULT_SPEED_MULTIPLIER = self

	for _, v9 in pairs(v3) do
		v9.Character:SetSpeedMultiplier(DEFAULT_SPEED_MULTIPLIER)
	end
end

function MapEntityClass.LogicLoop(p: number, p2: number)
	for _, v9 in pairs(v3) do
		v9:Logic(p, p2)
	end
end

function MapEntityClass:Logic(p: number, _: number)
	local character = self.Character
	local attackClientDataTable = self.AttackClientDataTable

	if attackClientDataTable then
		for _, v9 in pairs(attackClientDataTable) do
			v9.TimeSinceLastAttack += p

			if not v9.LatestAttackedTarget then
				continue
			end

			if v9.LatestAttackedTarget:Alive() then
				if v9.TimeSinceLastAttack >= v9.ReloadTime * 2 then
					v9.LatestAttackedTarget = nil
				end
			else
				v9.LatestAttackedTarget = nil
			end
		end
	end

	local v9 = attackClientDataTable and attackClientDataTable[1]

	if v9 then
		local _currentTarget = v9.CurrentTarget
	end

	local latestAttackedTarget = v9 and v9.LatestAttackedTarget

	if self.IsAlive then
		self:SetAnimationState("Idle")
	end

	if latestAttackedTarget and self.HasTurret and not self.TurretNoTrackTarget then
		if v9.CurrentTargetIsTower then
			self:FaceTower(1, latestAttackedTarget)
		else
			self:FaceEnemy(1, latestAttackedTarget)
		end
	end

	character:LerpCFrame(p, self.CFrame, true)
	character:Run(p)

	if attackClientDataTable then
		for _, v10 in pairs(attackClientDataTable) do
			if not v10.IsBurst then
				continue
			end

			v10.TimeUntilResetAttackBurstIndex -= p

			if v10.TimeUntilResetAttackBurstIndex <= 0 then
				v10.AttackBurstIndex = 1
			end
		end
	end

	if self.IsAlive and self.NearbyTowerBuffRadius then
		self:_UpdatePlacementDisplayDashedCircle()
	else
		self:_DestroyPlacementDashedCircle()
	end
end

function MapEntityClass:GetPosition()
	return self.Position
end

function MapEntityClass:GetTorsoPosition()
	return self.Character:GetRealTorso().Position
end

function MapEntityClass:FacePosition(vector: Vector3, p: number)
	if self.HasTurret then
		self.Character:AimTurretAtPosition(vector, p)
		return
	end

	local position = self:GetPosition()
	local vector2 = Vector3.new(vector.X, position.Y, vector.Z)
	self.CFrame = CFrame.new(position, vector2)

	if not self.Character:ShouldLerpRotation() then
		self.Character:SetCFrame(self.CFrame, true)
	end
end

function MapEntityClass:FaceEnemy(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPathPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function MapEntityClass:FaceTower(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function MapEntityClass:SetAnimationState(state: string)
	self.State = state
	self.Character:SetAnimationState(state)
end

function MapEntityClass:_RenderProjectileForAttack(_: number, _, _: boolean?)
	warn("TODO: MapEntityClass:_RenderProjectileForAttack")
end

function MapEntityClass:_HandleRenderHitEffect(p: number, object, vector: Vector3?)
	if not (object or vector) then
		warn("No goal position could be determined for rendering hit effect")
		return
	end

	local attackClientDataTable = self.AttackClientDataTable
	local v9 = attackClientDataTable and attackClientDataTable[p]
	local clientHitEffectData = v9 and v9.ClientHitEffectData

	if not clientHitEffectData then
		return
	end

	if self.AttackIsProjectile then
		warn("Projectile with ClientHitEffectData detected. Set hit effects in the projectile instead")
		return
	end

	local v10 = vector
		or (clientHitEffectData.TargetTorsoInsteadOfGround or object:GetIsAirUnit()) and object:GetTorsoPosition()
		or object:GetPosition()
	local randomOffsetPosition = ProjectileUtilities.RandomOffsetPosition(
		v10,
		clientHitEffectData.VarianceXZ,
		clientHitEffectData.VarianceY,
		clientHitEffectData.VarianceYOnlyDown
	)
	local v11 = {
		Name = clientHitEffectData.EffectName,
		Position = randomOffsetPosition,
		Delay = clientHitEffectData.Delay
	}
	VisualEffectHandler.NewVisualEffect(v11)
end

function MapEntityClass:Attack(p: number, latestAttackedTarget, flag: boolean?)
	local attackClientDataTable = self.AttackClientDataTable
	local v9 = attackClientDataTable and attackClientDataTable[p]

	if not v9 then
		return
	end

	if v9.AttackIsProjectile then
		self:_RenderProjectileForAttack(p, latestAttackedTarget, flag)
	elseif flag then
		self:FaceTower(p, latestAttackedTarget)
	else
		self:FaceEnemy(p, latestAttackedTarget)
	end

	v9.LatestAttackedTarget = latestAttackedTarget
	v9.TimeSinceLastAttack = 0
	v9.CurrentTargetIsTower = flag or false
	self:_Attacked(p)
	self:_HandleRenderHitEffect(p, latestAttackedTarget)
end

function MapEntityClass:TriggerAttackFromProjectileHandler(vector: Vector3, p: number?)
	self:FacePosition(vector, p)
	self:_Attacked()
end

function MapEntityClass:_Attacked(p: number)
	local character = self.Character
	local primaryAnimationHandler = self.Character.PrimaryAnimationHandler

	if
		primaryAnimationHandler
		and primaryAnimationHandler.Animations.Attack
		and (not self.NoRestartAttackAnimationIfPlaying or primaryAnimationHandler:GetState() ~= "Attack")
	then
		self:SetAnimationState("Attack")
	end

	character:Attacked(nil, p)
	self:_BurstAttackHandling(p)
end

function MapEntityClass._GetAttackBurstIndex(p, p2: number)
	local attackClientDataTable = p.AttackClientDataTable
	local v9 = attackClientDataTable and attackClientDataTable[p2]
	return v9 and v9.IsBurst and v9.AttackBurstIndex
end

function MapEntityClass:_BurstAttackHandling(p: number)
	local attackClientDataTable = self.AttackClientDataTable
	local v9 = attackClientDataTable and attackClientDataTable[p]

	if v9 and v9.IsBurst then
		v9.AttackBurstIndex += 1

		if v9.AttackBurstIndex > v9.BurstSize then
			v9.AttackBurstIndex = 1
		end

		v9.TimeUntilResetAttackBurstIndex = 2 * v9.BurstInterval
	end
end

function MapEntityClass:TargetChanged(p: number, p2: number, flag: boolean?)
	local attackClientDataTable = self.AttackClientDataTable
	local v9 = attackClientDataTable and attackClientDataTable[p]

	if not v9 then
		return
	end

	if p2 == 0 then
		v9.CurrentTarget = nil
		return
	end

	local currentTarget = flag and TowerClass.GetTower(p2) or EnemyClass.GetEnemy(p2)

	if not currentTarget then
		warn(`MapEntity TargetChanged: {flag and "Tower" or "Enemy"} doesn't exist`)
		return
	end

	v9.CurrentTarget = currentTarget
	v9.CurrentTargetIsTower = flag or false
end

function MapEntityClass.IsDestroyed(p)
	return p.Destroyed
end

function MapEntityClass:Destroy(flag: boolean?)
	if not flag then
		self.Character:MapEntityDeath()
	end

	self.Destroyed = true
	self.Character:SetFadeOutOnDeath(not flag)
	self.Character:Destroy(flag)
	v3[self.Hash] = nil
	v4[self.Character:GetTorso()] = nil
	v5 -= 1
end

function MapEntityClass:Alive()
	return self.IsAlive
end

function MapEntityClass:SetAlive(p)
	local isAlive = p.IsAlive
	local character = self.Character
	local primaryAnimationHandler = character.PrimaryAnimationHandler
	self.IsAlive = isAlive

	if not isAlive then
		character:MapEntityDeath()

		if primaryAnimationHandler and primaryAnimationHandler:GetAnimation("Death") then
			self:SetAnimationState("Death")
		end
	end
end

function MapEntityClass:GetIsAirUnit()
	return self.IsAirUnit
end

function MapEntityClass:SetHealth(p: number, p2: number)
	self.HealthHandler:SetHealth(p)
	self.HealthHandler:SetMaxHealth(p2)
end

function MapEntityClass.GetAttackerShouldFaceMovementDirection(p)
	return p.AttackerShouldFaceMovementDirection
end

function MapEntityClass:_UpdatePlacementDisplayDashedCircle()
	if self.NoDisplayBuffRadius then
		return
	end

	local placementDashedCircleData = self.PlacementDashedCircleData

	if v6 and v7 then
		local nearbyTowerBuffRadius = self.NearbyTowerBuffRadius
		local position = self:GetPosition()
		local v9

		if (Vector3.new(position.X, 0, position.Z) - Vector3.new(v7.X, 0, v7.Z)).Magnitude <= nearbyTowerBuffRadius + v8 then
			v9 = color2
		else
			v9 = color
		end

		if placementDashedCircleData and nearbyTowerBuffRadius == placementDashedCircleData.Radius then
			DashedCircleUtilities.UpdateCircleColor(placementDashedCircleData, v9)
			DashedCircleUtilities.ShowCircle(placementDashedCircleData)
		else
			self:_DestroyPlacementDashedCircle()
			local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
			self.PlacementDashedCircleData = DashedCircleUtilities.NewDashedCircleData(
				Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z),
				nearbyTowerBuffRadius,
				v9,
				0.1
			)
		end
	elseif placementDashedCircleData then
		DashedCircleUtilities.HideCircle(placementDashedCircleData)
	end
end

function MapEntityClass:_DestroyPlacementDashedCircle()
	if self.PlacementDashedCircleData then
		DashedCircleUtilities.DestroyCircle(self.PlacementDashedCircleData)
		self.PlacementDashedCircleData = nil
	end
end

function MapEntityClass.Initialize()
	event:AttachCallback(function(items)
		for _, item in pairs(items) do
			if item.Creation then
				MapEntityClass.New(item.Data)
			else
				local data = item.Data
				local hash = data.Hash
				local immediate = data.Immediate
				local v9 = v3[hash]

				if v9 then
					v9:Destroy(immediate)
				else
					print("Didn't find map entity to remove with hash " .. tostring(hash))
				end
			end
		end
	end)
	event3:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = item[1]
			local v10 = item[2]
			local v11 = item[3]
			local v12 = v3[v9]

			if v12 then
				v12:SetHealth(v10, v11)
			end
		end
	end)

	for i = 1, #v do
		local v9 = i
		v[i]:AttachCallback(function(list)
			for _, v10 in ipairs(list) do
				local decompressDoubleHash, v11 = NetworkingUtilities.DecompressDoubleHash(v10)
				local v12 = v3[decompressDoubleHash]

				if v12 then
					v12:TargetChanged(v9, v11)
				else
					print("MapEntity TargetChangedEvent: MapEntity doesn't exist")
					print(decompressDoubleHash)
					break
				end
			end
		end)
	end

	for i = 1, #v2 do
		local v9 = i
		v2[i]:AttachCallback(function(list)
			for _, v10 in ipairs(list) do
				local decompressDoubleHash, v11 = NetworkingUtilities.DecompressDoubleHash(v10)
				local v12 = v3[decompressDoubleHash]
				local enemy = EnemyClass.GetEnemy(v11)

				if not v12 then
					print("MapEntity AttackEvent: MapEntity doesn't exist")
					break
				end

				if enemy then
					v12:Attack(v9, enemy)
				else
					print("MapEntity AttackEvent: Enemy doesn't exist")
					break
				end
			end
		end)
	end

	event2:AttachCallback(function(p)
		local v9 = v3[p.Hash]

		if not v9 then
			return
		end

		v9:SetAlive(p)
	end)
	event4:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v9 = item[1]
			local v10 = item[2]
			local v11 = v3[v9]

			if v11 then
				VisualEffectHandler.HandleVisualEffectOnEntity(v11.Character, v10)
			else
				print("MapEntityVisualEffectEvent: MapEntity doesn't exist")
				break
			end
		end
	end)
end

return MapEntityClass