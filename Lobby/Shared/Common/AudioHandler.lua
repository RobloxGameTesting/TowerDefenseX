local AudioHandler = {}
local SoundService = game:GetService("SoundService")
local Constants = require(script.Parent:WaitForChild("Constants"))

function AudioHandler.PlaySound(soundId: string, value: number?)
	if not soundId or soundId == "" then
		warn("No SoundAssetId")
		return
	end

	local sound = Instance.new("Sound")
	sound.SoundId = soundId
	sound.Volume = value or 0.5
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

function AudioHandler.PlaySoundByKey(p: string, p2: number?)
	local v = Constants.ButtonSFX[p]

	if v then
		AudioHandler.PlaySound(v, p2)
	else
		warn(`Sound key "{p}" not found in Constants.ButtonSFX`)
	end
end

return AudioHandler