local EradicatorMK4GoldCustomCodeClass = {}
EradicatorMK4GoldCustomCodeClass.__index = EradicatorMK4GoldCustomCodeClass
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

function EradicatorMK4GoldCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		ProjectileOrigins = {},
		GrenadeProjectileOriginParts = {},
		_TimingHelpers = { DamagedTimingHelper = nil, DeathTimingHelper = nil },
		_Wrappers = { ArmorExplode = nil, DeathExplode = nil, DeathScreamSFX = nil }
	}, EradicatorMK4GoldCustomCodeClass))
end

function EradicatorMK4GoldCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local armorExplodePart = characterModel:FindFirstChild("ArmorExplodePart")
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	local deathScreamPart = characterModel:FindFirstChild("DeathScreamPart")
	self.GrenadeProjectileOriginParts[Enums.EnemyAbilities.EradicatorMK4GoldToxicGasGrenade] = {
		characterModel:FindFirstChild("EradicatorMK4GrenadeGreen1"):GetChildren(),
		characterModel:FindFirstChild("EradicatorMK4GrenadeGreen2"):GetChildren()
	}
	self.GrenadeProjectileOriginParts[Enums.EnemyAbilities.EradicatorMK4GoldExplosiveGrenade] = {
		characterModel:FindFirstChild("EradicatorMK4GrenadeRed1"):GetChildren(),
		characterModel:FindFirstChild("EradicatorMK4GrenadeRed2"):GetChildren()
	}
	self.GrenadeProjectileOriginParts[Enums.EnemyAbilities.EradicatorMK4GoldFireGrenade] = {
		characterModel:FindFirstChild("EradicatorMK4GrenadeYellow1"):GetChildren(),
		characterModel:FindFirstChild("EradicatorMK4GrenadeYellow2"):GetChildren()
	}
	self.GrenadeProjectileOriginParts[Enums.EnemyAbilities.EradicatorMK4GoldStunGrenade] = {
		characterModel:FindFirstChild("EradicatorMK4GrenadeBlue1"):GetChildren(),
		characterModel:FindFirstChild("EradicatorMK4GrenadeBlue2"):GetChildren()
	}
	self._Wrappers.ArmorExplode = WrapperFactory.NewEmitterAndSoundWrapper(armorExplodePart, speedMultiplier)
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._Wrappers.DeathScreamSFX = WrapperFactory.NewSoundWrapper(deathScreamPart, speedMultiplier)
	self._TimingHelpers.DamagedTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 0.55,
		Callback = function()
			local armor = characterModel:FindFirstChild("Armor")
			local v = {}

			for _, part in pairs(armor:GetChildren()) do
				if part:IsA("BasePart") then
					v[part] = true
				end
			end

			self._Wrappers.ArmorExplode:PlayAll()

			for _, weld in pairs(characterModel:GetDescendants()) do
				if not weld:IsA("Weld") then
					continue
				end

				local part1 = weld.Part1

				if not (part1 and v[part1]) then
					continue
				end

				weld:Destroy()
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
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 1.0625,
		Callback = function()
			self._Wrappers.DeathExplode:PlayAll()
		end
	})
end

function EradicatorMK4GoldCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function EradicatorMK4GoldCustomCodeClass:AbilityUsed(previousAbilityName: string)
	if previousAbilityName == Enums.EnemyAbilities.EradicatorMK4GoldRage then
		self:_EnterDamagedState()
	end

	local grenadeProjectileOriginPart = self.GrenadeProjectileOriginParts[previousAbilityName]

	if grenadeProjectileOriginPart then
		for _, v in pairs(grenadeProjectileOriginPart[1]) do
			v.Transparency = 0
		end

		for _, v in pairs(grenadeProjectileOriginPart[2]) do
			v.Transparency = 0
		end
	end

	self.PreviousAbilityName = previousAbilityName
end

function EradicatorMK4GoldCustomCodeClass.AbilityAnimationKeyframeReached(p, p2: string, p3: string)
	local grenadeProjectileOriginPart = p.GrenadeProjectileOriginParts[p2]

	if grenadeProjectileOriginPart then
		if p3 == "Shot1" then
			for _, v in pairs(grenadeProjectileOriginPart[1]) do
				v.Transparency = 1
			end
		elseif p3 == "Shot2" then
			for _, v in pairs(grenadeProjectileOriginPart[2]) do
				v.Transparency = 1
			end
		end
	end
end

function EradicatorMK4GoldCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function EradicatorMK4GoldCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	self._Wrappers.DeathScreamSFX:PlayAll()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function EradicatorMK4GoldCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function EradicatorMK4GoldCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function EradicatorMK4GoldCustomCodeClass:_EnterDamagedState()
	self.Character:OverrideAnimation("Move", "Sprint")
	self.Character:OverrideAnimation("Falter", "FalterSprint")
	self._TimingHelpers.DamagedTimingHelper:Start()

	for i = 1, 12 do
		local v = "EradicatorMK4SmallRocket" .. i
		local child = self.CharacterModel:FindFirstChild(v)

		if child then
			child:Destroy()
		else
			warn("Projectile origin not found: " .. v)
		end
	end
end

return EradicatorMK4GoldCustomCodeClass