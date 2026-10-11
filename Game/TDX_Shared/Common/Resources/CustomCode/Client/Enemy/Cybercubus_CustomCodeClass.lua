local CybercubusCustomCodeClass = {}
CybercubusCustomCodeClass.__index = CybercubusCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

local function GetRandomInitialVelocity() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-35, 35), math.random(40, 80), math.random(-35, 35)))
end

local function GetRandomInitialAngularImpulse() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-30, 30) / 100, math.random(-50, 50) / 100, 0))
end

function CybercubusCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		_TimingHelpers = { DamagedTimingHelper = nil, DeathTimingHelper = nil },
		_Wrappers = { ArmorExplode = nil, LeftArmSmash = nil, RightArmSmash = nil }
	}, CybercubusCustomCodeClass))
end

function CybercubusCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local armorExplodePart = characterModel:FindFirstChild("ArmorExplodePart")
	local smashVFXLeft = characterModel:FindFirstChild("SmashVFXLeft")
	local smashVFXRight = characterModel:FindFirstChild("SmashVFXRight")
	self._Wrappers.ArmorExplode = WrapperFactory.NewEmitterAndSoundWrapper(armorExplodePart, speedMultiplier)
	self._Wrappers.LeftArmSmash = WrapperFactory.NewEmitterAndSoundWrapper(smashVFXLeft, speedMultiplier)
	self._Wrappers.RightArmSmash = WrapperFactory.NewEmitterAndSoundWrapper(smashVFXRight, speedMultiplier)
	self._TimingHelpers.DamagedTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 5 / 3,
		Callback = function()
			local armor = characterModel:FindFirstChild("Armor")
			local v = {}

			for _, part in pairs(armor:GetChildren()) do
				if part:IsA("BasePart") then
					v[part] = true
				end
			end

			self._Wrappers.ArmorExplode:PlayAll()

			for _, jointInstance in pairs(characterModel:GetDescendants()) do
				if not jointInstance:IsA("JointInstance") then
					continue
				end

				local part1 = jointInstance.Part1

				if not (part1 and v[part1]) then
					continue
				end

				jointInstance:Destroy()
				local mass = part1:GetMass()
				part1.Parent = raycastIgnore
				part1:ApplyImpulse(GetRandomInitialVelocity() * mass) -- inferred equivalent call
				part1:ApplyAngularImpulse(GetRandomInitialAngularImpulse() * mass) -- inferred equivalent call
				task.delay(0.1, function()
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
		end
	})
end

function CybercubusCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function CybercubusCustomCodeClass:AbilityUsed(previousAbilityName: string)
	if previousAbilityName == Enums.EnemyAbilities.CybercubusArmorBreak then
		self:_EnterDamagedState()
	end

	self.PreviousAbilityName = previousAbilityName
end

function CybercubusCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.CybercubusSmashGroundDouble then
		if p2 == "Left" then
			self._Wrappers.LeftArmSmash:PlayAll()
		elseif p2 == "Right" then
			self._Wrappers.RightArmSmash:PlayAll()
		end
	end
end

function CybercubusCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function CybercubusCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function CybercubusCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function CybercubusCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function CybercubusCustomCodeClass:_EnterDamagedState()
	self._TimingHelpers.DamagedTimingHelper:Start()
end

return CybercubusCustomCodeClass