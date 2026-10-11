local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = ReplicatedStorage.TDX_Shared.Common.Resources
local v = { "MapVotingLobby", "Maps", "OnDemandResources", "__TDX_Plugin_Data" }
local v2 = { "Atrazine Test Map", "Atrazine Test Map Short" }
local v3 = { "TB Part 2", "PVP" }

for _, child in pairs(ServerStorage:GetChildren()) do
	if table.find(v, child.Name) then
		if child.Name == "Maps" then
			for _, child2 in pairs(child:GetChildren()) do
				if not table.find(v2, child2.Name) then
					child2:Destroy()
				end
			end
		end
	else
		child:Destroy()
	end
end

local models = ServerStorage:FindFirstChild("OnDemandResources")
	and ServerStorage.OnDemandResources:FindFirstChild("Enemies")
	and ServerStorage.OnDemandResources.Enemies:FindFirstChild("Models")

for _, v4 in pairs({ Resources.Enemies:FindFirstChild("Models"), models }) do
	for _, folder in pairs(v4:GetChildren()) do
		if not folder:IsA("Folder") or table.find(v3, folder.Name) then
			continue
		end

		folder:Destroy()
	end
end

local function GetOrCreateFolder(parent, name: string) -- 4 equivalent calls inferred from this helper
	local v4 = parent:FindFirstChild(name)

	if not v4 then
		v4 = Instance.new("Folder")
		v4.Name = name
		v4.Parent = parent
	end

	return v4
end

local function ClearFolder(parent, name: string)
	local folder = GetOrCreateFolder(parent, name) -- inferred equivalent call

	for _, v4 in pairs(folder:GetChildren()) do
		v4:Destroy()
	end
end

ClearFolder(Resources.Towers, "Skins")
ClearFolder(Resources.PathEntities, "Skins")
ClearFolder(Resources.StaticEntities, "Skins")
ClearFolder(Resources.Cutscenes, "Models")
local OnDemandResources = ServerStorage:FindFirstChild("OnDemandResources")

if OnDemandResources then
	ClearFolder(GetOrCreateFolder(OnDemandResources, "Towers"), "Skins") -- inferred equivalent call
	ClearFolder(GetOrCreateFolder(OnDemandResources, "PathEntities"), "Skins") -- inferred equivalent call
	ClearFolder(GetOrCreateFolder(OnDemandResources, "Cutscenes"), "Models") -- inferred equivalent call
end