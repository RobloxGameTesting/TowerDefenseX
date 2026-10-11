local ShipTurretClass = {}
ShipTurretClass.__index = ShipTurretClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Utilities"))
local ShipUtilities = require(common:WaitForChild("ShipUtilities"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local VisualEffectHandler = require(script.Parent.Parent.Parent:WaitForChild("VisualEffectHandler"))
local ShipTurretGunClass = require(script.Parent:WaitForChild("ShipTurretGunClass"))

local function GetTurretGunWelds(turretModel)
	local motor6Ds = {}

	for _, motor6D in pairs(turretModel.PrimaryPart:GetChildren()) do
		if not (motor6D:IsA("Motor6D") and motor6D.Part1.Parent.Name:find("Gun")) then
			continue
		end

		table.insert(motor6Ds, motor6D)
	end

	return motor6Ds
end

function ShipTurretClass.New(p: number, p2, character, data, p3: number)
	local characterModel = character:GetCharacterModel()
	local turretModel = ShipUtilities.GetTurretModel(characterModel, data)
	local isLegacy = data.TurretIndex == nil
	local guns = {}

	for _, v in pairs(ShipUtilities.GetTurretGunModels(turretModel, data)) do
		table.insert(guns, (ShipTurretGunClass.New(isLegacy, p, p2, v, data.GunData, p3)))
	end

	local v

	if isLegacy then
		local primaryPart = characterModel.PrimaryPart
		local turretMotor6D = ShipUtilities.GetTurretMotor6D(turretModel, primaryPart)
		v = {
			IsLegacy = isLegacy,
			Character = character,
			TurretModel = turretModel,
			RotationOffset = data.RotationOffset or CFrame.Angles(0, 0, 0),
			TurretMotor6D = turretMotor6D,
			Guns = guns,
			GunMotor6Ds = GetTurretGunWelds(turretModel),
			GunFireAngle = data.GunFireAngle,
			ClientHitEffectData = data.ClientHitEffectData
		}
	else
		local additionalTurretIndices = { data.TurretIndex }

		if data.AdditionalTurretIndices then
			for _, additionalTurretIndice in pairs(data.AdditionalTurretIndices) do
				table.insert(additionalTurretIndices, additionalTurretIndice)
			end
		end

		v = {
			IsLegacy = isLegacy,
			Character = character,
			TurretIndex = data.TurretIndex,
			TurretIndicesToUse = additionalTurretIndices,
			Guns = guns,
			ClientHitEffectData = data.ClientHitEffectData
		}
	end

	return (setmetatable(v, ShipTurretClass))
end

function ShipTurretClass:Attack(p: number, object, flag: boolean)
	local torsoPosition = object:GetTorsoPosition()

	if self.IsLegacy then
		local turretMotor6D = self.TurretMotor6D
		local part0 = turretMotor6D.Part0
		local part1 = turretMotor6D.Part1
		local v = CFrame.new(part1.Position, torsoPosition) * CFrame.Angles(0, 1.5707963267948966, 0)
		turretMotor6D.C0 = part0.CFrame:Inverse() * v * turretMotor6D.C1 * self.RotationOffset

		if self.GunFireAngle then
			for _, gunMotor6D in pairs(self.GunMotor6Ds) do
				gunMotor6D.C1 = CFrame.new() * CFrame.Angles(0, 0, (math.rad(self.GunFireAngle)))
			end
		end
	else
		local character = self.Character

		for _, v in pairs(self.TurretIndicesToUse) do
			character:AimTurretAtPosition(torsoPosition, v)
			character.TurretHandler:Attacked(v, p)
		end
	end

	local gun = self.Guns[p]

	if gun then
		gun:Attack(object, flag)
	else
		warn("Couldn't find gun with index " .. tostring(p))
	end

	if self.ClientHitEffectData then
		self:_HandleClientHitEffect(object)
	end
end

function ShipTurretClass:_HandleClientHitEffect(object)
	local clientHitEffectData = self.ClientHitEffectData
	local torsoPosition = (clientHitEffectData.TargetTorsoInsteadOfGround or object:GetIsAirUnit())
		and object:GetTorsoPosition()
		or object:GetPosition()
	local randomOffsetPosition = ProjectileUtilities.RandomOffsetPosition(
		torsoPosition,
		clientHitEffectData.VarianceXZ,
		clientHitEffectData.VarianceY,
		clientHitEffectData.VarianceYOnlyDown
	)
	local v = {
		Name = clientHitEffectData.EffectName,
		Position = randomOffsetPosition,
		Delay = clientHitEffectData.Delay
	}
	VisualEffectHandler.NewVisualEffect(v)
end

function ShipTurretClass:SetSpeedMultiplier(p: number)
	for _, gun in pairs(self.Guns) do
		gun:SetSpeedMultiplier(p)
	end
end

return ShipTurretClass