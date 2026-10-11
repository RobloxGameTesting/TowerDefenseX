local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Util = require(game.ReplicatedStorage.TDX_Shared.Modules.Util)
local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
local color = Color3.fromRGB(255, 117, 71)
local color2 = Color3.fromRGB(184, 255, 151)
local colorSequence = ColorSequence.new(Color3.fromRGB(255, 24, 24), Color3.fromRGB(255, 24, 24))
local colorSequence2 = ColorSequence.new(Color3.fromRGB(94, 255, 76), Color3.fromRGB(255, 255, 255))
local colorSequence3 = ColorSequence.new(Color3.fromRGB(255, 218, 105), Color3.fromRGB(255, 218, 105))
local colorSequence4 = ColorSequence.new(Color3.fromRGB(94, 255, 76), Color3.fromRGB(94, 255, 76))
local LevelBarrier = { ClassName = script.Name, ClassModule = script }
LevelBarrier.__index = LevelBarrier

function LevelBarrier.new(instance)
	return (setmetatable(
		{ Root = instance, Cleaner = Cleaner.new(), OriginalPoint = instance:GetPivot() },
		LevelBarrier
	))
end

function LevelBarrier:Init()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "XP" then
			self:Update()
		end
	end))
	self.CollisionPart = self.Root:FindFirstChild("Part")
	self.ForceFieldPart = self.Root:FindFirstChild("ForceField")
	self.SurfaceGui = self.ForceFieldPart.SurfaceGui
	self.TextLabel = self.SurfaceGui.Frame.TextLabel
	self.Gradients = {}
	self.Stripes = {}

	for _, attachment in pairs(self.Root:GetDescendants()) do
		if not attachment:IsA("Attachment") then
			continue
		end

		if attachment.Name == "gradientstart" then
			table.insert(self.Gradients, attachment:FindFirstChildOfClass("Beam"))
		elseif attachment.Name == "stripestart" then
			table.insert(self.Stripes, attachment:FindFirstChildOfClass("Beam"))
		end
	end

	self:Update()
end

function LevelBarrier:Update()
	local xp = Data.Get("XP") or 0
	local xpToLevelAndProgress = Util.XPToLevelAndProgress(xp)
	local minLevel = self.Root:GetAttribute("MinLevel")
	local v = minLevel <= xpToLevelAndProgress
	self.TextLabel.Text = `LVL {minLevel}+`
	self.TextLabel.Visible = not v
	self.CollisionPart.CanCollide = not v
	self.ForceFieldPart.Color = v and color2 or color
	self.ForceFieldPart.Transparency = v and 0.8 or 0.9

	for _, gradient in pairs(self.Gradients) do
		gradient.Color = v and colorSequence2 or colorSequence
	end

	for _, stripe in pairs(self.Stripes) do
		stripe.Color = v and colorSequence4 or colorSequence3
	end

	if self.Root:GetAttribute("FullyHideWhenUnlocked") then
		self.SurfaceGui.Enabled = not v
		self.ForceFieldPart.Transparency = v and 1 or 0.9

		for _, gradient in pairs(self.Gradients) do
			gradient.Enabled = not v
		end

		for _, stripe in pairs(self.Stripes) do
			stripe.Enabled = not v
		end
	end
end

function LevelBarrier.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { LevelBarrier })
return LevelBarrier