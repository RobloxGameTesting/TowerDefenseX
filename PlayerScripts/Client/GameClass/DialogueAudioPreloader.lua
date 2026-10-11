local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local dialogue = TDX_Shared:WaitForChild("Modules"):WaitForChild("Dialogue")

local function PreloadDialogue(preloadDialogueName: string)
	local child = dialogue:FindFirstChild(preloadDialogueName)

	if not child then
		warn("DialogueAudioPreloader:PreloadDialogue -> Dialogue module script not found for name: " .. preloadDialogueName)
		return
	end

	local module = require(child)
	local part = Instance.new("Part")
	part.Position = createVector(0, -100, 0)
	part.Parent = workspace

	for _, v in pairs(module) do
		for _, v2 in pairs(v.Dialogue) do
			if not v2.SoundId then
				continue
			end

			local sound = Instance.new("Sound")
			sound.SoundId = v2.SoundId
			sound.PlaybackSpeed = 0.01
			sound.Volume = 0.001
			sound.Parent = part
			sound:Play()
		end
	end

	task.delay(3, function()
		part:Destroy()
	end)
end

return {
	DifficultyChanged = function(p: string)
		local waveConfig = ResourceManager.GetWaveConfig(p)
		assert(waveConfig ~= nil, "Error: waves config is nil")

		if waveConfig.PreloadDialogueName then
			PreloadDialogue(waveConfig.PreloadDialogueName)
		end
	end
}