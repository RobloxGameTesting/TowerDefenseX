local createVector = vector.create
local EnemyViewport = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
local SkinHandler = require(common:WaitForChild("SkinHandler"))
local udim = UDim2.new(1, 0, 1, 0)
local udim2 = UDim2.new(0.5, 0, 0.5, 0)
local vector = Vector2.new(0.5, 0.5)
local cframe = CFrame.Angles(0, 0.7853981633974483, 0)

local function GetEnemyRotationOffset(p: string) -- 1 equivalent call inferred from this helper
	local success, enemyConfig = pcall(ResourceManager.GetEnemyConfig, p)

	if success and enemyConfig then
		return enemyConfig.RotationOffset
	end

	return nil
end

local function GetVisibleBoundingBox(folder)
	local function Measure(flag: boolean)
		local v = createVector(1, 1, 1) * 1e999
		local v2 = -v
		local flag2 = false

		for _, part in ipairs(folder:GetDescendants()) do
			if not (part:IsA("BasePart") and (not flag or part.Transparency < 1)) then
				continue
			end

			local cframe2 = part.CFrame
			local halfSize = part.Size / 2
			local vector2 = Vector3.new(
				math.abs(cframe2.XVector.X) * halfSize.X + math.abs(cframe2.YVector.X) * halfSize.Y + math.abs(cframe2.ZVector.X) * halfSize.Z,
				math.abs(cframe2.XVector.Y) * halfSize.X + math.abs(cframe2.YVector.Y) * halfSize.Y + math.abs(cframe2.ZVector.Y) * halfSize.Z,
				math.abs(cframe2.XVector.Z) * halfSize.X + math.abs(cframe2.YVector.Z) * halfSize.Y + math.abs(cframe2.ZVector.Z) * halfSize.Z
			)
			v = v:Min(cframe2.Position - vector2)
			v2 = v2:Max(cframe2.Position + vector2)
			flag2 = true
		end

		if flag2 then
			return (v + v2) / 2, v2 - v
		end

		return nil, nil
	end

	local v, v2 = Measure(true)

	if v and v2 then
		return v, v2
	end

	local v3, v4 = Measure(false)

	if v3 and v4 then
		return v3, v4
	end

	local boundingBox, v5 = folder:GetBoundingBox()
	return boundingBox.Position, v5
end

local function GetFitDistance(vector2: Vector3, fieldOfView: number, p: number) -- 1 equivalent call inferred from this helper
	local v = math.tan((math.rad(fieldOfView / 2)))
	local v2 = v * p
	return math.max(vector2.Y / 2 / v, vector2.X / 2 / v2) + vector2.Z / 2
end

local function GetEmptyViewport(parent, data)
	local name = data.Name or "Viewport"
	local viewportFrame = parent:FindFirstChild(name)

	if viewportFrame and viewportFrame:IsA("ViewportFrame") then
		for _, child in ipairs(viewportFrame:GetChildren()) do
			if not (child:IsA("Model") or child:IsA("WorldModel") or child:IsA("Camera")) then
				continue
			end

			child:Destroy()
		end

		return viewportFrame
	else
		local viewportFrame2 = Instance.new("ViewportFrame")
		viewportFrame2.Name = name
		viewportFrame2.BackgroundTransparency = 1
		viewportFrame2.AnchorPoint = data.AnchorPoint or vector
		viewportFrame2.Size = data.Size or udim
		viewportFrame2.Position = data.Position or udim2
		viewportFrame2.ZIndex = data.ZIndex or 3
		viewportFrame2.Parent = parent
		return viewportFrame2
	end
end

local function PlayMoveAnimation(parent)
	local animations = parent:FindFirstChild("Animations")
	local move = animations and animations:FindFirstChild("Move")

	if not move then
		return nil
	end

	if move.AnimationId == "" then
		Utilities.WarnEmptyAnimationOnce(parent, move)
		return nil
	end

	local animationController = Instance.new("AnimationController")
	animationController.Parent = parent
	local animator = Instance.new("Animator")
	animator.Parent = animationController
	local track = animator:LoadAnimation(move)
	track.Looped = true
	track:Play(0)
	return track
end

local function FrameCamera(parent, camera, instance, data)
	local distanceMult = data.DistanceMult or 1.15
	local v, v2 = GetVisibleBoundingBox(instance)
	local absoluteSize = parent.AbsoluteSize
	local v3 = not (absoluteSize.X > 0 and absoluteSize.Y > 0) and 1 or absoluteSize.X / absoluteSize.Y
	local v4 = GetFitDistance(v2, camera.FieldOfView, v3) * distanceMult / (data.Zoom or 1) -- inferred equivalent call
	camera.CFrame = CFrame.new(v + Vector3.new(0, 0, -v4), v)

	if data.PositionOffset then
		instance:PivotTo(instance:GetPivot() + data.PositionOffset)
	end

	parent.CurrentCamera = camera
end

local function MountModel(parent, pathEntityModel, cframe2: CFrame?, p, flag: boolean?)
	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = parent
	pathEntityModel.Parent = worldModel
	local rotationOffset = p.RotationOffset or cframe2 or CFrame.identity
	local pivot = pathEntityModel:GetPivot()

	if flag then
		pathEntityModel:PivotTo(CFrame.new(pivot.Position) * rotationOffset)
	else
		pathEntityModel:PivotTo(pivot * rotationOffset)
	end

	local camera = Instance.new("Camera")
	camera.FieldOfView = p.FieldOfView or 20
	camera.Parent = parent
	local playMoveAnimation = PlayMoveAnimation(pathEntityModel)

	if playMoveAnimation then
		task.spawn(function()
			local v = os.clock() + 3

			while playMoveAnimation.Length == 0 and os.clock() < v do
				RunService.Heartbeat:Wait()
			end

			RunService.Heartbeat:Wait()

			if camera.Parent ~= parent or pathEntityModel.Parent ~= worldModel then
				return
			end

			FrameCamera(parent, camera, pathEntityModel, p)
		end)
	else
		FrameCamera(parent, camera, pathEntityModel, p)
	end
end

function EnemyViewport.Build(parent, p: string, options)
	local v = options or {}
	local emptyViewport = GetEmptyViewport(parent, v)
	local overrideCharacterModelName = ResourceManager.GetEnemyConfig(p).OverrideCharacterModelName or p

	if ResourceManager.IsEnemyModelPending(overrideCharacterModelName) then
		task.spawn(function()
			if
				ResourceManager.RequestEnemyModelAsync(overrideCharacterModelName)
				and emptyViewport.Parent == parent
			then
				EnemyViewport.Build(parent, p, options)
			end
		end)
		return emptyViewport
	end

	if not ResourceManager.HasEnemyModel(overrideCharacterModelName) then
		return emptyViewport
	end

	local success, enemyModel = pcall(ResourceManager.GetEnemyModel, overrideCharacterModelName)

	if not (success and enemyModel) then
		return emptyViewport
	end

	MountModel(emptyViewport, enemyModel, GetEnemyRotationOffset(p), v) -- inferred equivalent call
	return emptyViewport
end

function EnemyViewport.BuildPathEntity(parent, p: string, p2: string?, options)
	local v = options or {}
	local parent2 = GetEmptyViewport(parent, v)
	local pathEntityConfig = ResourceManager.GetPathEntityConfig(p)
	local overrideModelName = pathEntityConfig.OverrideModelName or p
	local success, pathEntityModel = pcall(ResourceManager.GetPathEntityModel, overrideModelName)

	if not (success and pathEntityModel) then
		return parent2
	end

	if p2 and p2 ~= "" then
		pathEntityModel = SkinHandler.ApplySkin("PathEntity", p, p2, pathEntityModel, nil, nil, nil, overrideModelName)
	end

	local primaryPart = pathEntityModel.PrimaryPart
	local v2 = primaryPart and Utilities.TryReadChildValue(primaryPart, "CFrameOffset", CFrame.new()) or CFrame.new()
	MountModel(
		parent2,
		pathEntityModel,
		cframe * (pathEntityConfig.RotationOffset or CFrame.identity) * v2.Rotation,
		v,
		true
	)
	return parent2
end

return EnemyViewport