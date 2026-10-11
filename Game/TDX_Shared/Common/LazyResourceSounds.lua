local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local v = {}
local v2 = {}
local parent = nil

local function RestoreSound(sound) -- 3 equivalent calls inferred from this helper
	local lazySoundId = sound:GetAttribute("LazySoundId")

	if lazySoundId and sound.SoundId == "" then
		sound.SoundId = lazySoundId
	end
end

local LazyResourceSounds = {
	Strip = function(folder)
		for _, sound in pairs(folder:GetDescendants()) do
			if not (sound:IsA("Sound") and sound.SoundId ~= "") then
				continue
			end

			sound:SetAttribute("LazySoundId", sound.SoundId)
			sound.SoundId = ""
		end
	end,
	Restore = function(sound)
		if sound:IsA("Sound") then
			RestoreSound(sound) -- inferred equivalent call
		end

		for _, sound2 in pairs(sound:GetDescendants()) do
			if sound2:IsA("Sound") then
				RestoreSound(sound2) -- inferred equivalent call
			end
		end
	end,
	CollectSoundIds = function(folder, p)
		for _, sound in pairs(folder:GetDescendants()) do
			if not sound:IsA("Sound") then
				continue
			end

			local lazySoundId = sound:GetAttribute("LazySoundId") or sound.SoundId

			if lazySoundId ~= "" then
				p[lazySoundId] = true
			end
		end
	end,
	KeepLoaded = function(p: string, p2)
		v[p] = p2
		local v3 = {}

		for _, v4 in pairs(v) do
			for k in pairs(v4) do
				v3[k] = true
			end
		end

		if not parent then
			local folder = Instance.new("Folder")
			folder.Name = "KeptResourceSounds"
			folder.Parent = SoundService
			parent = folder
		end

		for k in pairs(v3) do
			if v2[k] then
				continue
			end

			local sound = Instance.new("Sound")
			sound.SoundId = k
			sound.Parent = parent
			v2[k] = sound
		end

		for k, v4 in pairs(v2) do
			if v3[k] then
				continue
			end

			v4:Destroy()
			v2[k] = nil
		end
	end
}

if RunService:IsClient() then
	workspace.DescendantAdded:Connect(function(sound)
		if sound:IsA("Sound") then
			RestoreSound(sound) -- inferred equivalent call
		end
	end)
end

return LazyResourceSounds