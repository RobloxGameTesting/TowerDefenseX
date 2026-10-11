local createVector = vector.create
local EntityUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PlacementHandler = require(common:WaitForChild("PlacementHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

function EntityUtilities.GetEffectFollowPart(object, flag: boolean?, flag2: boolean?)
	if flag then
		return object:GetHead()
	end

	if flag2 then
		return object:GetTorso()
	end

	return object:GetRealTorso()
end

function EntityUtilities.GetPointOnPartBounds(vector: Vector3, p)
	local randomPointInPart = Utilities.GetRandomPointInPart(p)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = { p }
	local raycastResult = workspace:Raycast(vector, 2 * (randomPointInPart - vector), raycastParams)

	if raycastResult then
		return raycastResult.Position
	end

	return p.Position
end

function EntityUtilities.GetParentModelUnderCharacterModel(p, p2)
	local parent = p.Parent

	while parent.Parent ~= p2 and parent ~= workspace do
		parent = parent.Parent
	end

	if parent.Parent ~= p2 then
		parent = false
	end

	return parent
end

function EntityUtilities.GetProjectileOriginNames(p)
	local modelNames = {}
	local v = false

	if p.ProjectileName then
		local projectileConfig = ResourceManager.GetProjectileConfig(p.ProjectileName)

		if projectileConfig then
			table.insert(modelNames, projectileConfig.ModelName)
			v = true
		end
	end

	if not p.AbilityConfigs then
		return v, modelNames
	end

	for _, abilityConfig in pairs(p.AbilityConfigs) do
		if not abilityConfig.ProjectileName then
			continue
		end

		local projectileConfig = ResourceManager.GetProjectileConfig(abilityConfig.ProjectileName)

		if not projectileConfig then
			continue
		end

		table.insert(modelNames, projectileConfig.ModelName)
		v = true
	end

	return v, modelNames
end

local function GetRandomInitialVelocity() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25), math.random(30, 55), math.random(-22, 22)))
end

local function GetRandomInitialAngularImpulse() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25) / 100, math.random(-35, 35) / 100, 0))
end

function EntityUtilities.ExplodeParts(folder, value: number?, value2: number?, callback)
	local primaryPart = folder.PrimaryPart
	local explodePartsKeepList = folder:FindFirstChild("ExplodePartsKeepList")
	local v = {}
	local v2 = primaryPart:FindFirstChildOfClass("Bone") ~= nil

	if explodePartsKeepList then
		local flipTable = Utilities.FlipTable(require(explodePartsKeepList))
		local parts = {}

		for _, part in pairs(folder:GetDescendants()) do
			if
				not part:IsA("BasePart")
				or flipTable[Utilities.GetPathFromParent(part, folder)]
				or primaryPart == part
			then
				continue
			end

			table.insert(parts, part)
		end

		for _, v3 in pairs(parts) do
			v3:Destroy()
			v[v3] = true
		end
	end

	local function DestroyIfBoneRig(part1) -- 2 equivalent calls inferred from this helper
		if v2 then
			part1:Destroy()
			v[part1] = true
		end
	end

	for _, descendant in pairs(folder:GetDescendants()) do
		if not (descendant:IsA("Weld") or descendant:IsA("Motor6D") or descendant:IsA("WeldConstraint")) then
			continue
		end

		local part1 = descendant.Part1

		if not part1 or v[part1] or not (descendant.Active or not descendant.Enabled) then
			continue
		end

		local canExplode = part1:FindFirstChild("CanExplode")
		local v3

		if canExplode and canExplode:IsA("BoolValue") then
			v3 = canExplode.Value
		else
			v3 = false
		end

		if not v3 then
			if part1.Transparency > 0.99 then
				continue
			end

			if part1.Size.Magnitude < 1 then
				DestroyIfBoneRig(part1) -- inferred equivalent call
				continue
			elseif part1:GetAttribute("ExplodePartsIgnore") then
				DestroyIfBoneRig(part1) -- inferred equivalent call
				continue
			end
		end

		descendant:Destroy()
		local mass = part1:GetMass()
		part1.Parent = raycastIgnore
		part1:ApplyImpulse(GetRandomInitialVelocity() * mass * (value or 1)) -- inferred equivalent call
		part1:ApplyAngularImpulse(GetRandomInitialAngularImpulse() * mass * (value or 1)) -- inferred equivalent call
		task.delay(0.07, function()
			part1.CanCollide = true
			task.wait(4)
			local total = 0

			while total < 1.5 do
				total += task.wait()
				part1.Transparency = total / 1.5
			end

			part1:Destroy()
		end)
	end

	if callback then
		task.delay(5.5 + (value2 or 0) + 1, callback)
	end
end

function EntityUtilities.GetCrashLocation(vector: Vector3, p: number, value: number?)
	local v = value or 5
	local x = vector.X
	local z = vector.Z
	local v2 = 2 * (math.random() - 0.5)
	local v3 = 2 * (math.random() - 0.5)
	local v4 = x + v2 * v
	local v5 = z + v3 * v
	local groundHeightAtXZ = PlacementHandler.GetGroundHeightAtXZ(v4, v5)
	local v6 = MapHandler.GetRangeDisplayHeightAtXZ(v4, v5) + p * 0.5
	local v7 = math.clamp(groundHeightAtXZ, MapHandler.GetMinMaxHeight(), v6)
	local vector2 = Vector3.new(x, MapHandler.GetRangeDisplayHeightAtXZ(x, z) + p, z)
	local vector3 = Vector3.new(v4, v7, v5)
	local v8 = vector3 - vector2
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	local raycastResult = workspace:Raycast(vector2, v8 * 2, raycastParams)

	if raycastResult then
		return raycastResult.Position - createVector(0, 1, 0)
	end

	return vector3 - createVector(0, 1, 0)
end

return EntityUtilities