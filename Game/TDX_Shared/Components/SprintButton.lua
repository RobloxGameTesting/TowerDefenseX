local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local playerWalkspeed = workspace:GetAttribute("PlayerWalkspeed") or 16
local playerSprintspeed = workspace:GetAttribute("PlayerSprintspeed") or RunService:IsStudio() and 50 or 32
local LocalPlayer = Players.LocalPlayer
local flag = false
local SprintButton = { ClassName = script.Name, ClassModule = script }
SprintButton.__index = SprintButton

local function getHumanoid() -- 3 equivalent calls inferred from this helper
	local character = LocalPlayer.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

function SprintButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, SprintButton))
end

function SprintButton:Init()
	self.Cleaner:Add(self.Root.Activated:Connect(function()
		local humanoid = getHumanoid() -- inferred equivalent call

		if humanoid then
			if humanoid:GetAttribute("FPSMode") then
				return
			end

			if flag then
				humanoid.WalkSpeed = playerWalkspeed
				flag = false
			else
				humanoid.WalkSpeed = playerSprintspeed
				flag = true
			end

			self.Root:SetAttribute("Active", flag)
		end
	end))
	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		local humanoid = getHumanoid() -- inferred equivalent call

		if humanoid and (input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.ButtonL3) then
			if humanoid:GetAttribute("FPSMode") then
				return
			end

			humanoid.WalkSpeed = playerSprintspeed
			flag = true
		end
	end))
	self.Cleaner:Add(UserInputService.InputEnded:Connect(function(input)
		local humanoid = getHumanoid() -- inferred equivalent call

		if humanoid and (input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.ButtonL3) then
			if humanoid:GetAttribute("FPSMode") then
				return
			end

			humanoid.WalkSpeed = playerWalkspeed
			flag = false
		end
	end))
	self.Cleaner:Add(UserInputService.LastInputTypeChanged:Connect(function()
		self:UpdateTouchButtonVisibility()
	end))
	self.Cleaner:Add(workspace:GetAttributeChangedSignal("FPSMode"):Connect(function()
		self:UpdateTouchButtonVisibility()
	end))
	local thread = task.spawn(function()
		while true do
			task.wait(1)
			local touchGui = LocalPlayer.PlayerGui:WaitForChild("TouchGui", 10)

			if not touchGui then
				break
			end

			local jumpButton = touchGui:FindFirstChild("JumpButton", true)

			if not jumpButton then
				continue
			end

			local v = jumpButton.Size.X.Offset / 70
			SprintButton.Position = jumpButton.Position - UDim2.new(0, 65 * v, 0, 0 * v)
			SprintButton.Size = UDim2.new(0, 50 * v, 0, 50 * v)
		end
	end)
	self.Cleaner:Add(function()
		task.cancel(thread)
		thread = nil
	end)
	self:UpdateTouchButtonVisibility()
end

function SprintButton:UpdateTouchButtonVisibility()
	local fpsMode = workspace:GetAttribute("FPSMode")
	self.Root.Visible = not fpsMode and UserInputService:GetLastInputType() == Enum.UserInputType.Touch
end

function SprintButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { SprintButton }, Players)
return SprintButton