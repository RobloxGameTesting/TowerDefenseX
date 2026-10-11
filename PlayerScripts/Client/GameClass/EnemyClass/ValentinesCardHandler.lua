local createVector = vector.create
local ValentinesCardHandler = {}
ValentinesCardHandler.__index = ValentinesCardHandler
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local v = {}

local function GetStartPosition(p: string, vector: Vector3) -- 1 equivalent call inferred from this helper
	if p == Enums.Enemies.Eradicator then
		return vector + createVector(0, 15, 0)
	end

	if p == Enums.Enemies.EradicatorMK2 then
		return vector + createVector(0, 3, 0)
	end
end

local function GetDelay(p: string) -- 1 equivalent call inferred from this helper
	if p == Enums.Enemies.Eradicator then
		return 3.35
	end

	if p == Enums.Enemies.EradicatorMK2 then
		return 5.4
	end

	return 0
end

local function GetInitialVelocity(p: string)
	if p == Enums.Enemies.Eradicator then
		return createVector(0, 0, 0)
	end

	if p == Enums.Enemies.EradicatorMK2 then
		return (Vector3.new(math.random(50, 70) / 10, math.random(170, 200), math.random(10, 15) / 10))
	end
end

local function GetInitialAngularImpulse(p: string) -- 1 equivalent call inferred from this helper
	if p == Enums.Enemies.Eradicator then
		return createVector(0, 0, 0)
	end

	if p == Enums.Enemies.EradicatorMK2 then
		return createVector(0.01, 0.02, 0)
	end
end

function ValentinesCardHandler.DropCard(p: string, vector: Vector3)
	local startPosition = GetStartPosition(p, vector) -- inferred equivalent call
	local delayRemaining = GetDelay(p) -- inferred equivalent call
	local initialVelocity = GetInitialVelocity(p)
	local initialAngularImpulse = GetInitialAngularImpulse(p) -- inferred equivalent call
	local miscResource = ResourceManager.GetMiscResource("ValentinesCard")
	local size = miscResource.Size
	local sound = miscResource:FindFirstChild("Sound")
	local sparkles = miscResource:FindFirstChild("Sparkles")
	miscResource.CFrame = CFrame.new(startPosition)
	miscResource.Transparency = 1
	miscResource.Size = createVector(0.1, 0.1, 0.1)
	miscResource.Anchored = true
	miscResource.Parent = raycastIgnore
	local v2 = {
		StartPosition = vector,
		DelayRemaining = delayRemaining,
		InitialVelocity = initialVelocity,
		InitialAngularImpulse = initialAngularImpulse,
		Started = false,
		CurrentScale = 0,
		OriginalSize = size,
		CardPart = miscResource,
		Sparkles = sparkles,
		Sound = sound
	}
	table.insert(v, v2)
	setmetatable(v2, ValentinesCardHandler)
	return v2
end

function ValentinesCardHandler:Run(p: number)
	if self.DelayRemaining > 0 then
		self.DelayRemaining = math.max(0, self.DelayRemaining - p)
		return
	end

	local cardPart = self.CardPart

	if not self.Started then
		cardPart.Transparency = 0
		cardPart.Anchored = false
		cardPart:ApplyImpulse(self.InitialVelocity * cardPart:GetMass())
		cardPart:ApplyAngularImpulse(self.InitialAngularImpulse * cardPart:GetMass())
		self.Sound:Play()
		self.Sparkles.Enabled = true
		self.Started = true
	end

	if self.CurrentScale < 1 then
		self.CurrentScale = math.min(1, self.CurrentScale + p / 0.5)
		cardPart.Size = self.CurrentScale * self.OriginalSize
	end
end

function ValentinesCardHandler:Destroy()
	self.CardPart:Destroy()
end

function ValentinesCardHandler.Restart()
	for _, v2 in pairs(v) do
		v2:Destroy()
	end

	table.clear(v)
end

function ValentinesCardHandler.LogicLoop(p: number)
	for _, v2 in pairs(v) do
		v2:Run(p)
	end
end

return ValentinesCardHandler