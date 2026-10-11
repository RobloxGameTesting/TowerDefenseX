local createVector = vector.create
local FarmCrateDrop = {}
FarmCrateDrop.__index = FarmCrateDrop
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Enums = require(Common:WaitForChild("Enums"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local MapHandler = require(Common:WaitForChild("MapHandler"))
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local TowerClass = require(script.Parent.Parent.Parent.TowerClass)
local VisualEffectHandler = require(script.Parent.Parent.Parent.VisualEffectHandler)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local towerConfig = ResourceManager.GetTowerConfig(Enums.Towers.Farm)
local pathLockLevel = towerConfig.UpgradePathData.PathLockLevel
local v = #towerConfig.UpgradePathData.Path1Data
local Farm = Common.Resources.Towers.Models.Farm
local SkinCrates = Farm:FindFirstChild("SkinCrates")

local function SetSoundGroup(folder)
	for _, sound in pairs(folder:GetDescendants()) do
		if sound:IsA("Sound") then
			GameSoundHandler.AddSoundToSoundGroup(sound, "SFX")
		end
	end
end

local v2 = {}

for _, childName in pairs({ "Tier1Crate", "Tier2Crate", "Tier3Crate", "AC130" }) do
	local child = Farm:FindFirstChild(childName)

	if child then
		SetSoundGroup(child)
	else
		warn("Could not find CrateModel " .. childName .. " in FarmCrateDrop")
	end
end

for _, child in pairs(SkinCrates:GetChildren()) do
	SetSoundGroup(child)
end

local function GetSkinKey(p: string, p2: number, p3: number) -- 1 equivalent call inferred from this helper
	if p3 == 0 then
		return p .. "Base"
	end

	if p3 < pathLockLevel then
		return p .. "L" .. p3
	end

	assert(p2 ~= nil, "Upgrade path Index was not provided")
	assert(p3 ~= nil, "Level was not provided")
	return p .. "P" .. tostring(p2) .. "L" .. tostring(p3)
end

local function TryGetCrateSkin(skinName: string, p: number, p2: number) -- 1 equivalent call inferred from this helper
	if skinName == "" then
		return
	end

	local v3 = v2[GetSkinKey(skinName, p, p2)] -- inferred equivalent call

	if v3 then
		return v3:Clone()
	end
end

local function outQuad(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	local v3 = p / p4
	return -p3 * v3 * (v3 - 2) + p2
end

local function ClosestPointXZ(ray, position)
	local vector = Vector2.new(position.X, position.Z)
	local vector2 = Vector2.new(ray.Origin.X, ray.Origin.Z)
	local unit = Vector2.new(ray.Direction.X, ray.Direction.Z).Unit
	return vector2 + unit * (vector - vector2):Dot(unit)
end

local function ApplySkinLegacy(folder, skinName: string)
	for _, part in pairs(folder:GetDescendants()) do
		if not (part:IsA("BasePart") and skinName == "Christmas") then
			continue
		end

		if part:GetAttribute("Christmas" .. "Skin") then
			part.Transparency = 0
		elseif part:GetAttribute("DefaultSkin") then
			part.Transparency = 1
		end
	end
end

function FarmCrateDrop.new(hash: number, name: string, p)
	local angle = p.Angle
	local farmHashToCashPerCrate = p.FarmHashToCashPerCrate
	local center = MapHandler.GetCenter()
	local vector = Vector3.new(math.cos(angle) * 300, 0, math.sin(angle) * 300)
	local start = center + createVector(0, 100, 0) + vector
	local goal = center + createVector(0, 100, 0) - vector
	local v3 = {
		Hash = hash,
		Name = name,
		Start = start,
		Goal = goal,
		Elapsed = 0,
		Duration = 18,
		Farms = {},
		CratesDropping = {},
		CurrentlyDropping = 0,
		FarmQueue = 0,
		Plane = Farm.AC130:Clone(),
		PlaneAngle = CFrame.new(goal, start).Rotation
	}
	local ray = Ray.new(v3.Start, v3.Goal - v3.Start)

	for _, tower in TowerClass.GetTowers() do
		if not (tower:Alive() and tower.Type == Enums.Towers.Farm) then
			continue
		end

		local closestPointXZ = ClosestPointXZ(ray, tower.CFrame.Position)
		local vector2 = Vector3.new(closestPointXZ.X, v3.Start.Y, closestPointXZ.Y)
		local startAtAlpha = (vector2 - v3.Start).Magnitude / (v3.Start - v3.Goal).Magnitude
		local cashToGive = farmHashToCashPerCrate[tostring(tower.Hash)] or 0
		v3.FarmQueue += 1
		table.insert(v3.Farms, {
			StartAtAlpha = startAtAlpha,
			StartPoint = vector2,
			CrateDuration = (tower.LevelHandler:GetLevelOnPath(1) >= 1 and 0.4 or 1) * 12,
			CashToGive = cashToGive,
			TwoCrates = tower.LevelHandler:GetLevelOnPath(2) >= 5,
			Tower = tower
		})
	end

	return (setmetatable(v3, FarmCrateDrop))
end

function FarmCrateDrop:Run(p: number)
	self.Elapsed += p
	local v3 = self.Elapsed / self.Duration

	for k, farm in pairs(self.Farms) do
		local tower = farm.Tower
		local levelHandler = tower.LevelHandler
		local characterModel = tower.Character:GetCharacterModel()

		if not (farm.StartAtAlpha <= v3 and characterModel and characterModel:IsDescendantOf(workspace)) then
			continue
		end

		local isLegacyCrate = false
		local skinName = tower.SkinName
		local clone = TryGetCrateSkin( -- inferred equivalent call
			skinName,
			not levelHandler and 0 or levelHandler:GetPath() or 0,
			not levelHandler and 0 or levelHandler:GetOverallLevel() or 0
		)

		if not clone then
			if levelHandler:GetLevelOnPath(2) >= 5 then
				clone = Farm.Tier2Crate:Clone()
			elseif levelHandler:GetLevelOnPath(1) >= 3 then
				clone = Farm.Tier3Crate:Clone()
			else
				clone = Farm.Tier1Crate:Clone()
			end

			ApplySkinLegacy(clone, skinName)
			isLegacyCrate = true
		end

		local v4 = clone.Root.Position.Y - clone.Bottom.Position.Y + clone.Bottom.Size.Y / 2
		local endPoint = characterModel.Platform.CratePoint.WorldPosition + Vector3.new(0, v4, 0)
		table.insert(self.CratesDropping, {
			StartPoint = farm.StartPoint,
			EndPoint = endPoint,
			Elapsed = 0,
			CrateDuration = farm.CrateDuration,
			TickOffset = math.random() * 3,
			IsLegacyCrate = isLegacyCrate,
			CrateModel = clone,
			CashToGive = farm.CashToGive,
			Tweens = {}
		})

		if farm.TwoCrates then
			local endPoint2 = characterModel.Platform.CratePoint2.WorldPosition + Vector3.new(0, v4, 0)
			table.insert(self.CratesDropping, {
				StartPoint = farm.StartPoint,
				EndPoint = endPoint2,
				Elapsed = 0,
				CrateDuration = farm.CrateDuration,
				TickOffset = math.random() * 3,
				IsLegacyCrate = isLegacyCrate,
				CrateModel = clone:Clone(),
				CashToGive = farm.CashToGive
			})
			self.CurrentlyDropping += 1
		end

		self.Farms[k] = nil
		self.FarmQueue -= 1
		self.CurrentlyDropping += 1
	end

	for k, v4 in pairs(self.CratesDropping) do
		v4.Elapsed += p
		local v5 = math.clamp(v4.Elapsed / v4.CrateDuration, 0, 1)
		local v6 = outQuad(v5, 0, 1, 1) -- inferred equivalent call
		local crateModel = v4.CrateModel
		local primaryPart = crateModel.PrimaryPart

		if crateModel.Parent == nil and not v4.DestroyVFX then
			primaryPart.Descend.TimePosition = math.random()
			primaryPart.Descend:Play()
			primaryPart["Open" .. math.random(1, 3)]:Play()
			crateModel.Parent = raycastIgnore
		end

		if crateModel.Parent and not v4.DestroyVFX then
			crateModel.Root.Descend.Volume = 0.5 * (1 - v6 * 0.75)
			crateModel:SetPrimaryPartCFrame(CFrame.new(v4.StartPoint:Lerp(v4.EndPoint, v6)) * CFrame.Angles(
				math.sin(v4.TickOffset + v4.Elapsed * 2.5) * 0.66 * (1 - v5),
				0,
				math.cos(v4.TickOffset + v4.Elapsed * 4) * 0.3 * (1 - v5)
			))
		end

		if not (v4.Elapsed >= v4.CrateDuration) then
			continue
		end

		if v4.DestroyVFX then
			for _, tween in v4.Tweens do
				tween:Cancel()
				tween:Destroy()
			end

			crateModel:Destroy()
			table.remove(self.CratesDropping, k)
			self.CurrentlyDropping -= 1
		else
			v4.CrateDuration += 3
			v4.DestroyVFX = true
			primaryPart.Land:Play()
			local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back)
			local tweenInfo2 = TweenInfo.new(0.35)
			local v7 = v4
			task.spawn(function()
				primaryPart.BillboardGui.TextLabel.Text = "$" .. v7.CashToGive
				local tween = TweenService:Create(primaryPart.BillboardGui, tweenInfo, {
					StudsOffset = Vector3.new()
				})
				local tween2 = TweenService:Create(primaryPart.BillboardGui.TextLabel, tweenInfo2, {
					TextTransparency = 0,
					TextStrokeTransparency = 0.5
				})
				local tween3 = TweenService:Create(primaryPart.BillboardGui.TextLabel, tweenInfo2, {
					TextTransparency = 1,
					TextStrokeTransparency = 1
				})
				v7.Tweens = { tween, tween2, tween3 }
				tween2:Play()
				tween:Play()
				task.wait(tweenInfo.Time + 1.75)
				tween3:Play()
			end)
			VisualEffectHandler.NewVisualEffect({
				Name = "CrateMoney",
				Position = v4.EndPoint - createVector(0, 1, 0),
				IsContinuous = false
			})

			if v4.IsLegacyCrate then
				crateModel.Box:Destroy()
				crateModel.ChristmasSkin:Destroy()
				crateModel.Parachute:Destroy()
			else
				for _, part in pairs(crateModel:GetChildren()) do
					if part:IsA("BasePart") and part ~= crateModel.PrimaryPart then
						part:Destroy()
					end
				end
			end

			primaryPart.Descend:Stop()
		end
	end

	local plane = self.Plane

	if plane.Parent == nil then
		GameSoundHandler.AddSoundToSoundGroup(self.Plane.Root.Engine, "SFX")
		plane.Root.Engine:Play()
		plane.Parent = raycastIgnore
	end

	plane:SetPrimaryPartCFrame(CFrame.new(self.Start:Lerp(self.Goal, v3)) * self.PlaneAngle)

	for _, child in pairs(plane:GetChildren()) do
		if child.Name == "Rotor" then
			child.CFrame *= CFrame.Angles(0, 0, p * 25)
		end
	end
end

function FarmCrateDrop.IsCleanupReady(data)
	return data.Elapsed >= data.Duration and data.FarmQueue == 0 and data.CurrentlyDropping == 0
end

function FarmCrateDrop:EndEarly()
	self.Farms = {}
	self.FarmQueue = 0

	for _, v3 in pairs(self.CratesDropping) do
		if v3.CrateModel then
			v3.CrateModel:Destroy()
		end
	end

	self.CratesDropping = {}
	self.CurrentlyDropping = 0
	self.Elapsed = self.Duration
end

function FarmCrateDrop:Destroy()
	self.Plane:Destroy()
end

for _, child in pairs(SkinCrates:GetChildren()) do
	local function AddCrateSkinModel(p: string, p2) -- 4 equivalent calls inferred from this helper
		v2[p] = p2
	end

	local name = child.Name
	local base = child:FindFirstChild("Base")
	local path1 = child:FindFirstChild("Path1")
	local path2 = child:FindFirstChild("Path2")
	assert(base ~= nil, "FarmCrate Base model was nil for " .. name)
	assert(path1 ~= nil, "FarmCrate Path1 folder was nil for " .. name)
	assert(path2 ~= nil, "FarmCrate Path2 folder was nil for " .. name)
	AddCrateSkinModel(name .. "Base", base) -- inferred equivalent call

	for i = 1, pathLockLevel - 1 do
		local child2 = child:FindFirstChild((tostring(i)))

		if child2 then
			local v3

			if i == 0 then
				v3 = name .. "Base"
			elseif i < pathLockLevel then
				v3 = name .. "L" .. i
			else
				assert(true, "Upgrade path Index was not provided")
				assert(i ~= nil, "Level was not provided")
				v3 = name .. "P" .. tostring(1) .. "L" .. tostring(i)
			end

			AddCrateSkinModel(v3, child2) -- inferred equivalent call
		else
			warn("Did not find model for " .. name .. ": Level " .. tostring(i))
		end
	end

	for i = pathLockLevel, v do
		local child2 = path1:FindFirstChild((tostring(i)))
		local child3 = path2:FindFirstChild((tostring(i)))

		if child2 then
			local v3

			if i == 0 then
				v3 = name .. "Base"
			elseif i < pathLockLevel then
				v3 = name .. "L" .. i
			else
				assert(true, "Upgrade path Index was not provided")
				assert(i ~= nil, "Level was not provided")
				v3 = name .. "P" .. tostring(1) .. "L" .. tostring(i)
			end

			AddCrateSkinModel(v3, child2) -- inferred equivalent call
		else
			warn("Did not find model for " .. name .. ": Path 1 Level " .. tostring(i))
		end

		if child3 then
			local v3

			if i == 0 then
				v3 = name .. "Base"
			elseif i < pathLockLevel then
				v3 = name .. "L" .. i
			else
				assert(true, "Upgrade path Index was not provided")
				assert(i ~= nil, "Level was not provided")
				v3 = name .. "P" .. tostring(2) .. "L" .. tostring(i)
			end

			AddCrateSkinModel(v3, child3) -- inferred equivalent call
		else
			warn("Did not find model for " .. name .. ": Path 2 Level " .. tostring(i))
		end
	end
end

return FarmCrateDrop