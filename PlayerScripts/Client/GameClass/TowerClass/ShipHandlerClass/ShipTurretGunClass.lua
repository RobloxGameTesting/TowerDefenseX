local ShipTurretGunClass = {}
ShipTurretGunClass.__index = ShipTurretGunClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("Utilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local parent = script.Parent.Parent.Parent
local towerClass = parent:WaitForChild("TowerClass")
local ProjectileHandler = require(parent:WaitForChild("ProjectileHandler"))
local count = 0

function ShipTurretGunClass.New(isLegacy: boolean, towerHash: number, p, instance, data, speedMultiplier: number)
	count += 1
	local barrel = instance:FindFirstChild("Barrel")
	local effectsWrapper = isLegacy and WrapperFactory.NewEmitterAndSoundWrapper(barrel, speedMultiplier)
	local animation = instance:FindFirstChildOfClass("Animation")
	local track

	if animation then
		local animationController = instance:FindFirstChildOfClass("AnimationController")
			or Instance.new("AnimationController", instance)
		track = (animationController:FindFirstChildOfClass("Animator") or Instance.new("Animator", animationController)):LoadAnimation(animation)
	end

	local isProjectile, projectileName

	if data.UseTowerLevelStats then
		isProjectile = p.IsProjectile
		projectileName = isProjectile and p.ProjectileName
	else
		isProjectile = data.UseProjectile
		projectileName = isProjectile and data.ProjectileName
	end

	local projectileConfig = isProjectile and ResourceManager.GetProjectileConfig(projectileName)
	local projectileOrigin = isProjectile and instance:FindFirstChild("ProjectileOrigin")
	return (setmetatable({
		Hash = count,
		IsLegacy = isLegacy,
		TowerHash = towerHash,
		UseProjectile = isProjectile,
		ProjectileConfig = projectileConfig,
		ProjectileOrigin = projectileOrigin,
		HandleProjectileRegeneration = data.HandleProjectileRegeneration,
		SpeedMultiplier = speedMultiplier,
		EffectsWrapper = effectsWrapper,
		Animation = track
	}, ShipTurretGunClass))
end

function ShipTurretGunClass:Attack(p, flag: boolean)
	if self.IsLegacy then
		self.EffectsWrapper:PlayAll()
	end

	if self.Animation then
		self.Animation:Play(nil, nil, self.SpeedMultiplier)
	end

	if self.UseProjectile then
		self:_FireProjectile(p, flag)
	end
end

function ShipTurretGunClass:SetSpeedMultiplier(speedMultiplier: number)
	if self.IsLegacy then
		self.EffectsWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.Animation then
		self.Animation:AdjustSpeed(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

function ShipTurretGunClass:_FireProjectile(object, flag: boolean)
	local module = require(towerClass)
	local tower = module.GetTower(self.TowerHash)
	local position = tower.CFrame.Position
	local projectileConfig = self.ProjectileConfig
	local projectileOrigin = self.ProjectileOrigin
	local timeToHitForRangedProjectile = ProjectileUtilities.GetTimeToHitForRangedProjectile(
		position,
		object:GetPosition(),
		projectileConfig
	)
	local v = {
		OriginEntityClass = Enums.EntityClass.Tower,
		TargetEntityClass = flag and Enums.EntityClass.Tower or Enums.EntityClass.Enemy,
		OriginHash = self.TowerHash,
		TargetHash = object.Hash,
		TimeToHit = timeToHitForRangedProjectile,
		FaceTarget = false,
		ProjectileConfig = projectileConfig,
		OverrideOriginPart = projectileOrigin
	}
	ProjectileHandler.NewProjectile(v)

	if self.HandleProjectileRegeneration then
		local regenerationDelay = projectileConfig.RegenerationDelay
		local regenerationTime = projectileConfig.RegenerationTime

		if regenerationDelay and regenerationTime then
			tower.Character:RegenerateProjectile(
				projectileOrigin,
				regenerationDelay,
				regenerationTime,
				(tostring(self.Hash))
			)
		else
			warn(`Projectile {projectileConfig.Name} is missing regeneration properties`)
		end
	end
end

return ShipTurretGunClass