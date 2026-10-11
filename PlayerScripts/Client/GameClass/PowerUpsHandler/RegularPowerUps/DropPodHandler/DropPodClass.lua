local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local LightAnimationHandlerClass = require(common:WaitForChild("LightAnimationHandlerClass"))
local parent = script.Parent.Parent.Parent.Parent.Parent
require(parent:WaitForChild("PlayerClass"))
require(common.Resources.Misc.RegularPowerUps.DropPod.Types)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local pod = common.Resources.Misc.RegularPowerUps.DropPod.Pod

local function SetModelTransparency(descendants, transparency: number) -- 1 equivalent call inferred from this helper
	for _, item in descendants do
		item.Transparency = transparency
	end
end

local DropPodClass = {}
DropPodClass.__index = DropPodClass

function DropPodClass.New(data, p: number)
	local clone = pod:Clone()
	local descendants = {}

	for _, descendant in clone:GetDescendants() do
		if not (descendant:IsA("BasePart") and descendant ~= clone.PrimaryPart and descendant.Transparency ~= 1 or descendant:IsA("Texture")) then
			continue
		end

		table.insert(descendants, descendant)
	end

	SetModelTransparency(descendants, 1) -- inferred equivalent call
	clone.Parent = raycastIgnore
	clone.PrimaryPart.CFrame = CFrame.new(data.Location)
	local animationHandler = LightAnimationHandlerClass.New(clone, p, true)
	animationHandler:Play("Drop")
	local v = {
		Hash = data.Hash,
		Player = Players:FindFirstChild(data.PlayerName),
		Location = data.Location,
		Model = clone,
		AnimationHandler = animationHandler,
		TimePassed = 0,
		TimeUntilVisible = 2,
		FadeOutDuration = 1,
		FadeOutTimeTimeLeft = 1,
		FadeOutParts = descendants
	}
	local descendants2 = {}
	local descendants3 = {}

	for _, descendant in clone:GetDescendants() do
		if descendant.Name ~= "Blast Door" then
			continue
		end

		if descendant:IsA("Weld") then
			table.insert(descendants2, descendant)
		elseif descendant:IsA("MeshPart") then
			table.insert(descendants3, descendant)
		end
	end

	animationHandler:GetAnimationTrack("Drop").KeyframeReached:Connect(function(p2: string)
		if p2 == "DoorsOpen" then
			for _, v2 in descendants2 do
				v2:Destroy()
			end

			for _, v2 in descendants3 do
				v2.CanCollide = true
				local angle = math.rad((v2:GetAttribute("Angle")))
				v2:ApplyImpulse((v2.CFrame * CFrame.Angles(0, angle, 0)).LookVector * 8)
			end
		end
	end)
	setmetatable(v, DropPodClass)
	return v
end

function DropPodClass:Run(p: number)
	self.TimePassed += p

	if self.TimePassed >= self.TimeUntilVisible and not self.Visible then
		self.Visible = true

		for _, fadeOutPart in self.FadeOutParts do
			fadeOutPart.Transparency = 0
		end
	end

	if self.ShouldFadeOut and self.FadeOutTimeTimeLeft >= 0 then
		self.FadeOutTimeTimeLeft -= p
		local transparency = math.max(0, 1 - self.FadeOutTimeTimeLeft / self.FadeOutDuration)

		for _, fadeOutPart in self.FadeOutParts do
			fadeOutPart.Transparency = transparency
		end
	end

	if self.FadeOutTimeTimeLeft <= 0 and not self.Destroyed then
		self.Destroyed = true
	end
end

function DropPodClass.SpeedMultiplierChanged(p, p2: number)
	p.AnimationHandler:SetSpeedMultiplier(p2)
end

function DropPodClass.CanCleanup(p)
	return p.Destroyed == true
end

function DropPodClass:ReceiveUpdate(p: string)
	if p == "Destroy" then
		self:Destroy()
	elseif p == "Fade" then
		self.ShouldFadeOut = true
	end
end

function DropPodClass:Destroy()
	self.Model:Destroy()
	self.Destroyed = true
end

return DropPodClass