local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("EmoteTypes"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup

local function MakeAnimations(value)
	local result = {}

	if not value then
		return result
	end

	if type(value) == "number" then
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. value
		table.insert(result, animation)
		return result
	else
		for _, v in value do
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://" .. v
			table.insert(result, animation)
		end

		return result
	end
end

local EmoteAnimationsV2 = {}

for _, moduleScript in common:WaitForChild("Resources"):WaitForChild("Emotes"):WaitForChild("Configs"):GetChildren() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	local module = require(moduleScript)
	local name = module.Name

	if EmoteAnimationsV2[name] then
		error("Emote name " .. name .. " already exists! " .. debug.traceback())
	end

	local animationIds = module.AnimationIds
	EmoteAnimationsV2[name] = {
		Name = name,
		Animations = MakeAnimations(animationIds[EmoteAnimationGroup.Main]),
		StartAnimation = MakeAnimations(animationIds[EmoteAnimationGroup.Start]),
		InteractAnimation = MakeAnimations(animationIds[EmoteAnimationGroup.Interact]),
		EndAnimation = MakeAnimations(animationIds[EmoteAnimationGroup.End]),
		MovingAnimation = MakeAnimations(animationIds[EmoteAnimationGroup.Moving]),
		ModelNames = module.ModelNames,
		EmoteSoundData = module.EmoteSoundData,
		IsPartner = module.IsPartner or false,
		KeyframeEventNames = module.KeyframeEventNames,
		ViewportOffset = module.ViewportOffset,
		ViewportAnimation = MakeAnimations(module.ViewportAnimationId)[1],
		CleanupOnMovement = module.CleanupOnMovement or nil,
		CanAlwaysPlay = module.CanAlwaysPlay or nil,
		MovingStudsPerLoop = module.MovingStudsPerLoop,
		MainAnimationDelay = module.MainAnimationDelay,
		ServerKeyframeHandler = module.ServerKeyframeHandler,
		ServerModelCallback = module.ServerModelCallback
	}
end

return EmoteAnimationsV2