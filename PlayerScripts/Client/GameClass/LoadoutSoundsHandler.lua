local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local LazyResourceSounds = require(common:WaitForChild("LazyResourceSounds"))
local resources = common:WaitForChild("Resources")
local models = resources:WaitForChild("Towers"):WaitForChild("Models")
local models2 = resources:WaitForChild("PathEntities"):WaitForChild("Models")
local v = {}
local v2 = nil
local v3 = false

local function IsLoadoutSlotAttribute(value: string) -- 2 equivalent calls inferred from this helper
	return value:match("^LoadoutSlot%d+$") ~= nil
end

local function GetPathEntityUnitModelNames()
	if v2 then
		return v2
	end

	local function AddModelNames(folder, p)
		for _, child in pairs(folder:GetChildren()) do
			if child:IsA("Model") then
				p[child.Name] = true
			elseif child:IsA("Folder") then
				AddModelNames(child, p)
			end
		end
	end

	local v4 = {}

	for _, folder in pairs(models2:GetChildren()) do
		local v5 = { [folder.Name] = true, [folder.Name:gsub("^Variants_", "")] = true }

		if folder:IsA("Folder") then
			AddModelNames(folder, v5)
		end

		v4[folder] = v5
	end

	v2 = v4
	return v2
end

local function GetTowerSoundIds(childName: string)
	local v4 = v[childName]

	if v4 then
		return v4
	end

	local v5 = {}
	local child = models:FindFirstChild(childName)

	if child then
		LazyResourceSounds.CollectSoundIds(child, v5)
	end

	local v6 = not ResourceManager.HasTowerConfig(childName) and {}
		or ResourceManager.GetConfigReferencedStrings((ResourceManager.GetTowerConfig(childName)))
		or {}
	v6[childName] = true

	for k, v7 in pairs((GetPathEntityUnitModelNames())) do
		for k2 in pairs(v7) do
			if not v6[k2] then
				continue
			end

			LazyResourceSounds.CollectSoundIds(k, v5)
			break
		end
	end

	v[childName] = v5
	return v5
end

local function Refresh()
	v3 = false
	local v4 = {}

	for k, v5 in pairs(Players.LocalPlayer:GetAttributes()) do
		if not (type(v5) == "string" and v5 ~= "" and IsLoadoutSlotAttribute(k)) then -- inferred equivalent call
			continue
		end

		for k2 in pairs((GetTowerSoundIds(v5))) do
			v4[k2] = true
		end
	end

	LazyResourceSounds.KeepLoaded("Loadout", v4)
end

local function ScheduleRefresh() -- 1 equivalent call inferred from this helper
	if not v3 then
		v3 = true
		task.defer(Refresh)
	end
end

Players.LocalPlayer.AttributeChanged:Connect(function(value: string)
	if IsLoadoutSlotAttribute(value) and not v3 then -- inferred equivalent call
		v3 = true
		task.defer(Refresh)
	end
end)
ScheduleRefresh() -- inferred equivalent call
return {}