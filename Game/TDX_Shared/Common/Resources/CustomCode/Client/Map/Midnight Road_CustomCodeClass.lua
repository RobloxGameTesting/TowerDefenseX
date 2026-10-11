local MidnightRoadCustomCodeClass = {}
MidnightRoadCustomCodeClass.__index = MidnightRoadCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("CustomCodeTypes"))
require(common:WaitForChild("MapTypes"))
local Hidden = Lighting:WaitForChild("Hidden")
local models = {}
local v = {}
local cars = nil
local v2 = {}
local v3 = 0

local function GetNextSpawnInterval() -- 2 equivalent calls inferred from this helper
	return 0.75 + math.random() * 2.25
end

local function SetUpCarTemplates(raycastIgnore)
	local carTemplates = raycastIgnore:WaitForChild("CarTemplates", 5)

	if not carTemplates then
		warn("Midnight Road: no CarTemplates folder found")
		return
	end

	for _, model in pairs(carTemplates:GetChildren()) do
		if not model:IsA("Model") then
			continue
		end

		local primaryPart = model.PrimaryPart or model:FindFirstChild("Root")

		if primaryPart and primaryPart:IsA("BasePart") then
			model.PrimaryPart = primaryPart
			table.insert(models, model)
		else
			warn(`Midnight Road: car template {model.Name} has no Root part`)
		end
	end

	carTemplates.Parent = Hidden
end

local function SetUpCarSpawns(raycastIgnore)
	local carSpawns = raycastIgnore:WaitForChild("CarSpawns", 5)

	if not carSpawns then
		warn("Midnight Road: no CarSpawns folder found")
		return
	end

	for _, part in pairs(carSpawns:GetChildren()) do
		local match = part.Name:match("^Spawn(%d+)$")

		if not (match and part:IsA("BasePart")) then
			continue
		end

		local part2 = carSpawns:FindFirstChild(`End{match}`)

		if part2 and part2:IsA("BasePart") then
			local v4 = part2.Position - part.Position
			table.insert(v, {
				StartCFrame = CFrame.lookAt(part.Position, part2.Position),
				Direction = v4.Unit,
				Distance = v4.Magnitude
			})
		else
			warn(`Midnight Road: {part.Name} has no matching End{match} part`)
		end
	end
end

local function ClearCars()
	for _, v4 in pairs(v2) do
		v4.Model:Destroy()
	end

	table.clear(v2)

	if cars then
		cars:ClearAllChildren()
	end
end

local function LaneIsClear(p) -- 1 equivalent call inferred from this helper
	for _, v4 in pairs(v2) do
		if v4.Spawn == p and v4.DistanceTravelled < 20 then
			return false
		end
	end

	return true
end

local function SpawnCar()
	if #models == 0 or #v == 0 or not cars then
		return
	end

	local v4 = {}

	for _, v5 in pairs(v) do
		if LaneIsClear(v5) then -- inferred equivalent call
			table.insert(v4, v5)
		end
	end

	if #v4 == 0 then
		return
	end

	local spawn = v4[math.random(1, #v4)]
	local clone = models[math.random(1, #models)]:Clone()

	for _, part in pairs(clone:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
	end

	local startCFrame = spawn.StartCFrame * clone.PrimaryPart.PivotOffset
	clone:PivotTo(startCFrame)
	clone.Parent = cars
	table.insert(v2, {
		Model = clone,
		Spawn = spawn,
		StartCFrame = startCFrame,
		DistanceTravelled = 0
	})
end

function MidnightRoadCustomCodeClass.New()
	return (setmetatable({}, MidnightRoadCustomCodeClass))
end

function MidnightRoadCustomCodeClass.OnLoaded(_, instance, _, _: number)
	ClearCars()
	table.clear(models)
	table.clear(v)
	cars = nil
	v3 = GetNextSpawnInterval() -- inferred equivalent call
	task.spawn(function()
		local raycastIgnore = instance:WaitForChild("RaycastIgnore", 5)

		if not raycastIgnore then
			warn("Midnight Road: no RaycastIgnore folder found")
			return
		end

		SetUpCarTemplates(raycastIgnore)
		SetUpCarSpawns(raycastIgnore)
		cars = raycastIgnore:WaitForChild("Cars", 5)

		if cars then
			cars:ClearAllChildren()
		else
			warn("Midnight Road: no Cars folder found")
		end
	end)
end

function MidnightRoadCustomCodeClass.ClientTick(_, p: number)
	for i = #v2, 1, -1 do
		local v4 = v2[i]
		local spawn = v4.Spawn
		v4.DistanceTravelled += p * 20

		if v4.DistanceTravelled >= spawn.Distance then
			v4.Model:Destroy()
			table.remove(v2, i)
		else
			v4.Model:PivotTo(v4.StartCFrame + spawn.Direction * v4.DistanceTravelled)
		end
	end

	v3 -= p

	if v3 <= 0 then
		v3 = GetNextSpawnInterval() -- inferred equivalent call
		SpawnCar()
	end
end

function MidnightRoadCustomCodeClass.SpeedMultiplierChanged(_, _: number) end

return MidnightRoadCustomCodeClass