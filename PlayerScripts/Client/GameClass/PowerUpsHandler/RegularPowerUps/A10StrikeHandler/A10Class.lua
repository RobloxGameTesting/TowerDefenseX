local A10Class = {}
A10Class.__index = A10Class
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local LightAnimationHandlerClass = require(common:WaitForChild("LightAnimationHandlerClass"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
require(common.Resources.Misc.RegularPowerUps.A10Strike.Types)
local EnemyClass = require(script.Parent.Parent.Parent.Parent:WaitForChild("EnemyClass"))
local VisualEffectHandler = require(script.Parent.Parent.Parent.Parent:WaitForChild("VisualEffectHandler"))
local AttackHandlerClass = require(script.Parent:WaitForChild("AttackHandlerClass"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local a10 = common.Resources.Misc.RegularPowerUps.A10Strike.A10

local function SetUpAttacks(clone, p: number)
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.A10Strike)
	local result = {}

	for k, attack in pairs(config.Attacks) do
		result[k] = AttackHandlerClass.New(clone, k, attack, p)
	end

	return result
end

local function ChangePlaneTransparency(allBasepartDescendants, p: number)
	for _, item in pairs(allBasepartDescendants) do
		local originalTransparency = item:GetAttribute("OriginalTransparency")

		if not originalTransparency then
			originalTransparency = item.Transparency
			item:SetAttribute("OriginalTransparency", originalTransparency)
		end

		item.Transparency = math.max(p, originalTransparency)
	end
end

function A10Class.New(data, speedMultiplier: number)
	local hash = data.Hash
	local child = Players:FindFirstChild(data.PlayerName)
	local start = data.Start
	local v = data.End
	local clientRootPosition = data.ClientRootPosition
	local totalTime = data.TotalTime
	local vector = Vector3.new(0, (hash - 1) * 12, 0)
	local v2 = "Move" .. tostring(hash % 2 == 0 and "1" or "2")
	local v3 = v - start
	local v4 = clientRootPosition + vector
	local clone = a10:Clone()
	local allBasepartDescendants = Utilities.GetAllBasepartDescendants(clone)
	local trails = {
		clone:FindFirstChild("TrailPart1"):FindFirstChild("Trail"),
		clone:FindFirstChild("TrailPart2"):FindFirstChild("Trail")
	}
	ChangePlaneTransparency(allBasepartDescendants, 1)

	for _, v5 in pairs(trails) do
		v5.Enabled = false
	end

	local primaryPart = clone.PrimaryPart
	primaryPart.CFrame = CFrame.new(v4, v4 - v3)
	clone.Parent = raycastIgnore
	local animationHandler = LightAnimationHandlerClass.New(clone, speedMultiplier)
	animationHandler:Play(v2)
	local attacks = SetUpAttacks(clone, speedMultiplier)
	local minigun = clone:FindFirstChild("Minigun")
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(minigun, speedMultiplier)
	local minigunSFX = clone:FindFirstChild("MinigunSFX")
	local soundWrapper = WrapperFactory.NewSoundWrapper(minigunSFX, speedMultiplier)
	local zoomSFX = clone:FindFirstChild("ZoomSFX")
	local soundWrapper2 = WrapperFactory.NewSoundWrapper(zoomSFX, speedMultiplier)
	local idleSFX = clone:FindFirstChild("IdleSFX")
	local soundWrapper3 = WrapperFactory.NewSoundWrapper(idleSFX, speedMultiplier)
	local v5 = {
		Hash = hash,
		Player = child,
		Start = start,
		End = v,
		TimePassed = 0,
		TotalTime = totalTime,
		SpeedMultiplier = speedMultiplier,
		AnimationHandler = animationHandler,
		Destroyed = false,
		PlaneModel = clone,
		Root = primaryPart,
		Attacks = attacks,
		Trails = trails,
		MinigunSFXStarted = false,
		_TimingHelpers = {
			MinigunSFXTimingHelper = TimingHelperClass.New({
				TimeUntilCallback = 0.2,
				Callback = function()
					soundWrapper:PlayAll()
				end
			}),
			ZoomSFXTimingHelper = TimingHelperClass.New({
				TimeUntilCallback = 4.5,
				Callback = function()
					soundWrapper2:PlayAll()
				end
			})
		},
		_Wrappers = {
			MinigunEffectWrapper = emitterAndSoundWrapper,
			MinigunSFXWrapper = soundWrapper,
			ZoomSFXWrapper = soundWrapper2,
			IdleSFXWrapper = soundWrapper3
		}
	}
	setmetatable(v5, A10Class)
	v5:_ScaleTrails()
	task.delay(0.5, function()
		ChangePlaneTransparency(allBasepartDescendants, 0)

		for _, v6 in pairs(trails) do
			v6.Enabled = true
		end

		v5._Wrappers.IdleSFXWrapper:PlayAll()
		v5._TimingHelpers.ZoomSFXTimingHelper:Start()
	end)
	return v5
end

function A10Class:Run(p: number)
	self.TimePassed += p

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function A10Class.CanCleanup(p)
	if p.Destroyed then
		return true
	end

	return false
end

function A10Class:Destroy()
	self.PlaneModel:Destroy()
	self.Destroyed = true

	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function A10Class:HandleAttack(data)
	local attackName = data.AttackName
	local attack = self.Attacks[attackName]
	local enemyHash = data.EnemyHash
	local enemy = EnemyClass.GetEnemy(enemyHash)

	if enemy then
		attack:HandleAttack(enemy, data.BurstIndex)
	end

	if attackName == "Minigun" then
		self._Wrappers.MinigunEffectWrapper:PlayAll()

		if not self.MinigunSFXStarted then
			self._TimingHelpers.MinigunSFXTimingHelper:Start()
			self.MinigunSFXStarted = true
		end

		self:_MinigunHitVFX(enemy:GetIsAirUnit() and enemy:GetTorsoPosition() or enemy:GetPosition())
	end
end

function A10Class:ReceiveUpdate(p: string, p2)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "EarlyExit" then
		self:BeginExit()
	elseif p == "Attack" then
		self:HandleAttack(p2)
	end
end

function A10Class:SpeedMultiplierChanged(speedMultiplier: number)
	for _, attack in pairs(self.Attacks) do
		attack:SpeedMultiplierChanged(speedMultiplier)
	end

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.AnimationHandler:SetSpeedMultiplier(speedMultiplier)
	self.SpeedMultiplier = speedMultiplier
	self:_ScaleTrails()
end

function A10Class:_ScaleTrails()
	for _, trail in pairs(self.Trails) do
		trail.Lifetime = 5 / math.max(self.SpeedMultiplier, 0.1)
	end
end

function A10Class:_MinigunHitVFX(vector: Vector3)
	local randomOffsetPosition = ProjectileUtilities.RandomOffsetPosition(vector, 1.5, 0.05)
	local v = { Name = Enums.VisualEffects.A10MinigunHit, Position = randomOffsetPosition }
	VisualEffectHandler.NewVisualEffect(v)
end

return A10Class