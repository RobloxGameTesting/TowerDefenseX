local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local v = {}

local function PreloadCharacterModel(folder)
	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		part.Transparency = 0.99
		part.Size = createVector(0.001, 0.001, 0.001)
	end

	folder:PivotTo(CFrame.new(0, -400, 0))
	folder.Parent = raycastIgnore
	local animations = folder:FindFirstChild("Animations")
	local animationController = animations and Instance.new("AnimationController", folder)
	local animator = animationController and Instance.new("Animator", animationController)
	local move = animations and animations:FindFirstChild("Move")
	local spawn = animations and animations:FindFirstChild("Spawn")

	for _, animation in pairs({ move, spawn }) do
		if animation.AnimationId == "" then
			Utilities.WarnEmptyAnimationOnce(folder, animation)
		else
			animator:LoadAnimation(animation)
		end
	end

	task.delay(3, function()
		folder:Destroy()
	end)
end

local function PreloadEnemy(item: string)
	local enemyConfig = ResourceManager.GetEnemyConfig(item)

	if not enemyConfig then
		warn("PreloadHandler: PreloadEnemy - No enemy config found for enemy name:", item)
		return true
	end

	local overrideCharacterModelName = enemyConfig.OverrideCharacterModelName or item

	if not ResourceManager.HasEnemyModel(overrideCharacterModelName) then
		return false
	end

	PreloadCharacterModel(ResourceManager.GetEnemyModel(overrideCharacterModelName))
	return true
end

local PreloadHandler = {}

function PreloadHandler.PreloadEnemies(items)
	for _, item in pairs(items) do
		if v[item] then
			continue
		end

		v[item] = true

		if PreloadEnemy(item) then
			task.wait(0.2)
		else
			v[item] = nil
		end
	end
end

function PreloadHandler.PreloadCharacterModel(instance)
	local clone = instance:Clone()
	clone.Parent = instance.Parent
	PreloadCharacterModel(clone)
end

return PreloadHandler