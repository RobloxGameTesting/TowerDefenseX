local TeleportUtilities = {}
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
workspace:GetAttribute("IsCoreGame")
local isLobby = workspace:GetAttribute("IsLobby")
local count = 0
local v = {}
local v2 = {}

local function ClearTeleport(instance) -- 3 equivalent calls inferred from this helper
	v[instance] = nil
	v2[instance] = nil
	instance:SetAttribute("Teleporting", nil)
end

local function WatchForStragglers(p: number, clone, p2)
	local v3 = {}

	for _, item in clone do
		v3[item] = v[item]
	end

	task.delay(20, function()
		for k, v4 in v3 do
			if not (k.Parent == Players and v[k] == v4) then
				continue
			end

			local v5 = (v2[k] or 0) + 1

			if v5 > 2 then
				warn(`TELEPORT FAILURE {k.Name} was never teleported`)
				ClearTeleport(k) -- inferred equivalent call
			else
				warn(`{k.Name} is still here {20}s after teleporting, retrying ({v5}/{2})`)
				v2[k] = v5
				task.spawn(TeleportUtilities.SafeTeleportAsync, p, { k }, p2, true)
			end
		end
	end)
end

local function HandleFailedTeleport(instance, p, p2: string, p3: number, p4)
	if p == Enum.TeleportResult.Flooded then
		task.wait(15)
	elseif p == Enum.TeleportResult.Failure then
		task.wait(3)
	else
		if p == Enum.TeleportResult.IsTeleporting then
			return
		end

		ClearTeleport(instance) -- inferred equivalent call
		error(("Invalid teleport [%s]: %s"):format(p.Name, p2))
	end

	if instance.Parent == Players then
		TeleportUtilities.SafeTeleportAsync(p3, { instance }, p4, true)
	end
end

function TeleportUtilities.SafeTeleportAsync(p: number, p2, p3, flag: boolean?)
	local clone = table.clone(p2)
	local count2 = 0

	for _, v3 in clone do
		count += 1
		v[v3] = count

		if not flag then
			v2[v3] = nil
		end

		v3:SetAttribute("Teleporting", true)
	end

	while true do
		for i = #clone, 1, -1 do
			if clone[i].Parent ~= Players then
				table.remove(clone, i)
			end
		end

		if #clone == 0 then
			return false, "No players left to teleport"
		end

		local success, result = pcall(function()
			return TeleportService:TeleportAsync(p, clone, p3)
		end)
		count2 += 1

		if not success then
			task.wait(3)
		end

		if not (success or count2 == 5) then
			continue
		end

		if success then
			WatchForStragglers(p, clone, p3)
		else
			warn("TELEPORT FAILURE " .. result)

			for _, v3 in clone do
				ClearTeleport(v3) -- inferred equivalent call
			end
		end

		return success, result
	end
end

if isLobby then
	TeleportService.TeleportInitFailed:Connect(HandleFailedTeleport)
end

Players.PlayerRemoving:Connect(function(player)
	v[player] = nil
	v2[player] = nil
end)
return TeleportUtilities