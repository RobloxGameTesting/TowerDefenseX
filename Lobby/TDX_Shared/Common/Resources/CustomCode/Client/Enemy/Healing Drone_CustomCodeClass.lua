local createVector = vector.create
local HealingDroneCustomCodeClass = {}
HealingDroneCustomCodeClass.__index = HealingDroneCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function HealingDroneCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		DeathStarted = false,
		DeathTimeRemaining = 0.995,
		DeathStartCFrame = nil,
		StartingHoverHeight = 0,
		CurrentPosition = nil,
		RotationOffset = nil,
		MaxSpeed = nil,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil }
	}, HealingDroneCustomCodeClass))
end

function HealingDroneCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	self.StartingHoverHeight = characterModel:GetAttribute("HoverHeight") or 0
	self.CurrentPosition = enemy:GetPosition()
	self.RotationOffset = config.RotationOffset
	self.MaxSpeed = config.Speed
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 0.995,
		Callback = function()
			self._Wrappers.DeathExplode:PlayAll()
			self.Character:ExplodeParts(1)
		end
	})
end

function HealingDroneCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.DeathStarted then
		self.DeathTimeRemaining -= p
		local characterModel = self.CharacterModel
		local v = 1 - self.DeathTimeRemaining / 0.995
		characterModel:PivotTo(self.DeathStartCFrame - Vector3.new(0, v ^ 3 * self.StartingHoverHeight, 0))
	end

	self:_RunTiltSpring(p)
end

function HealingDroneCustomCodeClass:_RunTiltSpring(p: number)
	if p == 0 then
		return
	end

	local torsoToRootWeld = self.Character:GetTorsoToRootWeld()

	if not torsoToRootWeld then
		return
	end

	local realCFrame = self.Enemy.MovementHandler.RealCFrame
	local currentPosition = self.CurrentPosition
	self.CurrentPosition = realCFrame.Position
	local v = (realCFrame.Position - currentPosition) * createVector(1, 0, 1)
	local magnitude = v.Magnitude
	local cframe = CFrame.Angles(0, 0, 0)

	if magnitude > 0 then
		local unit = v.Unit
		local maxSpeed = self.MaxSpeed
		local v2 = math.clamp(magnitude / p / maxSpeed, 0, 1)
		local v3 = select(2, realCFrame:ToEulerAnglesYXZ())
		cframe = CFrame.Angles(
			(math.cos(v3 + 3.141592653589793) * unit.Z + math.sin(v3 + 3.141592653589793) * unit.X) * v2 * 0.241660973353061,
			0,
			(math.sin(v3 + 3.141592653589793) * unit.Z + math.cos(v3) * unit.X) * v2 * 0.241660973353061
		)
	end

	torsoToRootWeld.C0 = torsoToRootWeld.C0:Lerp(
		CFrame.new(torsoToRootWeld.C0.Position) * self.RotationOffset * cframe,
		p * 2
	)
end

function HealingDroneCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function HealingDroneCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function HealingDroneCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function HealingDroneCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self.DeathStarted = true
	self.DeathStartCFrame = self.CharacterModel:GetPivot()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function HealingDroneCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function HealingDroneCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return HealingDroneCustomCodeClass