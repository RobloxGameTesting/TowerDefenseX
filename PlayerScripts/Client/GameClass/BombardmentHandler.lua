local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("EntityCreationTypes"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("ProjectileUtilities"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("PlacementHandler"))
require(script.Parent:WaitForChild("VisualEffectHandler"))
local ProjectileHandler = require(script.Parent:WaitForChild("ProjectileHandler"))

local function NewBombardmentAttack(data)
	local origin = data.Origin
	local goal = data.Goal
	local timeToHit = data.TimeToHit
	local projectileName = data.ProjectileName
	local targetTowerHash = data.TargetTowerHash
	local projectileConfig = ResourceManager.GetProjectileConfig(projectileName)

	if not projectileConfig then
		warn("ProjectileConfig not found for name: " .. projectileName)
		return
	end

	if projectileConfig.NoPhysicalProjectile then
		return
	end

	if targetTowerHash or not goal then
		goal = false
	end

	local v = {
		OriginEntityClass = "Misc",
		TargetEntityClass = "Tower",
		TargetHash = targetTowerHash,
		OverrideGoalPosition = goal,
		TimeToHit = timeToHit,
		FaceTarget = true,
		ProjectileConfig = projectileConfig,
		OverrideOriginCFrame = CFrame.new(origin) * CFrame.Angles(0, math.rad((math.random(0, 360))), 0),
		CustomCharacterHandling = true
	}
	ProjectileHandler.NewProjectile(v)
end

NetworkingHandler.GetEvent("BombardmentReplication"):AttachCallback(NewBombardmentAttack)
return {}