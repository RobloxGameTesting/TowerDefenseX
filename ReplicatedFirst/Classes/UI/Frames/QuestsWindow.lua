local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(TDX_Shared.Modules.DataTemplate)
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Shared = require(TDX_Shared.Modules.Shared)
local Data = require(TDX_Shared.Client.Services.Data)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
require(TDX_Shared.Modules.BattlePass)
local Lang = require(TDX_Shared.Modules.Lang)
local Network = require(game.ReplicatedFirst.Client.Network)
local Quests = require(TDX_Shared.Modules.Quests)
local Util = require(TDX_Shared.Modules.Util)
local color = Color3.fromRGB(236, 47, 47)
local IS_DEV_PLACE = Shared.IS_DEV_PLACE

local function log(...)
	if IS_DEV_PLACE then
		print("[QuestsWindow]", ...)
	end
end

local function ColorText(p: string, color2: Color3) -- 2 equivalent calls inferred from this helper
	return `<font color="rgb({math.floor(color2.R * 255)},{math.floor(color2.G * 255)},{math.floor(color2.B * 255)})">{p}</font>`
end

local function JoinStrings(list, p: string)
	local v = ""

	for i = 1, #list do
		v ..= list[i]

		if i ~= #list then
			v ..= ` {p} `
		end
	end

	return v
end

local function UpdateQuestFrame(p: string, questId: string, quest, child, streak: number)
	local questDefinition = Quests.GetQuestDefinition(p, questId)
	child:SetAttribute("QuestId", questId)
	local goldReward = questDefinition.GoldReward or 0
	local crystalsReward = questDefinition.CrystalsReward or 0
	local cookiesReward = questDefinition.CookiesReward or 0

	if p == "Daily" and streak > 0 then
		local dailyQuestRewardMultiplier = Quests.CalculateDailyQuestRewardMultiplier(streak)
		goldReward = math.floor(goldReward * dailyQuestRewardMultiplier)
		crystalsReward = math.floor(crystalsReward * dailyQuestRewardMultiplier)
		cookiesReward = math.floor(cookiesReward * dailyQuestRewardMultiplier)
	end

	local v = {}

	if questDefinition.CrystalsReward then
		table.insert(v, ColorText(`{crystalsReward} Crystals`, Shared.CURRENCY_COLORS.Crystals)) -- inferred equivalent call
	end

	if questDefinition.CookiesReward then
		table.insert(v, ColorText(`{cookiesReward} Cookies`, Shared.CURRENCY_COLORS.Cookies)) -- inferred equivalent call
	end

	if questDefinition.GoldReward then
		table.insert(v, `{goldReward} Gold`)
	end

	if questDefinition.XPReward then
		table.insert(v, `{questDefinition.XPReward} XP`)
	end

	child.Description.Text = Lang.Get(Lang.Strings.Quests[p][questId])
	local reward = child.Reward
	local color2 = Color3.new(1, 1, 1)
	reward.Text = JoinStrings(
		v,
		`<font color="rgb({math.floor(color2.R * 255)},{math.floor(color2.G * 255)},{math.floor(color2.B * 255)})">&</font>`
	)
	child.Progress.Visible = quest.MaxProgress > 1
	child.Progress.Text = `{math.floor(quest.Progress)}/{quest.MaxProgress}`
	local visible = quest.Progress >= quest.MaxProgress
	child.Claim.Visible = visible
	child.InProgress.Visible = not visible
	child.Visible = true
end

local QuestsWindow = { ClassName = script.Name, ClassModule = script }
QuestsWindow.__index = QuestsWindow

function QuestsWindow.new(root)
	return (setmetatable({ Root = root, Frame = root.Frame, Cleaner = Cleaner.new() }, QuestsWindow))
end

function QuestsWindow:Init()
	log("Initialized")
	self.Cleaner:Add(Data.Updated:Connect(function(p: string, _)
		if p ~= "Quests" then
			return
		end

		log("Quests data updated")
		self:Update()
	end))
	self:Update()
	self.Cleaner:Add(self.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		Network.Fire("ClientRequestHasSeenNewQuests")
	end))
	self.Cleaner:Add(self.Frame.DailyQuestsHeader.Refresh.Activated:Connect(function()
		MarketplaceService:PromptProductPurchase(Players.LocalPlayer, Shared.QUESTS_REFRESH_DAILY_PRODUCT_ID)
	end))
	self.Cleaner:Add(self.Frame.NoDailyQuests.Refresh.Activated:Connect(function()
		MarketplaceService:PromptProductPurchase(Players.LocalPlayer, Shared.QUESTS_REFRESH_DAILY_PRODUCT_ID)
	end))
	self.Cleaner:Add(self.Frame.WeeklyQuestHeader.Refresh.Activated:Connect(function()
		local xpToLevelAndProgress = Util.XPToLevelAndProgress(Data.Get("XP"))
		MarketplaceService:PromptProductPurchase(
			Players.LocalPlayer,
			Quests.GetWeeklyRefreshProductId(xpToLevelAndProgress)
		)
	end))
	self.Cleaner:Add(self.Frame.NoWeeklyQuest.Refresh.Activated:Connect(function()
		local xpToLevelAndProgress = Util.XPToLevelAndProgress(Data.Get("XP"))
		MarketplaceService:PromptProductPurchase(
			Players.LocalPlayer,
			Quests.GetWeeklyRefreshProductId(xpToLevelAndProgress)
		)
	end))
	self.Cleaner:Add(self.Root.DailyStreakBroken.Dialog.Repair.Activated:Connect(function()
		MarketplaceService:PromptProductPurchase(Players.LocalPlayer, Shared.QUESTS_REPAIR_DAILY_STREAK_PRODUCT_ID)
	end))
	self.Cleaner:Add(self.Root.DailyStreakBroken.Dialog.StartOver.Activated:Connect(function()
		Network.Fire("ClientRequestDoNotRepairStreak", "Daily")
	end))
	self.Cleaner:Add(self.Root.WeeklyStreakBroken.Dialog.Repair.Activated:Connect(function()
		MarketplaceService:PromptProductPurchase(Players.LocalPlayer, Shared.QUESTS_REPAIR_WEEKLY_STREAK_PRODUCT_ID)
	end))
	self.Cleaner:Add(self.Root.WeeklyStreakBroken.Dialog.StartOver.Activated:Connect(function()
		Network.Fire("ClientRequestDoNotRepairStreak", "Weekly")
	end))

	for i = 1, 3 do
		local child = self.Frame.DailyQuests:FindFirstChild(`Quest{i}`)

		if child then
			self.Cleaner:Add(child.Claim.Activated:Connect(function()
				Network.Fire("ClientRequestClaimQuest", "Daily", child:GetAttribute("QuestId"))
				SoundHandler.Play("QuestClaim")
			end))
		end
	end

	local quest1 = self.Frame.WeeklyQuest:FindFirstChild("Quest1")
	self.Cleaner:Add(quest1.Claim.Activated:Connect(function()
		Network.Fire("ClientRequestClaimQuest", "Weekly", quest1:GetAttribute("QuestId"))
		SoundHandler.Play("QuestClaim")
	end))
	self.TimerThread = task.spawn(function()
		while true do
			local now = os.time()
			local quests = Data.Get("Quests")
			local v = quests.Daily.NextRefreshTime - now
			local dailyRefreshTimer = self.Frame.DailyRefreshTimer
			local v2 = color
			dailyRefreshTimer.Text = string.format(
				`Auto refresh in: {`<font color="rgb({math.floor(v2.R * 255)},{math.floor(v2.G * 255)},{math.floor(v2.B * 255)})">%02dh %02dm %02ds</font>`}`,
				v // 3600,
				v // 60 % 60,
				v % 60
			)
			local v3 = quests.Weekly.NextRefreshTime - now
			local weeklyRefreshTimer = self.Frame.WeeklyRefreshTimer
			local v4 = color
			weeklyRefreshTimer.Text = string.format(
				`Auto refresh in: {`<font color="rgb({math.floor(v4.R * 255)},{math.floor(v4.G * 255)},{math.floor(v4.B * 255)})">%02dd %02dh %02dm %02ds</font>`}`,
				v3 // 86400,
				v3 // 3600 % 24,
				v3 // 60 % 60,
				v3 % 60
			)
			task.wait(1)
		end
	end)
end

function QuestsWindow:Update()
	local quests = Data.Get("Quests")

	for i = 1, 3 do
		local child = self.Frame.DailyQuests:FindFirstChild(`Quest{i}`)

		if child then
			child.Visible = false
		end
	end

	if next(quests.Daily.Quests) == nil then
		self.Frame.NoDailyQuests.Visible = true
	else
		self.Frame.NoDailyQuests.Visible = false
		local v = 1

		for k, quest in quests.Daily.Quests do
			local child = self.Frame.DailyQuests:FindFirstChild(`Quest{v}`)

			if child then
				UpdateQuestFrame("Daily", k, quest, child, quests.Daily.Streak)
			end

			v += 1
		end
	end

	local quest1 = self.Frame.WeeklyQuest:FindFirstChild("Quest1")
	quest1.Visible = false

	if next(quests.Weekly.Quests) == nil then
		self.Frame.NoWeeklyQuest.Visible = true
	else
		self.Frame.NoWeeklyQuest.Visible = false
		local v = 1

		for k, quest in quests.Weekly.Quests do
			local child = self.Frame.WeeklyQuest:FindFirstChild(`Quest{v}`)

			if child then
				UpdateQuestFrame("Weekly", k, quest, child, quests.Weekly.Streak)
			end

			v += 1
		end
	end

	self.Frame.DailyStreak.Text = `{quests.Daily.Streak} days in a row`
	self.Frame.WeeklyStreak.Text = `{quests.Weekly.Streak} weeks in a row`
	self.Root.DailyStreakBroken.Visible = false
	self.Root.WeeklyStreakBroken.Visible = false

	if quests.Daily.StreakBroken then
		self.Root.DailyStreakBroken.Dialog.StreakCounter.Text = tostring(quests.Daily.LastStreak)
		self.Root.DailyStreakBroken.Visible = true
	elseif quests.Weekly.StreakBroken then
		self.Root.WeeklyStreakBroken.Dialog.StreakCounter.Text = tostring(quests.Weekly.LastStreak)
		self.Root.WeeklyStreakBroken.Visible = true
	end
end

function QuestsWindow.Destroy(p)
	p.Cleaner:Clean()
	task.cancel(p.TimerThread)
end

Director.Register(script.Name, { QuestsWindow }, Players.LocalPlayer)
return QuestsWindow