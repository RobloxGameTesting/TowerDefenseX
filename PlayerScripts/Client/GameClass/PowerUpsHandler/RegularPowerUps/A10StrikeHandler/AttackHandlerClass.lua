local AttackHandlerClass = {}
AttackHandlerClass.__index = AttackHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("WrapperFactory"))
require(common.Resources.Misc.RegularPowerUps.A10Strike.Types)
require(script.Parent.Parent.Parent.Parent:WaitForChild("VisualEffectHandler"))
local ProjectileHandler = require(script.Parent.Parent.Parent.Parent:WaitForChild("ProjectileHandler"))

local function GetProjectileOriginParts(planeModel, projectileName: string, p: number?)
	local primaryParts = {}
	local models = {}

	local function SearchForProjectileOriginModel(p2: string)
		for _, model in pairs(planeModel:GetChildren()) do
			local v = model.Name:split("___")[1]

			if not (model:IsA("Model") and v == p2) then
				continue
			end

			if not model.PrimaryPart then
				error("Origin model in character model must have primary part set.")
			end

			table.insert(models, model)
			table.insert(primaryParts, model.PrimaryPart)
		end
	end

	if p then
		SearchForProjectileOriginModel(projectileName .. tostring(p))
	end

	if not p or #primaryParts == 0 then
		SearchForProjectileOriginModel(projectileName)
	end

	if #primaryParts ~= 0 then
		return primaryParts, models
	end

	if p then
		error(`Origin model with name {projectileName .. tostring(p)} not found in character model.`)
		return primaryParts, models
	else
		error(`Origin model with name {projectileName} not found in character model.`)
	end

	return primaryParts, models
end

function AttackHandlerClass.New(instance, attackName: string, p, speedMultiplier: number)
	local projectileName = p.ProjectileName
	local projectileConfig = projectileName and ResourceManager.GetProjectileConfig(projectileName)
	return (setmetatable({
		PlaneModel = instance,
		PlaneBody = instance:FindFirstChild("Body"),
		AttackName = attackName,
		ProjectileName = projectileName,
		ProjectileConfig = projectileConfig,
		SpeedMultiplier = speedMultiplier
	}, AttackHandlerClass))
end

function AttackHandlerClass.HandleAttack(data, object, p: number)
	if not data.ProjectileConfig then
		return
	end

	local position = data.PlaneBody.Position
	local position2 = object:GetPosition()
	local timeToHitForRangedProjectile, _ = ProjectileUtilities.GetTimeToHitForRangedProjectile(
		position,
		position2,
		data.ProjectileConfig
	)
	local v, v2 = GetProjectileOriginParts(data.PlaneModel, data.ProjectileName, p)
	local overrideOriginPart = v[1]
	local folder = v2[1]

	if not overrideOriginPart then
		warn("Origin part not found for attack: " .. data.AttackName)
		return
	end

	local v3 = {
		OriginEntityClass = "Misc",
		TargetEntityClass = "Enemy",
		TargetHash = object.Hash,
		TimeToHit = timeToHitForRangedProjectile,
		FaceTarget = true,
		ProjectileConfig = data.ProjectileConfig,
		OverrideOriginPart = overrideOriginPart,
		CustomCharacterHandling = true
	}
	ProjectileHandler.NewProjectile(v3)

	for _, part in pairs(folder:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = 1
		end
	end
end

function AttackHandlerClass:SpeedMultiplierChanged(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

return AttackHandlerClass