local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Enums = require(Common:WaitForChild("Enums"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local v = {
	Catgirl = "rbxassetid://12638838743",
	["Tower Battles"] = "rbxassetid://15565614486",
	["Cyber Neko"] = "rbxassetid://15602593408",
	Rockband = "rbxassetid://18269647275",
	["Admin Rockband"] = "rbxassetid://18269647275",
	Ghost = "rbxassetid://16932154087",
	Summer = "rbxassetid://137669840769268",
	Chad = "rbxassetid://103357713442854",
	Jolly = "rbxassetid://81227827641228"
}
local v2 = { Ghost = 0.15, Chad = 0.3 }
local event = BindableHandler.GetEvent("BossActiveUpdate")
local Terrain = workspace.Terrain
local v3 = nil
local attachment = nil
local skinName = nil
local sound = nil
local v4 = nil

local function BossActiveChanged()
	if sound then
		TweenService:Create(sound, TweenInfo.new(2), {
			Volume = v4 and 0 or v2[skinName] or 0.2
		}):Play()
	end
end

local function GetEDJMusicID(p) -- 1 equivalent call inferred from this helper
	return p.SkinName and v[p.SkinName] or "rbxassetid://15320437190"
end

local EDJMusicHandler = {
	EDJAdded = function(object)
		if not v3 then
			if attachment then
				attachment:Destroy()
			end

			attachment = Instance.new("Attachment")
			attachment.Name = "DJMUSIC"
			attachment.WorldCFrame = CFrame.new(object:GetPosition())
			attachment.Parent = Terrain
			skinName = object.SkinName
			sound = Instance.new("Sound")
			sound.SoundId = not object.SkinName and "rbxassetid://15320437190"
				or v[object.SkinName]
				or "rbxassetid://15320437190"
			sound.Looped = true
			sound.Parent = attachment
			sound.Volume = v4 and 0 or v2[skinName] or 0.2
			sound.RollOffMinDistance = 10
			sound.RollOffMaxDistance = 40
			sound.RollOffMode = Enum.RollOffMode.Linear
			sound:Play()
			GameSoundHandler.AddSoundToSoundGroup(sound, "EDJMusic")
			v3 = object
		end
	end,
	EDJRemoved = function(p, items)
		if v3 == p then
			local v5 = nil

			for _, item in pairs(items) do
				if not (item ~= p and item.Type == Enums.Towers.EDJ) then
					continue
				end

				v5 = item
				break
			end

			if v5 then
				v3 = v5
				attachment.WorldCFrame = CFrame.new(v5:GetPosition())
				local soundId = GetEDJMusicID(v5) -- inferred equivalent call

				if soundId ~= sound.SoundId then
					sound.SoundId = soundId
				end
			else
				attachment:Destroy()
				v3 = nil
				attachment = nil
				sound = nil
			end
		end
	end
}
event:AttachCallback(function(flag: boolean)
	if v4 ~= flag then
		v4 = flag
		BossActiveChanged()
	end
end)
return EDJMusicHandler