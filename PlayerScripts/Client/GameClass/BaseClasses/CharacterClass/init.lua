local createVector = vector.create
local CharacterClass = {}
CharacterClass.__index = CharacterClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("CustomCodeTypes"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local LazyResourceSounds = require(common:WaitForChild("LazyResourceSounds"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local HashGeneratorClass = require(common:WaitForChild("HashGeneratorClass"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local SkinHandler = require(common:WaitForChild("SkinHandler"))
local BaseRigMethodHandler = require(common:WaitForChild("BaseRigMethodHandler"))
local BeamEffectHelper = require(common:WaitForChild("BeamEffectHelper"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local PreloadHandler = require(common:WaitForChild("PreloadHandler"))
local VisualEffectHandler = require(script.Parent.Parent:WaitForChild("VisualEffectHandler"))
local AnimationHandlerClass = require(script.Parent:WaitForChild("AnimationHandlerClass"))
local DeathEffectHandler = require(script:WaitForChild("DeathEffectHandler"))
local RingHandlerClass = require(script:WaitForChild("RingHandlerClass"))
local CharacterOverlayPartHandlerClass = require(script:WaitForChild("CharacterOverlayPartHandlerClass"))
local TurretHandlerClass = require(script:WaitForChild("TurretHandlerClass"))
local RotatingBarrelHandlerClass = require(script:WaitForChild("RotatingBarrelHandlerClass"))
local FirstPersonHitHandlerClass = require(script:WaitForChild("FirstPersonHitHandlerClass"))
local SpawnLandingHandlerClass = require(script:WaitForChild("SpawnLandingHandlerClass"))
local CLIENT_DEFAULT_FPS = _G.CLIENT_DEFAULT_FPS
local v = 0.25 * CLIENT_DEFAULT_FPS
local color = Color3.fromRGB(80, 80, 80)
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = {
	Color = Color3.fromRGB(162, 235, 255),
	Material = Enum.Material.Ice,
	Transparency = 0.7,
	InitialEffectInstances = ResourceManager.GetMiscResource("FreezeEffects", true):GetChildren(),
	FinishEffectInstances = ResourceManager.GetMiscResource("ThawEffects", true):GetChildren()
}
CharacterClass.CHARACTER_OVERLAYS = {
	ICE_CHARACTER_OVERLAY_CONFIG = v2,
	UBER_CHARACTER_OVERLAY_CONFIG = {
		Color = Color3.fromRGB(255, 16, 72),
		Material = Enum.Material.Ice,
		Transparency = 0.7,
		InitialEffectInstances = ResourceManager.GetMiscResource("UberEffects", true):GetChildren()
	}
}
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")
local event = BindableHandler.GetEvent("SetSpeedMultiplier")
local torsos = {}
local values = {}
local v3 = {}
local v4 = HashGeneratorClass.New()
local total = 0
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER
local v5 = false

local function CreateCharacterModel(state, parent, object, flag: boolean?, p: number?, p2: number?)
	local kind = state.Type
	local overrideModelName = state.OverrideModelName or kind
	local skinName = state.SkinName
	local pathLevelString = state.PathLevelString
	local entityClass = state.EntityClass
	local config = state.Config
	local folder = nil
	local v6 = nil
	local sizes = {}
	local v7 = TowerUtilities.AppendPathLevelString(overrideModelName, pathLevelString)
	local cframe = CFrame.new()

	if entityClass == "Enemy" then
		folder = ResourceManager.GetEnemyModel(v7, p)
	elseif entityClass == "Tower" then
		local pathLockLevel = config.UpgradePathData.PathLockLevel
		local v8 = not object and 0 or object:GetPath() or 0
		local overallLevel = object and object:GetOverallLevel() or 0
		local overridePath1Level = state.OverridePath1Level
		local overridePath2Level = state.OverridePath2Level

		if overridePath1Level and overridePath2Level then
			v8 = pathLockLevel <= overridePath1Level and 1 or pathLockLevel <= overridePath2Level and 2 or v8
			overallLevel = math.max(overridePath1Level, overridePath2Level)
		end

		state.OverridePath1Level = nil
		state.OverridePath2Level = nil
		local v9
		folder, v9 = ResourceManager.GetTowerModel(v7, v8, overallLevel, pathLockLevel)

		if folder:GetAttribute("UseBaseRigMethod") then
			folder = BaseRigMethodHandler.SetUp(folder, v9)
		end

		if skinName then
			folder, v6 = SkinHandler.ApplySkin("Tower", kind, skinName, folder, v8, overallLevel, pathLockLevel)
		end

		if v9 then
			cframe *= Utilities.TryReadChildValue(v9, "CFrameOffset", CFrame.new())
		end

		if v6 and v6.CFrameOffset then
			cframe *= v6.CFrameOffset
		end
	elseif entityClass == "StaticEntity" then
		folder = ResourceManager.GetStaticEntityModel(v7, p)

		if skinName then
			folder, v6 = SkinHandler.ApplySkin("StaticEntity", kind, skinName, folder, nil, nil, nil, v7)
		end
	elseif entityClass == "PathEntity" then
		folder = ResourceManager.GetPathEntityModel(v7, p)

		if skinName then
			folder, v6 = SkinHandler.ApplySkin("PathEntity", kind, skinName, folder, nil, nil, nil, v7)
		end
	elseif entityClass == "AttachmentEntity" then
		folder = ResourceManager.GetAttachmentEntityModel(v7)
	elseif entityClass == "MapEntity" then
		folder = ResourceManager.GetMapEntityModel(v7)
	end

	assert(folder, "Model not found for AdjustedModelName " .. v7)
	local primaryPart = folder.PrimaryPart
	assert(primaryPart, kind .. ` ({v7}) model did not have a primary part set`)
	local autoWeldAllBaseparts = folder:GetAttribute("AutoWeldAllBaseparts")

	for _, descendant in pairs(folder:GetDescendants()) do
		if descendant == primaryPart then
			continue
		end

		if autoWeldAllBaseparts then
			if descendant:IsA("BasePart") then
				Utilities.Weld(primaryPart, descendant)
			end
		elseif descendant:IsA("Model") then
			local weldAllBasepartsToPart = descendant:GetAttribute("WeldAllBasepartsToPart")

			if weldAllBasepartsToPart then
				local child = descendant:FindFirstChild(weldAllBasepartsToPart)

				if child then
					for _, child2 in pairs(descendant:GetChildren()) do
						if child2 ~= child then
							Utilities.Weld(child, child2)
						end
					end
				else
					warn("PartToWeldChildrenTo not found for " .. weldAllBasepartsToPart)
				end
			end
		end
	end

	local v8 = cframe * Utilities.TryReadChildValue(primaryPart, "CFrameOffset", CFrame.new())
	local v9 = Utilities.TryReadChildValue(folder, "HoverHeight", false)
		or folder:GetAttribute("HoverHeight")
		or v6 and v6.HoverHeight
		or config.HoverHeight
		or (state.HoverHeightMultiplier or 1.5) * primaryPart.Size.Y

	if p2 then
		v9 += p2
	end

	folder:PivotTo(parent.CFrame * CFrame.new(0, v9, 0) * (config.RotationOffset * v8))
	local weld = Utilities.Weld(parent, primaryPart)
	primaryPart.Anchored = false

	if entityClass == "Tower" or entityClass == "PathEntity" then
		LazyResourceSounds.Restore(folder)
	end

	folder.Parent = parent

	if not (flag or config.NoTweenOnSpawn or state.NoSpawnTween) then
		for _, v10 in pairs(Utilities.GetAllBasepartDescendants(folder)) do
			local size = v10.Size
			sizes[v10] = size
			v10.Size = createVector(0, 0, 0)
			TweenService:Create(v10, tweenInfo, { Size = size }):Play()
		end
	end

	local setup = folder:FindFirstChild("Setup")

	if setup then
		require(setup)
	end

	return folder, sizes, v6, weld, v9
end

local function ProcessDeathEffectsData(deathEffectsData, deathExplodePartsDelay: number?)
	local result = {}

	for _, item in pairs(deathEffectsData) do
		table.insert(result, {
			InstancePath = item.InstancePath,
			EffectWrapper = nil,
			TimeUntilTrigger = deathExplodePartsDelay or item.Delay or 0,
			Triggered = false
		})
	end

	return result
end

local function GetRandomSoundWithName(instance, p: string)
	local sounds = {}

	for _, sound in pairs(instance:GetChildren()) do
		if sound:IsA("Sound") and sound.Name == p then
			table.insert(sounds, sound)
		end
	end

	local count = #sounds

	if count > 1 then
		return sounds[math.random(1, count)]
	end

	return sounds[1]
end

local function GetDeathSound(p, primaryPart) -- 2 equivalent calls inferred from this helper
	if p then
		return GetRandomSoundWithName(p, "Death") or GetRandomSoundWithName(primaryPart, "Death")
	end
end

local function GetSpawnSound(p, primaryPart) -- 2 equivalent calls inferred from this helper
	if p then
		return GetRandomSoundWithName(p, "Spawn") or GetRandomSoundWithName(primaryPart, "Spawn")
	end
end

local function GetStealthShimmerElements(folder, entityClass: string, projectileRegenerationModels, stealthMaintainColor: boolean?, fpsPartToOriginalParentMap)
	local instances = {}
	local instances2 = {}
	local instances3 = {}
	local v6 = entityClass == "Enemy"
	local v7 = {}

	if projectileRegenerationModels then
		for _, item in pairs(projectileRegenerationModels) do
			for k, v8 in pairs(item.OriginalTransparencyMap) do
				v7[k] = v8
			end
		end
	end

	local function HandleDescendant(instance)
		if instance:IsA("BasePart") then
			if instance:GetAttribute("IsOverlayPart") then
				return
			end

			local v8 = v7[instance] or instance:GetAttribute("OriginalTransparency")

			if (v6 and 0.4 or 0.9) > (v8 or instance.Transparency) or instance.Material == Enum.Material.Glass then
				instance:SetAttribute("OriginalTransparency", v8 or instance.Transparency)
				instance:SetAttribute("OriginalCastShadow", instance.CastShadow)
				table.insert(instances, instance)
				instance.CastShadow = false

				if not (v6 or stealthMaintainColor) then
					instance:SetAttribute("OriginalColor", instance.Color)
					instance:SetAttribute("OriginalMaterial", instance.Material)

					if instance:IsA("MeshPart") then
						instance:SetAttribute("OriginalTextureId", instance.TextureID)
					end

					if instance.Reflectance > 0 then
						instance:SetAttribute("OriginalReflectance", instance.Reflectance)
					end
				end
			end
		elseif instance:IsA("Decal") or instance:IsA("Texture") then
			if not v6 then
				instance:SetAttribute("OriginalTransparency", instance.Transparency)
				table.insert(instances2, instance)
			end
		elseif instance:IsA("SpecialMesh") and not v6 then
			instance:SetAttribute("OriginalTextureId", instance.TextureId)
			table.insert(instances3, instance)
		end
	end

	for _, descendant in pairs(folder:GetDescendants()) do
		HandleDescendant(descendant)
	end

	if not fpsPartToOriginalParentMap then
		return instances, instances2, instances3
	end

	for folder2 in pairs(fpsPartToOriginalParentMap) do
		HandleDescendant(folder2)

		for _, descendant in pairs(folder2:GetDescendants()) do
			HandleDescendant(descendant)
		end
	end

	return instances, instances2, instances3
end

local function GetChangeColorParts(p)
	local allBasepartDescendants = Utilities.GetAllBasepartDescendants(p)
	local allBasepartDescendants2 = {}

	for _, allBasepartDescendant in pairs(allBasepartDescendants) do
		if Utilities.TryReadChildValue(allBasepartDescendant, "ChangeColorPart", false) then
			table.insert(allBasepartDescendants2, allBasepartDescendant)
		end
	end

	return allBasepartDescendants2
end

local function GetFootstepEffectWrapper(p, footstepEffectInstanceNames)
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
	local v6 = typeof(footstepEffectInstanceNames) == "string" and { footstepEffectInstanceNames }
		or footstepEffectInstanceNames

	for _, v7 in pairs(v6) do
		local v8 = Utilities.TryGetInstanceFromPath(p, v7)

		if v8 then
			emitterAndSoundWrapper:AddFrom(v8, DEFAULT_SPEED_MULTIPLIER)
		else
			warn("Couldn't find effect instance with name " .. v7)
		end
	end

	emitterAndSoundWrapper:SetAttributeOnAllSounds("NoFadeOut", true)
	return emitterAndSoundWrapper
end

local function MakeWrappers(folder, list)
	local wrapperPointers = folder:FindFirstChild("WrapperPointers")
	local v6 = nil
	local v7 = nil
	local deathStopDelay

	if wrapperPointers then
		local v8 = {}

		for _, child in pairs(wrapperPointers:GetChildren()) do
			local value

			if child:IsA("ObjectValue") then
				value = child.Value
			elseif child:IsA("StringValue") then
				value = Utilities.TryGetInstanceFromPath(folder, child.Value)
			else
				warn("MakeWrappers: Invalid value type")
				continue
			end

			if value then
				if v8[value] then
					warn("Duplicate wrapper pointer for " .. value.Name)
				else
					v8[value] = true
				end

				table.insert(list, value)
			else
				warn("MakeWrappers: Object not found for", child:GetFullName())
			end
		end

		deathStopDelay = wrapperPointers:GetAttribute("DeathStopDelay")
	end

	if folder:GetAttribute("SetUpDefaultWrappers") then
		for _, emitter in pairs(folder:GetDescendants()) do
			if not (emitter:IsA("ParticleEmitter") and emitter.Enabled) then
				continue
			end

			emitter:SetAttribute("Continuous", true)
			table.insert(list, emitter)
		end
	end

	if not (#list > 0) then
		return v6, v7, deathStopDelay
	end

	for _, instance in pairs(list) do
		if instance:IsA("ParticleEmitter") then
			v6 = v6 or WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
			v6:AddEmitter(instance, DEFAULT_SPEED_MULTIPLIER)
		elseif instance:IsA("PointLight") or instance:IsA("SpotLight") or instance:IsA("SurfaceLight") then
			v6 = v6 or WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
			v6:AddLight(instance)
		elseif instance:IsA("Sound") then
			v7 = v7 or WrapperFactory.NewSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
			v7:AddSound(instance, DEFAULT_SPEED_MULTIPLIER)
		else
			v6 = v6 or WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
			v7 = v7 or WrapperFactory.NewSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
			v6:AddEmittersFrom(instance, DEFAULT_SPEED_MULTIPLIER)
			v7:AddSoundsFrom(instance, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	return v6, v7, deathStopDelay
end

local function FindTorsoBone(primaryPart)
	local torso = primaryPart:FindFirstChild("Torso")
		or primaryPart:FindFirstChild("torso")
		or Utilities.TryGetInstanceFromPath(primaryPart, "Root>Torso")

	if torso and torso:IsA("Bone") then
		return torso
	end

	return primaryPart:FindFirstChildOfClass("Bone")
end

local function MakeGeneratedPart(instance, p, instance2)
	local parent = instance:FindFirstChild("Atrazine_Generated")

	if not parent then
		parent = Instance.new("Model", instance)
		parent.Name = "Atrazine_Generated"
	end

	local miscResource = ResourceManager.GetMiscResource("FormattedPart")
	miscResource.Size = instance:GetScale() * instance2.MeshSize
	miscResource.CFrame = instance2.CFrame
	miscResource.Parent = parent

	for _, child in pairs(instance2:GetChildren()) do
		if child:IsA("ParticleEmitter") or child:IsA("Sound") then
			child.Parent = miscResource
		end
	end

	Utilities.WeldToBone(p, parent, { miscResource })
	return miscResource
end

local function GetHead(instance, flag: boolean?, noHead: boolean?, head, headPath)
	local primaryPart = instance.PrimaryPart

	if not head then
		if headPath then
			head = Utilities.TryGetInstanceFromPath(instance, headPath.Value)
		else
			head = instance:FindFirstChild("Head")
				or instance:FindFirstChild("head")
				or instance:FindFirstChild("Head1")
				or instance:FindFirstChild("hood_suit")
		end
	end

	local torsoBone = FindTorsoBone(primaryPart)

	if flag then
		return primaryPart
	end

	if head then
		if head:IsA("ObjectValue") then
			head = head.Value
		elseif head:IsA("StringValue") then
			head = Utilities.TryGetInstanceFromPath(instance, head.Value)
		end

		if not (head:IsA("MeshPart") and torsoBone) then
			return head
		end

		local head2 = torsoBone:FindFirstChild("Head") or torsoBone:FindFirstChild("head")

		if not head2 then
			warn("Could not find head bone for " .. instance.Name .. ", using primary part instead")
			return primaryPart
		end

		local generatedPart = MakeGeneratedPart(instance, head2, head)
		generatedPart.Name = "GeneratedHead"
		return generatedPart
	else
		if not noHead then
			warn("Could not find head for " .. instance.Name .. ", using primary part instead")
		end

		return primaryPart
	end
end

local function GetRealTorso(instance, flag: boolean?, noTorso: boolean?, torso, torsoPath)
	local primaryPart = instance.PrimaryPart

	if not torso then
		if torsoPath then
			torso = Utilities.TryGetInstanceFromPath(instance, torsoPath.Value)
		else
			torso = instance:FindFirstChild("Torso")
				or instance:FindFirstChild("Torso ")
				or instance:FindFirstChild("torso")
				or instance:FindFirstChild("Upper Torso")
				or instance:FindFirstChild("UpperTorso")
				or instance:FindFirstChild("torso_suit")
		end
	end

	local torsoBone = FindTorsoBone(primaryPart)

	if flag then
		return primaryPart
	end

	if torso then
		if torso:IsA("ObjectValue") then
			torso = torso.Value
		elseif torso:IsA("StringValue") then
			torso = Utilities.TryGetInstanceFromPath(instance, torso.Value)
		end

		if not (torso:IsA("MeshPart") and torsoBone) then
			return torso
		end

		local generatedPart = MakeGeneratedPart(instance, torsoBone, torso)
		generatedPart.Name = "GeneratedTorso"
		return generatedPart
	else
		if not noTorso then
			warn("Could not find real torso for " .. instance.Name .. ", using primary part instead")
		end

		return primaryPart
	end
end

local function GetOscillationData(instance, instance2)
	local oscillationData = instance:FindFirstChild("OscillationData")
	local useC = instance2 and instance2:FindFirstChild("Animations") ~= nil and true
		or instance:FindFirstChild("Animations") ~= nil

	if not oscillationData then
		return
	end

	local result = {}

	for _, child in pairs(oscillationData:GetChildren()) do
		local weld = nil
		local weldPointer = child:FindFirstChild("WeldPointer")

		if weldPointer then
			if weldPointer:IsA("StringValue") then
				weld = Utilities.TryGetInstanceFromPath(instance, weldPointer.Value)
			elseif weldPointer:IsA("ObjectValue") then
				weld = weldPointer.Value
			end
		end

		local v6 = Utilities.TryReadChildValue(child, "C0AnglePerSecond", (Vector3.new()))
		local v7 = Utilities.TryReadChildValue(child, "C1AnglePerSecond", (Vector3.new()))
		local linkedToMovementSpeed = child:GetAttribute("LinkedToMovementSpeed")
		local movementSpeedBaseline = child:GetAttribute("MovementSpeedBaseline")

		if weld then
			if weld:IsA("Motor6D") then
				if linkedToMovementSpeed and not movementSpeedBaseline then
					warn("GetOscillationData: LinkedToMovementSpeed is true but MovementSpeedBaseline is not set")
				else
					table.insert(result, {
						UseC0 = useC,
						Weld = weld,
						XTransform = v6.X + v7.X,
						YTransform = v6.Y + v7.Y,
						ZTransform = v6.Z + v7.Z,
						LinkedToMovementSpeed = linkedToMovementSpeed,
						MovementSpeedBaseline = movementSpeedBaseline
					})
				end
			else
				warn("GetOscillationData: weld is not a Motor6D", weld:GetFullName())
			end
		else
			warn("GetOscillationData: weld not found")
		end
	end

	return result
end

local function GetWorldFixedJoints(folder)
	if not folder:GetAttribute("HasWorldFixedJoints") then
		return nil
	end

	local v6 = {}

	for _, descendant in ipairs(folder:GetDescendants()) do
		if not ((descendant:IsA("Motor6D") or descendant:IsA("Weld")) and descendant:GetAttribute("WorldFixed") and descendant.Part0 and descendant.Part1) then
			continue
		end

		table.insert(v6, { Joint = descendant, OriginalC0 = descendant.C0 })
	end

	return #v6 > 0 and v6 or nil
end

local function GetGunModel(gunModelName: string, characterModel) -- 1 equivalent call inferred from this helper
	local v6 = Utilities.TryGetInstanceFromPath(characterModel, gunModelName)

	if not v6 then
		warn("Didn't find gun model named " .. tostring(gunModelName))
	end

	return v6
end

local function GetAimEffectWrapper(instance)
	local aimEffects = instance:FindFirstChild("AimEffects")

	if not aimEffects then
		return nil
	end

	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

	for _, child in pairs(aimEffects:GetChildren()) do
		local value = nil

		if child:IsA("ObjectValue") then
			value = child.Value
		elseif child:IsA("StringValue") then
			value = Utilities.TryGetInstanceFromPath(instance, child.Value)

			if not value then
				warn("GetAimEffectWrapper: Object not found", child.Value)
			end
		else
			warn("GetAimEffectWrapper: Invalid value type")
		end

		if value then
			emitterAndSoundWrapper:AddFrom(value, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	return emitterAndSoundWrapper
end

local function ShowModel(part)
	if part:IsA("BasePart") and part.Transparency == 1 then
		part.Transparency = part:GetAttribute("OriginalTransparency") or 1
	end

	for _, part2 in pairs(part:GetDescendants()) do
		if part2:IsA("BasePart") and part2.Transparency == 1 then
			part2.Transparency = part2:GetAttribute("OriginalTransparency") or 1
		end
	end
end

local function HideModel(part)
	if part:IsA("BasePart") then
		if not part:GetAttribute("OriginalTransparency") then
			part:SetAttribute("OriginalTransparency", part.Transparency)
		end

		part.Transparency = 1
	end

	for _, part2 in pairs(part:GetDescendants()) do
		if not part2:IsA("BasePart") then
			continue
		end

		if not part2:GetAttribute("OriginalTransparency") then
			part2:SetAttribute("OriginalTransparency", part2.Transparency)
		end

		part2.Transparency = 1
	end
end

local function ApplyTextureVariants(instance)
	local textureVariants = instance:FindFirstChild("TextureVariants")

	if not textureVariants then
		return
	end

	local namesByName = {}

	for _, child in pairs(textureVariants:GetChildren()) do
		local name = child.Name
		local children = child:GetChildren()
		namesByName[name] = children[math.random(1, #children)].Name
	end

	for _, part in pairs(Utilities.GetAllBasepartDescendants(instance)) do
		local v6 = part:IsA("MeshPart") and part

		if not v6 then
			continue
		end

		local textureID = namesByName[v6.MeshId]

		if textureID then
			v6.TextureID = textureID
		end
	end
end

function CharacterClass.ToggleOscillation()
	v5 = not v5
	RotatingBarrelHandlerClass.ToggleOscillation()
end

function CharacterClass.ToggleTurretAiming()
	TurretHandlerClass.ToggleTurretAiming()
end

function CharacterClass:New(object, randomHash: number?, p)
	local hash = self.Hash
	local kind = self.Type
	local entityClass = self.EntityClass
	local config = self.Config
	local spawnCFrame = self.SpawnCFrame
	local parent = self.Parent
	local stealth = self.Stealth
	local _summoned = self.Summoned
	local cloned = self.Cloned
	local isFakeEnemy = self.IsFakeEnemy
	local turretConfigs = self.TurretConfigs
	local rotatingBarrelData = self.RotatingBarrelData
	local moveAnimationSpeedMultiplier = self.MoveAnimationSpeedMultiplier
	local frozen = self.Frozen
	local freezeAnimationsIfFrozen = entityClass == "Tower"
	local v6 = entityClass == "Enemy"
	local v7 = entityClass == "PathEntity"
	local v8 = entityClass == "AttachmentEntity"

	if config.OverrideCharacterModelName then
		self.OverrideModelName = config.OverrideCharacterModelName
	end

	local v9 = freezeAnimationsIfFrozen and config
	local v10 = v6 and config
	local levelStats = p or object and object:GetLevelStats()

	if levelStats then
		turretConfigs = turretConfigs or levelStats.TurretConfigs
		rotatingBarrelData = rotatingBarrelData or levelStats.RotatingBarrelData
	elseif config.RotatingBarrelData then
		rotatingBarrelData = config.RotatingBarrelData
	end

	local miscResource = ResourceManager.GetMiscResource("Torso")
	miscResource.Name = kind
	miscResource.Transparency = 1
	miscResource.CFrame = spawnCFrame
	miscResource.Parent = parent
	local hoverHeightVariance = config.HoverHeightVariance and config.HoverHeightVariance * (math.random() - 0.5)
	local characterModel, v11, skinModelData, torsoToRootWeld, defaultHoverHeight = CreateCharacterModel(
		self,
		miscResource,
		object,
		nil,
		randomHash,
		hoverHeightVariance
	)
	local noAnimations = (config.NoAnimations or characterModel:GetAttribute("NoAnimations"))
		and not characterModel:GetAttribute("ForceAnimations")

	if characterModel:GetAttribute("IgnoreTurretConfigs") then
		turretConfigs = nil
	end

	local multipleInnerAnimations = characterModel:GetAttribute("MultipleInnerAnimations")
	local innerAnimationsModelName = characterModel:GetAttribute("InnerAnimationsModelName")
	local models = { characterModel }

	if multipleInnerAnimations then
		models = not characterModel:FindFirstChild("Animations") and {} or models

		for _, model in pairs(characterModel:GetChildren()) do
			if model:IsA("Model") and model:FindFirstChild("Animations") then
				table.insert(models, model)
			end
		end
	elseif innerAnimationsModelName then
		local child = characterModel:FindFirstChild(innerAnimationsModelName)

		if child then
			models = { child }
		else
			warn("Couldn't find animation model with name " .. innerAnimationsModelName)
		end
	end

	local v12 = models[1]
	local noHead = config.NoHead or characterModel:GetAttribute("NoHead")
	local noTorso = config.NoTorso or characterModel:GetAttribute("NoTorso")
	local head = GetHead(
		v12,
		isFakeEnemy,
		noHead,
		characterModel:FindFirstChild("Head"),
		characterModel:FindFirstChild("HeadPath")
	)
	local v13 = GetRealTorso(
		v12,
		isFakeEnemy,
		noTorso,
		characterModel:FindFirstChild("Torso"),
		characterModel:FindFirstChild("TorsoPath")
	)
	local animationHandlers = {}
	local primaryAnimationHandler = nil

	if not noAnimations then
		for _, v14 in pairs(models) do
			local v15 = AnimationHandlerClass.New(
				hash,
				kind,
				entityClass,
				config,
				v14,
				DEFAULT_SPEED_MULTIPLIER,
				moveAnimationSpeedMultiplier,
				randomHash
			)

			if not v15 then
				continue
			end

			table.insert(animationHandlers, v15)

			if not primaryAnimationHandler then
				primaryAnimationHandler = v15
			end
		end
	end

	local v14 = {}
	local spawnSound = GetSpawnSound(head, characterModel.PrimaryPart) -- inferred equivalent call

	if spawnSound then
		table.insert(v14, spawnSound)
	end

	if cloned then
		local miscResource2 = ResourceManager.GetMiscResource("ClonedSmoke")
		local miscResource3 = ResourceManager.GetMiscResource("ClonedSparks")
		miscResource2.Parent = v13
		miscResource3.Parent = v13
		table.insert(v14, miscResource2)
		table.insert(v14, miscResource3)
	end

	local emitterWrapper, soundWrapper, generalWrapperDeathStopTimeLeft = MakeWrappers(characterModel, v14)

	if config.SpawnEffectInstanceNames then
		emitterWrapper = emitterWrapper or WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
		soundWrapper = soundWrapper or WrapperFactory.NewSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

		for _, childName in pairs(config.SpawnEffectInstanceNames) do
			local child = characterModel:FindFirstChild(childName)

			if not child then
				continue
			end

			emitterWrapper:AddEmittersFrom(child, DEFAULT_SPEED_MULTIPLIER)
			soundWrapper:AddSoundsFrom(child, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	local animation = (v6 or v7 or v8) and primaryAnimationHandler and primaryAnimationHandler:GetAnimation("Death")
	local characterOverlayPartHandler = CharacterOverlayPartHandlerClass.New(
		freezeAnimationsIfFrozen,
		characterModel,
		v11,
		v13,
		DEFAULT_SPEED_MULTIPLIER,
		freezeAnimationsIfFrozen and levelStats
	)
	ApplyTextureVariants(characterModel)
	local oscillationData = GetOscillationData(characterModel)
	local turretConfigs2 = characterModel:FindFirstChild("TurretConfigs")

	if turretConfigs2 then
		turretConfigs = require(turretConfigs2)
	end

	local turretHandler = turretConfigs
		and TurretHandlerClass.New(characterModel, turretConfigs, DEFAULT_SPEED_MULTIPLIER)
	local rotatingBarrelHandlers = nil
	local rotatingBarrelData2 = characterModel:FindFirstChild("RotatingBarrelData")

	if rotatingBarrelData2 then
		rotatingBarrelData = require(rotatingBarrelData2)
	end

	if rotatingBarrelData then
		rotatingBarrelHandlers = {}

		for _, v15 in pairs(rotatingBarrelData) do
			local v16 = RotatingBarrelHandlerClass.New(characterModel, v15, config.NoAnimations)

			if v16 then
				table.insert(rotatingBarrelHandlers, v16)
			end
		end
	end

	local aimEffectWrapper = GetAimEffectWrapper(characterModel)
	local shieldModelName = v6 and v10.ShieldModelName or v7 and (v7 and config).ShieldModelName
	local child = shieldModelName and characterModel:FindFirstChild(shieldModelName)
	local shieldModelInstances = child and Utilities.GetAllBasepartDescendants(child)
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(child, DEFAULT_SPEED_MULTIPLIER)
	local placementEffectName = characterModel:GetAttribute("PlacementEffectName")
	local hitEffectName = characterModel:GetAttribute("HitEffectName")
	local deathEffectName = characterModel:GetAttribute("DeathEffectName")
	local hasBeamEffectForDefaultAttack = characterModel:GetAttribute("HasBeamEffectForDefaultAttack")
	local defaultBeamEffectHandlingData = v9 and v9.DefaultBeamEffectHandlingData
		or v10 and v10.DefaultBeamEffectHandlingData
	local defaultBeamEffects

	if
		defaultBeamEffectHandlingData
		and (not v9 or v9.BeamEffectForDefaultAttack or v9.BeamEffectForHeal or hasBeamEffectForDefaultAttack)
	then
		defaultBeamEffects = BeamEffectHelper.NewBeamEffects(
			characterModel,
			defaultBeamEffectHandlingData,
			DEFAULT_SPEED_MULTIPLIER
		)
	end

	local postTeleportEffectWrapper

	if v10 and v10.PostTeleportEffectParentInstanceNames then
		postTeleportEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

		for _, postTeleportEffectParentInstanceName in pairs(v10.PostTeleportEffectParentInstanceNames) do
			local v15 = Utilities.TryGetInstanceFromPath(characterModel, postTeleportEffectParentInstanceName)

			if v15 then
				postTeleportEffectWrapper:AddFrom(v15, DEFAULT_SPEED_MULTIPLIER)
			else
				warn("Couldn't find post-teleport effect instance with name " .. postTeleportEffectParentInstanceName)
			end
		end
	end

	local spawnLandingHandler = config.SpawnLandingData and SpawnLandingHandlerClass.New(config)
	local v15 = {
		Hash = hash,
		RandomHash = randomHash,
		NewCharacterData = self,
		Type = kind,
		EntityClass = entityClass,
		Config = config,
		CustomCode = nil,
		Radius = config.Radius,
		Torso = miscResource,
		CharacterModel = characterModel,
		SkinModelData = skinModelData,
		TorsoToRootWeld = torsoToRootWeld,
		WorldFixedJoints = GetWorldFixedJoints(characterModel),
		WorldFixedBaseRotation = nil,
		WorldFixedCaptureNext = false,
		DefaultHoverHeight = defaultHoverHeight,
		HoverHeightVariance = hoverHeightVariance,
		CurrentHoverHeight = nil,
		PrimaryPart = characterModel.PrimaryPart,
		NoHead = noHead,
		Head = head,
		RealTorso = v13,
		NoAnimations = noAnimations,
		AnimationHandlers = animationHandlers,
		PrimaryAnimationHandler = primaryAnimationHandler,
		MovementAnimationHasBeenOverriden = false,
		CurrentMovementAnimationName = "Move",
		DeathEffect = deathEffectName or config.DeathEffect,
		DeathEffectPlayed = false,
		DeathEffectsModelWrapper = nil,
		DeathRemoveTextures = config.DeathRemoveTextures,
		DeathColor = config.DeathColor,
		DeathMaterial = config.DeathMaterial,
		DeathStopCurrentAnimation = config.DeathStopCurrentAnimation,
		DeathSound = GetDeathSound(head, characterModel.PrimaryPart), -- inferred equivalent call
		FadeOutOnDeath = config.FadeOutOnDeath,
		DeathAnimation = animation,
		FadeOutDelay = config.FadeOutDelay,
		FadeOutTime = config.FadeOutCustomTime or 0.15,
		FadeOutRemoveDelay = config.FadeOutRemoveDelay,
		RingHandler = nil,
		OverallLevel = 0,
		ShimmerIfStealth = v6 or levelStats and levelStats.Stealth,
		CurrentStaticStealthTransparency = 0,
		StealthMaintainColor = config.StealthMaintainColor,
		StealthShimmerOffset = nil,
		StealthShimmerMultiplier = nil,
		StealthShimmerParts = nil,
		StealthShimmerDecals = nil,
		StealthShimmerSpecialMeshes = nil,
		Stealth = stealth,
		NoStealthShimmer = config.NoStealthShimmer,
		CurrentStealthTransparency = 0,
		StealthShimmerStopped = true,
		StealthEffectWrapper = nil,
		ChangeColorParts = config.HasChangeColorParts and GetChangeColorParts(characterModel),
		OscillationData = oscillationData,
		ParentCurrentMovementSpeed = nil,
		ShieldModelInstances = shieldModelInstances,
		ShieldEffectWrapper = emitterAndSoundWrapper,
		ShieldModelOn = false,
		ShieldModelTimeLeft = 0,
		ShieldModelCurrentTransparency = 1,
		OverridePlacementEffectName = placementEffectName,
		OverrideHitEffectName = hitEffectName,
		RingYOffset = characterModel:GetAttribute("RingYOffset"),
		OverrideBurstSizeFromCharacter = characterModel:GetAttribute("OverrideBurstSize"),
		OverrideBurstIntervalFromCharacter = characterModel:GetAttribute("OverrideBurstInterval"),
		FPSParts = nil,
		FPSPartToOriginalParentMap = nil,
		OverrideHasBeamEffectForDefaultAttack = hasBeamEffectForDefaultAttack,
		AttackNoFaceTarget = characterModel:GetAttribute("AttackNoFaceTarget"),
		IgnoreNoRestartAttackAnimationIfPlaying = characterModel:GetAttribute("IgnoreNoRestartAttackAnimationIfPlaying"),
		LevelStats = levelStats,
		TowerSelected = false,
		TowerRebuilding = false,
		TowerConverted = false,
		TowerDead = false,
		RebuildVFXName = v9 and v9.RebuildVFX,
		RebuildVFXOffset = v9 and v9.RebuildVFXOffset,
		CurrentRebuildVFX = nil,
		LerpRotation = characterModel:GetAttribute("LerpRotation"),
		LerpAlpha = characterModel:GetAttribute("LerpAlpha"),
		DeathHash = nil,
		DeathAnimationFinished = true,
		DeathFadeOutDelayTimeLeft = nil,
		DeathFadeOutTimeLeft = nil,
		DeathFadeOutRemoveDelayTimeLeft = nil,
		DeathFadeOutParts = nil,
		DeathEffectInstanceNames = config.DeathEffectInstanceNames,
		DeathExplodePartsDone = false,
		DeathExplodePartsScale = config.DeathExplodePartsScale,
		DeathExplodePartsTimeLeft = config.DeathExplodePartsDelay or 0,
		ExplodePartsExtraKeepTime = config.ExplodePartsExtraKeepTime,
		InternalDeathEffectsData = config.DeathEffectsData and ProcessDeathEffectsData(
			config.DeathEffectsData,
			config.DeathExplodePartsDelay
		),
		EmitterWrapper = emitterWrapper,
		SoundWrapper = soundWrapper,
		GeneralWrapperDeathStopTimeLeft = generalWrapperDeathStopTimeLeft,
		GeneralWrapperStopped = false,
		BurnNameToEmitterWrapperMap = {},
		ActiveStunMap = {},
		StunNameToEffectWrapperMap = {},
		TakingExtraDamage = false,
		TakingExtraDamageEffectWrapper = nil,
		FootstepEffectInstanceNames = config.FootstepEffectInstanceNames,
		FootstepEffectWrapper = nil,
		CharacterOverlayPartHandler = characterOverlayPartHandler,
		FreezeAnimationsIfFrozen = freezeAnimationsIfFrozen,
		ProjectileOriginEffectWrappers = nil,
		ProjectileRegenerationModels = nil,
		TriggerProjectileOriginModel = nil,
		TriggerProjectileOriginEffectDelay = nil,
		ProjectilesFiredCount = 0,
		TurretHandler = turretHandler,
		RotatingBarrelHandlers = rotatingBarrelHandlers,
		ProjectileTurretHandlerMap = nil,
		TimeSinceLastAttack = 1e999,
		GunModelName = characterModel:GetAttribute("GunModelName") or config.GunModelName,
		AttackEffectsDelay = config.GunModelEffectsDelay,
		AttackSoundGroupPlaying = false,
		AttackSoundGroupName = config.GunModelSoundGroupName,
		AttackSoundGroupStopDelay = config.GunModelSoundGroupStopDelay,
		GunModelSoundGroupStopDelayBufferForTowers = config.GunModelSoundGroupStopDelayBufferForTowers,
		SpecialBurstHandlingForModel = v9 and v9.SpecialBurstHandlingForModel,
		AttackEmitterWrapperMap = nil,
		AttackSoundWrapperMap = nil,
		AttackEffectsDelayRemainingMap = nil,
		AimEffectWrapper = aimEffectWrapper,
		AttackHideForTimeData = nil,
		AttackBurstModulo = nil,
		HiddenModels = {},
		HiddenModelsNameToVisibleMap = {},
		HideGunModelForVictoryDance = characterModel:GetAttribute("HideGunModelForVictoryDance"),
		DefaultBeamEffectHandlingData = defaultBeamEffectHandlingData,
		DefaultBeamEffects = defaultBeamEffects,
		FirstPersonHitHandler = nil,
		StunNameToPartsMap = {},
		PreTeleportVFXName = v10 and v10.PreTeleportVFXName,
		PostTeleportEffectWrapper = postTeleportEffectWrapper,
		SpawnLandingHandler = spawnLandingHandler,
		EnemyUberHighlight = nil,
		SavedTemporaryInstances = {},
		SavedObjectValuePointers = {},
		DeathClone = nil,
		DeathCloneSavedCFrames = {},
		OriginalCharacterModel = nil,
		CFrameRestoreTweens = {}
	}

	if emitterWrapper then
		emitterWrapper:PlayAll()
	end

	if soundWrapper then
		soundWrapper:PlayAll()
	end

	if v15.FootstepEffectInstanceNames then
		v15.FootstepEffectWrapper = GetFootstepEffectWrapper(characterModel, v15.FootstepEffectInstanceNames)
	end

	if animationHandlers then
		for _, v16 in pairs(animationHandlers) do
			v16:InitializeWithCharacter(v15)
		end
	end

	setmetatable(v15, CharacterClass)

	if v15.GunModelName then
		v15:_SetUpAttackEffectWrappers()
	end

	if stealth and not v15.NoStealthShimmer then
		v15:RunStealthShimmer()
	end

	if not freezeAnimationsIfFrozen and frozen then
		v15:Freeze(true)
	end

	v15:_ProcessBaseParts()
	v15:_SetUpTrailTeleportGuards()

	if spawnLandingHandler then
		spawnLandingHandler:SetCharacter(v15, DEFAULT_SPEED_MULTIPLIER)
	end

	return v15
end

function CharacterClass.PreloadEnemies(p)
	PreloadHandler.PreloadEnemies(p)
end

local v6 = {}

local function TickVoidDeathSequence(state, p: number)
	state.ElapsedTime += p
	local elapsedTime = state.ElapsedTime

	if not (state.GrowFinished or state.Closing) then
		local v7 = math.min(elapsedTime / 0.35, 1)
		state.CurrentScale = state.PortalScale * TweenService:GetValue(
			v7,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		state.SetPortalVisualScale(state.CurrentScale)

		if v7 >= 1 then
			state.GrowFinished = true

			for k, rate in state.PortalEmitterBaseRateMap do
				k.Rate = rate
			end
		end
	end

	if state.Clone and elapsedTime >= 0.25 then
		local v7 = math.min((elapsedTime - 0.25) / 0.6, 1)
		state.Clone:PivotTo(state.SinkStartCFrame:Lerp(
			state.SinkTargetCFrame,
			TweenService:GetValue(v7, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		))
	end

	if state.Clone and elapsedTime >= 1 then
		if not state.FadeItems then
			state.FadeItems = {}

			for _, descendant in state.Clone:GetDescendants() do
				if not ((descendant:IsA("BasePart") or descendant:IsA("Decal") or descendant:IsA("Texture")) and descendant.Transparency < 1) then
					continue
				end

				table.insert(state.FadeItems, {
					Instance = descendant,
					Transparency = descendant.Transparency
				})
			end
		end

		local v7 = math.min((elapsedTime - 1) / 0.5, 1)

		for _, fadeItem in state.FadeItems do
			fadeItem.Instance.Transparency = fadeItem.Transparency + (1 - fadeItem.Transparency) * v7
		end

		if elapsedTime >= 1.6 then
			state.Clone:Destroy()
			state.Clone = nil
			state.FadeItems = nil
		end
	end

	if state.Closing then
		if not state.CloseEntered then
			state.CloseEntered = true
			state.CloseStartScale = state.CurrentScale

			for k, v7 in state.PortalEmitterBaseRateMap do
				k.Rate = v7 * 8
				k:Clear()
			end
		end

		state.CloseElapsed += p
		local v7 = math.min(state.CloseElapsed / 0.35, 1)
		state.CurrentScale = state.CloseStartScale * (1 - TweenService:GetValue(
			v7,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		))
		state.SetPortalVisualScale(state.CurrentScale)

		if v7 >= 1 then
			if state.Portal then
				state.Portal:Destroy()
				state.Portal = nil
			end

			v6[state] = nil
		end
	elseif state.GrowFinished and not state.Clone then
		v6[state] = nil
	end
end

local v7 = {}

local function TickTrailTeleportGuard(state) -- 1 equivalent call inferred from this helper
	local position = state.Part.Position

	if state.LastPosition and (position - state.LastPosition).Magnitude > 100 then
		state.Trail:Clear()
	end

	state.LastPosition = position
end

function CharacterClass.Tick(p: number, p2: number)
	workspace:BulkMoveTo(torsos, values, Enum.BulkMoveMode.FireCFrameChanged)
	table.clear(torsos)
	table.clear(values)
	total += p
	DeathEffectHandler.Tick(p)

	for k in pairs(v6) do
		TickVoidDeathSequence(k, p)
	end

	for k in pairs(v7) do
		TickTrailTeleportGuard(k) -- inferred equivalent call
	end

	for _, v8 in pairs(v3) do
		v8:RunDeathLogic(p, p2)
	end
end

function CharacterClass:Run(p: number)
	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:Run(p)
		end
	end

	if self.CharacterOverlayPartHandler then
		self.CharacterOverlayPartHandler:Run(p)
	end

	if self.CustomCode then
		self.CustomCode:Run_FromCharacter(p)
	end

	local projectileRegenerationModels = self.ProjectileRegenerationModels
	local v8 = not (self.ShimmerIfStealth or self.StealthShimmerStopped)
	local currentStaticStealthTransparency = self.CurrentStaticStealthTransparency

	if projectileRegenerationModels then
		for _, projectileRegenerationModel in pairs(projectileRegenerationModels) do
			if not (projectileRegenerationModel.TimeLeft > 0) then
				continue
			end

			if projectileRegenerationModel.DelayLeft > 0 then
				projectileRegenerationModel.DelayLeft -= p
			else
				projectileRegenerationModel.TimeLeft -= p
				local v9 = math.max(0, projectileRegenerationModel.TimeLeft / projectileRegenerationModel.TotalTimeLeft)

				if v8 then
					v9 = math.max(v9, currentStaticStealthTransparency)
				end

				for k, v10 in pairs(projectileRegenerationModel.OriginalTransparencyMap) do
					local transparency = math.max(v9, v10)
					k.Transparency = transparency
					k:SetAttribute("StealthShimmerOverrideMinTransparency", transparency)
				end
			end
		end
	end

	local attackHideForTimeData = self.AttackHideForTimeData

	if attackHideForTimeData then
		for _, v9 in pairs(attackHideForTimeData) do
			v9.TimeLeft -= p
			local visible = v9.TimeLeft <= 0

			if visible == v9.Visible then
				continue
			end

			v9.Visible = visible

			if visible then
				for _, instance in pairs(v9.Instances) do
					local originalTransparency = instance:GetAttribute("OriginalTransparency") or 0
					instance.Transparency = originalTransparency
					instance:SetAttribute("StealthShimmerOverrideMinTransparency", originalTransparency)
				end
			else
				for _, instance in pairs(v9.Instances) do
					instance.Transparency = 1
					instance:SetAttribute("StealthShimmerOverrideMinTransparency", 1)
				end
			end
		end
	end

	if self.TriggerProjectileOriginEffectDelay then
		self.TriggerProjectileOriginEffectDelay -= p

		if self.TriggerProjectileOriginEffectDelay <= 0 then
			self:ProjectileFired(self.TriggerProjectileOriginModel)
			self.TriggerProjectileOriginEffectDelay = nil
		end
	end

	if self.OscillationData and not (v5 or self.TowerRebuilding) then
		local parentCurrentMovementSpeed = self.ParentCurrentMovementSpeed

		for _, v9 in pairs(self.OscillationData) do
			local v10 = 1

			if v9.LinkedToMovementSpeed then
				if parentCurrentMovementSpeed then
					v10 = parentCurrentMovementSpeed / v9.MovementSpeedBaseline
				else
					warn("OscillationData with LinkedToMovementSpeed error: ParentCurrentMovementSpeed not set")
				end
			end

			local v11 = v10 * p
			local cframe = CFrame.Angles(v11 * v9.XTransform, v11 * v9.YTransform, v11 * v9.ZTransform)

			if v9.UseC0 then
				v9.Weld.C0 *= cframe
			else
				v9.Weld.Transform *= cframe
			end
		end
	end

	if self.AttackEffectsDelayRemainingMap then
		for k, _ in pairs(self.AttackEffectsDelayRemainingMap) do
			self.AttackEffectsDelayRemainingMap[k] -= p

			if not (self.AttackEffectsDelayRemainingMap[k] <= 0) then
				continue
			end

			self:_PlayAttackTriggeredEffects(nil, k)
			self.AttackEffectsDelayRemainingMap[k] = nil
		end
	end

	self.TimeSinceLastAttack += p

	if
		self.AttackSoundWrapperMap
		and self.AttackSoundGroupPlaying
		and self.TimeSinceLastAttack >= self.AttackSoundGroupStopDelay
	then
		for _, v9 in pairs(self.AttackSoundWrapperMap) do
			v9:StopSoundGroup(self.AttackSoundGroupName)
		end

		self.AttackSoundGroupPlaying = false
	end

	if self.TurretHandler then
		self.TurretHandler:Run(p)
	end

	if self.RotatingBarrelHandlers then
		for _, rotatingBarrelHandler in pairs(self.RotatingBarrelHandlers) do
			rotatingBarrelHandler:Run(p)
		end
	end

	if self.ProjectileTurretHandlerMap then
		for _, v9 in pairs(self.ProjectileTurretHandlerMap) do
			v9:Run(p)
		end
	end

	if self.ShieldModelTimeLeft > 0 then
		self.ShieldModelTimeLeft -= p

		if self.ShieldModelTimeLeft <= 0 then
			self:ToggleShieldIfExists(false)
		end
	end

	if self.ShieldModelInstances then
		local shieldModelCurrentTransparency = self.ShieldModelCurrentTransparency
		local v9 = p / 0.5

		if self.ShieldModelOn then
			v9 *= -1
		end

		local v10 = math.clamp(shieldModelCurrentTransparency + v9, 0, 1)

		if v10 ~= self.ShieldModelCurrentTransparency then
			for _, shieldModelInstance in pairs(self.ShieldModelInstances) do
				shieldModelInstance.Transparency = v10
			end

			self.ShieldModelCurrentTransparency = v10
		end
	end

	if self.DefaultBeamEffects then
		BeamEffectHelper.RunBeamEffects(p, self.DefaultBeamEffects)
	end

	if self.SpawnLandingHandler then
		self.SpawnLandingHandler:Run(p)
	end
end

function CharacterClass:RunDeathLogic(p: number, p2: number)
	self:Run(p)

	if self.DeathExplodePartsScale and not self.DeathExplodePartsDone then
		if self.DeathExplodePartsTimeLeft <= 0 then
			self:ExplodeParts(self.DeathExplodePartsScale, self.ExplodePartsExtraKeepTime)
			self.DeathExplodePartsDone = true
		else
			self.DeathExplodePartsTimeLeft -= p
		end
	end

	local internalDeathEffectsData = self.InternalDeathEffectsData

	if internalDeathEffectsData then
		for _, v8 in pairs(internalDeathEffectsData) do
			if v8.Triggered then
				continue
			end

			if v8.TimeUntilTrigger <= 0 then
				v8.Triggered = true
				local v9 = Utilities.TryGetInstanceFromPath(self.CharacterModel, v8.InstancePath)

				if v9 then
					local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(
						v9,
						DEFAULT_SPEED_MULTIPLIER
					)
					emitterAndSoundWrapper:PlayAll()
					v8.EffectWrapper = emitterAndSoundWrapper
				else
					warn("InternalDeathEffectData: Parent instance not found for death effect", v8.InstancePath)
				end
			else
				v8.TimeUntilTrigger -= p
			end
		end
	end

	if self.DeathAnimationFinished then
		local deathFadeOutDelayTimeLeft = self.DeathFadeOutDelayTimeLeft

		if deathFadeOutDelayTimeLeft and deathFadeOutDelayTimeLeft > 0 then
			self.DeathFadeOutDelayTimeLeft -= p
			return
		end

		local v8 = math.max(0, 1 - self.DeathFadeOutTimeLeft / self.FadeOutTime)

		for _, deathFadeOutPart in pairs(self.DeathFadeOutParts) do
			deathFadeOutPart.Transparency = math.max(deathFadeOutPart.Transparency, v8)
		end

		if self.EntityClass == "Tower" then
			self.DeathFadeOutTimeLeft -= p2
		else
			self.DeathFadeOutTimeLeft -= p
		end

		if self.DeathFadeOutTimeLeft <= 0 then
			local deathFadeOutRemoveDelayTimeLeft = self.DeathFadeOutRemoveDelayTimeLeft

			if deathFadeOutRemoveDelayTimeLeft and deathFadeOutRemoveDelayTimeLeft > 0 then
				self.DeathFadeOutRemoveDelayTimeLeft -= p
				return
			else
				self.FadeOutOnDeath = false
				self:_Cleanup()
			end
		end
	end

	if self.GeneralWrapperDeathStopTimeLeft and self.GeneralWrapperDeathStopTimeLeft > 0 then
		self.GeneralWrapperDeathStopTimeLeft -= p

		if self.GeneralWrapperDeathStopTimeLeft <= 0 then
			self:StopGeneralWrappers()
			self.GeneralWrapperDeathStopTimeLeft = nil
		end
	end
end

function CharacterClass:SetHash(hash: number)
	self.Hash = hash

	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:SetHash(hash)
		end
	end
end

function CharacterClass:SetCurrentReloadTimeForTower(p: number)
	if self.GunModelSoundGroupStopDelayBufferForTowers then
		self.AttackSoundGroupStopDelay = p + self.GunModelSoundGroupStopDelayBufferForTowers
	end
end

function CharacterClass.GetSkinModelData(p)
	return p.SkinModelData
end

function CharacterClass.GetOverrideBurstSize(p)
	return p.OverrideBurstSizeFromCharacter
end

function CharacterClass.GetOverrideBurstInterval(p)
	return p.OverrideBurstIntervalFromCharacter
end

function CharacterClass.FootstepKeyframeReached(p, p2: string)
	local footstepEffectWrapper = p.FootstepEffectWrapper

	if footstepEffectWrapper then
		footstepEffectWrapper:PlayKeyframeTriggered(p2)
	end
end

function CharacterClass:_SetUpStealthShimmer()
	local v8 = self.EntityClass == "Enemy"
	self.StealthShimmerOffset = math.random(0, 500) / 100
	self.StealthShimmerMultiplier = math.random(90, 110) / 100
	local stealthShimmerParts, stealthShimmerDecals, stealthShimmerSpecialMeshes = GetStealthShimmerElements(
		self.CharacterModel,
		self.EntityClass,
		self.ProjectileRegenerationModels,
		self.StealthMaintainColor,
		self.FPSPartToOriginalParentMap
	)
	self.StealthShimmerParts = stealthShimmerParts
	self.StealthShimmerDecals = stealthShimmerDecals
	self.StealthShimmerSpecialMeshes = stealthShimmerSpecialMeshes

	if not v8 then
		self.StealthEffectWrapper = WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
		local miscResource = ResourceManager.GetMiscResource("TowerStealthEffect", true)
		local realTorso = self.RealTorso

		for _, child in pairs(miscResource:GetChildren()) do
			local clone = child:Clone()
			clone.Parent = realTorso
			self.StealthEffectWrapper:AddEmitter(clone, DEFAULT_SPEED_MULTIPLIER)
		end
	end
end

function CharacterClass:ForceSetUpStealthShimmerParts()
	if not self.StealthShimmerParts then
		self:_SetUpStealthShimmer()
	end
end

function CharacterClass:RunStealthShimmer(flag: boolean?)
	if self.NoStealthShimmer then
		return
	end

	local v8 = self.EntityClass == "Enemy"
	local shimmerIfStealth = self.ShimmerIfStealth
	local v9

	if self.StealthShimmerParts then
		v9 = false
	else
		self:_SetUpStealthShimmer()
		v9 = true
	end

	local v10 = flag and 0.575
		or (math.cos(6.283185307179586 * (self.StealthShimmerMultiplier * total + self.StealthShimmerOffset) / (v8 and 1 or 2)) * 0.5 + 0.5) * 0.35 + 0.4

	if v9 or self.StealthShimmerStopped then
		for _, part in pairs(self.StealthShimmerParts) do
			part.CastShadow = false

			if v8 then
				continue
			end

			if not self.StealthMaintainColor then
				part.Color = color
				part.Material = Enum.Material.SmoothPlastic
				part.Reflectance = 0

				if part:IsA("MeshPart") then
					part.TextureID = ""
				end

				local surfaceAppearance = part:FindFirstChildOfClass("SurfaceAppearance")

				if surfaceAppearance then
					local folder = Instance.new("Folder")
					folder.Name = "_SurfaceAppearanceContainer"
					surfaceAppearance.Parent = folder
					folder.Parent = part
				end
			end

			if part:GetAttribute("StealthMakeInvisible") then
				part.Transparency = 1
			elseif not shimmerIfStealth then
				part.Transparency = v10
			end
		end

		for _, stealthShimmerDecal in pairs(self.StealthShimmerDecals) do
			stealthShimmerDecal.Transparency = 1
		end

		for _, stealthShimmerSpecialMesh in pairs(self.StealthShimmerSpecialMeshes) do
			stealthShimmerSpecialMesh.TextureId = ""
		end

		if self.StealthShimmerStopped and self.EntityClass == "Tower" and self.StealthEffectWrapper then
			self.StealthEffectWrapper:PlayTriggered()
		end

		if not shimmerIfStealth then
			self.CurrentStaticStealthTransparency = v10
		end
	end

	if shimmerIfStealth then
		for _, stealthShimmerPart in pairs(self.StealthShimmerParts) do
			if not (stealthShimmerPart:GetAttribute("NoStealthShimmer") or stealthShimmerPart:GetAttribute("StealthMakeInvisible")) then
				stealthShimmerPart.Transparency = math.max(
					v10,
					stealthShimmerPart:GetAttribute("StealthShimmerOverrideMinTransparency") or 0
				)
			end
		end
	end

	self.CurrentStealthTransparency = v10
	self.StealthShimmerStopped = false
end

function CharacterClass:StopStealthShimmer()
	if self.StealthShimmerStopped or not self.StealthShimmerParts then
		return
	end

	local v8 = self.EntityClass == "Enemy"

	for _, part in pairs(self.StealthShimmerParts) do
		if part:GetAttribute("NoStealthShimmer") then
			continue
		end

		part.Transparency = part:GetAttribute("OriginalTransparency")
		part.CastShadow = part:GetAttribute("OriginalCastShadow")

		if v8 or self.StealthMaintainColor then
			continue
		end

		part.Color = part:GetAttribute("OriginalColor")
		part.Material = part:GetAttribute("OriginalMaterial")

		if part:IsA("MeshPart") then
			part.TextureID = part:GetAttribute("OriginalTextureId")
		end

		local originalReflectance = part:GetAttribute("OriginalReflectance")

		if originalReflectance then
			part.Reflectance = originalReflectance
		end

		local surfaceAppearanceContainer = part:FindFirstChild("_SurfaceAppearanceContainer")

		if not surfaceAppearanceContainer then
			continue
		end

		local surfaceAppearance = surfaceAppearanceContainer:FindFirstChildOfClass("SurfaceAppearance")

		if not surfaceAppearance then
			continue
		end

		surfaceAppearance.Parent = part
		surfaceAppearanceContainer:Destroy()
	end

	for _, stealthShimmerDecal in pairs(self.StealthShimmerDecals) do
		stealthShimmerDecal.Transparency = stealthShimmerDecal:GetAttribute("OriginalTransparency")
	end

	for _, stealthShimmerSpecialMesh in pairs(self.StealthShimmerSpecialMeshes) do
		stealthShimmerSpecialMesh.TextureId = stealthShimmerSpecialMesh:GetAttribute("OriginalTextureId")
	end

	if self.EntityClass == "Tower" and self.StealthEffectWrapper then
		self.StealthEffectWrapper:PlayTriggered()
	end

	self.StealthShimmerStopped = true
end

function CharacterClass.StealthIsActive(p)
	return not p.StealthShimmerStopped
end

function CharacterClass.GetCurrentStealthTransparency(p)
	return p.CurrentStealthTransparency
end

function CharacterClass.ShouldLerpRotation(p)
	return p.LerpRotation
end

function CharacterClass:SetCFrameUsingRoot(cframe: CFrame)
	local config = self.Config
	local cframe2 = self.PrimaryPart.CFrame
	local cframe3 = cframe + (self.Torso.CFrame.Position - cframe2.Position)

	if config.RotationOffset then
		cframe3 *= config.RotationOffset
	end

	self:_UpdateWorldFixedJoints(cframe3)
	self.Torso.CFrame = cframe3

	if self.RingHandler then
		self.RingHandler:SetPosition(self.Torso.Position)
	end
end

function CharacterClass.GetTorsoToRootOffsets(instance)
	local config = instance.Config
	local cframe = instance.PrimaryPart.CFrame
	return instance.Torso.CFrame.Position - cframe.Position, config.RotationOffset
end

function CharacterClass:MarkNextCFrameAsWorldFixedBase()
	self.WorldFixedCaptureNext = true
end

function CharacterClass:_UpdateWorldFixedJoints(cframe: CFrame)
	local worldFixedJoints = self.WorldFixedJoints

	if not worldFixedJoints then
		return
	end

	if self.WorldFixedCaptureNext or not self.WorldFixedBaseRotation then
		self.WorldFixedBaseRotation = cframe.Rotation
		self.WorldFixedCaptureNext = false
	end

	local v8 = cframe.Rotation:Inverse() * self.WorldFixedBaseRotation
	local cframe2 = self.Torso.CFrame

	for _, worldFixedJoint in ipairs(worldFixedJoints) do
		local joint = worldFixedJoint.Joint
		local part0 = joint.Part0

		if not part0 then
			continue
		end

		local cframe3 = cframe2:ToObjectSpace(part0.CFrame)
		joint.C0 = cframe3:Inverse() * v8 * cframe3 * worldFixedJoint.OriginalC0
	end
end

function CharacterClass:SetCFrame(cframe: CFrame, flag: boolean?, flag2: boolean?)
	self:_UpdateWorldFixedJoints(cframe)

	if flag then
		self.Torso.CFrame = cframe
	else
		table.insert(torsos, self.Torso)
		table.insert(values, cframe)
	end

	if not flag2 and self.RingHandler then
		self.RingHandler:SetPosition(self.Torso.Position)
	end
end

function CharacterClass:LerpCFrame(p: number, cframe: CFrame, flag: boolean?, flag2: boolean?)
	local lerpAlpha = self.LerpAlpha
	local v8 = math.min(p * (lerpAlpha and lerpAlpha * CLIENT_DEFAULT_FPS or v), 1)
	local lerped = self.Torso.CFrame:Lerp(cframe, v8)
	self:_UpdateWorldFixedJoints(lerped)

	if flag then
		self.Torso.CFrame = lerped
	else
		table.insert(torsos, self.Torso)
		table.insert(values, lerped)
	end

	if not flag2 and self.RingHandler then
		self.RingHandler:SetPosition(self.Torso.Position)
	end
end

function CharacterClass:SetPositionLerpRotation(p: number, cframe: CFrame, flag: boolean)
	local v8 = math.min(p * v, 1)
	local torso = self.Torso
	local position = torso.CFrame.Position
	local position2 = cframe.Position
	local v9 = (position2 - position) * createVector(1, 0, 1)
	local magnitude = v9.Magnitude
	local cframe2 = CFrame.Angles(0, 0, 0)

	if magnitude > 0 then
		local unit = v9.Unit
		local v10 = math.clamp(magnitude / 4, 0, 1)
		local v11 = select(2, cframe:ToEulerAnglesYXZ())
		local v12 = 0.5235987755982988 / math.sqrt(self.Radius)
		cframe2 = CFrame.Angles(
			(math.cos(v11 + 3.141592653589793) * unit.Z + math.sin(v11 + 3.141592653589793) * unit.X) * v10 * v12,
			0,
			(math.sin(v11 + 3.141592653589793) * unit.Z + math.cos(v11) * unit.X) * v10 * v12
		)
	end

	local lerped = torso.CFrame.Rotation:Lerp(cframe.Rotation, v8)
	local cframe3 = CFrame.new(position2) * lerped * cframe2
	self:_UpdateWorldFixedJoints(cframe3)

	if flag then
		torso.CFrame = cframe3
	else
		table.insert(torsos, torso)
		table.insert(values, cframe3)
	end

	if self.RingHandler then
		self.RingHandler:SetPosition(self.Torso.Position)
	end
end

function CharacterClass.SetRingPosition(p, vector: Vector3)
	if p.RingHandler then
		p.RingHandler:SetPosition(vector)
	else
		warn("RingHandler is nil")
	end
end

function CharacterClass:MakeRing(p: number, flag: boolean, flag2: boolean?)
	if self.RingHandler then
		self.RingHandler:Destroy()
	end

	self.RingHandler = RingHandlerClass.New(self.Torso, p, self.RingYOffset, flag, flag2)
end

function CharacterClass:SetPreviewMode()
	if self.RingHandler then
		self.RingHandler:SetPreviewMode()
	end
end

function CharacterClass:SetDefaultMode()
	if self.RingHandler then
		self.RingHandler:SetDefaultMode()
	end
end

function CharacterClass:RemoveRing()
	if self.RingHandler then
		self.RingHandler:FadeOutDestroy()
		self.RingHandler = nil
	end
end

function CharacterClass.GetTorso(p)
	return p.Torso
end

function CharacterClass.WeldTorsoToPart(p, p2)
	local torso = p.Torso
	torso.Anchored = false
	return Utilities.Weld(p2, torso)
end

function CharacterClass:GetCharacterModel()
	return self.CharacterModel
end

function CharacterClass.GetCharacterHasNoHead(p)
	return p.NoHead
end

function CharacterClass.GetHead(p)
	return p.Head
end

function CharacterClass.SetParent(p, parent)
	p.Torso.Parent = parent
end

function CharacterClass:Select()
	self.TowerSelected = true
	self:_UpdateRingHandler()
end

function CharacterClass:Deselect()
	self.TowerSelected = false
	self:_UpdateRingHandler()
end

function CharacterClass:_UpdateRingHandler()
	if not self.RingHandler then
		return
	end

	if self.TowerReviving then
		self.RingHandler:Reviving(self.TowerSelected)
	elseif self.TowerDead then
		self.RingHandler:Dead()
	elseif self.TowerRebuilding then
		self.RingHandler:Rebuilding(self.TowerSelected)
	elseif self.TowerConverted then
		self.RingHandler:Converted(self.TowerSelected)
	elseif self.TowerSelected then
		self.RingHandler:Select()
	else
		self.RingHandler:Deselect()
	end
end

function CharacterClass:FadeOutDestroy(flag: boolean?)
	if self.RingHandler then
		self.RingHandler:FadeOutDestroy()
	end

	if flag then
		self.DeathFadeOutDelayTimeLeft = 0
		self.DeathFadeOutTimeLeft = 0.15
		self.DeathFadeOutRemoveDelayTimeLeft = 0
	else
		self.DeathFadeOutDelayTimeLeft = self.FadeOutDelay
		self.DeathFadeOutTimeLeft = self.FadeOutTime
		self.DeathFadeOutRemoveDelayTimeLeft = self.FadeOutRemoveDelay
	end

	local descendants = {}

	for _, descendant in pairs(self.CharacterModel:GetDescendants()) do
		if descendant:IsA("BasePart") or descendant:IsA("Texture") then
			table.insert(descendants, descendant)
		end
	end

	self.DeathFadeOutParts = descendants
	self:_AddToDyingCharacters()
end

function CharacterClass:StopGeneralWrappers()
	if self.GeneralWrappersStopped then
		return
	end

	if self.EmitterWrapper then
		self.EmitterWrapper:StopContinuous()
	end

	if self.SoundWrapper then
		self.SoundWrapper:StopContinuous()
	end

	self.GeneralWrappersStopped = true
end

function CharacterClass:Destroy(flag: boolean?, flag2: boolean?)
	if not self.GeneralWrapperDeathStopTimeLeft or flag or flag2 then
		self:StopGeneralWrappers()
	end

	if self.DeathRemoveTextures then
		self:_RemoveTexturesAndChangeColorAndMaterial(self.DeathColor, self.DeathMaterial)
	end

	if self.CurrentRebuildVFX then
		self.CurrentRebuildVFX:StopEarly()
		self.CurrentRebuildVFX = nil
	end

	if self.DefaultBeamEffects then
		BeamEffectHelper.StopBeamEffects(self.DefaultBeamEffects)
	end

	for _, v8 in pairs(self.StunNameToPartsMap) do
		for _, v9 in pairs(v8) do
			v9:Destroy()
		end
	end

	if not (flag or flag2 or self.DeathEffectPlayed) then
		self.DeathEffectPlayed = true

		if self.DeathEffect or self.DeathSound then
			DeathEffectHandler.NewDeathEffect(
				self.RealTorso,
				self.DeathEffect,
				self.DeathSound,
				DEFAULT_SPEED_MULTIPLIER
			)
		end
	end

	if flag or flag2 then
		self:_Cleanup()
		return
	end

	if self.DeathStopCurrentAnimation and self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:PauseCurrentAnimation()
		end
	end

	if self.DeathAnimation then
		local track = self.DeathAnimation.Track

		local function FinishDeathAnimation() -- 1 equivalent call inferred from this helper
			if self.DeathAnimationFinished then
				return
			end

			self.DeathAnimationFinished = true

			if self.FadeOutOnDeath then
				self:FadeOutDestroy()
			else
				self:_Cleanup()
			end
		end

		track.Stopped:Connect(FinishDeathAnimation)
		track.KeyframeReached:Connect(function(p: string)
			if p == "StartDeathFadeOut" and self.FadeOutOnDeath then
				FinishDeathAnimation() -- inferred equivalent call
			end
		end)
		self.DeathAnimationFinished = false

		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:Set("Death")
		end

		self:_AddToDyingCharacters()
	elseif self.FadeOutOnDeath then
		self:FadeOutDestroy()
	else
		self:_Cleanup()
	end
end

function CharacterClass:_AddToDyingCharacters()
	if not self.DeathHash then
		self.DeathHash = v4:Get()
		v3[self.DeathHash] = self
	end

	if self.EntityClass == "Enemy" then
		self:Thaw(true, true)
	end
end

function CharacterClass:_Cleanup()
	self:_CleanupVoidDeathSequence()

	if self.TrailTeleportGuards then
		for _, trailTeleportGuard in self.TrailTeleportGuards do
			v7[trailTeleportGuard] = nil
		end

		self.TrailTeleportGuards = nil
	end

	for _, savedTemporaryInstance in self.SavedTemporaryInstances do
		if savedTemporaryInstance then
			savedTemporaryInstance:Destroy()
		end
	end

	self.SavedTemporaryInstances = {}

	for _, savedObjectValuePointer in self.SavedObjectValuePointers do
		if savedObjectValuePointer then
			savedObjectValuePointer:Destroy()
		end
	end

	self.SavedObjectValuePointers = {}

	for k in self.CFrameRestoreTweens do
		k:Cancel()
		k:Destroy()
	end

	self.CFrameRestoreTweens = {}

	if self.OriginalCharacterModel then
		self.CharacterModel = self.OriginalCharacterModel
		self.OriginalCharacterModel = nil
		self.WorldFixedJoints = GetWorldFixedJoints(self.CharacterModel)
	end

	if self.DeathClone then
		self.DeathClone:Destroy()
		self.DeathClone = nil
	end

	self.DeathCloneSavedCFrames = {}

	if self.CustomCode then
		self.CustomCode:CharacterCleanedUp()
	end

	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:Destroy()
		end
	end

	self.Torso:Destroy()

	if self.DeathHash then
		v3[self.DeathHash] = nil
		v4:Return(self.DeathHash)
		self.DeathHash = nil
	end

	if self.FPSPartToOriginalParentMap then
		for k in pairs(self.FPSPartToOriginalParentMap) do
			k:Destroy()
		end
	end

	if self.FirstPersonHitHandler then
		self.FirstPersonHitHandler:Destroy()
	end
end

function CharacterClass:_SetUpTrailTeleportGuards()
	self.TrailTeleportGuards = {}

	for _, trail in self.CharacterModel:GetDescendants() do
		if not (trail:IsA("Trail") and trail:GetAttribute("ClearOnTeleport")) then
			continue
		end

		local attachment0 = trail.Attachment0 or trail.Attachment1
		local parent = attachment0 and attachment0.Parent

		if not (parent and parent:IsA("BasePart")) then
			continue
		end

		local v8 = { Trail = trail, Part = parent, LastPosition = nil }
		table.insert(self.TrailTeleportGuards, v8)
		v7[v8] = true
	end
end

function CharacterClass.TowerInitialPlacement(p, p2)
	p.CharacterOverlayPartHandler:SetTowerLevelStats(p2)
end

function CharacterClass:_ProcessBaseParts()
	if self.LevelStats then
		local characterModel = self.CharacterModel
		local projectileOriginNames, v8 = EntityUtilities.GetProjectileOriginNames(self.LevelStats)

		for _, part in pairs(characterModel:GetDescendants()) do
			if not part:IsA("BasePart") then
				continue
			end

			if projectileOriginNames then
				local parentModelUnderCharacterModel = EntityUtilities.GetParentModelUnderCharacterModel(
					part,
					characterModel
				)
				local flag = false

				if parentModelUnderCharacterModel then
					for _, v9 in pairs(v8) do
						if not Utilities.StringStartsWith(parentModelUnderCharacterModel.Name, v9) then
							continue
						end

						flag = true
						break
					end
				end

				if flag then
					part:SetAttribute("PartOfProjectileOrigin", true)
				end
			end

			local attackHideForTime = part:GetAttribute("AttackHideForTime")

			if not attackHideForTime then
				continue
			end

			if not self.AttackHideForTimeData then
				self.AttackHideForTimeData = {}
			end

			local attackHideForTimeIndex = part:GetAttribute("AttackHideForTimeIndex") or 1
			local v9 = self.AttackHideForTimeData[attackHideForTimeIndex]

			if v9 then
				if v9.HideTime ~= attackHideForTime then
					warn("Different hide times not supported yet")
				end
			else
				v9 = {
					Instances = {},
					Visible = true,
					TimeLeft = 0,
					HideTime = attackHideForTime,
					OriginalTransparencyMap = {}
				}
				self.AttackHideForTimeData[attackHideForTimeIndex] = v9
			end

			table.insert(v9.Instances, part)
			local originalTransparency = part:GetAttribute("OriginalTransparency") or part.Transparency
			v9.OriginalTransparencyMap[part] = originalTransparency
		end
	elseif self.EntityClass == "Tower" then
		warn("LevelStats not set for tower character")
	end
end

function CharacterClass:Upgrade(object)
	local v8 = { ModelChanged = false, ResetToSpawnCFrame = false }

	if self.OverallLevel == object:GetOverallLevel() then
		return v8
	end

	local config = self.Config
	local levelStats = object:GetLevelStats()
	self.LevelStats = levelStats
	self.OverallLevel = object:GetOverallLevel()
	self.CharacterModel:Destroy()
	self.TorsoToRootWeld:Destroy()
	local characterModel, v9, skinModelData, torsoToRootWeld = CreateCharacterModel(
		self.NewCharacterData,
		self.Torso,
		object,
		true,
		nil,
		self.HoverHeightVariance
	)
	local noAnimations = self.NoAnimations or characterModel:GetAttribute("NoAnimations")
	local multipleInnerAnimations = characterModel:GetAttribute("MultipleInnerAnimations")
	local innerAnimationsModelName = characterModel:GetAttribute("InnerAnimationsModelName")
	local models = { characterModel }

	if multipleInnerAnimations then
		models = not characterModel:FindFirstChild("Animations") and {} or models

		for _, model in pairs(characterModel:GetChildren()) do
			if model:IsA("Model") and model:FindFirstChild("Animations") then
				table.insert(models, model)
			end
		end
	elseif innerAnimationsModelName then
		local child = characterModel:FindFirstChild(innerAnimationsModelName)

		if child then
			models = { child }
		else
			warn("Couldn't find animation model with name " .. innerAnimationsModelName)
		end
	end

	self.CharacterModel = characterModel
	self.SkinModelData = skinModelData
	self.TorsoToRootWeld = torsoToRootWeld
	self.WorldFixedJoints = GetWorldFixedJoints(characterModel)
	self.RingYOffset = characterModel:GetAttribute("RingYOffset")
	self.OverrideBurstSizeFromCharacter = characterModel:GetAttribute("OverrideBurstSize")
	self.OverrideBurstIntervalFromCharacter = characterModel:GetAttribute("OverrideBurstInterval")
	self.OverrideHitEffectName = characterModel:GetAttribute("HitEffectName")

	if self.RingHandler then
		self.RingHandler:SetOffset(self.RingYOffset)
	end

	local v10 = models[1]
	self.PrimaryPart = characterModel.PrimaryPart
	self.NoHead = self.Config.NoHead or characterModel:GetAttribute("NoHead")
	self.Head = GetHead(
		v10,
		false,
		self.NoHead,
		characterModel:FindFirstChild("Head"),
		characterModel:FindFirstChild("HeadPath")
	)
	self.RealTorso = GetRealTorso(
		v10,
		false,
		self.Config.NoTorso or characterModel:GetAttribute("NoTorso"),
		characterModel:FindFirstChild("Torso"),
		characterModel:FindFirstChild("TorsoPath")
	)
	self.DeathSound = GetDeathSound(self.Head, characterModel.PrimaryPart) -- inferred equivalent call
	self.LerpRotation = characterModel:GetAttribute("LerpRotation")
	self.LerpAlpha = characterModel:GetAttribute("LerpAlpha")
	self.OverrideHasBeamEffectForDefaultAttack = characterModel:GetAttribute("HasBeamEffectForDefaultAttack")

	if
		(config.BeamEffectForDefaultAttack or config.BeamEffectForHeal or self.OverrideHasBeamEffectForDefaultAttack)
		and self.DefaultBeamEffectHandlingData
	then
		self.DefaultBeamEffects = BeamEffectHelper.NewBeamEffects(
			characterModel,
			self.DefaultBeamEffectHandlingData,
			DEFAULT_SPEED_MULTIPLIER
		)
	end

	self.AttackNoFaceTarget = characterModel:GetAttribute("AttackNoFaceTarget")

	if self.GunModelName then
		self:_SetUpAttackEffectWrappers()
	end

	if noAnimations then
		self.AnimationHandlers = nil
		self.PrimaryAnimationHandler = nil
	else
		local animationHandlers = {}
		local primaryAnimationHandler = nil

		for i, v11 in ipairs(models) do
			local v12 = self.AnimationHandlers and self.AnimationHandlers[i]
			local v13 = not v12 and "Idle" or v12:GetState() or "Idle"
			local v14 = v12 and v12.Animations[v13]
			local timePosition = v14 and v14.Track and v14:GetTimePosition()
			local noUpgradeTransition = v14 and v14.NoUpgradeTransition
			local defaultState = v12 and v12.DefaultState

			if noUpgradeTransition then
				v13 = "Idle"
				timePosition = nil
			end

			local v15 = AnimationHandlerClass.New(
				self.Hash,
				self.Type,
				self.EntityClass,
				self.Config,
				v11,
				DEFAULT_SPEED_MULTIPLIER,
				nil,
				self.RandomHash
			)

			if not v15 then
				continue
			end

			table.insert(animationHandlers, v15)
			primaryAnimationHandler = primaryAnimationHandler or v15
			v15:InitializeWithCharacter(self)
			v15:SetCustomCode(self.CustomCode)
			local animation = v15.Animations[v13]

			if animation and animation:IsAdditive() and defaultState then
				v15:Set(defaultState)
			end

			v15:Set(v13, true, nil, true, timePosition)
			v15:OverrideDefaultState(defaultState)
		end

		self.AnimationHandlers = animationHandlers
		self.PrimaryAnimationHandler = primaryAnimationHandler
	end

	self.ProjectileOriginEffectWrappers = {}
	self.ProjectileRegenerationModels = nil
	self.TriggerProjectileOriginModel = nil
	self.TriggerProjectileOriginEffectDelay = nil
	self.OscillationData = GetOscillationData(characterModel, v10)
	local turretConfigs = levelStats.TurretConfigs

	if characterModel:GetAttribute("IgnoreTurretConfigs") then
		turretConfigs = nil
	end

	local turretConfigs2 = characterModel:FindFirstChild("TurretConfigs")

	if turretConfigs2 then
		turretConfigs = require(turretConfigs2)
	end

	self.TurretHandler = turretConfigs
		and TurretHandlerClass.New(characterModel, turretConfigs, DEFAULT_SPEED_MULTIPLIER)
	local rotatingBarrelData = levelStats.RotatingBarrelData
	local rotatingBarrelData2 = characterModel:FindFirstChild("RotatingBarrelData")

	if rotatingBarrelData2 then
		rotatingBarrelData = require(rotatingBarrelData2)
	end

	if rotatingBarrelData then
		self.RotatingBarrelHandlers = {}

		for _, v11 in pairs(rotatingBarrelData) do
			local v12 = RotatingBarrelHandlerClass.New(characterModel, v11, self.NoAnimations)

			if v12 then
				table.insert(self.RotatingBarrelHandlers, v12)
			end
		end
	else
		self.RotatingBarrelHandlers = nil
	end

	self.AimEffectWrapper = GetAimEffectWrapper(characterModel)
	self.ProjectileTurretHandlerMap = nil
	self.CharacterOverlayPartHandler:CharacterModelChanged(characterModel, self.RealTorso, v9, levelStats)
	self.BurnNameToEmitterWrapperMap = {}
	self.GunModelName = characterModel:GetAttribute("GunModelName") or self.GunModelName
	self.HiddenModels = {}
	self.HiddenModelsNameToVisibleMap = {}
	self.HideGunModelForVictoryDance = characterModel:GetAttribute("HideGunModelForVictoryDance")
	self.ShimmerIfStealth = levelStats.Stealth
	self.StealthShimmerParts = nil
	self.StealthShimmerDecals = nil
	self.StealthEffectWrapper = nil
	self.StealthShimmerStopped = true
	self.FPSParts = nil
	self.FPSPartToOriginalParentMap = nil
	local v11 = {}
	local spawnSound = GetSpawnSound(self.Head, characterModel.PrimaryPart) -- inferred equivalent call

	if spawnSound then
		table.insert(v11, spawnSound)
	end

	local emitterWrapper, soundWrapper, generalWrapperDeathStopTimeLeft = MakeWrappers(characterModel, v11)

	if config.SpawnEffectInstanceNames then
		emitterWrapper = emitterWrapper or WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
		soundWrapper = soundWrapper or WrapperFactory.NewSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

		for _, childName in pairs(config.SpawnEffectInstanceNames) do
			local child = characterModel:FindFirstChild(childName)

			if not child then
				continue
			end

			emitterWrapper:AddEmittersFrom(child, DEFAULT_SPEED_MULTIPLIER)
			soundWrapper:AddSoundsFrom(child, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	self.EmitterWrapper = emitterWrapper
	self.SoundWrapper = soundWrapper
	self.GeneralWrapperDeathStopTimeLeft = generalWrapperDeathStopTimeLeft

	if emitterWrapper then
		emitterWrapper:PlayAll()
	end

	if soundWrapper then
		soundWrapper:PlayAll()
	end

	if self.CurrentHoverHeight then
		self:SetHoverHeight(self.CurrentHoverHeight)
	end

	self.AttackHideForTimeData = nil
	self:_ProcessBaseParts()
	v8.ModelChanged = true
	v8.ResetToSpawnCFrame = characterModel:GetAttribute("ResetToSpawnCFrameOnUpgrade")
	return v8
end

function CharacterClass:SetSpeedMultiplier(p: number)
	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:SetSpeedMultiplier(p)
		end
	end

	if self.EmitterWrapper then
		self.EmitterWrapper:SpeedMultiplierChanged(p)
	end

	if self.SoundWrapper then
		self.SoundWrapper:SpeedMultiplierChanged(p)
	end

	if self.BurnNameToEmitterWrapperMap then
		for _, v8 in pairs(self.BurnNameToEmitterWrapperMap) do
			v8:SpeedMultiplierChanged(p)
		end
	end

	if self.FootstepEffectWrapper then
		self.FootstepEffectWrapper:SpeedMultiplierChanged(p)
	end

	if self.CharacterOverlayPartHandler then
		self.CharacterOverlayPartHandler:SpeedMultiplierChanged(p)
	end

	if self.ProjectileOriginEffectWrappers then
		for _, projectileOriginEffectWrapper in pairs(self.ProjectileOriginEffectWrappers) do
			projectileOriginEffectWrapper:SpeedMultiplierChanged(p)
		end
	end

	if self.CustomCode then
		self.CustomCode:SpeedMultiplierChanged_FromCharacter(p)
	end

	if self.TurretHandler then
		self.TurretHandler:SpeedMultiplierChanged(p)
	end

	for _, v8 in pairs(self.StunNameToEffectWrapperMap) do
		v8:SpeedMultiplierChanged(p)
	end

	if self.ProjectileTurretHandlerMap then
		for _, v8 in pairs(self.ProjectileTurretHandlerMap) do
			v8:SpeedMultiplierChanged(p)
		end
	end

	if self.PostTeleportEffectWrapper then
		self.PostTeleportEffectWrapper:SpeedMultiplierChanged(p)
	end

	if self.SpawnLandingHandler then
		self.SpawnLandingHandler:SpeedMultiplierChanged(p)
	end

	if self.AttackSoundWrapperMap then
		for _, v8 in pairs(self.AttackEmitterWrapperMap) do
			v8:SpeedMultiplierChanged(p)
		end
	end

	if self.AttackSoundWrapperMap then
		for _, v8 in pairs(self.AttackSoundWrapperMap) do
			v8:SpeedMultiplierChanged(p)
		end
	end

	if self.AimEffectWrapper then
		self.AimEffectWrapper:SpeedMultiplierChanged(p)
	end

	if self.ShieldEffectWrapper then
		self.ShieldEffectWrapper:SpeedMultiplierChanged(p)
	end

	if self.DeathEffectsModelWrapper then
		self.DeathEffectsModelWrapper:SpeedMultiplierChanged(p)
	end

	if self.DefaultBeamEffects then
		BeamEffectHelper.SpeedMultiplierChanged(p, self.DefaultBeamEffects)
	end

	if self.StealthEffectWrapper then
		self.StealthEffectWrapper:SpeedMultiplierChanged(p)
	end

	if self.TakingExtraDamageEffectWrapper then
		self.TakingExtraDamageEffectWrapper:SpeedMultiplierChanged(p)
	end

	local internalDeathEffectsData = self.InternalDeathEffectsData

	if internalDeathEffectsData then
		for _, v8 in pairs(internalDeathEffectsData) do
			if v8.EffectWrapper then
				v8.EffectWrapper:SpeedMultiplierChanged(p)
			end
		end
	end
end

function CharacterClass:SetAttackAnimationSpeed(p: number)
	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:SetAttackAnimationSpeed(p)
		end
	end
end

function CharacterClass:SetMovementAnimationSpeed(p: number)
	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:SetMovementAnimationSpeed(p)
		end
	end
end

function CharacterClass:SetAnimationState(p: string)
	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			if not animationHandler:Set(p) then
				continue
			end

			local state = animationHandler:GetState()

			if not (self.GunModelName and self.HideGunModelForVictoryDance) then
				continue
			end

			if state == "VictoryDance" then
				self:HideModelWithName(self.GunModelName)
			else
				self:ShowModelWithName(self.GunModelName)
			end
		end
	end
end

function CharacterClass.OverrideDefaultAnimationState(p, p2: string, flag: boolean?)
	if p.AnimationHandlers then
		for _, animationHandler in pairs(p.AnimationHandlers) do
			animationHandler:OverrideDefaultState(p2, flag)
		end
	end
end

function CharacterClass.StartBurn(p, value: string?)
	local v8 = value or "Burn"
	local v9 = p.BurnNameToEmitterWrapperMap[v8]

	if not v9 then
		local realTorso = p.RealTorso
		local v10 = ResourceManager.GetMiscResource(v8) or ResourceManager.GetMiscResource("Burn")
		v9 = WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

		for _, child in pairs(v10:GetChildren()) do
			v9:AddEmitter(child, DEFAULT_SPEED_MULTIPLIER)
			child.Parent = realTorso
		end

		v10:Destroy()
		p.BurnNameToEmitterWrapperMap[v8] = v9
	end

	v9:PlayAll()
end

function CharacterClass.StopBurn(p, value: string?)
	local v8 = p.BurnNameToEmitterWrapperMap[value or "Burn"]

	if v8 then
		v8:StopContinuous()
	end
end

function CharacterClass:GetRealTorso()
	return self.RealTorso
end

function CharacterClass.SetChangeColorPartsColor(p, color2: Color3, duration: number?)
	if not p.ChangeColorParts then
		warn("Attempt to set color of entity with HasChangeColorParts set to false")
	elseif duration then
		for _, changeColorPart in pairs(p.ChangeColorParts) do
			TweenService:Create(changeColorPart, TweenInfo.new(duration), { Color = color2 }):Play()
		end
	else
		for _, changeColorPart in pairs(p.ChangeColorParts) do
			changeColorPart.Color = color2
		end
	end
end

function CharacterClass.ApplyCharacterOverlayPartConfig(p, p2)
	p.CharacterOverlayPartHandler:Apply(p2, p.FPSParts)
end

function CharacterClass:RemoveCharacterOverlayParts()
	self.CharacterOverlayPartHandler:Remove()
end

function CharacterClass:ToggleEnemyUberHighlight(flag: boolean)
	if flag and not self.EnemyUberHighlight then
		self.EnemyUberHighlight = ResourceManager.GetMiscResource("EnemyUberHighlight")
		self.EnemyUberHighlight.Parent = self.CharacterModel
		self.EnemyUberHighlight.Adornee = self.CharacterModel
	elseif not flag and self.EnemyUberHighlight then
		self.EnemyUberHighlight:Destroy()
		self.EnemyUberHighlight = nil
	end
end

function CharacterClass:Freeze(flag: boolean?)
	if flag then
		self.CharacterOverlayPartHandler:Apply(v2)
	end

	if self.FreezeAnimationsIfFrozen then
		local state = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetState()
		local animation = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetAnimation(state)

		if animation then
			animation:Pause()
		end
	end
end

function CharacterClass:Thaw(flag: boolean?, flag2: boolean?)
	if flag then
		self.CharacterOverlayPartHandler:Remove()
	end

	if not flag2 and self.FreezeAnimationsIfFrozen then
		local state = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetState()
		local animation = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetAnimation(state)

		if animation and animation.Paused then
			animation:Play()
		end
	end
end

function CharacterClass:ToggleShieldIfExists(shieldModelOn: boolean)
	if not (self.ShieldModelInstances and self.ShieldModelOn ~= shieldModelOn) then
		return
	end

	self.ShieldModelTimeLeft = 0

	if shieldModelOn then
		self.ShieldEffectWrapper:PlayAll()
	else
		self.ShieldEffectWrapper:StopContinuous()
	end

	self.ShieldModelOn = shieldModelOn
end

function CharacterClass:ToggleShieldForTime(shieldModelTimeLeft: number)
	if not self.ShieldModelInstances then
		return
	end

	self:ToggleShieldIfExists(true)
	self.ShieldModelTimeLeft = shieldModelTimeLeft
end

function CharacterClass:SetStunned(items)
	local activeStunMap = {}

	for _, item in pairs(items) do
		activeStunMap[item] = true
	end

	for k, v8 in pairs(self.ActiveStunMap) do
		if not v8 or activeStunMap[k] then
			continue
		end

		activeStunMap[k] = false
	end

	local stunNameToEffectWrapperMap = self.StunNameToEffectWrapperMap

	for childName, v8 in pairs(activeStunMap) do
		local v9 = stunNameToEffectWrapperMap[childName]

		if not v9 then
			local child = ResourceManager.GetMiscResource("StunnedEffects", true):FindFirstChild(childName)

			if child then
				local clone = child:Clone()
				local head = clone:GetAttribute("OnHead") and self.Head or self.RealTorso
				v9 = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
				stunNameToEffectWrapperMap[childName] = v9

				for _, child2 in pairs(clone:GetChildren()) do
					if child2:IsA("ParticleEmitter") then
						child2.Parent = head
						v9:Add(child2, DEFAULT_SPEED_MULTIPLIER)
					elseif child2:IsA("Model") and child2.Name == "TorsoPart" then
						self:_CreateStunTorsoPart(childName, child2)
					end
				end

				clone:Destroy()
			else
				warn("Stunned effect with name " .. childName .. " not found in Misc.StunnedEffects")
			end
		end

		if v9 then
			if v8 then
				if self.ActiveStunMap[childName] then
					v9:PlayContinuous()
				else
					v9:PlayAll()
				end
			else
				v9:StopContinuous()
			end
		end

		self:_ToggleStunTorsoParts(childName, v8)
	end

	self.ActiveStunMap = activeStunMap
end

function CharacterClass:_CreateStunTorsoPart(p: string, instance)
	if self.StunNameToPartsMap[p] then
		warn(`_CreateStunTorsoPart: Already initialized for {p}, this shouldn't be called`)
		return
	end

	local parts = {}
	self.StunNameToPartsMap[p] = parts
	local folder = instance:FindFirstChild((tostring(math.random(1, #instance:GetChildren()))))

	if not folder then
		return
	end

	local realTorso = self.RealTorso
	folder:PivotTo(realTorso:GetPivot())
	local primaryPart = folder.PrimaryPart
	local size = primaryPart.Size
	local torsoScale = primaryPart:GetAttribute("TorsoScale") or 1

	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		if part == primaryPart then
			part.Size = realTorso.Size * torsoScale
			Utilities.Weld(realTorso, part)
		else
			part.Size = Vector3.new(
				part.Size.X / size.X * realTorso.Size.X * torsoScale,
				part.Size.Y / size.Y * realTorso.Size.Y * torsoScale,
				part.Size.Z / size.Z * realTorso.Size.Z * torsoScale
			)
		end

		part:SetAttribute("OriginalTransparency", part.Transparency)
		part.Transparency = 1
		part.Parent = raycastIgnore
		table.insert(parts, part)
	end
end

function CharacterClass:_ToggleStunTorsoParts(p: string, flag: boolean)
	local v8 = self.StunNameToPartsMap[p]

	if not v8 then
		return
	end

	for _, v9 in pairs(v8) do
		if flag then
			v9.Transparency = v9:GetAttribute("OriginalTransparency") or 0
		else
			v9.Transparency = 1
		end
	end
end

function CharacterClass:SetTakingExtraDamage(takingExtraDamage: boolean)
	if takingExtraDamage == self.TakingExtraDamage then
		return
	end

	if takingExtraDamage then
		if not self.TakingExtraDamageEffectWrapper then
			local realTorso = self.RealTorso
			local miscResource = ResourceManager.GetMiscResource("TakingExtraDamageEffects")
			local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
			self.TakingExtraDamageEffectWrapper = emitterAndSoundWrapper

			for _, child in pairs(miscResource:GetChildren()) do
				child.Parent = realTorso
				emitterAndSoundWrapper:Add(child, DEFAULT_SPEED_MULTIPLIER)
			end

			miscResource:Destroy()
		end

		self.TakingExtraDamageEffectWrapper:PlayAll()
	elseif self.TakingExtraDamageEffectWrapper then
		self.TakingExtraDamageEffectWrapper:StopContinuous()
	end

	self.TakingExtraDamage = takingExtraDamage
end

function CharacterClass:TowerRebuilt()
	self.TowerRebuilding = false
	self:_UpdateRingHandler()

	if self.CurrentRebuildVFX then
		self.CurrentRebuildVFX:StopEarly()
		self.CurrentRebuildVFX = nil
	end
end

function CharacterClass:TowerRevived()
	self:_CleanupVoidDeathSequence()
	self.TowerReviving = false

	if self.TowerDead then
		self.TowerDead = false
	end

	self.FadeOutOnDeath = self.Config.FadeOutOnDeath
	self.DeathEffectPlayed = false
	local state = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetState()
	local animation = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetAnimation(state)

	if animation and state ~= "Idle" then
		animation:Stop()
	end

	if self.PrimaryAnimationHandler then
		self.PrimaryAnimationHandler:Set("Idle", true)
	end

	self:ReverseTowerTemporaryDeathStuff()
	self:_UpdateRingHandler()
end

function CharacterClass:SetTowerRebuilding()
	self:Thaw(nil, true)
	self.TowerRebuilding = true
	self:_UpdateRingHandler()
	local rebuildVFXName = self.RebuildVFXName

	if rebuildVFXName then
		if self.CurrentRebuildVFX then
			self.CurrentRebuildVFX:StopEarly()
			self.CurrentRebuildVFX = nil
		end

		local rebuildVFXOffset = self.RebuildVFXOffset or createVector(0, 0, 0)
		local v8 = {
			Name = rebuildVFXName,
			Position = self.PrimaryPart.Position + rebuildVFXOffset,
			IsContinuous = true,
			PlayUntilManuallyStopped = true
		}
		self.CurrentRebuildVFX = VisualEffectHandler.NewVisualEffect(v8)
	end
end

function CharacterClass:SetTowerReviving()
	self:Thaw(nil, true)
	self.TowerReviving = true
	self:_UpdateRingHandler()
end

function CharacterClass:SetTowerConverted(towerConverted: boolean)
	if self.TowerConverted ~= towerConverted then
		self.TowerConverted = towerConverted
		self:_UpdateRingHandler()
	end
end

function CharacterClass:_PlayDeathEffects(p: string?)
	local characterModel = self.CharacterModel
	local deathEffectsModelWrapper = nil
	local v8 = p and characterModel:FindFirstChild(p .. "DeathEffects") or characterModel:FindFirstChild("DeathEffects")

	if v8 and not deathEffectsModelWrapper then
		deathEffectsModelWrapper = WrapperFactory.NewEmitterAndSoundWrapper(v8, DEFAULT_SPEED_MULTIPLIER)
	end

	if self.DeathEffectInstanceNames then
		deathEffectsModelWrapper = deathEffectsModelWrapper
			or WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

		for _, deathEffectInstanceName in pairs(self.DeathEffectInstanceNames) do
			local v9 = Utilities.TryGetInstanceFromPath(characterModel, deathEffectInstanceName)

			if v9 then
				deathEffectsModelWrapper:AddFrom(v9, DEFAULT_SPEED_MULTIPLIER)
			else
				warn("Death effect instance with name " .. deathEffectInstanceName .. " not found")
			end
		end
	end

	if deathEffectsModelWrapper then
		deathEffectsModelWrapper:PlayAll()
		self.DeathEffectsModelWrapper = deathEffectsModelWrapper
	end
end

function CharacterClass:MapEntityDeath()
	self:_PlayDeathEffects()
	local parts = {}

	for _, part in pairs(self.CharacterModel:GetDescendants()) do
		if part:IsA("BasePart") and part:GetAttribute("DeathFadeOut") then
			table.insert(parts, part)
		end
	end

	self.DeathFadeOutDelayTimeLeft = self.FadeOutDelay
	self.DeathFadeOutTimeLeft = self.FadeOutTime
	self.DeathFadeOutRemoveDelayTimeLeft = self.FadeOutRemoveDelay
	self.DeathFadeOutParts = parts
	self:_AddToDyingCharacters()
end

function CharacterClass:_CleanupVoidDeathSequence()
	local voidDeathSequenceData = self.VoidDeathSequenceData

	if not voidDeathSequenceData then
		return
	end

	self.VoidDeathSequenceData = nil

	if voidDeathSequenceData.Clone then
		voidDeathSequenceData.Clone:Destroy()
		voidDeathSequenceData.Clone = nil
	end

	if voidDeathSequenceData.Portal and not voidDeathSequenceData.Closing then
		voidDeathSequenceData.Closing = true
		v6[voidDeathSequenceData] = true
	elseif not voidDeathSequenceData.Portal then
		v6[voidDeathSequenceData] = nil
	end

	local characterModel = self.CharacterModel
	local v8

	if characterModel and voidDeathSequenceData.OriginalParent then
		v8 = pcall(function()
			characterModel.Parent = voidDeathSequenceData.OriginalParent
		end)
	else
		v8 = false
	end

	if not v8 then
		return
	end

	if voidDeathSequenceData.DeathAnimation then
		voidDeathSequenceData.DeathAnimation:Pause(true)
	end
end

function CharacterClass:_TryPlayVoidDeathSequence()
	local characterModel = self.CharacterModel

	if
		not (characterModel and characterModel.Parent)
		or characterModel:FindFirstChild("VoidDeathEffects")
		or self.Config.PlacementType == Enums.PlacementTypes.Air
	then
		return false
	end

	local v8 = DEFAULT_SPEED_MULTIPLIER > 0 and DEFAULT_SPEED_MULTIPLIER or 1
	local pivot = characterModel:GetPivot()
	local boundingBox, v9 = characterModel:GetBoundingBox()
	local y = boundingBox.Position.Y - v9.Y / 2
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	local raycastResult = workspace:Raycast(
		Vector3.new(pivot.Position.X, boundingBox.Position.Y + v9.Y / 2 + 1, pivot.Position.Z),
		Vector3.new(0, -(v9.Y + 50), 0),
		raycastParams
	)
	local cframe

	if raycastResult then
		y = raycastResult.Position.Y
		local normal = raycastResult.Normal
		local cross = normal:Cross(createVector(0, 0, 1))
		local v10 = cross.Magnitude < 0.001 and createVector(1, 0, 0) or cross
		cframe = CFrame.fromMatrix(raycastResult.Position + normal * 0.1, v10.Unit, normal)
	else
		cframe = CFrame.new(pivot.Position.X, y + 0.1, pivot.Position.Z)
	end

	local primaryAnimationHandler = self.PrimaryAnimationHandler
	local state = primaryAnimationHandler and primaryAnimationHandler:GetState()
	local animation

	if state and string.find(state, "Death", 1, true) then
		animation = primaryAnimationHandler:GetAnimation(state)
	end

	local clone = characterModel:Clone()
	clone.Name = characterModel.Name .. "_VoidDeathClone"

	for _, descendant in clone:GetDescendants() do
		if not (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") or descendant:IsA("Trail") or descendant:IsA("Fire") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") or descendant:IsA("Light") or descendant:IsA("Sound") or descendant:IsA("Highlight") or descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") or descendant:IsA("BaseScript")) then
			continue
		end

		descendant:Destroy()
	end

	if clone.PrimaryPart then
		clone.PrimaryPart.Anchored = true
	else
		for _, part in clone:GetDescendants() do
			if part:IsA("BasePart") then
				part.Anchored = true
			end
		end
	end

	local parent = characterModel.Parent
	clone.Parent = parent
	local folder = ResourceManager.GetMiscResource("VoidDeathPortal")
	folder.CFrame = cframe

	for _, part in folder:GetDescendants() do
		if not part:IsA("BasePart") then
			continue
		end

		part.CanQuery = false
		part.CanCollide = false
	end

	folder.CanQuery = false
	folder.CanCollide = false
	local sizesByEmitter = {}
	local ratesByEmitter = {}
	local v10 = 0

	for _, emitter in folder:GetDescendants() do
		if not emitter:IsA("ParticleEmitter") then
			continue
		end

		sizesByEmitter[emitter] = emitter.Size
		ratesByEmitter[emitter] = emitter.Rate

		for _, keypoint in emitter.Size.Keypoints do
			v10 = math.max(v10, keypoint.Value)
		end
	end

	local function SetPortalVisualScale(p: number)
		for k, v11 in sizesByEmitter do
			local numberSequenceKeypoints = {}

			for _, keypoint in v11.Keypoints do
				table.insert(
					numberSequenceKeypoints,
					NumberSequenceKeypoint.new(keypoint.Time, keypoint.Value * p, keypoint.Envelope * p)
				)
			end

			k.Size = NumberSequence.new(numberSequenceKeypoints)
		end
	end

	local v11 = math.max(v9.X, v9.Z) + 4
	local portalScale = not (v10 > 0) and 1 or math.min(v11, 10) / v10
	SetPortalVisualScale(portalScale)
	folder.Size = Vector3.new(folder.Size.X * portalScale, folder.Size.Y, folder.Size.Z * portalScale)
	folder.Parent = workspace
	characterModel.Parent = nil
	local track = nil
	local cloneDeathTrackBaseSpeed = nil

	if animation then
		local speed = animation.Track.Speed
		local animator = clone:FindFirstChildWhichIsA("Animator", true)
		local animation2 = animation.Track.Animation

		if animator and animation2 then
			track = animator:LoadAnimation(animation2)
			track.Looped = false
			local v12

			if speed > 0 then
				v12 = speed or v8
			else
				v12 = v8
			end

			cloneDeathTrackBaseSpeed = v12 / v8
			track.Stopped:Connect(function()
				track:Play(0, 1, 0)
				track.TimePosition = 0.999 * track.Length
			end)
			local v13 = cloneDeathTrackBaseSpeed * v8
			track:Play(0, 1, v13)
		end
	end

	local v12 = pivot.Position.Y - y + v9.Y + 3
	local voidDeathSequenceData = {
		Clone = clone,
		Portal = folder,
		OriginalParent = parent,
		DeathAnimation = animation,
		CloneDeathTrack = track,
		CloneDeathTrackBaseSpeed = cloneDeathTrackBaseSpeed,
		ElapsedTime = 0,
		PortalScale = portalScale,
		SetPortalVisualScale = SetPortalVisualScale,
		PortalEmitterBaseRateMap = ratesByEmitter,
		CurrentScale = 0,
		GrowFinished = false,
		SinkStartCFrame = pivot,
		SinkTargetCFrame = pivot - Vector3.new(0, v12, 0),
		FadeItems = nil,
		Closing = false,
		CloseEntered = false,
		CloseElapsed = 0,
		CloseStartScale = nil
	}
	self.VoidDeathSequenceData = voidDeathSequenceData
	SetPortalVisualScale(0)

	for k, v13 in ratesByEmitter do
		k.Rate = v13 * 8
		k.Enabled = true
	end

	v6[voidDeathSequenceData] = true
	return true
end

function CharacterClass:TowerDeath(p: string?)
	local v8

	if p == "Void" then
		v8 = self:_TryPlayVoidDeathSequence()
	else
		v8 = false
	end

	if not v8 then
		self:_PlayDeathEffects(p)
	end

	if not self.DeathEffectPlayed then
		self.DeathEffectPlayed = true

		if self.DeathEffect or self.DeathSound then
			DeathEffectHandler.NewDeathEffect(
				self.RealTorso,
				self.DeathEffect,
				self.DeathSound,
				DEFAULT_SPEED_MULTIPLIER
			)
		end
	end

	self:Thaw(nil, true)
	self:RemoveCharacterOverlayParts()
	self.TowerDead = true
	self:_UpdateRingHandler()
	self:SetFadeOutOnDeath(true)

	if self.DefaultBeamEffects then
		BeamEffectHelper.StopBeamEffects(self.DefaultBeamEffects)
	end
end

function CharacterClass:SetFadeOutOnDeath(fadeOutOnDeath: boolean)
	self.FadeOutOnDeath = fadeOutOnDeath
end

function CharacterClass:TowerTemporaryDeathStuff(flag: boolean?)
	if self.TowerTemporaryDeathStuffApplied then
		return
	end

	self.TowerTemporaryDeathStuffApplied = true

	for k in self.CFrameRestoreTweens do
		k:Cancel()
		k:Destroy()
	end

	self.CFrameRestoreTweens = {}

	if flag then
		self:_PrepareDeathClone()
		return
	end

	self:_RemoveTexturesAndChangeColorAndMaterial(Color3.fromRGB(35, 35, 35), Enum.Material.CrackedLava)
	local state = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetState()
	local animation = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetAnimation(state)

	if animation then
		animation:Pause()
	end
end

function CharacterClass:ReverseTowerTemporaryDeathStuff()
	if not self.TowerTemporaryDeathStuffApplied then
		return
	end

	for _, instance in self.SavedTemporaryInstances do
		if instance:IsA("Decal") or instance:IsA("Texture") or instance:IsA("SurfaceAppearance") then
			local savedObjectValuePointer = self.SavedObjectValuePointers[instance]

			if savedObjectValuePointer then
				instance.Parent = savedObjectValuePointer.Value
			end

			savedObjectValuePointer:Destroy()
			self.SavedObjectValuePointers[instance] = nil
		else
			local savedTextureID = instance:IsA("MeshPart") and instance:GetAttribute("SavedTextureID")

			if savedTextureID then
				instance:SetAttribute("SavedTextureID", nil)
				instance.TextureID = savedTextureID
			end

			local savedTextureId = instance:IsA("SpecialMesh") and instance:GetAttribute("SavedTextureId")

			if savedTextureId then
				instance:SetAttribute("SavedTextureId", nil)
				instance.TextureId = savedTextureId
			end

			if instance:IsA("BasePart") then
				local savedColor = instance:GetAttribute("SavedColor")

				if savedColor then
					instance:SetAttribute("SavedColor", nil)
					instance.Color = savedColor
				end

				local savedMaterial = instance:GetAttribute("SavedMaterial")

				if savedMaterial then
					instance:SetAttribute("SavedMaterial", nil)
					instance.Material = savedMaterial
				end
			end
		end
	end

	local state = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetState()
	local animation = self.PrimaryAnimationHandler and self.PrimaryAnimationHandler:GetAnimation(state)

	if animation and animation:IsPaused() then
		animation:Play(true)
	end

	if self.DeathClone then
		for k in self.DeathCloneSavedCFrames do
			if k and k.Parent then
				k.Anchored = true
			end
		end

		self.CFrameRestoreTweens = {}
		local tweenInfo2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		for k, deathCloneSavedCFrame in self.DeathCloneSavedCFrames do
			if not (k and k.Parent) then
				continue
			end

			local tween = TweenService:Create(k, tweenInfo2, { CFrame = deathCloneSavedCFrame })
			self.CFrameRestoreTweens[tween] = true
			tween:Play()
			tween.Completed:Once(function()
				self.CFrameRestoreTweens[tween] = nil
				tween:Destroy()

				if not next(self.CFrameRestoreTweens) then
					self:_RestoreOriginalModel()
				end
			end)
		end

		if not next(self.CFrameRestoreTweens) then
			self:_RestoreOriginalModel()
		end
	end

	self.TowerTemporaryDeathStuffApplied = false
end

function CharacterClass:_RestoreOriginalModel()
	if self.DeathClone then
		self.DeathClone:Destroy()
		self.DeathClone = nil
	end

	if self.OriginalCharacterModel then
		self.CharacterModel = self.OriginalCharacterModel
		Utilities.ShowModel(self.OriginalCharacterModel)
		self.OriginalCharacterModel = nil
	end

	self.DeathCloneSavedCFrames = {}
end

function CharacterClass:_RemoveTexturesAndChangeColorAndMaterial(color2: Color3?, material)
	self.SavedTemporaryInstances = {}
	self.SavedObjectValuePointers = {}

	for _, descendant in pairs(self.CharacterModel:GetDescendants()) do
		table.insert(self.SavedTemporaryInstances, descendant)

		if descendant:IsA("Decal") or descendant:IsA("Texture") or descendant:IsA("SurfaceAppearance") then
			local objectValue = Instance.new("ObjectValue")
			objectValue.Value = descendant.Parent
			objectValue.Parent = nil
			self.SavedObjectValuePointers[descendant] = objectValue
			descendant.Parent = nil
		else
			if descendant:IsA("MeshPart") then
				descendant:SetAttribute("SavedTextureID", descendant.TextureID)
				descendant.TextureID = ""
			end

			if descendant:IsA("SpecialMesh") then
				descendant:SetAttribute("SavedTextureId", descendant.TextureId)
				descendant.TextureId = ""
			end

			if descendant:IsA("BasePart") then
				if color2 then
					descendant:SetAttribute("SavedColor", descendant.Color)
					descendant.Color = color2
				end

				if material then
					descendant:SetAttribute("SavedMaterial", descendant.Material)
					descendant.Material = material
				end
			end
		end
	end
end

function CharacterClass:_PrepareDeathClone()
	local clone = self.CharacterModel:Clone()
	self.DeathCloneSavedCFrames = {}

	for _, part in pairs(clone:GetDescendants()) do
		if part:IsA("BasePart") then
			self.DeathCloneSavedCFrames[part] = part.CFrame
		end
	end

	self.OriginalCharacterModel = self.CharacterModel
	Utilities.HideModel(self.OriginalCharacterModel)
	clone.Parent = self.Torso
	self.CharacterModel = clone
	self.DeathClone = clone
end

function CharacterClass:Attacked(p: number?, value: number?)
	if self.AttackEffectsDelay then
		local v8 = p and self.GunModelName .. tostring(p)

		if p and self.AttackEmitterWrapperMap[v8] then
			self.AttackEffectsDelayRemainingMap[v8] = self.AttackEffectsDelay
		else
			self.AttackEffectsDelayRemainingMap[self.GunModelName] = self.AttackEffectsDelay
		end
	else
		self:_PlayAttackTriggeredEffects(p)
	end

	if self.TurretHandler then
		self.TurretHandler:Attacked(value or 1, p)
	end

	if self.RotatingBarrelHandlers then
		for _, rotatingBarrelHandler in pairs(self.RotatingBarrelHandlers) do
			rotatingBarrelHandler:Attacked()
		end
	end

	if self.AttackHideForTimeData then
		if p then
			local v8 = self.AttackHideForTimeData[p]

			if v8 then
				v8.TimeLeft = v8.HideTime
			else
				for _, v9 in pairs(self.AttackHideForTimeData) do
					v9.TimeLeft = v9.HideTime
				end
			end
		else
			for _, v8 in pairs(self.AttackHideForTimeData) do
				v8.TimeLeft = v8.HideTime
			end
		end
	end

	self.TimeSinceLastAttack = 0
end

function CharacterClass.TriggerRotatingBarrels(p, p2: number?)
	if p.RotatingBarrelHandlers then
		for _, rotatingBarrelHandler in pairs(p.RotatingBarrelHandlers) do
			rotatingBarrelHandler:Attacked(p2)
		end
	end
end

function CharacterClass:_PlayAttackTriggeredEffects(p: number?, p2: string?)
	local gunModelName = self.GunModelName

	if not self.GunModelName then
		return
	end

	local attackBurstModulo = self.AttackBurstModulo

	if attackBurstModulo then
		p = p and (p - 1) % attackBurstModulo + 1
	end

	local v8 = p2 or p and gunModelName .. tostring(p)
	local attackEmitterWrapperMap = self.AttackEmitterWrapperMap
	local attackSoundWrapperMap = self.AttackSoundWrapperMap
	local v9 = attackEmitterWrapperMap and (attackEmitterWrapperMap[v8] or attackEmitterWrapperMap[gunModelName])

	if v9 then
		v9:PlayTriggered()
	end

	local v10 = attackSoundWrapperMap and (attackSoundWrapperMap[v8] or attackSoundWrapperMap[gunModelName])

	if v10 then
		v10:PlayTriggered()

		if self.AttackSoundGroupName and not self.AttackSoundGroupPlaying then
			v10:PlaySoundGroup(self.AttackSoundGroupName)
			self.AttackSoundGroupPlaying = true
		end
	end
end

function CharacterClass.PlayAttackContinuousEffects(p)
	if p.AttackEmitterWrapperMap then
		for _, v8 in pairs(p.AttackEmitterWrapperMap) do
			v8:PlayContinuous()
		end
	end

	if p.AttackSoundWrapperMap then
		for _, v8 in pairs(p.AttackSoundWrapperMap) do
			v8:PlayContinuous()
		end
	end
end

function CharacterClass.StopAttackContinuousEffects(p)
	if p.AttackEmitterWrapperMap then
		for _, v8 in pairs(p.AttackEmitterWrapperMap) do
			v8:StopContinuous()
		end
	end

	if p.AttackSoundWrapperMap then
		for _, v8 in pairs(p.AttackSoundWrapperMap) do
			v8:StopContinuous()
		end
	end
end

function CharacterClass.AttackKeyframeReached(p, p2: string)
	if p.AttackEmitterWrapperMap then
		for _, v8 in pairs(p.AttackEmitterWrapperMap) do
			v8:PlayKeyframeTriggered(p2)
		end
	end

	if p.AttackSoundWrapperMap then
		for _, v8 in pairs(p.AttackSoundWrapperMap) do
			v8:PlayKeyframeTriggered(p2)
		end
	end
end

function CharacterClass:_SetUpAttackEffectWrappers()
	local characterModel = self.CharacterModel
	local attackEmitterWrapperMap = {}
	local attackSoundWrapperMap = {}
	local specialBurstHandling = self.SpecialBurstHandlingForModel
		and characterModel:GetAttribute("SpecialBurstHandling")
		or self.OverrideBurstSizeFromCharacter
	local attackBurstModulo = characterModel:GetAttribute("AttackBurstModulo")

	if specialBurstHandling then
		local v8 = "^" .. self.GunModelName

		for _, child in pairs(characterModel:GetChildren()) do
			if not child.Name:find(v8) then
				continue
			end

			attackEmitterWrapperMap[child.Name] = WrapperFactory.NewEmitterWrapper(child, DEFAULT_SPEED_MULTIPLIER, 1)
			attackSoundWrapperMap[child.Name] = WrapperFactory.NewSoundWrapper(child, DEFAULT_SPEED_MULTIPLIER, 0.5)
		end
	elseif attackBurstModulo then
		for i = 1, attackBurstModulo do
			local v8 = self.GunModelName .. tostring(i)
			local characterModel2 = self.CharacterModel
			local v9 = Utilities.TryGetInstanceFromPath(characterModel2, v8)

			if not v9 then
				warn("Didn't find gun model named " .. tostring(v8))
			end

			if not v9 then
				local gunModelName = self.GunModelName
				local characterModel3 = self.CharacterModel
				v9 = Utilities.TryGetInstanceFromPath(characterModel3, gunModelName)

				if not v9 then
					warn("Didn't find gun model named " .. tostring(gunModelName))
				end
			end

			if not v9 then
				continue
			end

			attackEmitterWrapperMap[v9.Name] = WrapperFactory.NewEmitterWrapper(v9, DEFAULT_SPEED_MULTIPLIER, 1)
			attackSoundWrapperMap[v9.Name] = WrapperFactory.NewSoundWrapper(v9, DEFAULT_SPEED_MULTIPLIER, 0.5)
		end
	else
		local gunModel = GetGunModel(self.GunModelName, self.CharacterModel) -- inferred equivalent call

		if gunModel then
			attackEmitterWrapperMap[self.GunModelName] = WrapperFactory.NewEmitterWrapper(
				gunModel,
				DEFAULT_SPEED_MULTIPLIER,
				1
			)
			attackSoundWrapperMap[self.GunModelName] = WrapperFactory.NewSoundWrapper(
				gunModel,
				DEFAULT_SPEED_MULTIPLIER,
				0.5
			)
		end
	end

	self.AttackSoundGroupPlaying = false
	self.AttackEmitterWrapperMap = attackEmitterWrapperMap
	self.AttackSoundWrapperMap = attackSoundWrapperMap
	self.AttackEffectsDelayRemainingMap = {}
	self.AttackBurstModulo = attackBurstModulo
end

function CharacterClass:ProjectileFired(triggerProjectileOriginModel, triggerProjectileOriginEffectDelay: number?, flag: boolean?, value: number?)
	self.ProjectilesFiredCount += 1

	if flag then
		return
	end

	if not self.ProjectileOriginEffectWrappers then
		self.ProjectileOriginEffectWrappers = {}
	end

	local projectileOriginEffectWrapper = self.ProjectileOriginEffectWrappers[triggerProjectileOriginModel.Name]

	if not projectileOriginEffectWrapper then
		projectileOriginEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(
			triggerProjectileOriginModel,
			DEFAULT_SPEED_MULTIPLIER * (value or 1)
		)
		self.ProjectileOriginEffectWrappers[triggerProjectileOriginModel.Name] = projectileOriginEffectWrapper
	end

	if not triggerProjectileOriginEffectDelay then
		projectileOriginEffectWrapper:PlayAll()
		return
	end

	self.TriggerProjectileOriginModel = triggerProjectileOriginModel
	self.TriggerProjectileOriginEffectDelay = triggerProjectileOriginEffectDelay
end

function CharacterClass:RegenerateProjectile(model, delayLeft: number, p: number, p2: string?)
	if not self.ProjectileRegenerationModels then
		self.ProjectileRegenerationModels = {}
	end

	local v8 = p2 or model.Name
	local projectileRegenerationModels = self.ProjectileRegenerationModels
	local projectileRegenerationModel = projectileRegenerationModels[v8]

	if projectileRegenerationModel then
		projectileRegenerationModel.DelayLeft = delayLeft
		projectileRegenerationModel.TimeLeft = p
		projectileRegenerationModel.TotalTimeLeft = p
	else
		local originalTransparencies = {}

		for _, v9 in pairs(Utilities.GetAllBasepartDescendants(model)) do
			originalTransparencies[v9] = v9:GetAttribute("OriginalTransparency") or v9.Transparency
		end

		projectileRegenerationModel = {
			DelayLeft = delayLeft,
			TimeLeft = p,
			TotalTimeLeft = p,
			Model = model,
			OriginalTransparencyMap = originalTransparencies
		}
		projectileRegenerationModels[v8] = projectileRegenerationModel
	end

	for k, _ in pairs(projectileRegenerationModel.OriginalTransparencyMap) do
		k.Transparency = 1
		k:SetAttribute("StealthShimmerOverrideMinTransparency", 1)
	end
end

function CharacterClass.GetProjectilesFiredCount(p)
	return p.ProjectilesFiredCount
end

function CharacterClass.GetCustomCode(p)
	return p.CustomCode
end

function CharacterClass:SetCustomCode(customCode)
	self.CustomCode = customCode

	if self.AnimationHandlers then
		for _, animationHandler in pairs(self.AnimationHandlers) do
			animationHandler:SetCustomCode(customCode)
		end
	end
end

function CharacterClass.HasTurret(p)
	return p.TurretHandler ~= nil
end

function CharacterClass.AimTurretAtPosition(p, vector: Vector3, value: number?, flag: boolean?)
	p.TurretHandler:AimAtPosition(value or 1, vector, flag)
end

function CharacterClass:AimProjectileTurret(p: string, p2, vector: Vector3)
	self:_SetUpProjectileTurretIfDoesNotExist(p, p2)
	local v8 = self.ProjectileTurretHandlerMap[p]

	if v8 then
		v8:AimAtPosition(1, vector)
	end
end

function CharacterClass:_SetUpProjectileTurretIfDoesNotExist(p: string, p2)
	if not self.ProjectileTurretHandlerMap then
		self.ProjectileTurretHandlerMap = {}
	end

	if not self.ProjectileTurretHandlerMap[p] then
		local characterModel = self.CharacterModel
		local v8 = TurretHandlerClass.New(characterModel, p2, DEFAULT_SPEED_MULTIPLIER)
		self.ProjectileTurretHandlerMap[p] = v8
	end
end

function CharacterClass.AimingStarted(p)
	if p.AimEffectWrapper then
		p.AimEffectWrapper:PlayAll()
	end
end

function CharacterClass.AimingStopped(p)
	if p.AimEffectWrapper then
		p.AimEffectWrapper:StopContinuous()
	end
end

function CharacterClass.ScaleAttackEffects(p, p2: number, p3: number?)
	if p.AttackEmitterWrapperMap then
		for _, v8 in pairs(p.AttackEmitterWrapperMap) do
			v8:ScaleEmitters(p2)
		end
	end

	local defaultBeamEffects = p.DefaultBeamEffects

	if defaultBeamEffects then
		BeamEffectHelper.ScaleTo(defaultBeamEffects, p2, p3)
	end
end

function CharacterClass.RunDefaultBeamEffects(p, flag: boolean, object, p2: number?, value: number?, p3)
	local defaultBeamEffects = p.DefaultBeamEffects

	if not defaultBeamEffects then
		return
	end

	local v8

	if object and object:GetCharacterModel():GetAttribute("TargetTorsoBounds") then
		local effectFollowPart = EntityUtilities.GetEffectFollowPart(
			object,
			defaultBeamEffects[1].TargetHead,
			defaultBeamEffects[1].TargetGround
		)
		v8 = EntityUtilities.GetPointOnPartBounds(p.RealTorso.Position, effectFollowPart)
	end

	if not flag then
		BeamEffectHelper.StopBeamEffects(defaultBeamEffects)
		return
	end

	local startBeamEffects = BeamEffectHelper.StartBeamEffects

	if v8 ~= nil then
		object = false
	end

	startBeamEffects(defaultBeamEffects, value or 0, p2, v8, object, nil, p3)
end

function CharacterClass.FadeOutEmitters(p)
	local emitterWrapper = p.EmitterWrapper
	local soundWrapper = p.SoundWrapper

	if emitterWrapper then
		emitterWrapper:StopContinuous()
	end

	if soundWrapper then
		soundWrapper:StopContinuous()
	end
end

function CharacterClass.HideCharacterModel(p)
	HideModel(p.CharacterModel)
end

function CharacterClass:HideModelWithName(childName: string)
	local child = self.HiddenModels[childName]

	if not child then
		child = self.CharacterModel:FindFirstChild(childName)

		if child then
			self.HiddenModels[childName] = child
			self.HiddenModelsNameToVisibleMap[childName] = true
		else
			warn("HideModelWithName: Model with name " .. childName .. " not found")
			return
		end
	end

	if self.HiddenModelsNameToVisibleMap[childName] then
		self.HiddenModelsNameToVisibleMap[childName] = false
		HideModel(child)
		self.CharacterOverlayPartHandler:ForceRefresh()
	end
end

function CharacterClass:ShowModelWithName(p: string)
	local hiddenModel = self.HiddenModels[p]

	if not hiddenModel then
		return
	end

	if not self.HiddenModelsNameToVisibleMap[p] then
		self.HiddenModelsNameToVisibleMap[p] = true
		ShowModel(hiddenModel)
		self.CharacterOverlayPartHandler:ForceRefresh()
	end
end

function CharacterClass:SetParentCurrentMovementSpeed(parentCurrentMovementSpeed: number)
	self.ParentCurrentMovementSpeed = parentCurrentMovementSpeed
end

function CharacterClass:OverrideAnimation(p: string, p2: string)
	if p == "Move" then
		self.MovementAnimationHasBeenOverriden = true
	end

	for _, animationHandler in pairs(self.AnimationHandlers) do
		animationHandler:OverrideAnimation(p, p2)
	end
end

function CharacterClass:SetOverrideMovementAnimation(currentMovementAnimationName: string?)
	if self.MovementAnimationHasBeenOverriden then
		return
	end

	if currentMovementAnimationName then
		if self.CurrentMovementAnimationName ~= currentMovementAnimationName then
			self:SetAnimationState(currentMovementAnimationName)
			self.CurrentMovementAnimationName = currentMovementAnimationName
		end
	elseif self.CurrentMovementAnimationName then
		self:SetAnimationState("Move")
		self.CurrentMovementAnimationName = nil
	end
end

function CharacterClass.GetOverridePlacementEffectName(p)
	return p.OverridePlacementEffectName
end

function CharacterClass.GetOverrideHitEffectName(p)
	return p.OverrideHitEffectName
end

function CharacterClass.GetDefaultHoverHeight(p)
	return p.DefaultHoverHeight
end

function CharacterClass:SetHoverHeight(p: number, p2: number?)
	local hoverHeightVariance = self.HoverHeightVariance or 0
	local torsoToRootWeld = self.TorsoToRootWeld
	local y = torsoToRootWeld.C0.Position.Y
	local lerped = p + hoverHeightVariance

	if p2 then
		lerped = Utilities.Lerp(y, lerped, p2)
	end

	torsoToRootWeld.C0 = CFrame.new(0, lerped, 0) * torsoToRootWeld.C0.Rotation
	self.CurrentHoverHeight = lerped - hoverHeightVariance
end

function CharacterClass.GetCurrentHoverHeight(p)
	return p.CurrentHoverHeight or 0
end

function CharacterClass.GetTorsoToRootWeld(p)
	return p.TorsoToRootWeld
end

function CharacterClass.SetTorsoToRootWeldRotation(p, cframe: CFrame)
	local torsoToRootWeld = p.TorsoToRootWeld
	torsoToRootWeld.C0 = CFrame.new(torsoToRootWeld.C0.Position) * cframe
end

function CharacterClass:DestroyTorsoToRootWeld()
	if self.DeathClone then
		return
	end

	local torsoToRootWeld = self.TorsoToRootWeld

	if torsoToRootWeld then
		self.SavedTorsoToRootWeldC0 = torsoToRootWeld.C0
		self.SavedTorsoToRootWeldC1 = torsoToRootWeld.C1
	end

	self.TorsoToRootWeld:Destroy()
end

function CharacterClass:RestoreTorsoToRootWeld()
	local primaryPart = self.CharacterModel and self.CharacterModel.PrimaryPart
	local torso = self.Torso

	if not (primaryPart and torso) then
		return
	end

	local torsoToRootWeld = self.TorsoToRootWeld

	if torsoToRootWeld and torsoToRootWeld.Parent then
		return
	end

	local weld = Instance.new("Weld")
	weld.Part0 = torso
	weld.Part1 = primaryPart
	weld.C0 = self.SavedTorsoToRootWeldC0 or torso.CFrame:ToObjectSpace(primaryPart.CFrame)
	weld.C1 = self.SavedTorsoToRootWeldC1 or CFrame.new()
	weld.Name = primaryPart.Name
	weld.Parent = torso
	primaryPart.Anchored = false
	self.TorsoToRootWeld = weld
end

function CharacterClass:ExplodeParts(p: number?, p2: number?)
	EntityUtilities.ExplodeParts(self.CharacterModel, p, p2, function()
		if self.DeathAnimation then
			self.DeathAnimationFinished = true
			self:_Cleanup()
		end
	end)
end

function CharacterClass:ToggleFPSParts(flag: boolean, flag2: boolean?)
	if not self.FPSParts then
		self.FPSParts = {}
		self.FPSPartToOriginalParentMap = {}

		if flag2 then
			table.insert(self.FPSParts, self.CharacterModel)
		else
			for _, descendant in pairs(self.CharacterModel:GetDescendants()) do
				if descendant:GetAttribute("IsOverlayPart") or not descendant:GetAttribute("FPSHide") then
					continue
				end

				table.insert(self.FPSParts, descendant)
			end
		end
	end

	if flag then
		for k, parent in pairs(self.FPSPartToOriginalParentMap) do
			k.Parent = parent
			self.FPSPartToOriginalParentMap[k] = nil
		end

		if self.RingHandler then
			self.RingHandler:ToggleVisible(true)
		end
	else
		for _, fpsPart in pairs(self.FPSParts) do
			self.FPSPartToOriginalParentMap[fpsPart] = fpsPart.Parent
			fpsPart.Parent = Hidden
		end

		if self.RingHandler then
			self.RingHandler:ToggleVisible(false)
		end
	end
end

function CharacterClass:TookFirstPersonDamage(p: number, flag: boolean, flag2: boolean, flag3: boolean, vector: Vector3, flag4: boolean)
	if not self.FirstPersonHitHandler then
		self.FirstPersonHitHandler = FirstPersonHitHandlerClass.New(self:GetRealTorso())
	end

	self.FirstPersonHitHandler:Hit(p, flag, flag2, flag3, vector, flag4)
end

function CharacterClass.HasBeamEffectForDefaultAttack(p)
	return p.OverrideHasBeamEffectForDefaultAttack
end

function CharacterClass.PlayPreTeleportEffects(p)
	if p.PreTeleportVFXName then
		local v8 = { Name = p.PreTeleportVFXName, Position = p.RealTorso.Position }
		VisualEffectHandler.NewVisualEffect(v8)
	end
end

function CharacterClass.PlayPostTeleportEffects(p)
	if p.PostTeleportEffectWrapper then
		p.PostTeleportEffectWrapper:PlayAll()
	end
end

function CharacterClass.GetAttackNoFaceTarget(p)
	return p.AttackNoFaceTarget
end

event:AttachCallback(function(p: number)
	DEFAULT_SPEED_MULTIPLIER = p

	for _, v8 in pairs(v3) do
		v8:SetSpeedMultiplier(p)
	end

	for k in pairs(v6) do
		if k.Clone and k.CloneDeathTrack then
			k.CloneDeathTrack:AdjustSpeed(k.CloneDeathTrackBaseSpeed * p)
		end
	end
end)
return CharacterClass