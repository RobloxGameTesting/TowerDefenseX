local RunService = game:GetService("RunService")
local BadgeService = game:GetService("BadgeService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Modules"):WaitForChild("DataTemplate"))
local isStudio = RunService:IsStudio()
local Util = {
	Create = function(className: string, items)
		local instance = Instance.new(className)
		local parent = nil

		for k, item in pairs(items) do
			if tonumber(k) == nil then
				if k == "Parent" then
					parent = item
				else
					instance[k] = item
				end
			else
				item.Parent = instance
			end
		end

		instance.Parent = parent
		return instance
	end
}
local v = {
	2500,
	2700,
	2900,
	3000,
	3250,
	3500,
	3750,
	3850,
	3950,
	4000,
	4150,
	4250,
	4300,
	4450,
	4500,
	4600,
	4700,
	4800,
	4950,
	5000,
	5250,
	5350,
	5450,
	5500,
	5600,
	5750,
	5800,
	5900,
	5950,
	6000,
	6150,
	6250,
	6350,
	6400,
	6500,
	6600,
	6750,
	6850,
	6950,
	7000,
	7200,
	7400,
	7600,
	7800,
	8000,
	8500,
	9000,
	9500,
	9850,
	10000
}
local v2 = {
	{ Type = "Gold", Value = 125 },
	{ Type = "Gold", Value = 175 },
	{ Type = "Gold", Value = 200 },
	{ Type = "XP", Value = 750 },
	{ Type = "Gold", Value = 250 },
	{ Type = "XP", Value = 1000 },
	{ Type = "Gold", Value = 275 },
	{ Type = "XP", Value = 1400 },
	{ Type = "Gold", Value = 300 },
	{ Type = "Gold", Value = 325 },
	{ Type = "XP", Value = 1750 },
	{ Type = "Gold", Value = 375 },
	{ Type = "XP", Value = 1800 },
	{ Type = "Gold", Value = 400 }
}

function Util.LevelToXP(p: number)
	if p == 0 then
		return 0
	end

	local total = 0

	for i = 1, p do
		if v[i] then
			total += v[i]
		else
			total += v[#v] + math.ceil(((i - 49) / 0.03) ^ 1.7 * 0.1)
		end
	end

	return total
end

local v3 = {}

function Util.XPToLevelAndProgress(p: number)
	debug.profilebegin("util.XPToLevelAndProgress()")

	if v3[p] then
		debug.profileend()
		return v3[p].Level, v3[p].Needed, v3[p].Current
	end

	local count = 0
	local v4

	while true do
		v4 = Util.LevelToXP(count + 1)

		if not (v4 <= p) then
			break
		end

		count += 1
	end

	local levelToXP = Util.LevelToXP(count)
	local needed = v4 - levelToXP
	local current = p - levelToXP
	v3[p] = {
		Level = count + 1,
		Needed = needed,
		Current = current
	}
	debug.profileend()
	return count + 1, needed, current
end

function Util.GetDailyReward(_: number, p: number)
	return v2[(p - 1) % #v2 + 1]
end

function Util.IsDailyPVPRewardAvailable(p, p2: number?)
	if not _G.PVP_DAILY_BONUS_ENABLED then
		return false
	end

	local v4 = p2 or os.time()
	local lastDailyPVPReward = p.LastDailyPVPReward or 0

	if lastDailyPVPReward == 0 or v4 - lastDailyPVPReward >= 86400 then
		return true
	end

	local v5 = v4 - (p.LastDailyReward or 0)
	return v5 >= 86400 and lastDailyPVPReward < v4 - v5 % 86400
end

function Util.GetAchievementProgress(p, p2: string)
	local achievement = p.Achievements[p2]

	if not achievement then
		warn(`CHECKED AN INVALID ACHIEVEMENT NAME -> {p2}`)
		return 0, false
	end

	local progress = achievement.Progress

	if progress == nil and achievement.Path then
		progress = p

		for _, v4 in string.split(achievement.Path, ">") do
			progress = progress[v4]

			if progress == nil then
				break
			end
		end
	end

	if progress == nil and isStudio and not achievement.Path:find("BossKillMap") then
		print(`Could not find achievement progress {achievement.Path} {achievement.Progress}`)
	end

	return progress or 0, achievement.Claimed or false
end

function Util.TryAwardBadgeAsync(p, p2: number)
	task.spawn(function()
		local success, result = pcall(function()
			return BadgeService:GetBadgeInfoAsync(p2)
		end)

		if success then
			if result.IsEnabled then
				local success2, result2 = pcall(function()
					return BadgeService:UserHasBadgeAsync(p.UserId, p2)
				end)

				if not success2 then
					warn("Error while checking if player has badge: " .. p2)
				end

				if result2 then
					return
				end

				local success3, result3 = pcall(function()
					return BadgeService:AwardBadge(p.UserId, p2)
				end)

				if not success3 then
					warn("Error while awarding badge: " .. tostring(p2) .. ", ", result3)
				elseif not result3 then
					warn("Failed to award badge:", p2)
				end
			end
		else
			warn("Error while fetching badge info: " .. result)
		end
	end)
end

function Util.FormatCurrency(p: number)
	return tostring((math.floor(p))):reverse():gsub("(%d%d%d)", "%1,"):gsub(",(%-?)$", "%1"):reverse()
end

function Util.IsPlayerInRange(player, p, p2: number)
	if player.Character then
		return (player.Character.HumanoidRootPart.Position - p.Position).Magnitude < p2
	end

	return false
end

return Util