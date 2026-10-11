local RunService = game:GetService("RunService")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
require(game.ReplicatedStorage.TDX_Shared.Modules.Util)

local function log(...)
	if RunService:IsStudio() then
		print("[ClientAnimatedNPC]", ...)
	end
end

local ClientAnimatedNPC = { ClassName = script.Name, ClassModule = script }
ClientAnimatedNPC.__index = ClientAnimatedNPC

function ClientAnimatedNPC.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, ClientAnimatedNPC))
end

function ClientAnimatedNPC:Init()
	log("Init()")
	local animationController = self.Root:WaitForChild("AnimationController")
	self.Animator = Instance.new("Animator")
	self.Animator.Parent = animationController
	self.Cleaner:Add(self.Animator)
	local animation = Instance.new("Animation")
	animation.AnimationId = self.Root:GetAttribute("AnimationId")
	animation.Parent = self.Root
	local track = self.Animator:LoadAnimation(animation)
	track.Looped = true
	track:Play()
end

Director.Register(script.Name, { ClientAnimatedNPC }, workspace)
return ClientAnimatedNPC