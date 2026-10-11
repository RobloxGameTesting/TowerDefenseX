local createVector = vector.create
local VoidPrimeCustomCodeClass = {}
VoidPrimeCustomCodeClass.__index = VoidPrimeCustomCodeClass
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
NetworkingHandler.GetEvent("BombardmentReplication"):AttachCallback(function(data)
	if data.ProjectileName == "VoidPrimeMeteor" then
		table.insert(v, { Goal = data.Goal, TimeToHit = data.TimeToHit })

		if #v > 32 then
			table.remove(v, 1)
		end
	end
end)
local color = Color3.fromRGB(190, 150, 235)
local VoidPrimeMeteorBlast = Enums.VisualEffects.VoidPrimeMeteorBlast
local VoidPrimeWarshipBlast = Enums.VisualEffects.VoidPrimeWarshipBlast
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

local v3 = {}

for _, v4 in { Enums.EnemyAbilities.VoidPrimeClawCalling, Enums.EnemyAbilities.VoidPrimePVPClawCalling } do
	local success, enemyAbilityConfig = pcall(ResourceManager.GetEnemyAbilityConfig, v4)
	local total2

	if success and enemyAbilityConfig and enemyAbilityConfig.BombardmentData then
		total2 = 0

		for _, attack in enemyAbilityConfig.BombardmentData.Attacks do
			total2 += attack.Count
		end
	else
		total2 = 18
	end

	v3[v4] = total2
end

function VoidPrimeCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		SequenceActive = false,
		ElapsedTime = 0,
		ClipFinished = false,
		Portal = nil,
		PortalState = nil,
		PortalPosition = nil,
		PortalSpin = 0,
		PortalCloseElapsed = 0,
		ActiveDebris = {},
		ConsumedDropCount = 0,
		ExpectedDropCount = 18,
		LastDropTime = 0,
		AnchorGoal = nil,
		FaceYawOffset = 0,
		BaseC0Rotation = nil,
		VoidGrade = nil
	}, VoidPrimeCustomCodeClass))
end

function VoidPrimeCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
end

function VoidPrimeCustomCodeClass:AbilityUsed(p: string)
	local expectedDropCount = v3[p]

	if expectedDropCount then
		self:_CleanupClawCalling()
		self.SequenceActive = true
		self.ExpectedDropCount = expectedDropCount
	end
end

function VoidPrimeCustomCodeClass:Run_FromCharacter(p: number)
	if not self.SequenceActive then
		return
	end

	self.ElapsedTime += p

	if self.ElapsedTime <= 22 / 3 then
		self:_UpdateBossRise()
		self:_UpdateBossFacing(p)
	elseif not self.ClipFinished then
		self.ClipFinished = true
		self.Character:SetHoverHeight(self.Character:GetDefaultHoverHeight())
		self:_RestoreBossFacing()
	end

	self:_UpdatePortal(p)
	self:_ConsumePendingDrops()
	self:_UpdateDebris(p)

	if
		self.PortalState == "Open"
		and #self.ActiveDebris == 0
		and (self.ConsumedDropCount >= self.ExpectedDropCount or self.ElapsedTime - self.LastDropTime > 20)
	then
		self.PortalState = "Closing"
		self.PortalCloseElapsed = 0
	end

	if self.PortalState == "Done" and self.ClipFinished and #self.ActiveDebris == 0 then
		self:_CleanupClawCalling()
	end
end

function VoidPrimeCustomCodeClass:_UpdateBossRise()
	local value

	if self.ElapsedTime < 7 / 3 then
		value = TweenService:GetValue(
			math.clamp((self.ElapsedTime - 0.5) / 1.8333333333333335, 0, 1),
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
	elseif self.ElapsedTime < 73 / 12 then
		value = 1
	else
		value = 1 - TweenService:GetValue(
			math.clamp((self.ElapsedTime - 73 / 12) / 1.25, 0, 1),
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
	end

	self.Character:SetHoverHeight(self.Character:GetDefaultHoverHeight() + 20 * value)
end

function VoidPrimeCustomCodeClass:_UpdateBossFacing(p: number)
	local torsoToRootWeld = self.Character:GetTorsoToRootWeld()

	if not self.BaseC0Rotation then
		self.BaseC0Rotation = torsoToRootWeld.C0.Rotation
	end

	local anchorGoal = self.AnchorGoal
	local v4

	if anchorGoal and self.ElapsedTime < 73 / 12 then
		local cframe = torsoToRootWeld.Part0.CFrame
		local vectorToObjectSpace = cframe:VectorToObjectSpace((Vector3.new(
			anchorGoal.X - cframe.X,
			0,
			anchorGoal.Z - cframe.Z
		)))
		v4 = math.atan2(-vectorToObjectSpace.X, -vectorToObjectSpace.Z)
	else
		v4 = 0
	end

	local v5 = (v4 - self.FaceYawOffset + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
	local v6 = math.min(p * 3, 1)
	self.FaceYawOffset += v5 * v6
	torsoToRootWeld.C0 = CFrame.new(torsoToRootWeld.C0.Position) * CFrame.Angles(0, self.FaceYawOffset, 0) * self.BaseC0Rotation
end

function VoidPrimeCustomCodeClass:_RestoreBossFacing()
	if self.BaseC0Rotation then
		local torsoToRootWeld = self.Character:GetTorsoToRootWeld()
		torsoToRootWeld.C0 = CFrame.new(torsoToRootWeld.C0.Position) * self.BaseC0Rotation
	end

	self.FaceYawOffset = 0
end

function VoidPrimeCustomCodeClass:_UpdatePortal(p: number)
	if not self.Portal then
		if self.PortalState or not (self.ElapsedTime >= 0.5) then
			return
		else
			self:_SpawnPortal()
		end
	end

	local v4 = 0.03490658503988659

	if self.PortalState == "Closing" then
		v4 *= math.clamp(self.PortalCloseElapsed / 1.2, 0, 1) * 99 + 1
	end

	self.PortalSpin += v4 * p
	local value = 1

	if self.PortalState == "Opening" then
		local v5 = math.clamp((self.ElapsedTime - 0.5) / 1.8333333333333335, 0, 1)
		value = TweenService:GetValue(v5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		if v5 >= 1 then
			self.PortalState = "Open"
		end
	elseif self.PortalState == "Closing" then
		self.PortalCloseElapsed += p
		local v5 = math.clamp(self.PortalCloseElapsed / 1.2, 0, 1)
		value = 1 - TweenService:GetValue(v5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		if v5 >= 1 then
			self.Portal:Destroy()
			self.Portal = nil
			self.PortalState = "Done"
			self:_RestoreLighting()
			return
		end
	end

	self.Portal:PivotTo(CFrame.new(self.PortalPosition) * CFrame.Angles(0, self.PortalSpin, 0) * CFrame.Angles(0, 0, -1.5707963267948966))
	self.Portal:ScaleTo(math.max(value, 0.02) * 16)
	self:_ApplyVoidLighting(value)
end

function VoidPrimeCustomCodeClass:_ApplyVoidLighting(p: number)
	local voidGrade = self.VoidGrade

	if not voidGrade then
		return
	end

	local v4 = p * 1
	voidGrade.TintColor = Color3.new(1, 1, 1):Lerp(color, v4)
	voidGrade.Saturation = v4 * -0.35
	voidGrade.Contrast = v4 * 0.15
	voidGrade.Brightness = v4 * -0.03
end

function VoidPrimeCustomCodeClass:_RestoreLighting()
	if self.VoidGrade then
		self.VoidGrade:Destroy()
		self.VoidGrade = nil
	end
end

function VoidPrimeCustomCodeClass:_SpawnPortal()
	local primaryPart = self.CharacterModel.PrimaryPart
	local lookVector = primaryPart.CFrame.LookVector
	local vector = Vector3.new(lookVector.X, 0, lookVector.Z)
	local unit = vector.Magnitude > 0 and vector.Unit or createVector(0, 0, 1)
	local v4 = primaryPart.Position + unit * 100
	self.PortalPosition = Vector3.new(v4.X, self:_GetGroundY(v4) + 180, v4.Z)
	self.Portal = ResourceManager.GetMiscResource("VoidPrimePortal")
	self.PortalState = "Opening"
	self.PortalSpin = 0
	local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "VoidPrimePortalGrade"
	colorCorrectionEffect.Parent = Lighting
	self.VoidGrade = colorCorrectionEffect

	for _, part in self.Portal:GetDescendants() do
		if part:IsA("BasePart") then
			part.CastShadow = false
		end
	end

	self.Portal:ScaleTo(0.32)
	self.Portal:PivotTo(CFrame.new(self.PortalPosition) * CFrame.Angles(0, 0, -1.5707963267948966))
	self.Portal.Parent = workspace
end

function VoidPrimeCustomCodeClass:_ConsumePendingDrops()
	if not self.Portal or self.PortalState == "Closing" or self.PortalState == "Done" then
		return
	end

	while #v > 0 do
		self:_SpawnDebris(table.remove(v, 1))
	end
end

function VoidPrimeCustomCodeClass:_SpawnDebris(p)
	self.ConsumedDropCount += 1
	self.LastDropTime = self.ElapsedTime
	local v4 = self.ConsumedDropCount >= self.ExpectedDropCount
	local name = nil
	local blastName = nil

	if v4 then
		blastName = VoidPrimeWarshipBlast
		name = "VoidPrimeDebrisHullWarship"
	elseif self.ConsumedDropCount == 1 then
		blastName = VoidPrimeMeteorBlast
		self.AnchorGoal = p.Goal
		name = "VoidPrimeDebrisTurret"
	else
		local v5 = math.random() * total

		for _, v6 in v2 do
			v5 -= v6.Weight

			if not (v5 <= 0) then
				continue
			end

			name = v6.Name
			blastName = v6.BlastName
			break
		end
	end

	local miscResource = ResourceManager.GetMiscResource(name)
	miscResource:ScaleTo(v4 and 1 or 1.5 + math.random() * 1)
	local v5 = math.random() * 2 * 3.141592653589793
	local v6 = math.sqrt((math.random())) * (v4 and 0 or 69.12)
	local spawnPosition = self.PortalPosition + Vector3.new(math.cos(v5) * v6, 0, math.sin(v5) * v6)
	local goal = p.Goal
	local vector = Vector3.new(goal.X, self:_GetGroundY(goal), goal.Z)
	local vector2 = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
	local unit = vector2.Magnitude > 0.01 and vector2.Unit or createVector(1, 0, 0)
	local v7 = {
		Model = miscResource,
		Goal = vector,
		FlightTime = p.TimeToHit,
		Elapsed = 0,
		SpawnPosition = spawnPosition,
		TumbleAxis = unit,
		TumbleSpeed = v4 and math.random() * 0.05235987755982989 or 0.6981317007977318 + math.random() * 0.8726646259971648,
		TumbleAngle = math.random() * 2 * 3.141592653589793,
		BlastName = blastName
	}
	miscResource:PivotTo(CFrame.new(spawnPosition) * CFrame.fromAxisAngle(unit, v7.TumbleAngle))
	miscResource.Parent = workspace
	table.insert(self.ActiveDebris, v7)
end

function VoidPrimeCustomCodeClass:_UpdateDebris(p: number)
	for i = #self.ActiveDebris, 1, -1 do
		local v4 = self.ActiveDebris[i]
		v4.Elapsed += p
		local v5 = math.min(v4.Elapsed / v4.FlightTime, 1)
		local v6

		if v5 < 0.35 then
			local v7 = v5 / 0.35
			v6 = v4.SpawnPosition - Vector3.new(0, v7 * 20, 0)
		else
			local v7 = (v5 - 0.35) / 0.65
			local v8 = v7 ^ 5
			local v9 = v4.SpawnPosition - createVector(0, 20, 0)
			local v10 = 20 / (0.35 * v4.FlightTime)
			local v11 = v7 * 0.65 * v4.FlightTime
			v6 = v9:Lerp(v4.Goal, v8) - Vector3.new(0, v10 * v11 * (1 - v8), 0)
		end

		v4.TumbleAngle += v4.TumbleSpeed * p * (v5 * 10 + 1)
		v4.Model:PivotTo(CFrame.new(v6) * CFrame.fromAxisAngle(v4.TumbleAxis, v4.TumbleAngle))

		if not (v4.Elapsed >= v4.FlightTime) then
			continue
		end

		event:Fire(v4.BlastName, v4.Goal)
		v4.Model:Destroy()
		table.remove(self.ActiveDebris, i)
	end
end

function VoidPrimeCustomCodeClass:_GetGroundY(vector: Vector3)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	local raycastResult = workspace:Raycast(vector + createVector(0, 50, 0), createVector(0, -500, 0), raycastParams)
	return raycastResult and raycastResult.Position.Y or vector.Y
end

function VoidPrimeCustomCodeClass:_CleanupClawCalling()
	if self.Portal then
		self.Portal:Destroy()
		self.Portal = nil
	end

	self:_RestoreLighting()

	for _, v4 in self.ActiveDebris do
		v4.Model:Destroy()
	end

	self:_RestoreBossFacing()
	self.SequenceActive = false
	self.ElapsedTime = 0
	self.ClipFinished = false
	self.PortalState = nil
	self.PortalPosition = nil
	self.PortalSpin = 0
	self.PortalCloseElapsed = 0
	self.ActiveDebris = {}
	self.ConsumedDropCount = 0
	self.LastDropTime = 0
	self.AnchorGoal = nil
	table.clear(v)
end

function VoidPrimeCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function VoidPrimeCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function VoidPrimeCustomCodeClass:EnemyDestroyed(_: boolean?, _: boolean?)
	self:_CleanupClawCalling()
end

function VoidPrimeCustomCodeClass:CharacterCleanedUp()
	self:_CleanupClawCalling()
end

function VoidPrimeCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return VoidPrimeCustomCodeClass