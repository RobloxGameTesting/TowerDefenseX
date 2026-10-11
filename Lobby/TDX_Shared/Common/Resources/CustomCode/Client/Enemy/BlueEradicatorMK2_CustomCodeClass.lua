local BlueEradicatorMK2CustomCodeClass = {}
BlueEradicatorMK2CustomCodeClass.__index = BlueEradicatorMK2CustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))

function BlueEradicatorMK2CustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		DamagedWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		MinigunEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		Highlight = nil,
		PreviousAbilityName = nil,
		ProjectileOrigins = {},
		DeathTimingHelpers = {},
		_Wrappers = {}
	}, BlueEradicatorMK2CustomCodeClass))
end

function BlueEradicatorMK2CustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local characterModel = self.CharacterModel
	self.Character:ForceSetUpStealthShimmerParts()
	local damagedSparksVFX = characterModel:FindFirstChild("DamagedSparksVFX")
	self.DamagedWrapper:AddFrom(damagedSparksVFX, self.SpeedMultiplier)
	table.insert(self._Wrappers, self.DamagedWrapper)
	local rotaryGuns = characterModel:FindFirstChild("RotaryGuns")
	self.MinigunEffectWrapper:AddFrom(rotaryGuns, self.SpeedMultiplier)
	table.insert(self._Wrappers, self.MinigunEffectWrapper)
	local highlight = characterModel:FindFirstChild("Highlight")

	if highlight then
		highlight.FillTransparency = 1
		TweenService:Create(highlight, TweenInfo.new(1), { FillTransparency = 0.5 }):Play()
	end

	self.Highlight = highlight

	for i = 1, 16 do
		local v = "EradicatorMK2Rocket" .. tostring(i)
		local child = characterModel:FindFirstChild(v)

		if child then
			table.insert(self.ProjectileOrigins, child)
		else
			warn("Projectile origin not found: " .. v)
		end
	end
end

function BlueEradicatorMK2CustomCodeClass.Run_FromCharacter(p, p2: number)
	for _, deathTimingHelper in pairs(p.DeathTimingHelpers) do
		deathTimingHelper:Run(p2)
	end
end

function BlueEradicatorMK2CustomCodeClass:AbilityUsed(previousAbilityName: string)
	if previousAbilityName == Enums.EnemyAbilities.BlueEradicatorMK2Rage then
		self:_EnterDamagedState()
	end

	self.PreviousAbilityName = previousAbilityName
end

function BlueEradicatorMK2CustomCodeClass.AbilityAnimationKeyframeReached(p, p2: string, p3: string)
	if p2 == Enums.EnemyAbilities.BlueEradicatorMK2Minigun then
		if p3 == "Minigun" then
			p.MinigunEffectWrapper:PlayAll()
		elseif p3 == "Minigun_Stop" then
			p.MinigunEffectWrapper:StopContinuous()
		end
	end
end

function BlueEradicatorMK2CustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function BlueEradicatorMK2CustomCodeClass.EnemyDestroyed(player, _: boolean?, flag: boolean?)
	if flag then
		return
	end

	for _, deathTimingHelper in pairs(player.DeathTimingHelpers) do
		deathTimingHelper:Start()
	end

	player.DamagedWrapper:StopContinuous()
	player.MinigunEffectWrapper:StopContinuous()

	for _, projectileOrigin in pairs(player.ProjectileOrigins) do
		projectileOrigin:Destroy()
	end

	TweenService:Create(player.Highlight, TweenInfo.new(1), { FillTransparency = 1 }):Play()

	for _, animationHandler in pairs(player.Character.AnimationHandlers) do
		animationHandler:PauseCurrentAnimation()
	end
end

function BlueEradicatorMK2CustomCodeClass.CharacterCleanedUp(p)
	for _, deathTimingHelper in pairs(p.DeathTimingHelpers) do
		deathTimingHelper:Destroy()
	end

	for _, projectileOrigin in pairs(p.ProjectileOrigins) do
		projectileOrigin:Destroy()
	end
end

function BlueEradicatorMK2CustomCodeClass.AnimationStateChanged(_, _: string, _) end

function BlueEradicatorMK2CustomCodeClass:_EnterDamagedState()
	local plane0541 = self.CharacterModel:FindFirstChild("Plane.054-1")

	if plane0541 then
		plane0541.Transparency = 1
	else
		warn("Nose not found")
	end

	if self.DamagedWrapper then
		self.DamagedWrapper:PlayAll()
	end
end

return BlueEradicatorMK2CustomCodeClass