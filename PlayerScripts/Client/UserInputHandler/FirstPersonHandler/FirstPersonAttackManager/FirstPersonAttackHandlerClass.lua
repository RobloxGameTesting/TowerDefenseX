local createVector = vector.create
local FirstPersonAttackHandlerClass = {}
FirstPersonAttackHandlerClass.__index = FirstPersonAttackHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("TowerBuffUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
require(common:WaitForChild("Utilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local parent = script.Parent.Parent
local parent2 = parent.Parent
local gameClass = parent2.Parent:WaitForChild("GameClass")
local VisualEffectHandler = require(gameClass:WaitForChild("VisualEffectHandler"))
local ProjectileHandler = require(gameClass:WaitForChild("ProjectileHandler"))
local UserInputUtilities = require(parent2:WaitForChild("UserInputUtilities"))
local FPS_MODE_STRONG_BOSS_THRESHOLD = _G.FPS_MODE_STRONG_BOSS_THRESHOLD
local isStudio = RunService:IsStudio()
local _ = { Reloading = 1, ShotInterval = 2, ReadyToFire = 3 }
local enemies = workspace:WaitForChild("Game"):WaitForChild("Enemies")
local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include
overlapParams.FilterDescendantsInstances = { enemies }

local function GetHitEnemiesForSplash(vector: Vector3, splashRadius: number)
	local partBoundsInRadius = workspace:GetPartBoundsInRadius(vector, math.min(splashRadius, 100), overlapParams)
	local v = {}
	local enemies2 = {}

	for _, v2 in pairs(partBoundsInRadius) do
		local enemy = UserInputUtilities.GetEnemyFromKnownEnemyPart(v2)

		if not enemy or v[enemy] or not enemy:FirstPersonTargetable() then
			continue
		end

		table.insert(enemies2, enemy)
		v[enemy] = true
	end

	return enemies2
end

local function FilterTakeNoDamageEnemies(list)
	local result = {}

	for _, v in ipairs(list) do
		if not v:ShouldTakeNoDamage() then
			table.insert(result, v)
		end
	end

	return result
end

function FirstPersonAttackHandlerClass.New(p: number, player, firstPersonConfig)
	local attackConfig = firstPersonConfig.AttackConfigs[p]

	if not attackConfig then
		error("FirstPersonAttackHandlerClass.New - Invalid attack handler index: " .. tostring(p))
	end

	local character = player.Character
	local hitEffectName = attackConfig.HitEffectName
	local defaultSpreadDegrees = attackConfig.DefaultSpreadDegrees or 0
	local damage = nil
	local damageType = nil
	local ignoreResistance = nil
	local isSplash = nil
	local splashRadius = nil
	local overrideBurstSize = nil
	local overrideBurstSize2 = nil
	local overrideBurstInterval = nil
	local isProjectile, projectileName, shotInterval, reloadTime, magSize

	if attackConfig.UseAbilityName then
		local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(attackConfig.UseAbilityName)

		if not towerAbilityConfig then
			warn("Invalid ability name: " .. tostring(attackConfig.UseAbilityName))
			return
		end

		isProjectile = towerAbilityConfig.ProjectileName ~= nil
		projectileName = towerAbilityConfig.ProjectileName

		if not isProjectile then
			warn("Non-projectile ability not supported yet")
			return
		end

		local magSize2 = attackConfig.MagSize or 1e999
		shotInterval = attackConfig.ShotInterval or towerAbilityConfig.Cooldown
		reloadTime = attackConfig.ReloadTime or towerAbilityConfig.Cooldown
		magSize = shotInterval == reloadTime and 1 or magSize2
		local projectileHitData = towerAbilityConfig.ProjectileHitData

		if projectileHitData then
			damage = projectileHitData.Damage or 0
			damageType = projectileHitData.DamageType or Enums.DamageTypes.Bullet
			isSplash = projectileHitData.IsSplash or false
			splashRadius = projectileHitData.SplashRadius or 0
			ignoreResistance = false
		end
	else
		local levelStats = player.LevelHandler:GetLevelStats()
		local clientsideIsBurst = levelStats.ClientsideIsBurst
		isProjectile = levelStats.IsProjectile
		projectileName = levelStats.ProjectileName
		magSize = attackConfig.MagSize
			or levelStats.DirectControlMagSize
			or not (levelStats.IsBurst and levelStats.BurstSize > 1) and 1e999
			or levelStats.BurstSize
			or 1e999
		shotInterval = attackConfig.ShotInterval
			or levelStats.IsBurst and levelStats.BurstSize > 1 and levelStats.BurstInterval
			or levelStats.ReloadTime
		reloadTime = attackConfig.ReloadTime or levelStats.DirectControlReloadTime or levelStats.ReloadTime
		damage = levelStats.Damage
		damageType = levelStats.DamageType
		ignoreResistance = levelStats.IgnoreResistance
		isSplash = levelStats.IsSplash
		splashRadius = levelStats.SplashRadius
		overrideBurstSize = character:GetOverrideBurstSize() or clientsideIsBurst or levelStats.IsBurst
		overrideBurstSize2 = character:GetOverrideBurstSize()
			or clientsideIsBurst and levelStats.ClientsideBurstSize
			or levelStats.BurstSize
		overrideBurstInterval = character:GetOverrideBurstInterval()
			or clientsideIsBurst and levelStats.ClientsideBurstInterval
			or levelStats.BurstInterval
	end

	local baseMultiplier = attackConfig.BaseMultiplier or 1
	local headshotMultiplier = attackConfig.HeadshotMultiplier or baseMultiplier
	local bossHeadshotMultiplier = attackConfig.BossHeadshotMultiplier or headshotMultiplier
	local strongBossHeadshotMultiplier = attackConfig.StrongBossHeadshotMultiplier or bossHeadshotMultiplier
	local previousStateData = player.DirectControlHandler:GetPreviousStateData(p)
	local state = not previousStateData and 3 or previousStateData.State or 3
	local timeLeftInState = not previousStateData and 0 or previousStateData.TimeLeftInState or 0
	local shotsRemaining

	if previousStateData then
		shotsRemaining = previousStateData.ShotsRemaining or magSize
	else
		shotsRemaining = magSize
	end

	local v = {
		TryAttacking = false,
		Index = p,
		Tower = player,
		FirstPersonConfig = firstPersonConfig,
		AttackConfig = attackConfig,
		UseAbilityName = attackConfig.UseAbilityName,
		State = state,
		TimeLeftInState = timeLeftInState,
		HitEffectName = hitEffectName,
		DefaultSpreadDegrees = defaultSpreadDegrees,
		BaseMultiplier = baseMultiplier,
		HeadshotMultiplier = headshotMultiplier,
		BossHeadshotMultiplier = bossHeadshotMultiplier,
		StrongBossHeadshotMultiplier = strongBossHeadshotMultiplier,
		HeadshotIgnoreResistance = attackConfig.HeadshotIgnoreResistance or false,
		IsProjectile = isProjectile,
		ProjectileConfig = isProjectile and ResourceManager.GetProjectileConfig(projectileName),
		MagSize = magSize,
		DefaultShotInterval = shotInterval,
		ReloadTime = reloadTime,
		Damage = damage,
		DamageType = damageType,
		IgnoreResistance = ignoreResistance,
		IsSplash = isSplash,
		SplashRadius = splashRadius,
		ClientsideIsBurst = overrideBurstSize,
		ClientsideBurstSize = overrideBurstSize2,
		ClientsideBurstInterval = overrideBurstInterval,
		AttackBurstIndex = 1,
		TimeUntilResetAttackBurstIndex = 0,
		ShotsRemaining = shotsRemaining,
		CurrentFirerateMultiplier = 1,
		ActiveProjectileDataMap = isProjectile and {},
		DebugCopyId = math.random(1, 99999)
	}

	if
		attackConfig.HeadshotMultiplier
		or attackConfig.BossHeadshotMultiplier
		or attackConfig.HeadshotIgnoreResistance
	then
		if v.IsProjectile then
			warn("Headshot modifiers not compatible with projectiles")
		elseif v.IsSplash then
			warn("Headshot modifiers not compatible with splash radius")
		end
	end

	return (setmetatable(v, FirstPersonAttackHandlerClass))
end

function FirstPersonAttackHandlerClass.GetStateData(data)
	return {
		State = data.State,
		TimeLeftInState = data.TimeLeftInState,
		ShotsRemaining = data.ShotsRemaining
	}
end

function FirstPersonAttackHandlerClass:ToggleTryAttacking(tryAttacking: boolean)
	self.TryAttacking = tryAttacking
	self:_RunCurrentState(0)
end

function FirstPersonAttackHandlerClass:OnRenderStepped(p: number, p2: number)
	local debugTimeScale

	if p > 0 then
		debugTimeScale = p2 / p
	end

	self.DebugTimeScale = debugTimeScale
	self.CurrentFirerateMultiplier = 1 / (1 + self.Tower.BuffHandler:GetStatMultipliers().FirerateMultiplier)
	self:_RunCurrentState(p2)

	if self.ClientsideIsBurst then
		self.TimeUntilResetAttackBurstIndex -= p2

		if self.TimeUntilResetAttackBurstIndex <= 0 then
			self.AttackBurstIndex = 1
		end
	end
end

function FirstPersonAttackHandlerClass:Run(_: number)
	if self.IsProjectile then
		for _, v in pairs(self.ActiveProjectileDataMap) do
			if v.Projectile.Hit then
				self:_ProjectileHit(v)
			end
		end
	end
end

function FirstPersonAttackHandlerClass:Reload()
	if not (self.State ~= 1 and self.ShotsRemaining ~= self.MagSize) then
		return
	end

	self.ShotsRemaining = 0
	self:_SetState(1, self.ReloadTime, 0)
end

function FirstPersonAttackHandlerClass.GetData(data)
	local isReloading = data.State == 1
	return {
		IsReloading = isReloading,
		ReloadTimeRemaining = not isReloading and 0 or data.TimeLeftInState or 0,
		TotalReloadTime = data.ReloadTime,
		MagSize = data.MagSize,
		ShotsRemaining = data.ShotsRemaining,
		AttackConfig = data.AttackConfig
	}
end

function FirstPersonAttackHandlerClass:_RunCurrentState(p: number)
	if self.State == 1 then
		self.TimeLeftInState -= p

		if self.TimeLeftInState <= 0 then
			self.ShotsRemaining = self.MagSize
			self:_SetState(3, 0, -self.TimeLeftInState)
		end
	elseif self.State == 2 then
		self.TimeLeftInState -= p

		if self.TimeLeftInState <= 0 then
			self:_SetState(3, 0, -self.TimeLeftInState)
		end
	elseif self.State == 3 and self.TryAttacking then
		self:_Attack()
		self.ShotsRemaining -= 1

		if self.ShotsRemaining <= 0 then
			self:_SetState(1, self.ReloadTime, -self.TimeLeftInState)
		else
			self:_SetState(2, self:_GetCurrentShotInterval(), -self.TimeLeftInState)
		end
	end
end

function FirstPersonAttackHandlerClass:_SetState(state: number, timeLeftInState: number, p: number)
	self.State = state
	self.TimeLeftInState = timeLeftInState

	if state == 1 then
		local module = require(parent)
		module.Reloaded()
	end

	if p > 0 then
		self:_RunCurrentState(p)
	end
end

function FirstPersonAttackHandlerClass:_Attack()
	local attackConfig = self.AttackConfig

	if isStudio then
		local now = os.clock()
		print(string.format(
			"[FPS shot] weapon %d: %dms since previous, interval %.3f x firerate mult %.3f, time scale x%.2f, %s/%s shots left",
			self.Index,
			math.floor((now - (self.DebugLastShotClock or now)) * 1000),
			self.DefaultShotInterval,
			self.CurrentFirerateMultiplier,
			self.DebugTimeScale or 0,
			tostring(self.ShotsRemaining),
			(tostring(self.MagSize))
		))
		self.DebugLastShotClock = now
	end

	local defaultSpreadDegrees = self.DefaultSpreadDegrees
	local module = require(parent)
	local crosshairPosition = module.GetCrosshairPosition()
	local module2 = require(parent)
	local currentSpreadFactor = module2.GetCurrentSpreadFactor()
	local screenPositionGetHitForFPSMode, v, v2 = UserInputUtilities.ScreenPositionGetHitForFPSMode(
		crosshairPosition,
		currentSpreadFactor * defaultSpreadDegrees
	)

	if self.IsProjectile then
		self:_AttackProjectile(screenPositionGetHitForFPSMode, v, v2)
	else
		self:_AttackHitscan(screenPositionGetHitForFPSMode, v, v2)
	end

	self:_BurstAttackHandling()
	local module3 = require(parent)
	module3.Attacked(self.Index, self.UseAbilityName, attackConfig.NoTriggerClientTowerAttacked)
end

function FirstPersonAttackHandlerClass:_HitWasHeadshot(instance, player)
	if instance:GetAttribute("IsHead") then
		return true
	end

	local character = player.Character

	if character:GetCharacterHasNoHead() then
		return false
	end

	local head = character:GetHead()

	if instance == head or instance:IsDescendantOf(head) then
		return true
	end

	return false
end

function FirstPersonAttackHandlerClass:_AttackHitscan(p, vector: Vector3?, vector2: Vector3)
	local uniqueId = nil
	local v

	if p then
		if self.IsSplash then
			v = GetHitEnemiesForSplash(vector, self.SplashRadius)
		else
			local enemy = UserInputUtilities.GetEnemyFromHit(p)

			if enemy and not enemy:FirstPersonTargetable() then
				enemy = nil
			end

			v = { enemy }

			if enemy and self:_HitWasHeadshot(p, enemy) then
				uniqueId = enemy.UniqueId
			end
		end

		if self.HitEffectName then
			local v2 = { Name = self.HitEffectName, Position = vector }
			VisualEffectHandler.NewVisualEffect(v2)
		end
	end

	if v and #v > 0 then
		local module = require(parent)
		module.AttackHitEnemies(
			self.Index,
			FilterTakeNoDamageEnemies(v),
			vector,
			uniqueId,
			self.DebugCopyId,
			self.ShotsRemaining
		)
		self:_HitEnemies(v, uniqueId, vector)
	else
		local module = require(parent)
		module.AttackMiss(vector2)
	end
end

function FirstPersonAttackHandlerClass:_AttackProjectile(flag: boolean, position: Vector3?, vector: Vector3)
	local tower = self.Tower
	local character = tower.Character
	local torsoPosition = tower:GetTorsoPosition()
	local projectileConfig = self.ProjectileConfig
	local attackConfig = self.AttackConfig
	local targetEnemy = nil
	local magnitude = nil

	if projectileConfig.StraightDown then
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Include
		raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
		local raycastResult = workspace:Raycast(torsoPosition, createVector(0, -200, 0), raycastParams)

		if raycastResult then
			position = raycastResult.Position
			magnitude = (torsoPosition - position).Magnitude
		else
			position = torsoPosition + createVector(0, -200, 0)
			magnitude = 200
		end
	elseif flag then
		targetEnemy = UserInputUtilities.GetEnemyFromHit(flag, true)

		if targetEnemy then
			position = targetEnemy:GetPosition() or position
		end
	else
		position = torsoPosition + (attackConfig.ProjectileMissTravelDistance or 150) * vector.Unit
	end

	local timeToHitForRangedProjectile = ProjectileUtilities.GetTimeToHitForRangedProjectile(
		torsoPosition,
		position,
		projectileConfig,
		magnitude
	)
	local v = {
		OriginEntityClass = "Tower",
		TargetEntityClass = "Enemy",
		OriginHash = tower.Hash,
		TargetHash = targetEnemy and targetEnemy.Hash,
		ForceTrackCharacter = targetEnemy ~= nil,
		OverrideGoalPosition = not targetEnemy and position,
		TimeToHit = timeToHitForRangedProjectile,
		FaceTarget = false,
		ProjectileConfig = projectileConfig,
		BurstIndex = self:_GetAttackBurstIndex(),
		SkinModelData = character:GetSkinModelData(),
		NoOriginEffects = true
	}
	local projectile = ProjectileHandler.NewProjectile(v)[1]

	if not projectile then
		warn("Failed to create projectile")
		return
	end

	local v2 = {
		Hash = projectile.Hash,
		Projectile = projectile,
		TargetEnemy = targetEnemy,
		GoalPosition = position,
		IsSplash = self.IsSplash,
		SplashRadius = self.SplashRadius
	}
	self.ActiveProjectileDataMap[projectile.Hash] = v2
	local module = require(parent)
	module.FireProjectile(targetEnemy, position, timeToHitForRangedProjectile, self.DebugCopyId, self.ShotsRemaining)
end

function FirstPersonAttackHandlerClass:_ProjectileHit(data)
	local targetEnemy = data.TargetEnemy
	local goalPosition = data.GoalPosition

	if targetEnemy then
		goalPosition = targetEnemy:GetTorsoPosition() or goalPosition
	end

	local v = nil

	if data.IsSplash then
		v = GetHitEnemiesForSplash(goalPosition, data.SplashRadius)
	elseif targetEnemy then
		if not targetEnemy:FirstPersonTargetable() then
			targetEnemy = nil
		end

		v = { targetEnemy }
	end

	if v and #v > 0 then
		local module = require(parent)
		module.AttackHitEnemies(self.Index, FilterTakeNoDamageEnemies(v), goalPosition)
		self:_HitEnemies(v, nil, goalPosition)
	end

	self.ActiveProjectileDataMap[data.Hash] = nil
end

function FirstPersonAttackHandlerClass:_HitEnemies(list, p: number?, vector: Vector3)
	local upgradeShopMultiplier = self.Tower:GetUpgradeShopMultiplier(Enums.TowerUpgradeShopTypes.Damage)
	local v = false
	local v2 = false
	local v3 = false
	local v4 = false

	for _, v5 in ipairs(list) do
		local v6 = v5.UniqueId == p
		local damage = self.Damage
		local damageType = self.DamageType
		local ignoreResistance = self.IgnoreResistance
		local strongBossHeadshotMultiplier

		if v6 then
			if v5.IsBoss or v5.IsMiniBoss then
				if FPS_MODE_STRONG_BOSS_THRESHOLD < v5.HealthHandler:GetMaxHealth() then
					strongBossHeadshotMultiplier = self.StrongBossHeadshotMultiplier
				else
					strongBossHeadshotMultiplier = self.BossHeadshotMultiplier
				end
			else
				strongBossHeadshotMultiplier = self.HeadshotMultiplier
			end
		else
			strongBossHeadshotMultiplier = self.BaseMultiplier
		end

		local v7 = damage * strongBossHeadshotMultiplier * upgradeShopMultiplier

		if v6 then
			ignoreResistance = self.HeadshotIgnoreResistance or ignoreResistance
		end

		local firstPersonDamage, v8, v9 = v5:FirstPersonDamage(
			v7,
			damageType,
			v6,
			ignoreResistance,
			vector,
			self.IsSplash
		)
		v = v or firstPersonDamage
		v2 = v2 or v8
		v3 = v3 or v9
		v4 = v4 or v6
	end

	if v then
		SoundHandler.Play("HitKill")
	end

	if v2 then
		SoundHandler.Play("HitShieldShatter")
	elseif v3 then
		if v4 then
			SoundHandler.PlayRandom({ "HitShieldHeadshot1", "HitShieldHeadshot2", "HitShieldHeadshot3" })
		else
			SoundHandler.PlayRandom({ "HitShield1", "HitShield2", "HitShield3" })
		end
	elseif v4 then
		SoundHandler.Play("HitHeadshot")
	else
		SoundHandler.Play("HitStandard")
	end
end

function FirstPersonAttackHandlerClass:_GetCurrentShotInterval()
	return self.DefaultShotInterval * self.CurrentFirerateMultiplier
end

function FirstPersonAttackHandlerClass:_GetAttackBurstIndex()
	if self.ClientsideIsBurst then
		return self.AttackBurstIndex
	end
end

function FirstPersonAttackHandlerClass:_BurstAttackHandling()
	if self.ClientsideIsBurst then
		self.AttackBurstIndex += 1

		if self.AttackBurstIndex > self.ClientsideBurstSize then
			self.AttackBurstIndex = 1
		end

		self.TimeUntilResetAttackBurstIndex = 2 * self.ClientsideBurstInterval
	end
end

return FirstPersonAttackHandlerClass