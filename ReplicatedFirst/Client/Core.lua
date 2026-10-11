debug.setmemorycategory("Client/Core")
game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(game.ReplicatedFirst.Client.Network)
require(Common:WaitForChild("ChatHandlerClientside"))
local Core = { Loaded = false }
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://11394651255"

if _G.FOURTH_OF_JULY_2026_EVENT_ENABLED then
	sound.SoundId = "rbxassetid://132096739956746"
end

if _G.TB2_EVENT_ENABLED then
	sound.SoundId = "rbxassetid://77238473366820"
end

sound.Volume = 0.18
sound.Looped = true
sound.Parent = workspace
task.spawn(function()
	local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
	GameSoundHandler.AddSoundToSoundGroup(sound, "Music")
	sound:Play()
end)
local Lobby = workspace:FindFirstChild("Lobby")
local snowParticles = Lobby and Lobby:FindFirstChild("SnowParticles")

if not snowParticles then
	warn("SnowParticles not found")
	return Core
end

for _, emitter in pairs(snowParticles:GetDescendants()) do
	if emitter:IsA("ParticleEmitter") then
		emitter.Enabled = true
	end
end

return Core