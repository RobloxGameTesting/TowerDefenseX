local createVector = vector.create
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local guideBeam = ReplicatedStorage:WaitForChild("LobbyResources"):WaitForChild("GuideBeam")
local LocalPlayer = Players.LocalPlayer
local GuideToHelicopter = { ClassName = script.Name, ClassModule = script }
GuideToHelicopter.__index = GuideToHelicopter

function GuideToHelicopter.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, GuideToHelicopter))
end

function GuideToHelicopter.Init(p)
	p.Cleaner:Add(p.Root.Triggered:Connect(function(player)
		if player == LocalPlayer then
			local character = player.Character

			if not character then
				return
			end

			local clone = guideBeam:Clone()
			clone.Parent = workspace
			local start = clone:FindFirstChild("Start")
			local firstChild = clone:FindFirstChild("End")

			if not (firstChild and start) then
				clone:Destroy()
				return
			end

			local v = true
			local diedConnection = nil
			diedConnection = character.Humanoid.Died:Connect(function()
				v = false
				diedConnection:Disconnect()
				clone:Destroy()
			end)

			while v and RunService.Heartbeat:Wait() do
				start.WorldCFrame = character.HumanoidRootPart.CFrame
				firstChild.WorldCFrame = CFrame.new(createVector(-65.44, -29.579, 428.912))
			end
		end
	end))
end

function GuideToHelicopter:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { GuideToHelicopter })
return GuideToHelicopter