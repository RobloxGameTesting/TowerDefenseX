local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local ScalingHandler = require(Common:WaitForChild("ScalingHandler"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Shared = require(TDX_Shared.Modules.Shared)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Data = require(TDX_Shared.Client.Services.Data)
local Achievements = require(TDX_Shared.Modules.Achievements)
local Lang = require(TDX_Shared.Modules.Lang)
local Util = require(TDX_Shared.Modules.Util)
local Network = require(ReplicatedFirst.Client.Network)
local MapData = require(ReplicatedStorage.TDX_Shared.Common.MapData)
local NameTagData = require(TDX_Shared.Modules.NameTagData)
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local v = {
	Base = 0,
	Gameplay = 200,
	Bosses = 400,
	Wins = 600,
	Level = 800,
	Kills = 1000,
	TimePlayed = 1200
}
local MEDALS_LIST = Shared.MEDALS_LIST
local v2 = {}
local achievements = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TopBar"):WaitForChild("MenuIconHolder"):WaitForChild("Achievements")

local function GetRewardTextResources(childName: string, reward)
	if reward.Type ~= "NameTagEffect" then
		return ResourceManager.GetMiscResource("Achievements", true):FindFirstChild(childName)
	end

	if NameTagData.Effects[reward.Item] and NameTagData.Effects[reward.Item].LinkedStyle then
		local linkedStyle = NameTagData.Effects[reward.Item].LinkedStyle
		return ResourceManager.GetMiscResource("NameTags", true).Styles[linkedStyle]
	else
		return nil
	end
end

local function GetRewardDisplayName(reward)
	if reward.Type == "NameTagEffect" then
		return `{Lang.Get(Lang.Strings.AssetInfo.NameTagEffects[reward.Item].Name)} Name Tag`
	end

	if reward.Type == "Tower" then
		return `{Lang.Get(Lang.Strings.AssetInfo.Towers[reward.Item].Name)} Tower`
	end

	if reward.Type == "Skin" then
		local v3, v4 = unpack(string.split(reward.Item, "_"))
		return `{v4} {Lang.Get(Lang.Strings.AssetInfo.Towers[v3].Name)} Skin`
	else
		error(`GetRewardDisplayName: Unsupport reward type: {reward.Type}`)
	end
end

local AchievementsWindow = { ClassName = script.Name, ClassModule = script }
AchievementsWindow.__index = AchievementsWindow

function AchievementsWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), CurrentLevel = 0 }, AchievementsWindow))
end

function AchievementsWindow:Init()
	local mainList = self.Root.Frame.MainList
	local template = mainList.template
	template.Visible = false

	for _, child in mainList:GetChildren() do
		if child ~= template and child:IsA(template.ClassName) then
			child:Destroy()
		end
	end

	for k, achievement in Achievements do
		local clone = template:Clone()
		clone.Name = k
		local inner = clone.Inner
		inner.goldAmount.Visible = false
		inner.CrystalsAmount.Visible = false
		inner.xpAmount.Visible = false
		inner.gold.Visible = false
		inner.Crystals.Visible = false
		inner.xp.Visible = false

		for _, reward in achievement.Rewards do
			if reward.Type == "Gold" then
				inner.goldAmount.Text = "$" .. reward.Amount
				inner.goldAmount.Visible = true
				inner.gold.Visible = true
			elseif reward.Type == "Crystals" then
				inner.CrystalsAmount.Text = reward.Amount
				inner.CrystalsAmount.Visible = true
				inner.Crystals.Visible = true
			elseif reward.Type == "XP" then
				inner.xpAmount.Text = reward.Amount
				inner.xpAmount.Visible = true
				inner.xp.Visible = true
			else
				inner.NameTagEffect.Visible = true
				inner.NameTagEffect.Text = GetRewardDisplayName(reward)
				local rewardTextResources = GetRewardTextResources(k, reward)

				if rewardTextResources ~= nil then
					for _, child in rewardTextResources:GetChildren() do
						local clone_2 = child:Clone()
						clone_2.Parent = inner.NameTagEffect
					end
				end
			end
		end

		Lang.Set(inner.title, Lang.Strings.Achievements[k].DisplayName)
		Lang.Set(inner.description, Lang.Strings.Achievements[k].Description)
		local v3 = k
		inner.claim.Activated:Connect(function()
			local v4, v5 = Network.Invoke("AchievementClaim", v3)

			if not v4 then
				print(`Could not claim {v3} rewards because {v5}`)
				return
			end

			SoundHandler.Play("DailyLogin")
			self:Update()
		end)
		clone.Parent = mainList
		clone.Visible = true
	end

	self:Update()
	self.CurrentLevel = Util.XPToLevelAndProgress(Data.Get("XP"))
	Data.Updated:Connect(function(p)
		if p == "XP" then
			local xpToLevelAndProgress = Util.XPToLevelAndProgress(Data.Get("XP"))

			if xpToLevelAndProgress ~= self.CurrentLevel then
				self.CurrentLevel = xpToLevelAndProgress
				self:Update()
			end
		end
	end)
	self.Cleaner:Add(self.Root.Frame.Maps.MouseButton1Down:Connect(function()
		self.Root.Frame.Maps:SetAttribute("Selected", true)
		self.Root.Frame.General:SetAttribute("Selected", false)
		self.Root.Frame.MapList.Visible = true
		self.Root.Frame.MainList.Visible = false
	end))
	self.Cleaner:Add(self.Root.Frame.General.MouseButton1Down:Connect(function()
		self.Root.Frame.Maps:SetAttribute("Selected", false)
		self.Root.Frame.General:SetAttribute("Selected", true)
		self.Root.Frame.MapList.Visible = false
		self.Root.Frame.MainList.Visible = true
	end))
	self.Cleaner:Add(self.Root.Frame.MapList["!search"].Background.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		local text = string.lower(self.Root.Frame.MapList["!search"].Background.TextBox.Text)

		for _, frame in self.Root.Frame.MapList:GetChildren() do
			if frame:IsA("Frame") and frame.Name ~= "!search" then
				frame.Visible = text == "" or string.sub(string.lower(frame.Name), 1, #text) == text
			end
		end
	end))
	local template2 = self.Root.Frame.MapList.template
	template2.Parent = nil
	local mapAndDifficultyWins = Data.Get("MapAndDifficultyWins") or {}

	for k, v3 in MapData do
		if v3.IsEventOnlyMap then
			continue
		end

		local clone = template2:Clone()
		clone.Name = k
		clone.Inner.title.Text = k
		clone.Inner.icon.Image = v3.Image or ""

		for childName, v4 in MEDALS_LIST do
			local v5 = not mapAndDifficultyWins[k] and 0 or mapAndDifficultyWins[k][childName] or 0
			local child = clone.Inner.medals:FindFirstChild(childName)

			if child then
				child.Image = v4[v5 > 0]
			end
		end

		clone.Parent = self.Root.Frame.MapList
	end

	ScalingHandler.ManualTriggerScreenSizeChanged()
end

local function SelectUIGradient(folder, category: string)
	local v3 = false

	for _, uiGradient in folder:GetDescendants() do
		if not uiGradient:IsA("UIGradient") then
			continue
		end

		if uiGradient.Name == category then
			uiGradient.Enabled = true
			v3 = true
		else
			uiGradient.Enabled = false
		end
	end

	local base = not v3 and folder:FindFirstChild("Base")

	if base then
		base.Enabled = true
	end
end

function AchievementsWindow:Update()
	local count = 0

	for childName, _ in Data.Get("Achievements") do
		local child = self.Root.Frame.MainList:FindFirstChild(childName)

		if not child then
			continue
		end

		local inner = child.Inner
		local achievement = Achievements[childName]
		local achievementProgress, visible = Util.GetAchievementProgress(Data.Cache, childName)
		local progressNeeded = achievement.ProgressNeeded
		local v3 = not visible and progressNeeded <= achievementProgress
		local category = achievement._Category
		local v4

		if v3 then
			count += 1
			v4 = 0
		else
			v4 = 4000
		end

		child.LayoutOrder = v4 + (not category and 0 or v[category] or 0) + (achievement.PriorityInCategory or 0) - (v2[childName] or 0)
		local claim = inner.claim
		local textLabel = claim.TextLabel

		if visible then
			textLabel.Text = Lang.Get(Lang.Strings.General.Claimed)
			claim:SetAttribute("Selected", true)
			claim.Selectable = false
		elseif v3 then
			textLabel.Text = Lang.Get(Lang.Strings.General.Claim)
			claim:SetAttribute("Selected", false)
			claim.Selectable = true
		else
			local v5 = math.min(achievementProgress, progressNeeded)

			if achievement.DisplayDivisor then
				v5 /= achievement.DisplayDivisor
				progressNeeded /= achievement.DisplayDivisor
			end

			if achievement.ConvertProgressToLevel then
				v5 = Util.XPToLevelAndProgress(v5)
				progressNeeded = Util.XPToLevelAndProgress(progressNeeded)
			end

			if not achievement.NoRoundDisplayNumbers then
				v5 = math.floor(v5)
				progressNeeded = math.ceil(progressNeeded)
			end

			textLabel.Text = `{v5}/{progressNeeded}`
			claim:SetAttribute("Selected", true)
			claim.Selectable = false
		end

		claim.Checkmark.Visible = visible
		SelectUIGradient(inner.title, category)
	end

	achievements.Background.Dot.Visible = count > 0
end

function AchievementsWindow:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { AchievementsWindow })

for k, _ in v2 do
	table.insert(v2, k)
end

table.sort(v2)

for k, v3 in v2 do
	local v4 = v2[v3]
	local v5 = v2[k]
	v2[k] = v4
	v2[v3] = v5
end

return AchievementsWindow