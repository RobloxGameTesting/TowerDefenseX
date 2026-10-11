local createVector = vector.create
local ForgottenKnightCustomCodeClass = {}
ForgottenKnightCustomCodeClass.__index = ForgottenKnightCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))

function ForgottenKnightCustomCodeClass.New(speedMultiplier: number)
	local raycastIgnore = MapHandler.GetCurrentMap():FindFirstChild("RaycastIgnore")
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		DeathStarted = false,
		DeathTimeRemaining = 2.2,
		DeathStartCFrame = nil,
		StartingHoverHeight = 0,
		CurrentPosition = nil,
		RotationOffset = nil,
		MaxSpeed = nil,
		VinesModel = raycastIgnore and raycastIgnore:FindFirstChild("ForgottenKnightVines"),
		VinesModelVisible = false,
		TimeUntilHideVinesModel = 0,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil }
	}, ForgottenKnightCustomCodeClass))
end

function ForgottenKnightCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	self.StartingHoverHeight = characterModel:GetAttribute("HoverHeight") or config.HoverHeight or 0
	self.CurrentPosition = enemy:GetPosition()
	self.RotationOffset = config.RotationOffset
	self.MaxSpeed = config.Speed
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2.2,
		Callback = function() end
	})
end

function ForgottenKnightCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.DeathStarted then
		self.DeathTimeRemaining -= p
		local v = 2.2 - self.DeathTimeRemaining

		if v < 1.7 then
			return
		end

		local characterModel = self.CharacterModel
		local v2 = math.clamp((v - 1.7) / 0.5000000000000002, 0, 1)
		characterModel:PivotTo(self.DeathStartCFrame - Vector3.new(0, v2 ^ 2 * self.StartingHoverHeight, 0))
	end

	if self.VinesModelVisible then
		self.TimeUntilHideVinesModel -= p

		if self.TimeUntilHideVinesModel <= 0 then
			self:_HideVinesModel()
		end
	end
end

function ForgottenKnightCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function ForgottenKnightCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.ForgottenKnightCurseBase and p2 == "Vines" then
		self:_ShowVinesModel()
	end
end

function ForgottenKnightCustomCodeClass:_ShowVinesModel()
	self.VinesModelVisible = true
	self.TimeUntilHideVinesModel = 5

	if self.VinesModel then
		local tweenInfo = TweenInfo.new(1)

		for _, part in pairs(self.VinesModel:GetDescendants()) do
			if part:IsA("BasePart") then
				TweenService:Create(part, tweenInfo, { Transparency = 0 }):Play()
			end
		end
	end
end

function ForgottenKnightCustomCodeClass:_HideVinesModel()
	self.VinesModelVisible = false

	if self.VinesModel then
		local tweenInfo = TweenInfo.new(1)

		for _, part in pairs(self.VinesModel:GetDescendants()) do
			if part:IsA("BasePart") then
				TweenService:Create(part, tweenInfo, { Transparency = 1 }):Play()
			end
		end
	end
end

function ForgottenKnightCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function ForgottenKnightCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self.DeathStarted = true
	self.DeathStartCFrame = self.CharacterModel:GetPivot()
	local position = self.CharacterModel.PrimaryPart.Position
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	local raycastResult = workspace:Raycast(position, createVector(0, -100, 0), raycastParams)

	if raycastResult then
		local position2 = raycastResult.Position
		local startingHoverHeight = math.abs(position.Y - position2.Y)

		if self.StartingHoverHeight < startingHoverHeight then
			self.StartingHoverHeight = startingHoverHeight
		end
	end

	self._TimingHelpers.DeathTimingHelper:Start()
end

function ForgottenKnightCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function ForgottenKnightCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return ForgottenKnightCustomCodeClass