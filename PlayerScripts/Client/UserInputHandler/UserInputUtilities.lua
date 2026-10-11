local UserInputUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local MapHandler = require(common:WaitForChild("MapHandler"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("TeamUtilities"))
local GameClass = script.Parent.Parent:WaitForChild("GameClass")
local EnemyClass = GameClass:WaitForChild("EnemyClass")
local TowerClass = GameClass:WaitForChild("TowerClass")
local PathEntityClass = GameClass:WaitForChild("PathEntityClass")
local StaticEntityClass = GameClass:WaitForChild("StaticEntityClass")
local MapEntityClass = GameClass:WaitForChild("MapEntityClass")
local parent = script.Parent
require(parent:WaitForChild("UserInputTypes"))
local CurrentCamera = workspace.CurrentCamera
local fpsParts = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore"):WaitForChild("FPSParts")
local characters = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore"):WaitForChild("Characters")
local filterDescendantsInstances = nil
local raycastParams = nil
local raycastParams2 = nil
local Game = workspace:WaitForChild("Game")
local Enemies = Game:WaitForChild("Enemies")
local Towers = Game:WaitForChild("Towers")
local PathEntities = Game:WaitForChild("PathEntities")
local StaticEntities = Game:WaitForChild("StaticEntities")
local MapEntities = Game:WaitForChild("MapEntities")
local v = nil
local v2 = nil

local function AddIgnoreInstance(character) -- 1 equivalent call inferred from this helper
	table.insert(filterDescendantsInstances, character)
	raycastParams.FilterDescendantsInstances = filterDescendantsInstances
end

function UserInputUtilities.ScreenPositionGetHit(point: Vector2, p)
	assert(p, "InputState missing")
	local viewportPointToRay = CurrentCamera:ViewportPointToRay(point.X, point.Y)
	local v3 = {
		"AimingPowerUpGround",
		"AimingAbility",
		"RelocationAbility",
		"AimingAtTowerAbility",
		"Retargeting",
		"InitialAiming",
		"Placement"
	}
	local v4

	if table.find(v3, p) then
		v4 = raycastParams2
	else
		v4 = raycastParams
	end

	local raycastResult = workspace:Raycast(viewportPointToRay.Origin, 1000 * viewportPointToRay.Direction, v4)
	local instance = raycastResult and raycastResult.Instance
	local position = raycastResult and raycastResult.Position

	if instance then
		v = instance
		v2 = position
	elseif table.find(v3, p) then
		instance = v
		position = v2
	end

	return instance, position
end

function UserInputUtilities.ScreenPositionGetHitForFPSMode(point: Vector2, p: number?)
	local viewportPointToRay = CurrentCamera:ViewportPointToRay(point.X, point.Y)
	local direction = viewportPointToRay.Direction
	local vector = Vector3.new()

	if p then
		local unit = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5).Unit
		vector = (unit - unit:Dot(direction) * direction).Unit * math.tan((math.rad(p > 0 and math.random(0, 1000 * p) / 1000 or 0)))
	end

	local unit = (direction + vector).Unit
	local raycastResult = workspace:Raycast(viewportPointToRay.Origin, 1000 * unit, raycastParams)
	return raycastResult and raycastResult.Instance, raycastResult and raycastResult.Position, unit
end

function UserInputUtilities.GetEnemyFromHit(parent2)
	if parent2 and parent2:IsDescendantOf(Enemies) then
		while parent2.Parent ~= Enemies do
			parent2 = parent2.Parent
		end

		local module = require(EnemyClass)
		local enemy = module.GetEnemyByTorso(parent2)

		if enemy and not (enemy.IsFakeEnemy or enemy.NoHoverTooltip) then
			if enemy:IsInStasis() and enemy.UnstasisNoHoverTooltip then
				return
			end

			if enemy.HealthHandler:GetHealth() > 0 then
				return enemy
			end
		end
	end
end

function UserInputUtilities.GetEnemyFromKnownEnemyPart(parent2)
	while parent2.Parent ~= Enemies do
		parent2 = parent2.Parent
	end

	local module = require(EnemyClass)
	local enemy = module.GetEnemyByTorso(parent2)

	if enemy and not (enemy.IsFakeEnemy or enemy.NoHoverTooltip) then
		return enemy
	end
end

function UserInputUtilities.GetTowerFromHit(parent2)
	if parent2:IsDescendantOf(Towers) then
		while parent2.Parent ~= Towers do
			parent2 = parent2.Parent
		end

		local module = require(TowerClass)
		local tower = module.GetTowerByTorso(parent2)

		if tower and not tower.NoHoverTooltip then
			return tower
		end
	end
end

function UserInputUtilities.GetPathEntityFromHit(parent2)
	if parent2:IsDescendantOf(PathEntities) then
		while parent2.Parent ~= PathEntities do
			parent2 = parent2.Parent
		end

		local module = require(PathEntityClass)
		local pathEntity = module.GetPathEntityByTorso(parent2)

		if pathEntity and not pathEntity.NoHoverTooltip then
			return pathEntity
		end
	end
end

function UserInputUtilities.GetStaticEntityFromHit(parent2)
	if parent2:IsDescendantOf(StaticEntities) then
		while parent2.Parent ~= StaticEntities do
			parent2 = parent2.Parent
		end

		local module = require(StaticEntityClass)
		local staticEntity = module.GetStaticEntityByTorso(parent2)

		if staticEntity and not staticEntity.NoHoverTooltip then
			return staticEntity
		end
	end
end

function UserInputUtilities.GetMapEntityFromHit(parent2)
	if parent2:IsDescendantOf(MapEntities) then
		while parent2.Parent ~= MapEntities do
			parent2 = parent2.Parent
		end

		local module = require(MapEntityClass)
		local mapEntity = module.GetMapEntityByTorso(parent2)

		if mapEntity and not mapEntity.NoHoverTooltip then
			return mapEntity
		end
	end
end

local playerAddedConnection = nil

function UserInputUtilities.Initialize()
	filterDescendantsInstances = MapHandler.GetIgnoreInstances()
	table.insert(filterDescendantsInstances, fpsParts)
	raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = filterDescendantsInstances
	raycastParams2 = RaycastParams.new()
	raycastParams2.FilterType = Enum.RaycastFilterType.Include
	raycastParams2.FilterDescendantsInstances = MapHandler.GetMapInstances()

	local function PlayerJoined(player)
		player.CharacterAdded:Connect(function(character)
			character.Parent = characters
			table.insert(filterDescendantsInstances, character)
			raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		end)

		if player.Character then
			player.Character.Parent = characters
			AddIgnoreInstance(player.Character) -- inferred equivalent call
		end
	end

	if playerAddedConnection then
		playerAddedConnection:Disconnect()
	end

	playerAddedConnection = Players.PlayerAdded:Connect(PlayerJoined)

	for _, v3 in pairs(Players:GetPlayers()) do
		task.spawn(PlayerJoined, v3)
	end
end

return UserInputUtilities