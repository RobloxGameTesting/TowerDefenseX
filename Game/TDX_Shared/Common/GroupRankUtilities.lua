local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("GlobalConstants"))
local RankRoles = require(common:WaitForChild("RankRoles"))
local TDX_GROUP_ID = _G.TDX_GROUP_ID
local v = {}
local v2 = {}
local GroupRankUtilities = {}

for k in RankRoles do
	table.insert(v, k)
end

table.sort(v, function(a: string, b: string)
	return RankRoles[a].GroupRank > RankRoles[b].GroupRank
end)

function GroupRankUtilities.GetRankInGroup(p)
	local userId = p.UserId
	local v3 = v2[userId]

	if v3 then
		return v3
	end

	if userId <= 0 then
		return 0
	end

	local rolesInGroupAsync = GroupService:GetRolesInGroupAsync(userId, TDX_GROUP_ID)
	local v4 = 0

	for _, v5 in ipairs(rolesInGroupAsync.Roles or {}) do
		v4 = math.max(v4, v5.Rank)
	end

	v2[userId] = v4
	return v4
end

function GroupRankUtilities.GetGroupRole(p, p2: number?)
	local v3 = p2 or GroupRankUtilities.GetRankInGroup(p)

	for _, v4 in ipairs(v) do
		if RankRoles[v4].GroupRank <= v3 then
			return v4
		end
	end

	return nil
end

Players.PlayerRemoving:Connect(function(player)
	v2[player.UserId] = nil
end)
return GroupRankUtilities