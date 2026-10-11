local createVector = vector.create
local CharacterOverlayPartHandlerClass = {}
CharacterOverlayPartHandlerClass.__index = CharacterOverlayPartHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local v = {
	"Head",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg",
	"LeftArm",
	"RightArm",
	"LeftLeg",
	"RightLeg",
	"Torso"
}
local v2 = {}
local TryReadChildValue = Utilities.TryReadChildValue
local Weld = Utilities.Weld

local function GenerateValidLimbsMap() -- 1 equivalent call inferred from this helper
	for _, v3 in pairs(v) do
		v2[v3:lower()] = true
	end
end

local function CreateOverlayPart(clones, p, part, p2, flag: boolean?, p3)
	local clone = part:Clone()
	local tryReadChildValue = TryReadChildValue(part, "IceScaleFactor", 1.15)
	local v3 = false

	for _, specialMesh in pairs(clone:GetChildren()) do
		if flag or not TryReadChildValue(specialMesh, "Freeze", nil) then
			if specialMesh:IsA("SpecialMesh") then
				specialMesh.Scale *= tryReadChildValue
				specialMesh.TextureId = ""
				v3 = true

				for _, child in pairs(specialMesh:GetChildren()) do
					child:Destroy()
				end
			else
				specialMesh:Destroy()
			end
		else
			CreateOverlayPart(clones, p, specialMesh, part, nil, p3)
			specialMesh:Destroy()
		end
	end

	clone.Color = p3.Color
	clone.Material = p3.Material
	clone.Transparency = 1
	clone.CastShadow = false
	clone.CanQuery = false

	if not v3 then
		local v4 = p and p[part] or part.Size

		if flag then
			if math.max(v4.X, v4.Y, v4.Z) < 1 then
				clone.Size = tryReadChildValue * v4
			else
				clone.Size = v4 + createVector(0.1, 0.1, 0.1)
			end
		else
			clone.Size = tryReadChildValue * v4
		end
	end

	if clone:IsA("MeshPart") then
		clone.TextureID = ""
	end

	local tryReadChildValue2 = TryReadChildValue(part, "IceOffset", nil)

	if tryReadChildValue2 then
		clone.Position += tryReadChildValue2
	end

	clone.Parent = p2 or part
	clone.Name ..= "_Overlay"
	clone:SetAttribute("IsOverlayPart", true)
	Weld(p2 or part, clone)
	table.insert(clones, clone)
end

local function CreateOverlayParts(characterModel, partSizeMap, currentActiveConfig)
	local v3 = {}

	for _, part in pairs(characterModel:GetChildren()) do
		if not (part:IsA("BasePart") and TryReadChildValue(part, "Freeze", nil) ~= false) then
			continue
		end

		if not (v2[part.Name:lower()] or TryReadChildValue(part, "Freeze", nil)) then
			continue
		end

		CreateOverlayPart(v3, partSizeMap, part, nil, nil, currentActiveConfig)
	end

	return v3
end

local function CreateOverlayPartsForTower(folder, partSizeMap, currentActiveConfig, towerLevelStats, items)
	if not towerLevelStats then
		warn("TowerLevelStats not provided for tower overlay parts")
	end

	local v3 = {}

	local function ProcessDescendant(part)
		if
			not part:IsA("BasePart")
			or TryReadChildValue(part, "Freeze", nil) == false
			or (part:GetAttribute("OriginalTransparency") or part.Transparency) >= 0.5
		then
			return
		end

		local v4 = partSizeMap[part] or part.Size

		if
			math.max(v4.X, v4.Y, v4.Z) < 0.25
			or part:GetAttribute("PartOfProjectileOrigin")
			or part:GetAttribute("NoOverlay")
		then
			return
		end

		CreateOverlayPart(v3, partSizeMap, part, nil, true, currentActiveConfig)
	end

	for _, descendant in pairs(folder:GetDescendants()) do
		ProcessDescendant(descendant)
	end

	if not items then
		return v3
	end

	for _, folder2 in pairs(items) do
		ProcessDescendant(folder2)

		for _, descendant in pairs(folder2:GetDescendants()) do
			ProcessDescendant(descendant)
		end
	end

	return v3
end

local function CreateEffectWrapper(realTorso, speedMultiplier: number, items)
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	local v3 = (realTorso.Size.X + realTorso.Size.Z) / 1.2

	for _, item in pairs(items) do
		local clone = item:Clone()
		clone.Parent = realTorso

		if clone:IsA("ParticleEmitter") then
			Utilities.ScaleParticleEmitter(clone, v3)
		end

		emitterAndSoundWrapper:Add(clone, speedMultiplier)
	end

	return emitterAndSoundWrapper
end

function CharacterOverlayPartHandlerClass.New(isTower: boolean, characterModel, partSizeMap, realTorso, speedMultiplier: number, towerLevelStats)
	return (setmetatable({
		IsTower = isTower,
		PartSizeMap = partSizeMap,
		OverlayParts = nil,
		RealTorso = realTorso,
		OverlayPartsGenerated = false,
		CharacterModel = characterModel,
		CurrentTransparency = 1,
		ForceRefreshNextFrame = false,
		SpeedMultiplier = speedMultiplier,
		CurrentActiveConfig = nil,
		TowerLevelStats = towerLevelStats,
		ConfigToInitialEffectWrapperMap = {},
		ConfigToFinishEffectWrapperMap = {}
	}, CharacterOverlayPartHandlerClass))
end

function CharacterOverlayPartHandlerClass:SetTowerLevelStats(towerLevelStats)
	self.TowerLevelStats = towerLevelStats
end

function CharacterOverlayPartHandlerClass:Apply(currentActiveConfig, p)
	if self.CurrentActiveConfig == currentActiveConfig then
		return
	end

	self.CurrentActiveConfig = currentActiveConfig

	if self.OverlayPartsGenerated then
		for _, overlayPart in pairs(self.OverlayParts) do
			overlayPart.Transparency = 1
			overlayPart.Color = currentActiveConfig.Color
			overlayPart.Material = currentActiveConfig.Material
		end

		self.CurrentTransparency = 1
	else
		if self.IsTower then
			self.OverlayParts = CreateOverlayPartsForTower(
				self.CharacterModel,
				self.PartSizeMap,
				currentActiveConfig,
				self.TowerLevelStats,
				p
			)
		else
			self.OverlayParts = CreateOverlayParts(self.CharacterModel, self.PartSizeMap, currentActiveConfig)
		end

		self.PartSizeMap = nil
		self.OverlayPartsGenerated = true
	end

	local v3 = self.ConfigToInitialEffectWrapperMap[currentActiveConfig]

	if not v3 then
		v3 = CreateEffectWrapper(self.RealTorso, self.SpeedMultiplier, currentActiveConfig.InitialEffectInstances or {})
		self.ConfigToInitialEffectWrapperMap[currentActiveConfig] = v3
	end

	v3:PlayAll()
	local v4 = self.ConfigToFinishEffectWrapperMap[currentActiveConfig]

	if v4 then
		v4:StopContinuous()
	end
end

function CharacterOverlayPartHandlerClass:Remove()
	local currentActiveConfig = self.CurrentActiveConfig

	if not currentActiveConfig then
		return
	end

	(self.ConfigToFinishEffectWrapperMap[currentActiveConfig] or CreateEffectWrapper(
		self.RealTorso,
		self.SpeedMultiplier,
		currentActiveConfig.FinishEffectInstances or {}
	)):PlayAll()
	local v3 = self.ConfigToInitialEffectWrapperMap[currentActiveConfig]

	if v3 then
		v3:StopContinuous()
	end

	self.CurrentActiveConfig = nil
end

function CharacterOverlayPartHandlerClass:Run(p: number)
	if not self.OverlayPartsGenerated then
		return
	end

	local currentActiveConfig = self.CurrentActiveConfig
	local currentTransparency = self.CurrentTransparency
	local v3 = p / 0.4

	if currentActiveConfig and currentActiveConfig.Transparency < currentTransparency then
		self.CurrentTransparency = math.max(currentActiveConfig.Transparency, currentTransparency - v3)
	elseif not currentActiveConfig and currentTransparency < 1 then
		self.CurrentTransparency = math.min(1, currentTransparency + v3)
	end

	if currentTransparency ~= self.CurrentTransparency or self.ForceRefreshNextFrame then
		local currentTransparency2 = self.CurrentTransparency

		for _, overlayPart in pairs(self.OverlayParts) do
			local parent = overlayPart.Parent

			if parent then
				overlayPart.Transparency = math.max(currentTransparency2, parent.Transparency)
			end
		end

		self.ForceRefreshNextFrame = false
	end
end

function CharacterOverlayPartHandlerClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, v3 in pairs(self.ConfigToInitialEffectWrapperMap) do
		v3:SpeedMultiplierChanged(speedMultiplier)
	end

	for _, v3 in pairs(self.ConfigToFinishEffectWrapperMap) do
		v3:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

function CharacterOverlayPartHandlerClass:CharacterModelChanged(characterModel, realTorso, partSizeMap, towerLevelStats)
	self.CharacterModel = characterModel
	self.RealTorso = realTorso
	self.PartSizeMap = partSizeMap
	self.TowerLevelStats = towerLevelStats

	for _, v3 in pairs(self.ConfigToInitialEffectWrapperMap) do
		v3:StopContinuous()
	end

	self.ConfigToInitialEffectWrapperMap = {}

	for _, v3 in pairs(self.ConfigToFinishEffectWrapperMap) do
		v3:StopContinuous()
	end

	self.ConfigToFinishEffectWrapperMap = {}

	if self.OverlayParts then
		for _, overlayPart in pairs(self.OverlayParts) do
			overlayPart:Destroy()
		end

		self.OverlayParts = nil
		self.OverlayPartsGenerated = false
	end

	local currentActiveConfig = self.CurrentActiveConfig

	if currentActiveConfig then
		self.CurrentActiveConfig = nil
		self.CurrentTransparency = currentActiveConfig.Transparency + 0.01
		self:Apply(currentActiveConfig)
	end
end

function CharacterOverlayPartHandlerClass:ForceRefresh()
	self.ForceRefreshNextFrame = true
end

GenerateValidLimbsMap() -- inferred equivalent call
return CharacterOverlayPartHandlerClass