local createVector = vector.create
local VoidTraitorCustomCodeClass = {}
VoidTraitorCustomCodeClass.__index = VoidTraitorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local event = BindableHandler.GetEvent("NewVisualEffectBindable")
local v = {}
NetworkingHandler.GetEvent("TowerBombardmentReplication"):AttachCallback(function(data)
	if data.ProjectileName ~= "VoidTraitorMeteor" then
		return
	end

	local v2 = v[data.OriginTowerHash]

	if not v2 then
		v2 = {}
		v[data.OriginTowerHash] = v2
	end

	table.insert(v2, { Goal = data.Goal, TimeToHit = data.TimeToHit })

	if #v2 > 16 then
		table.remove(v2, 1)
	end
end)
local color = Color3.fromRGB(190, 150, 235)
local v2 = {
	{
		Name = "VoidPrimeDebrisRock1",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastSmall,
		Weight = 3
	},
	{
		Name = "VoidPrimeDebrisRock2",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastSmall,
		Weight = 3
	},
	{
		Name = "VoidPrimeDebrisRock3",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastMedium,
		Weight = 2
	},
	{
		Name = "VoidPrimeDebrisTurret",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastMedium,
		Weight = 1
	},
	{
		Name = "VoidPrimeDebrisAATurret",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastSmall,
		Weight = 1
	}
}
local total = 0

for _, v3 in v2 do
	total += v3.Weight
end

local success, towerAbilityConfig = pcall(
	ResourceManager.GetTowerAbilityConfig,
	Enums.TowerAbilities.VoidTraitorVoidRift
)
local total2

if success and towerAbilityConfig and towerAbilityConfig.BombardmentData then
	total2 = 0

	for _, attack in towerAbilityConfig.BombardmentData.Attacks do
		total2 += attack.Count
	end
else
	total2 = 8
end

function VoidTraitorCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Tower = nil,
		Config = nil,
		SequenceActive = false,
		ElapsedTime = 0,
		Portal = nil,
		PortalState = nil,
		PortalPosition = nil,
		PortalSpin = 0,
		PortalCloseElapsed = 0,
		ActiveDebris = {},
		ConsumedDropCount = 0,
		LastDropTime = 0,
		VoidGrade = nil
	}, VoidTraitorCustomCodeClass))
end

function VoidTraitorCustomCodeClass:Initialize(tower, config)
	self.Tower = tower
	self.Config = config
end

function VoidTraitorCustomCodeClass:AbilityUsed(p)
	if p and p.Name == "VoidTraitorVoidRift" then
		self:_CleanupVoidRift()
		self.SequenceActive = true
	end
end

function VoidTraitorCustomCodeClass:Run_FromCharacter(p: number)
	if not self.SequenceActive then
		return
	end

	self.ElapsedTime += p
	self:_UpdatePortal(p)
	self:_ConsumePendingDrops()
	self:_UpdateDebris(p)

	if
		self.PortalState == "Open"
		and #self.ActiveDebris == 0
		and (total2 <= self.ConsumedDropCount or self.ElapsedTime - self.LastDropTime > 14)
	then
		self.PortalState = "Closing"
		self.PortalCloseElapsed = 0
	end

	if self.PortalState == "Done" and #self.ActiveDebris == 0 then
		self:_CleanupVoidRift()
	end
end

function VoidTraitorCustomCodeClass:_UpdatePortal(p: number)
	if not self.Portal then
		if self.PortalState or not (self.ElapsedTime >= 113 / 60) then
			return
		else
			self:_SpawnPortal()
		end
	end

	local v3 = 0.10471975511965978

	if self.PortalState == "Closing" then
		v3 *= math.clamp(self.PortalCloseElapsed / 0.8, 0, 1) * 99 + 1
	end

	self.PortalSpin += v3 * p
	local value = 1

	if self.PortalState == "Opening" then
		local v4 = math.clamp((self.ElapsedTime - 113 / 60) / 1.7166666666666668, 0, 1)
		value = TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		if v4 >= 1 then
			self.PortalState = "Open"
		end
	elseif self.PortalState == "Closing" then
		self.PortalCloseElapsed += p
		local v4 = math.clamp(self.PortalCloseElapsed / 0.8, 0, 1)
		value = 1 - TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		if v4 >= 1 then
			self.Portal:Destroy()
			self.Portal = nil
			self.PortalState = "Done"
			self:_RestoreLighting()
			return
		end
	end

	self.Portal:PivotTo(CFrame.new(self.PortalPosition) * CFrame.Angles(0, self.PortalSpin, 0) * CFrame.Angles(0, 0, -1.5707963267948966))
	self.Portal:ScaleTo(math.max(value, 0.02) * 6)
	self:_ApplyVoidLighting(value)
end

function VoidTraitorCustomCodeClass:_ApplyVoidLighting(p: number)
	local voidGrade = self.VoidGrade

	if not voidGrade then
		return
	end

	local v3 = p * 1
	voidGrade.TintColor = Color3.new(1, 1, 1):Lerp(color, v3)
	voidGrade.Saturation = v3 * -0.35
	voidGrade.Contrast = v3 * 0.15
	voidGrade.Brightness = v3 * -0.03
end

function VoidTraitorCustomCodeClass:_RestoreLighting()
	if self.VoidGrade then
		self.VoidGrade:Destroy()
		self.VoidGrade = nil
	end
end

function VoidTraitorCustomCodeClass:_SpawnPortal()
	local characterModel = self.Tower.Character:GetCharacterModel()
	local primaryPart = characterModel and characterModel.PrimaryPart

	if not primaryPart then
		return
	end

	local rotationOffset = self.Config.RotationOffset
	local lookVector = (rotationOffset and primaryPart.CFrame * rotationOffset:Inverse() or primaryPart.CFrame).LookVector
	local vector = Vector3.new(lookVector.X, 0, lookVector.Z)
	local unit = vector.Magnitude > 0 and vector.Unit or createVector(0, 0, 1)
	local v3 = primaryPart.Position + unit * 50
	self.PortalPosition = Vector3.new(v3.X, self:_GetGroundY(v3) + 90, v3.Z)
	self.Portal = ResourceManager.GetMiscResource("VoidPrimePortal")
	self.PortalState = "Opening"
	self.PortalSpin = 0
	local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "VoidRiftPortalGrade"
	colorCorrectionEffect.Parent = Lighting
	self.VoidGrade = colorCorrectionEffect

	for _, part in self.Portal:GetDescendants() do
		if part:IsA("BasePart") then
			part.CastShadow = false
		end
	end

	self.Portal:ScaleTo(0.12)
	self.Portal:PivotTo(CFrame.new(self.PortalPosition) * CFrame.Angles(0, 0, -1.5707963267948966))
	self.Portal.Parent = workspace
end

function VoidTraitorCustomCodeClass:_ConsumePendingDrops()
	if not self.Portal or self.PortalState == "Closing" or self.PortalState == "Done" then
		return
	end

	local v3 = v[self.Tower.Hash]

	if not v3 then
		return
	end

	while #v3 > 0 do
		self:_SpawnDebris(table.remove(v3, 1))
	end
end

function VoidTraitorCustomCodeClass:_SpawnDebris(p)
	self.ConsumedDropCount += 1
	self.LastDropTime = self.ElapsedTime
	local v3 = math.random() * total
	local name = nil
	local blastName = nil

	for _, v4 in v2 do
		v3 -= v4.Weight

		if not (v3 <= 0) then
			continue
		end

		name = v4.Name
		blastName = v4.BlastName
		break
	end

	local miscResource = ResourceManager.GetMiscResource(name)
	miscResource:ScaleTo(0.375 + math.random() * 0.25)
	local v4 = math.random() * 2 * 3.141592653589793
	local v5 = math.sqrt((math.random())) * 25.920000000000005
	local spawnPosition = self.PortalPosition + Vector3.new(math.cos(v4) * v5, 0, math.sin(v4) * v5)
	local goal = p.Goal
	local vector = Vector3.new(goal.X, self:_GetGroundY(goal), goal.Z)
	local vector2 = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
	local unit = vector2.Magnitude > 0.01 and vector2.Unit or createVector(1, 0, 0)
	local v6 = {
		Model = miscResource,
		Goal = vector,
		FlightTime = p.TimeToHit,
		Elapsed = 0,
		SpawnPosition = spawnPosition,
		TumbleAxis = unit,
		TumbleSpeed = 0.6981317007977318 + math.random() * 0.8726646259971648,
		TumbleAngle = math.random() * 2 * 3.141592653589793,
		BlastName = blastName
	}
	miscResource:PivotTo(CFrame.new(spawnPosition) * CFrame.fromAxisAngle(unit, v6.TumbleAngle))
	miscResource.Parent = workspace
	table.insert(self.ActiveDebris, v6)
end

function VoidTraitorCustomCodeClass:_UpdateDebris(p: number)
	for i = #self.ActiveDebris, 1, -1 do
		local v3 = self.ActiveDebris[i]
		v3.Elapsed += p
		local v4 = math.min(v3.Elapsed / v3.FlightTime, 1)
		local v5

		if v4 < 0.35 then
			local v6 = v4 / 0.35
			v5 = v3.SpawnPosition - Vector3.new(0, v6 * 5, 0)
		else
			local v6 = (v4 - 0.35) / 0.65
			local v7 = v6 ^ 5
			local v8 = v3.SpawnPosition - createVector(0, 5, 0)
			local v9 = 5 / (0.35 * v3.FlightTime)
			local v10 = v6 * 0.65 * v3.FlightTime
			v5 = v8:Lerp(v3.Goal, v7) - Vector3.new(0, v9 * v10 * (1 - v7), 0)
		end

		v3.TumbleAngle += v3.TumbleSpeed * p * (v4 * 10 + 1)
		v3.Model:PivotTo(CFrame.new(v5) * CFrame.fromAxisAngle(v3.TumbleAxis, v3.TumbleAngle))

		if not (v3.Elapsed >= v3.FlightTime) then
			continue
		end

		event:Fire(v3.BlastName, v3.Goal)
		v3.Model:Destroy()
		table.remove(self.ActiveDebris, i)
	end
end

function VoidTraitorCustomCodeClass:_GetGroundY(vector: Vector3)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	local raycastResult = workspace:Raycast(vector + createVector(0, 50, 0), createVector(0, -500, 0), raycastParams)
	return raycastResult and raycastResult.Position.Y or vector.Y
end

function VoidTraitorCustomCodeClass:_CleanupVoidRift()
	if self.Portal then
		self.Portal:Destroy()
		self.Portal = nil
	end

	self:_RestoreLighting()

	for _, v3 in self.ActiveDebris do
		v3.Model:Destroy()
	end

	self.SequenceActive = false
	self.ElapsedTime = 0
	self.PortalState = nil
	self.PortalPosition = nil
	self.PortalSpin = 0
	self.PortalCloseElapsed = 0
	self.ActiveDebris = {}
	self.ConsumedDropCount = 0
	self.LastDropTime = 0

	if self.Tower then
		v[self.Tower.Hash] = nil
	end
end

function VoidTraitorCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function VoidTraitorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function VoidTraitorCustomCodeClass.Upgraded(_, _) end

function VoidTraitorCustomCodeClass:CharacterCleanedUp()
	self:_CleanupVoidRift()
end

function VoidTraitorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function VoidTraitorCustomCodeClass.Attacked(_, _, _: boolean?) end

function VoidTraitorCustomCodeClass:Death()
	self:_CleanupVoidRift()
end

return VoidTraitorCustomCodeClass