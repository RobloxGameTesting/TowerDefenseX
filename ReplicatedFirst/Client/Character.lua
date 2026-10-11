local Network = require(game.ReplicatedFirst.Client.Network)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local run = ReplicatedStorage:WaitForChild("LobbyResources"):WaitForChild("Run")
local LocalPlayer = Players.LocalPlayer
local PlayerModule = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local controls = PlayerModule:GetControls()
local track = nil

local function handleCharacter(character) -- 1 equivalent call inferred from this helper
	if track then
		track:Destroy()
	end

	track = character:WaitForChild("Humanoid"):LoadAnimation(run)
end

Network.HookEvent("SetControlsEnabled", function(p, p2, cframe)
	if p then
		controls:Enable()
	else
		controls:Disable()
	end

	if p2 and LocalPlayer.Character then
		task.wait()
		local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")

		if humanoid then
			humanoid.Jump = true
		end
	end

	if cframe and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
		for _ = 1, 3 do
			task.wait()
			LocalPlayer.Character:PivotTo(cframe)
		end
	end
end)

if LocalPlayer.Character then
	handleCharacter(LocalPlayer.Character) -- inferred equivalent call
end

LocalPlayer.CharacterAdded:Connect(handleCharacter)
return {}