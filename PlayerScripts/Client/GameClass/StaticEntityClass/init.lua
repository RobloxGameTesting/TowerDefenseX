local StaticEntityClass = {}
StaticEntityClass.__index = StaticEntityClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local BeamEffectHelper = require(common:WaitForChild("BeamEffectHelper"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local NetworkingUtilities = require(common:WaitForChild("NetworkingUtilities"))
require(common:WaitForChild("Utilities"))
local BaseClasses = script.Parent:WaitForChild("BaseClasses")
local CharacterClass = require(BaseClasses:WaitForChild("CharacterClass"))
local TowerClass = require(script.Parent:WaitForChild("TowerClass"))
local EnemyClass = require(script.Parent:WaitForChild("EnemyClass"))
local ProjectileHandler = require(script.Parent:WaitForChild("ProjectileHandler"))
local VisualEffectHandler = require(script.Parent:WaitForChild("VisualEffectHandler"))
local HealthHandlerClass = require(script:WaitForChild("HealthHandlerClass"))
local event = NetworkingHandler.GetEvent("StaticEntityFactoryQueueUpdated")
local event2 = NetworkingHandler.GetEvent("StaticEntityHealthChanged")
local event3 = NetworkingHandler.GetEvent("StaticEntityCollision")
local event4 = NetworkingHandler.GetEvent("BombardierC4Update")
local event5 = NetworkingHandler.GetEvent("StaticEntityHealTargetsChanged")
local v = {
	NetworkingHandler.GetEvent("StaticEntityTargetChanged1"),
	NetworkingHandler.GetEvent("StaticEntityTargetChanged2"),
	NetworkingHandler.GetEvent("StaticEntityTargetChanged3"),
	NetworkingHandler.GetEvent("StaticEntityTargetChanged4"),
	NetworkingHandler.GetEvent("StaticEntityTargetChanged5")
}
local v2 = {
	NetworkingHandler.GetEvent("StaticEntityAttack1"),
	NetworkingHandler.GetEvent("StaticEntityAttack2"),
	NetworkingHandler.GetEvent("StaticEntityAttack3"),
	NetworkingHandler.GetEvent("StaticEntityAttack4"),
	NetworkingHandler.GetEvent("StaticEntityAttack5")
}
local v3 = {}
local v4 = {}
local v5 = 0
local Game = workspace:WaitForChild("Game")
local StaticEntities = Game:WaitForChild("StaticEntities")
local staticEntities = Game:WaitForChild("RaycastIgnore"):FindFirstChild("StaticEntities")
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function MakeAttackClientDataTable(staticEntityConfig)
	if not staticEntityConfig.HasAttack then
		return
	end

	local result = {}

	for i, v6 in ipairs(staticEntityConfig.AttackData) do
		local projectileName = v6.IsProjectile and v6.ProjectileName
		result[i] = {
			AimTime = v6.AimTime or 0,
			IsBurst = v6.IsBurst or false,
			BurstSize = v6.BurstSize,
			BurstInterval = v6.BurstInterval,
			IsPiercing = v6.IsPiercing,
			Range = v6.Range,
			ReloadTime = v6.ReloadTime,
			DamageDelay = v6.DamageDelay,
			AttackIsProjectile = v6.IsProjectile,
			AttackProjectileConfig = projectileName and ResourceManager.GetProjectileConfig(projectileName),
			AttackAnimationSpeedMultiplier = 1,
			AttackBurstIndex = 1,
			TimeUntilResetAttackBurstIndex = 0,
			ClientHitEffectData = v6.ClientHitEffectData,
			CurrentTarget = nil,
			LatestAttackedTarget = nil,
			TimeSinceLastAttack = 1e999,
			CurrentTargetIsTower = false,
			TimeSinceLastHadTarget = 0
		}
	end

	return result
end

local function GetCharacter(hash: number, p: string, skinName: string, p2: string, staticEntityConfig, position: Vector3, projectile, stealth: boolean?, p3: number)
	local primaryPartCFrame, v6

	if projectile then
		primaryPartCFrame = projectile:GetPrimaryPartCFrame()
		stealth = projectile:StealthIsActive()
		local _, v7, _ = primaryPartCFrame:ToOrientation()
		v6 = CFrame.new(position) * CFrame.Angles(0, v7, 0)
	else
		primaryPartCFrame = CFrame.new(position) * CFrame.Angles(0, math.random(0, 360) * 3.141592653589793 / 180, 0)
		v6 = primaryPartCFrame
	end

	local v7 = {
		Hash = hash,
		Type = p,
		SkinName = skinName,
		EntityClass = "StaticEntity",
		Config = staticEntityConfig,
		SpawnCFrame = primaryPartCFrame,
		Parent = staticEntityConfig.RaycastIgnore and staticEntities or StaticEntities,
		Stealth = stealth,
		PathLevelString = staticEntityConfig.VariableModel and p2,
		NoSpawnTween = projectile ~= nil,
		HoverHeightMultiplier = 0.5,
		TurretConfigs = staticEntityConfig.TurretConfigs
	}
	return CharacterClass.New(v7, nil, p3), v6
end

function StaticEntityClass.New(list)
	assert(list, "InitData not provided")
	local hash = list[1]
	local v6 = list[2]
	local skinName = list[3]
	local pathLevelString = list[4]
	local path1Level = list[5]
	local path2Level = list[6]
	local customPathLevelStringDisplayText = list[7]
	local position = list[8]
	local v7 = list[9]
	local v8 = list[10]
	local dashedCircleRange = list[11]
	local v9 = list[12]
	local v10 = list[13]
	local uniqueId = list[14]
	local pvpTeamIndex = list[15]
	assert(hash, "Static entity hash not provided")
	assert(v6, "Static entity type not provided")
	assert(position, "Position not provided")
	local v11 = v3[hash]

	if v11 then
		v11:Destroy(true)
	end

	local staticEntityConfig = ResourceManager.GetStaticEntityConfig(v6)
	assert(staticEntityConfig, "Static entity config not found for type " .. v6)
	local projectile = ProjectileHandler.FindProjectileWithStaticEntityHash(hash)
	local burnEffectData, burnEffectDuration

	if projectile then
		burnEffectData, burnEffectDuration = projectile:GetBurnEffectData()
		projectile:EntitySpawned()
	end

	local character, cframe = GetCharacter(
		hash,
		v6,
		skinName,
		pathLevelString,
		staticEntityConfig,
		position,
		projectile,
		v7,
		v9
	)
	local v12 = staticEntityConfig.AttackData and staticEntityConfig.AttackData[1]
	local healthHandler = staticEntityConfig.CollisionHealth
		and HealthHandlerClass.New(v10 or staticEntityConfig.CollisionHealth, staticEntityConfig.CollisionHealth)
	local v13 = {
		UniqueId = uniqueId,
		Hash = hash,
		PVPTeamIndex = pvpTeamIndex,
		Type = v6,
		SkinName = skinName,
		NoDisplayPathLevelString = staticEntityConfig.NoDisplayPathLevelString,
		PathLevelString = pathLevelString,
		Path1Level = path1Level,
		Path2Level = path2Level,
		CustomPathLevelStringDisplayText = customPathLevelStringDisplayText,
		Position = position,
		Config = staticEntityConfig,
		DisplayName = staticEntityConfig.OverrideDisplayName or v6,
		NoHoverTooltip = staticEntityConfig.NoHoverTooltip,
		CFrame = cframe,
		Character = character,
		Destroyed = false,
		DashedCircleRange = dashedCircleRange,
		IsAirUnit = false,
		NoRestartAttackAnimationIfPlaying = staticEntityConfig.NoRestartAttackAnimationIfPlaying,
		CollisionEffectName = staticEntityConfig.CollisionEffectName,
		StealthDetection = v8 or staticEntityConfig.StealthDetection,
		ClientsideAttackTargetPathPosition = staticEntityConfig.ClientsideAttackTargetPathPosition,
		ClientsideAttackTargetTorsoPosition = staticEntityConfig.ClientsideAttackTargetTorsoPosition,
		HasTurret = character:HasTurret(),
		AttackClientDataTable = MakeAttackClientDataTable(staticEntityConfig),
		Range = v12 and v12.Range,
		ExplosionEffectNames = staticEntityConfig.ExplosionEffectNames,
		VariableExplosionEffects = staticEntityConfig.VariableExplosionEffects,
		BurnEffectName = burnEffectData,
		BurnEffectDuration = burnEffectDuration,
		HealthHandler = healthHandler,
		UserInputHovered = false,
		BeamEffectsV2 = nil,
		BeamEffectsV2SetUp = false,
		AffectedEntities = {}
	}
	v3[v13.Hash] = v13
	v4[character:GetTorso()] = v13
	v5 += 1

	if staticEntityConfig.SpawnAnimationTime then
		character:SetAnimationState("Spawn")
	else
		character:SetAnimationState("Idle")
	end

	setmetatable(v13, StaticEntityClass)
	return v13
end

function StaticEntityClass.SpawnExistingStaticEntities(list)
	for _, v6 in ipairs(list) do
		if not v3[v6[1]] then
			StaticEntityClass.New(v6)
		end
	end
end

function StaticEntityClass.GetStaticEntity(p: number)
	return v3[p]
end

function StaticEntityClass.GetStaticEntities()
	return v3
end

function StaticEntityClass.GetStaticEntityByTorso(p)
	return v4[p]
end

function StaticEntityClass:SetSpeedMultiplier()
	DEFAULT_SPEED_MULTIPLIER = self

	for _, v6 in pairs(v3) do
		v6.Character:SetSpeedMultiplier(DEFAULT_SPEED_MULTIPLIER)

		if not v6.BeamEffectsV2 then
			continue
		end

		for _, v7 in pairs(v6.BeamEffectsV2) do
			BeamEffectHelper.SpeedMultiplierChanged(self, v7)
		end
	end
end

function StaticEntityClass.LogicLoop(p: number, p2: number)
	for _, v6 in pairs(v3) do
		v6:Logic(p, p2)
	end
end

function StaticEntityClass:Logic(p: number, _: number)
	local character = self.Character
	local attackClientDataTable = self.AttackClientDataTable

	if attackClientDataTable then
		for _, v6 in pairs(attackClientDataTable) do
			v6.TimeSinceLastAttack += p

			if not v6.LatestAttackedTarget then
				continue
			end

			if v6.LatestAttackedTarget:Alive() then
				if v6.TimeSinceLastAttack >= v6.ReloadTime * 2 then
					v6.LatestAttackedTarget = nil
				end
			else
				v6.LatestAttackedTarget = nil
			end
		end
	end

	local v6 = attackClientDataTable and attackClientDataTable[1]

	if v6 then
		local _currentTarget = v6.CurrentTarget
	end

	local latestAttackedTarget = v6 and v6.LatestAttackedTarget
	self:SetAnimationState("Idle")

	if latestAttackedTarget and self.HasTurret then
		if v6.CurrentTargetIsTower then
			self:FaceTower(1, latestAttackedTarget)
		else
			self:FaceEnemy(1, latestAttackedTarget)
		end
	end

	character:LerpCFrame(p, self.CFrame, true)
	character:Run(p)
	self:_RunBeamEffectsV2(p)

	if attackClientDataTable then
		for _, v7 in pairs(attackClientDataTable) do
			if not v7.IsBurst then
				continue
			end

			v7.TimeUntilResetAttackBurstIndex -= p

			if v7.TimeUntilResetAttackBurstIndex <= 0 then
				v7.AttackBurstIndex = 1
			end
		end
	end
end

function StaticEntityClass:HandleAffectedEntityEffects(items)
	local affectedEntityEffectData = self.Config.MultiHealData.AffectedEntityEffectData

	if not affectedEntityEffectData then
		return
	end

	for _, item in pairs(items) do
		local character = item.Character
		local beamEffectHandlingData = affectedEntityEffectData.BeamEffectHandlingData

		if beamEffectHandlingData then
			self:_HandleBeamEffectsV2(
				beamEffectHandlingData,
				character,
				affectedEntityEffectData.TryRestartExistingBeam,
				item.UniqueId
			)
		end
	end
end

function StaticEntityClass:_HandleBeamEffectsV2(p, p2, flag: boolean?, p3: number?)
	if not self.BeamEffectsV2SetUp then
		self.BeamEffectsV2 = {}
		self.BeamEffectsV2SetUp = true
	end

	local flag2 = false

	if flag then
		local v6 = nil

		for _, v7 in pairs(self.BeamEffectsV2) do
			local v8 = v7[1]

			if not (v8 and v8.On and v8.TrackCharacter == p2) then
				continue
			end

			v6 = v7
			break
		end

		if v6 then
			BeamEffectHelper.StartBeamEffects(v6, nil, nil, nil, p2, true)
		else
			flag2 = true
		end
	else
		flag2 = true
	end

	if flag2 then
		local beamEffects = BeamEffectHelper.NewBeamEffects(
			self.Character:GetCharacterModel(),
			p,
			DEFAULT_SPEED_MULTIPLIER,
			p3
		)
		self.BeamEffectsV2[os.clock()] = beamEffects
		BeamEffectHelper.StartBeamEffects(beamEffects, nil, nil, nil, p2)
	end
end

function StaticEntityClass:_RunBeamEffectsV2(p: number)
	if not self.BeamEffectsV2 then
		return
	end

	for k, v6 in pairs(self.BeamEffectsV2) do
		BeamEffectHelper.RunBeamEffects(p, v6)

		if BeamEffectHelper.ReadyToCleanUp(v6) then
			self.BeamEffectsV2[k] = nil
		end
	end
end

function StaticEntityClass:GetPosition()
	return self.Position
end

function StaticEntityClass:FacePosition(vector: Vector3, p: number)
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

function StaticEntityClass:FaceEnemy(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPathPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function StaticEntityClass:FaceTower(p: number, object)
	if self.ClientsideAttackTargetPathPosition then
		self:FacePosition(object:GetPosition(), p)
	elseif self.ClientsideAttackTargetTorsoPosition or object:GetIsAirUnit() then
		self:FacePosition(object:GetTorsoPosition(), p)
	else
		self:FacePosition(object:GetPosition(), p)
	end
end

function StaticEntityClass:SetAnimationState(state: string)
	self.State = state
	self.Character:SetAnimationState(state)
end

function StaticEntityClass:_RenderProjectileForAttack(_: number, _, _: boolean?)
	warn("TODO: StaticEntityClass:_RenderProjectileForAttack")
end

function StaticEntityClass:_HandleRenderHitEffect(p: number, p2, vector: Vector3?)
	if not (p2 or vector) then
		warn("No goal position could be determined for rendering hit effect")
		return
	end

	local attackClientDataTable = self.AttackClientDataTable
	local v6 = attackClientDataTable and attackClientDataTable[p]

	if v6 and v6.ClientHitEffectData then
		warn("TODO: StaticEntityClass:_HandleRenderHitEffect")
	end
end

function StaticEntityClass:Attack(p: number, latestAttackedTarget, flag: boolean?)
	local attackClientDataTable = self.AttackClientDataTable
	local v6 = attackClientDataTable and attackClientDataTable[p]

	if not v6 then
		return
	end

	if v6.AttackIsProjectile then
		self:_RenderProjectileForAttack(p, latestAttackedTarget, flag)
	elseif flag then
		self:FaceTower(p, latestAttackedTarget)
	else
		self:FaceEnemy(p, latestAttackedTarget)
	end

	v6.LatestAttackedTarget = latestAttackedTarget
	v6.TimeSinceLastAttack = 0
	v6.CurrentTargetIsTower = flag or false
	self:_Attacked(p)
	self:_HandleRenderHitEffect(p, latestAttackedTarget)
end

function StaticEntityClass:_Attacked(p: number)
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

function StaticEntityClass._GetAttackBurstIndex(p, p2: number)
	local attackClientDataTable = p.AttackClientDataTable
	local v6 = attackClientDataTable and attackClientDataTable[p2]
	return v6 and v6.IsBurst and v6.AttackBurstIndex
end

function StaticEntityClass:_BurstAttackHandling(p: number)
	local attackClientDataTable = self.AttackClientDataTable
	local v6 = attackClientDataTable and attackClientDataTable[p]

	if v6 and v6.IsBurst then
		v6.AttackBurstIndex += 1

		if v6.AttackBurstIndex > v6.BurstSize then
			v6.AttackBurstIndex = 1
		end

		v6.TimeUntilResetAttackBurstIndex = 2 * v6.BurstInterval
	end
end

function StaticEntityClass:TargetChanged(p: number, p2: number, flag: boolean?)
	local attackClientDataTable = self.AttackClientDataTable
	local v6 = attackClientDataTable and attackClientDataTable[p]

	if not v6 then
		return
	end

	if p2 == 0 then
		v6.CurrentTarget = nil
		return
	end

	local currentTarget = flag and TowerClass.GetTower(p2) or EnemyClass.GetEnemy(p2)

	if not currentTarget then
		warn(`StaticEntity TargetChanged: {flag and "Tower" or "Enemy"} doesn't exist`)
		return
	end

	v6.CurrentTarget = currentTarget
	v6.CurrentTargetIsTower = flag or false
end

function StaticEntityClass:SetHealth(p: number)
	self.HealthHandler:SetHealth(p)
end

function StaticEntityClass.IsDestroyed(p)
	return p.Destroyed
end

function StaticEntityClass:Destroy(flag: boolean?, _: boolean?, flag2: boolean?)
	self.Destroyed = true

	if self.BeamEffectsV2 then
		for _, v6 in pairs(self.BeamEffectsV2) do
			BeamEffectHelper.StopBeamEffects(v6)
		end
	end

	if flag2 then
		self:_Explode()
	end

	self.Character:SetFadeOutOnDeath(not flag)
	self.Character:Destroy(flag)
	v3[self.Hash] = nil
	v4[self.Character:GetTorso()] = nil
	v5 -= 1
end

function StaticEntityClass:_Explode()
	local variableExplosionEffects = self.VariableExplosionEffects
	local pathLevelString = self.PathLevelString
	local position = self.Character:GetRealTorso().Position

	if self.ExplosionEffectNames then
		for _, explosionEffectName in pairs(self.ExplosionEffectNames) do
			VisualEffectHandler.NewVisualEffect({
				Name = explosionEffectName,
				PathLevelString = variableExplosionEffects and pathLevelString,
				Position = position
			})
		end
	end
end

function StaticEntityClass:BombardierC4Event(p: string)
	local characterModel = self.Character:GetCharacterModel()

	if p == "Disarm" then
		for _, part in pairs(characterModel:GetDescendants()) do
			if part:IsA("BasePart") and part.Name == "Lights" then
				part.Color = Color3.fromRGB(109, 243, 56)
			end
		end
	end
end

function StaticEntityClass:Collided()
	if self.CollisionEffectName then
		local v6 = { Name = self.CollisionEffectName, Position = self.CFrame.Position }
		VisualEffectHandler.NewVisualEffect(v6)
	end
end

function StaticEntityClass:GetIsAirUnit()
	return self.IsAirUnit
end

local function FindEntityInArray(items, p)
	for _, item in pairs(items) do
		if p.Hash == item.Hash then
			return true
		end
	end

	return false
end

function StaticEntityClass:_GetOldAffectedEntities(items)
	local result = {}

	for _, v6 in pairs(self.AffectedEntities or {}) do
		local v7 = false

		for _, item in pairs(items) do
			if v6.Hash ~= item.Hash then
				continue
			end

			v7 = true
			break
		end

		if not v7 then
			table.insert(result, v6)
		end
	end

	return result
end

function StaticEntityClass.Initialize()
	event:AttachCallback(function(items)
		for _, item in pairs(items) do
			if item.Creation then
				StaticEntityClass.New(item.Data)
			else
				local data = item.Data
				local hash = data.Hash
				local timedOut = data.TimedOut
				local exploded = data.Exploded
				local immediate = data.Immediate
				local v6 = v3[hash]

				if v6 then
					v6:Destroy(immediate, timedOut, exploded)
				else
					print("Didn't find static entity to remove with hash " .. tostring(hash))
				end
			end
		end
	end)
	event2:AttachCallback(function(items)
		for _, item in pairs(items) do
			local decompressHashAndNumber1Place, v6 = NetworkingUtilities.DecompressHashAndNumber1Place(item)
			local v7 = v3[decompressHashAndNumber1Place]

			if v7 then
				v7:SetHealth(v6)
			end
		end
	end)
	event3:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v6 = v3[NetworkingUtilities.DecompressHashAndInteger(item)]

			if v6 then
				v6:Collided()
			end
		end
	end)
	event5:AttachCallback(function(items)
		for _, item in pairs(items) do
			local v6 = item[1]
			local v7 = item[2]
			local v8 = item[3] or Enums.EntityClass.Tower
			local v9 = v3[v6]

			if not (v9 and v7) then
				continue
			end

			local towers = {}
			local towers2 = {}

			for _, v10 in pairs(v7) do
				if v8 ~= Enums.EntityClass.Tower then
					warn("StaticEntityHealTargets are only implemented for Tower entities")
					return
				end

				local tower = TowerClass.GetTower(v10)

				if not tower then
					continue
				end

				local affectedEntities = v9.AffectedEntities
				local v11 = false

				for _, affectedEntity in pairs(affectedEntities) do
					if tower.Hash ~= affectedEntity.Hash then
						continue
					end

					v11 = true
					break
				end

				if not v11 then
					table.insert(towers2, tower)
				end

				table.insert(towers, tower)
			end

			local oldAffectedEntities = v9:_GetOldAffectedEntities(towers)

			for _, oldAffectedEntity in pairs(oldAffectedEntities) do
				local beams = BeamEffectHelper.GetBeamsByTargetEntityUniqueId(
					v9.BeamEffectsV2,
					oldAffectedEntity.UniqueId or 0
				)
				BeamEffectHelper.StopBeamEffects(beams)

				for _, beam in pairs(beams) do
					beam.ParentInstance:Destroy()
					beam.Destroyed = true
				end
			end

			v9.AffectedEntities = towers
			v9:HandleAffectedEntityEffects(towers2)
		end
	end)
	event4:AttachCallback(function(p: number, p2: string)
		local v6 = v3[p]

		if v6 then
			v6:BombardierC4Event(p2)
		end
	end)

	for i = 1, #v do
		local v6 = i
		v[i]:AttachCallback(function(list)
			for _, v7 in ipairs(list) do
				local decompressDoubleHash, v8 = NetworkingUtilities.DecompressDoubleHash(v7)
				local v9 = v3[decompressDoubleHash]

				if v9 then
					v9:TargetChanged(v6, v8)
				else
					print("StaticEntity TargetChangedEvent: StaticEntity doesn't exist")
					print(decompressDoubleHash)
					break
				end
			end
		end)
	end

	for i = 1, #v2 do
		local v6 = i
		v2[i]:AttachCallback(function(list)
			for _, v7 in ipairs(list) do
				local decompressDoubleHash, v8 = NetworkingUtilities.DecompressDoubleHash(v7)
				local v9 = v3[decompressDoubleHash]
				local enemy = EnemyClass.GetEnemy(v8)

				if not v9 then
					print("StaticEntity AttackEvent: StaticEntity doesn't exist")
					break
				end

				if enemy then
					v9:Attack(v6, enemy)
				else
					print("StaticEntity AttackEvent: Enemy doesn't exist")
					break
				end
			end
		end)
	end
end

return StaticEntityClass