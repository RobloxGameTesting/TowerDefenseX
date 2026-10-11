local RunService = game:GetService("RunService")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
require(game.ReplicatedStorage.TDX_Shared.Modules.Util)
local MagicShop = require(game.ReplicatedStorage.TDX_Shared.Modules.MagicShop)

local function log(...)
	if RunService:IsStudio() then
		print("[MagicShopNPC]", ...)
	end
end

local MagicShopNPC = { ClassName = script.Name, ClassModule = script }
MagicShopNPC.__index = MagicShopNPC

function MagicShopNPC.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, MagicShopNPC))
end

function MagicShopNPC:Init()
	log("Init()")
	self.Model = game.ReplicatedStorage.LobbyResources.MagicShop:Clone()
	self.Model:PivotTo(CFrame.new(0, 0, 0))
	self.Model.Name = "MagicShopNPC"
	self.Cleaner:Add(self.Model)
	local animationController = self.Model:WaitForChild("AnimationController")
	local animations = self.Model:WaitForChild("Animations")
	self.Model.Parent = workspace
	self.Animator = Instance.new("Animator")
	self.Animator.Parent = animationController
	self.Cleaner:Add(self.Animator)
	self.SpawnAnimation = self.Animator:LoadAnimation(animations.Spawn)
	self.SpawnAnimation.Looped = false
	self.DespawnAnimation = self.Animator:LoadAnimation(animations.Despawn)
	self.DespawnAnimation.Looped = false
	self.DespawnAnimation.Priority = Enum.AnimationPriority.Action
	self.IdleAnimation = self.Animator:LoadAnimation(animations.Idle)
	self.IdleAnimation.Looped = true
	self.GlitchParticles = {}
	self.LightningParticles = {}

	for _, emitter in self.Model:GetDescendants() do
		if not emitter:IsA("ParticleEmitter") then
			continue
		end

		if emitter.Name == "Glitch" then
			table.insert(self.GlitchParticles, emitter)
		elseif emitter.Name == "Lightning" then
			table.insert(self.LightningParticles, emitter)
		end
	end

	self:SpawnIn()
end

function MagicShopNPC:SpawnIn()
	self.SpawnAnimation:Play()
	task.delay(0.25, function()
		self.Model.Highlight.Enabled = false
		self:SetTransparency(1)
		self.Model:PivotTo(self.Root.CFrame)

		for _, glitchParticle in self.GlitchParticles do
			glitchParticle:Emit(2)
		end

		for _, lightningParticle in self.LightningParticles do
			lightningParticle.Enabled = true
		end

		task.delay(0.75, function()
			for _, lightningParticle in self.LightningParticles do
				lightningParticle.Enabled = false
			end
		end)
		task.delay(0.2, function()
			self.Model.Highlight.Enabled = true
			self:SetTransparency(0)
		end)
	end)
	self.IdleAnimation:Play()
end

function MagicShopNPC:Destroy()
	log("Destroy()")
	self.DespawnAnimation:Play()
	task.delay(1.5, function()
		for _, lightningParticle in self.LightningParticles do
			lightningParticle.Enabled = true
		end

		task.wait(0.4)
		self.Model.Highlight.Enabled = false
		self:SetTransparency(1)

		for _, glitchParticle in self.GlitchParticles do
			glitchParticle:Emit(2)
		end
	end)
	self.DespawnAnimation.Stopped:Once(function()
		self.IdleAnimation:Stop()
		self.DespawnAnimation:Play(0, 1, 0)
		self.DespawnAnimation.TimePosition = self.DespawnAnimation.Length - 0.00001
		self.Animator = nil
		self.IdleAnimation = nil
		self.SpawnAnimation = nil
		self.DespawnAnimation = nil
		task.wait(0.3)
		self.Cleaner:Clean()
	end)
end

function MagicShopNPC:SetTransparency(transparency: number)
	for _, part in self.Model.NightmareTechnician:GetDescendants() do
		if part:IsA("BasePart") then
			part.Transparency = transparency
		end
	end
end

Director.Register(MagicShop.TAG_MAGIC_SHOP_NPC, { MagicShopNPC }, workspace)
return MagicShopNPC