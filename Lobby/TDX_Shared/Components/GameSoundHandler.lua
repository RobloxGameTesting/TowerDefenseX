local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Data = require(TDX_Shared.Client.Services.Data)
local v = { "UI", "Music", "SFX", "Ambient", "EDJMusic", "Emotes" }
local GameSoundHandler = {}

for _, childName in ipairs(v) do
	if SoundService:FindFirstChild(childName) then
		continue
	end

	local soundGroup = Instance.new("SoundGroup")
	soundGroup.Volume = 0
	soundGroup.Name = childName
	soundGroup.Parent = SoundService
end

local function updateSoundLevels()
	local settings = Data.Get("Settings")

	for _, childName in ipairs(v) do
		local child = SoundService:FindFirstChild(childName)

		if not child then
			continue
		end

		local setting = settings[childName]

		if setting and not child:GetAttribute("Muted") then
			child.Volume = 0.2 * (setting - 5) + 1
		else
			warn("Missing value for volume setting", childName)
		end
	end
end

Data.Updated:Connect(function(p)
	if p == "Settings" then
		updateSoundLevels()
	end
end)
updateSoundLevels()

function GameSoundHandler:AddSoundToSoundGroup(childName: string)
	local child = SoundService:FindFirstChild(childName)

	if child then
		self.SoundGroup = child
	else
		warn("Unknown sound group", childName)
	end
end

function GameSoundHandler.GetSoundGroup(childName: string)
	local child = SoundService:FindFirstChild(childName)

	if child then
		return child
	end

	warn("Unknown sound group", childName)
end

function GameSoundHandler.MuteSoundGroup(childName: string)
	local child = SoundService:FindFirstChild(childName)

	if child then
		child:SetAttribute("Muted", true)
		child:SetAttribute("OriginalVolume", child.Volume)
		child.Volume = 0
	end
end

function GameSoundHandler.UnmuteSoundGroup(childName: string)
	local child = SoundService:FindFirstChild(childName)

	if child and child:GetAttribute("Muted") then
		child:SetAttribute("Muted", false)
		child.Volume = child:GetAttribute("OriginalVolume")
		child:SetAttribute("OriginalVolume", nil)
		updateSoundLevels()
	end
end

local function handlePatchedInst(instance) -- 1 equivalent call inferred from this helper
	local __groupName = instance:GetAttribute("__GroupName")

	if __groupName then
		GameSoundHandler.AddSoundToSoundGroup(instance, __groupName)
	end
end

CollectionService:GetInstanceAddedSignal("SoundFix"):Connect(handlePatchedInst)

for _, v2 in CollectionService:GetTagged("SoundFix") do
	handlePatchedInst(v2) -- inferred equivalent call
end

return GameSoundHandler