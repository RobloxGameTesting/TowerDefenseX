local createVector = vector.create
local VoidGodAirstrike = {}
VoidGodAirstrike.__index = VoidGodAirstrike
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local Config = require(common.Resources.Misc.VoidGodAirstrike.Config)
local parent = script.Parent.Parent.Parent
local VisualEffectHandler = require(parent:WaitForChild("VisualEffectHandler"))
local ProjectileHandler = require(parent:WaitForChild("ProjectileHandler"))
local enemyClass = parent:WaitForChild("EnemyClass")
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local f22 = common.Resources.Misc.RegularPowerUps.AirStrike.F22

local function GetBaseParts(airstrikeTargets)
	local parts = {}

	if airstrikeTargets then
		for _, part in pairs(airstrikeTargets:GetChildren()) do
			if part:IsA("BasePart") then
				table.insert(parts, part)
			end
		end
	end

	return parts
end

local function GetPlaneCFrame(vector: Vector3, vector2: Vector3) -- 2 equivalent calls inferred from this helper
	return CFrame.new(vector, vector - vector2)
end

local function ScaleTrails(p, p2: number) -- 2 equivalent calls inferred from this helper
	for _, trail in pairs(p.Trails) do
		trail.Lifetime = 3 / math.max(p2, 0.1)
	end
end

local function GetMissileOriginPart(p, burstIndex: number)
	local projectileName = Config.ProjectileName

	for _, v in ipairs({ `{projectileName}{burstIndex}`, projectileName }) do
		for _, model in pairs(p.Model:GetChildren()) do
			if model:IsA("Model") and model.PrimaryPart and model.Name:split("___")[1] == v then
				return model.PrimaryPart
			end
		end
	end

	return p.Root
end

local function DetachPortal(folder, portal)
	for _, descendant in pairs(folder:GetDescendants()) do
		if not ((descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) and (descendant.Part0 == portal or descendant.Part1 == portal)) then
			continue
		end

		descendant:Destroy()
	end
end

local function NewPlane(vector: Vector3, unit: Vector3, leadPlaneSpeed: number, p: number)
	local clone = f22:Clone()
	local primaryPart = clone.PrimaryPart
	local portal = clone:FindFirstChild("Portal", true)

	if not (portal and portal:IsA("BasePart")) then
		portal = nil
	end

	local v

	if portal then
		v = primaryPart.CFrame:ToObjectSpace(portal.CFrame)
		DetachPortal(clone, portal)
	end

	primaryPart.CFrame = GetPlaneCFrame(vector, unit) -- inferred equivalent call
	clone.Parent = raycastIgnore
	local portalWrapper

	if portal and v then
		portal.Anchored = true
		portal.CFrame = primaryPart.CFrame * v
		portal.Parent = raycastIgnore
		portalWrapper = WrapperFactory.NewEmitterAndSoundWrapper(portal, p)
		portalWrapper:PlayAll()
	end

	local trails = {}

	for _, trail in pairs(clone:GetDescendants()) do
		if not trail:IsA("Trail") then
			continue
		end

		trail.Enabled = true
		table.insert(trails, trail)
	end

	local wrappers = {
		WrapperFactory.NewSoundWrapper(clone:FindFirstChild("IdleSFX"), p),
		WrapperFactory.NewSoundWrapper(clone:FindFirstChild("ZoomSFX"), p)
	}

	for _, v2 in pairs(wrappers) do
		v2:PlayAll()
	end

	local v2 = {
		Model = clone,
		Root = primaryPart,
		Trails = trails,
		Wrappers = wrappers,
		Start = vector,
		Direction = unit,
		Speed = leadPlaneSpeed,
		EndTime = 0,
		Missiles = {},
		Destroyed = false,
		Portal = portal,
		PortalWrapper = portalWrapper,
		PortalStopped = false
	}
	ScaleTrails(v2, p) -- inferred equivalent call
	return v2
end

local function DestroyPlane(state) -- 3 equivalent calls inferred from this helper
	if state.Destroyed then
		return
	end

	state.Destroyed = true
	state.Model:Destroy()
end

local function DestroyPortal(plane) -- 2 equivalent calls inferred from this helper
	local portal = plane.Portal

	if portal then
		portal:Destroy()
		plane.Portal = nil
		plane.PortalWrapper = nil
	end
end

local function GetStraightPosition(data, p: number) -- 1 equivalent call inferred from this helper
	return data.Start + data.Direction * (data.Speed * p)
end

local function GetCrashPosition(data, crashTargetPart, p: number) -- 1 equivalent call inferred from this helper
	local crashTime = data.CrashTime
	local v = not (crashTime > 0) and 1 or math.clamp(p / crashTime, 0, 1)
	return data.Start:Lerp(crashTargetPart.Position, v)
end

local function LaunchMissile(data, missile, p: number)
	missile.Launched = true
	local projectileConfig = ResourceManager.GetProjectileConfig(Config.ProjectileName)

	if not projectileConfig then
		warn(`VoidGodAirstrike: projectile config {Config.ProjectileName} not found`)
		return
	end

	local v = {
		OriginEntityClass = "Misc",
		TargetEntityClass = "Enemy",
		OverrideGoalPosition = missile.TargetPart.Position,
		TrackGoalPart = missile.TargetPart,
		TimeToHit = math.max(missile.HitTime - p, 0.05),
		FaceTarget = true,
		ProjectileConfig = projectileConfig,
		OverrideOriginPart = GetMissileOriginPart(data, missile.BurstIndex),
		CustomCharacterHandling = true
	}
	ProjectileHandler.NewProjectile(v)
end

local function HidePlane(p)
	for _, descendant in pairs(p.Model:GetDescendants()) do
		if descendant:IsA("BasePart") or descendant:IsA("Decal") then
			descendant.Transparency = 1
		elseif descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") or descendant:IsA("Light") then
			descendant.Enabled = false
		elseif descendant:IsA("Sound") then
			descendant:Stop()
		end
	end
end

local function CrashPlane(data, p: number) -- 1 equivalent call inferred from this helper
	local crashTargetPart = data.CrashTargetPart

	if crashTargetPart then
		local v = { Name = Config.CrashExplosionEffectName, Position = crashTargetPart.Position }
		VisualEffectHandler.NewVisualEffect(v)
	end

	HidePlane(data)
	data.TrailFadeEndTime = p + 3
end

local function RunPlane(plane, elapsed: number)
	if plane.Destroyed then
		return
	end

	local trailFadeEndTime = plane.TrailFadeEndTime

	if trailFadeEndTime then
		if trailFadeEndTime <= elapsed then
			DestroyPlane(plane) -- inferred equivalent call
		end
	else
		local crashTime = plane.CrashTime

		if crashTime and crashTime <= elapsed then
			CrashPlane(plane, elapsed) -- inferred equivalent call
		elseif plane.EndTime <= elapsed then
			DestroyPlane(plane) -- inferred equivalent call
		else
			local crashTargetPart = plane.CrashTargetPart
			local direction = plane.Direction
			local v

			if crashTargetPart then
				v = GetCrashPosition(plane, crashTargetPart, elapsed) -- inferred equivalent call
				local v2 = crashTargetPart.Position - v

				if v2.Magnitude > 0.001 then
					direction = v2.Unit
				end
			else
				v = GetStraightPosition(plane, elapsed) -- inferred equivalent call
			end

			plane.Root.CFrame = GetPlaneCFrame(v, direction) -- inferred equivalent call

			for _, missile in ipairs(plane.Missiles) do
				if missile.Launched or not (missile.LaunchTime <= elapsed) then
					continue
				end

				LaunchMissile(plane, missile, elapsed)
			end
		end
	end
end

local function RunPortal(state, p: number)
	local portalWrapper = state.PortalWrapper

	if not portalWrapper then
		return
	end

	if not state.PortalStopped and Config.PortalDuration <= p then
		state.PortalStopped = true
		portalWrapper:StopContinuous()
	end

	local portal = Config.PortalDuration + 5 <= p and state.Portal

	if portal then
		portal:Destroy()
		state.Portal = nil
		state.PortalWrapper = nil
	end
end

local function CreatePlanes(data, p: number)
	local result = {}
	local module = require(enemyClass)
	local enemy = module.GetEnemy(data.EnemyHash)
	local character = enemy and enemy.Character
	local characterModel = character and character:GetCharacterModel()

	if not characterModel then
		return result
	end

	local airstrikeDirection = characterModel:FindFirstChild("AirstrikeDirection")
	local start = airstrikeDirection and airstrikeDirection:FindFirstChild("Start")
	local part = airstrikeDirection and airstrikeDirection:FindFirstChild("End")
	local baseParts = GetBaseParts(characterModel:FindFirstChild("AirstrikeTargets"))

	if not (start and start:IsA("BasePart") and part and part:IsA("BasePart")) then
		warn("VoidGodAirstrike: AirstrikeDirection>Start/End not found on the Void God")
		return result
	end

	if #baseParts == 0 then
		warn("VoidGodAirstrike: no parts under AirstrikeTargets on the Void God")
		return result
	end

	local random = Random.new(data.Seed)
	local v = (part.Position - start.Position) * createVector(1, 0, 1)

	if v.Magnitude < 0.001 then
		warn("VoidGodAirstrike: AirstrikeDirection Start and End are on top of each other")
		return result
	end

	local directionVarianceDegrees = math.rad(Config.DirectionVarianceDegrees)
	local unit = (CFrame.Angles(0, random:NextNumber(-directionVarianceDegrees, directionVarianceDegrees), 0) * v.Unit).Unit
	local unit2 = unit:Cross(createVector(0, 1, 0)).Unit
	local v2 = createVector(0, 0, 0)
	local v3 = -1e999

	for _, v4 in ipairs(baseParts) do
		v2 += v4.Position
		v3 = math.max(v3, v4.Position.Y)
	end

	local v4 = v2 / #baseParts
	local vector = Vector3.new(v4.X, v3 + Config.AltitudeAboveTargets, v4.Z)
	local v5 = #data.Planes

	for i, plane in ipairs(data.Planes) do
		local missiles = {}

		for j, missileHitTime in ipairs(plane.MissileHitTimes) do
			table.insert(missiles, {
				LaunchTime = math.max(0, missileHitTime - Config.MissileFlightTime),
				HitTime = missileHitTime,
				TargetPart = baseParts[random:NextInteger(1, #baseParts)],
				BurstIndex = j,
				Launched = false
			})
		end

		local v6 = not missiles[1] and 0 or missiles[1].LaunchTime
		local v7 = vector + unit2 * ((i - (v5 + 1) / 2) * Config.FormationSpacing) + Vector3.new(0, (i - 1) * Config.FormationAltitudeStep, 0)
		local leadPlaneSpeed = Config.LeadPlaneSpeed

		if i > 1 then
			local followingPlaneSpeedVariance = Config.FollowingPlaneSpeedVariance
			leadPlaneSpeed = Config.FollowingPlaneSpeed + random:NextNumber(
				-followingPlaneSpeedVariance,
				followingPlaneSpeedVariance
			)
		end

		local crashTime = plane.CrashTime
		local v8

		if crashTime then
			local crashTargetPart = baseParts[random:NextInteger(1, #baseParts)]
			local position = crashTargetPart.Position
			local v9 = math.max(leadPlaneSpeed * crashTime, 1)
			local v10 = math.clamp(v7.Y - position.Y, 0, v9)
			local start2 = position - unit * math.sqrt(v9 ^ 2 - v10 ^ 2) + createVector(0, 1, 0) * v10
			v8 = NewPlane(start2, (position - start2).Unit, leadPlaneSpeed, p)
			v8.EndTime = crashTime
			v8.CrashTime = crashTime
			v8.CrashTargetPart = crashTargetPart
		else
			local v9 = Config.ReleaseDistance + leadPlaneSpeed * v6
			v8 = NewPlane(v7 - unit * v9, unit, leadPlaneSpeed, p)
			v8.EndTime = (v9 + Config.ExitDistance) / leadPlaneSpeed
		end

		v8.Missiles = missiles
		table.insert(result, v8)
	end

	return result
end

function VoidGodAirstrike.new(hash: number, name: string, list, speedMultiplier: number)
	return (setmetatable({
		Hash = hash,
		Name = name,
		EndOnRestart = true,
		Elapsed = 0,
		SpeedMultiplier = speedMultiplier,
		Planes = CreatePlanes(list[1], speedMultiplier)
	}, VoidGodAirstrike))
end

function VoidGodAirstrike:Run(p: number)
	self.Elapsed += p

	for _, plane in ipairs(self.Planes) do
		RunPlane(plane, self.Elapsed)
		local elapsed = self.Elapsed
		local portalWrapper = plane.PortalWrapper

		if not portalWrapper then
			continue
		end

		if not plane.PortalStopped and Config.PortalDuration <= elapsed then
			plane.PortalStopped = true
			portalWrapper:StopContinuous()
		end

		if Config.PortalDuration + 5 <= elapsed then
			DestroyPortal(plane) -- inferred equivalent call
		end
	end
end

function VoidGodAirstrike.IsCleanupReady(p)
	for _, plane in ipairs(p.Planes) do
		if not plane.Destroyed or plane.Portal then
			return false
		end
	end

	return true
end

function VoidGodAirstrike:SpeedMultiplierChanged(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, plane in ipairs(self.Planes) do
		if not plane.Destroyed then
			ScaleTrails(plane, speedMultiplier) -- inferred equivalent call

			for _, wrapper in pairs(plane.Wrappers) do
				wrapper:SpeedMultiplierChanged(speedMultiplier)
			end
		end

		if plane.PortalWrapper then
			plane.PortalWrapper:SpeedMultiplierChanged(speedMultiplier)
		end
	end
end

function VoidGodAirstrike:EndEarly()
	for _, plane in ipairs(self.Planes) do
		DestroyPlane(plane) -- inferred equivalent call
		DestroyPortal(plane) -- inferred equivalent call
	end
end

function VoidGodAirstrike:Destroy()
	self:EndEarly()
end

return VoidGodAirstrike