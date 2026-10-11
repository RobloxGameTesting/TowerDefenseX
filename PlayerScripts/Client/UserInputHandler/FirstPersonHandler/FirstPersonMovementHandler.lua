local createVector = vector.create
local FirstPersonMovementHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("FirstPersonTypes"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local MapHandler = require(Common:WaitForChild("MapHandler"))
local Director = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Director"))
local event = BindableHandler.GetEvent("DirectControlMoveUp")
local event2 = BindableHandler.GetEvent("DirectControlMoveDown")
local LocalPlayer = Players.LocalPlayer
local playerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
local module = require(playerModule)
local controls = module:GetControls()
local CurrentCamera = workspace.CurrentCamera
local flag = false
local v = nil
local torso = nil
local v2 = nil
local movementConfig = nil
local v3 = nil
local v4 = nil
local v5 = nil
local currentHoverHeight = nil
local now = 0
local v6 = false
local v7 = false
local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
local magnitude = 0
local fpsParts = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore"):WaitForChild("FPSParts")
local v8 = 1

local function NewCollider(colliderDiameter: number)
	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Ball
	part.Name = "FPSCollider"
	part.Size = Vector3.new(colliderDiameter, colliderDiameter, colliderDiameter)
	part.CanCollide = true
	part.Anchored = false
	part.Transparency = 1
	part.Massless = true
	part.CustomPhysicalProperties = PhysicalProperties.new(0.001, 0, 0)
	part.CollisionGroup = Enums.CollisionGroups.Collider
	part.Parent = fpsParts
	local bodyPosition = Instance.new("BodyPosition")
	bodyPosition.D = 1000
	bodyPosition.MaxForce = createVector(0, 2000000, 0)
	bodyPosition.P = 3000
	bodyPosition.Position = createVector(0, 0, 0)
	bodyPosition.Parent = part
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = createVector(2000000, 0, 2000000)
	bodyVelocity.Velocity = createVector(0, 0, 0)
	bodyVelocity.Parent = part
	local bodyGyro = Instance.new("BodyGyro")
	bodyGyro.D = 400
	bodyGyro.MaxTorque = createVector(2000000, 2000000, 2000000)
	bodyGyro.P = 3000
	bodyGyro.Parent = part
	v3 = part
	v4 = bodyPosition
	v5 = bodyVelocity
end

local function ToggleCharacterControls(flag2: boolean)
	local character = LocalPlayer.Character

	if not character then
		return
	end

	local humanoid = character:WaitForChild("Humanoid", 1)

	if not humanoid then
		return
	end

	if flag2 then
		humanoid.WalkSpeed = 16
		humanoid:SetAttribute("FPSMode", false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		ContextActionService:UnbindAction("CharacterMovementSink")
		LocalPlayer.CameraMaxZoomDistance = CameraMaxZoomDistance
		LocalPlayer.CameraMinZoomDistance = CameraMinZoomDistance

		if v2.PlayerAnimationName then
			for _, v9 in Director.GetItemsFromClass(Director.Classes.EmoteUI) do
				v9:EmoteToggle()
			end
		end
	else
		humanoid.WalkSpeed = 0
		humanoid:SetAttribute("FPSMode", true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
		ContextActionService:BindActionAtPriority("CharacterMovementSink", function()
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, Enum.PlayerActions.CharacterJump)
		pcall(function()
			magnitude = (CurrentCamera.CFrame.Position - character.Head.Position).Magnitude
		end)
		LocalPlayer.CameraMaxZoomDistance = magnitude
		LocalPlayer.CameraMinZoomDistance = magnitude

		if v2.PlayerAnimationName then
			for _, v9 in Director.GetItemsFromClass(Director.Classes.EmoteUI) do
				v9:EmoteToggle()
				v9:PlayEmote(v2.PlayerAnimationName)
			end
		end
	end
end

local function GetCurrentMovementSpeed() -- 1 equivalent call inferred from this helper
	local levelStats = v.LevelHandler:GetLevelStats()
	local levelStatsMovementSpeedMultiplier = movementConfig.LevelStatsMovementSpeedMultiplier or 1
	local upgradeShopMultiplier = v:GetUpgradeShopMultiplier(Enums.TowerUpgradeShopTypes.MovementSpeed)
	return movementConfig.MovementSpeed
		or levelStats.MovementSpeed * levelStatsMovementSpeedMultiplier * upgradeShopMultiplier
end

local function GetMoveVector()
	local moveVector = controls:GetMoveVector()

	if moveVector.Magnitude >= 0.01 then
		local vectorToWorldSpace = workspace.CurrentCamera.CFrame:VectorToWorldSpace(moveVector)
		local vector = Vector3.new(vectorToWorldSpace.X, 0, vectorToWorldSpace.Z)
		local currentMovementSpeed = GetCurrentMovementSpeed() -- inferred equivalent call
		moveVector = vector.Unit * currentMovementSpeed
	end

	local verticalMovementSpeed = movementConfig.VerticalMovementSpeed or 0

	if verticalMovementSpeed and not (v6 and v7) then
		if v6 then
			moveVector += Vector3.new(0, verticalMovementSpeed, 0)
		elseif v7 then
			moveVector -= Vector3.new(0, verticalMovementSpeed, 0)
		end
	end

	if moveVector.Magnitude < 0.01 then
		return
	else
		return moveVector
	end
end

local function ShouldReplicateMove() -- 2 equivalent calls inferred from this helper
	if os.clock() - now < 0.05 then
		return false
	end

	now = os.clock()
	return true
end

function FirstPersonMovementHandler.SetTower(player, p)
	flag = true
	v = player
	torso = player.Character:GetTorso()
	v2 = p
	movementConfig = p.MovementConfig
	currentHoverHeight = player.Character:GetCurrentHoverHeight()

	if movementConfig and movementConfig.LevelStatsMovementSpeedMultiplier and movementConfig.MovementSpeed then
		warn("LevelStatsMovementSpeedMultiplier and MovementSpeed are both set. Using movement speed.")
	end

	ToggleCharacterControls(false)
	v6 = false
	v7 = false

	if v3 then
		v3:Destroy()
		v3 = nil
	end

	if movementConfig and movementConfig.ColliderDiameter then
		NewCollider(movementConfig.ColliderDiameter)
		local position = v:GetCurrentFPSPosition() + Vector3.new(0, currentHoverHeight, 0)
		v3.CFrame = CFrame.new(position)
		v4.Position = position
	end
end

function FirstPersonMovementHandler.RemoveTower()
	flag = false
	local character = LocalPlayer.Character
	local humanoid = character and character:WaitForChild("Humanoid", 1)

	if humanoid then
		humanoid.WalkSpeed = 16
		humanoid:SetAttribute("FPSMode", false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		ContextActionService:UnbindAction("CharacterMovementSink")
		LocalPlayer.CameraMaxZoomDistance = CameraMaxZoomDistance
		LocalPlayer.CameraMinZoomDistance = CameraMinZoomDistance

		if v2.PlayerAnimationName then
			for _, v9 in Director.GetItemsFromClass(Director.Classes.EmoteUI) do
				v9:EmoteToggle()
			end
		end
	end

	if v3 then
		v3:Destroy()
		v3 = nil
	end
end

function FirstPersonMovementHandler.OnRenderStepped(_: number, p: number)
	if not movementConfig then
		return
	end

	local moveVector = GetMoveVector()
	local v9 = MapHandler.GetNodesMinY() + -20
	local v10 = MapHandler.GetNodesMaxY() + 75

	if v3 then
		local v11 = moveVector or createVector(0, 0, 0)
		local v12 = v3.CFrame.Position + v11
		local vector = Vector3.new(v12.X, math.clamp(v12.Y, v9, v10), v12.Z)
		v4.Position = vector
		v5.Velocity = v8 * v11
		v:FirstPersonMoveTo(v3.CFrame.Position - Vector3.new(0, currentHoverHeight, 0), ShouldReplicateMove()) -- inferred equivalent call
	else
		if not moveVector then
			return
		end

		local currentFPSPosition = v:GetCurrentFPSPosition()

		if not currentFPSPosition then
			return
		end

		local v11 = currentFPSPosition + moveVector * p
		local vector = Vector3.new(v11.X, math.clamp(v11.Y, v9, v10), v11.Z)
		v:FirstPersonMoveTo(vector, ShouldReplicateMove()) -- inferred equivalent call
	end
end

function FirstPersonMovementHandler.SetSpeedMultiplier(p: number)
	v8 = p
end

event:AttachCallback(function(flag2: boolean)
	v6 = flag2
end)
event2:AttachCallback(function(flag2: boolean)
	v7 = flag2
end)
LocalPlayer.CharacterAdded:Connect(function()
	if flag then
		ToggleCharacterControls(false)
	end
end)
return FirstPersonMovementHandler