local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(TDX_Shared.Modules.DataTemplate)
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Tabs = require(script.Parent.Tabs)
local Shared = require(TDX_Shared.Modules.Shared)
local Data = require(TDX_Shared.Client.Services.Data)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local BattlePass = require(TDX_Shared.Modules.BattlePass)
local Lang = require(TDX_Shared.Modules.Lang)
local Network = require(game.ReplicatedFirst.Client.Network)
local LocalPlayer = Players.LocalPlayer
local BattlePassWindow = { ClassName = script.Name, ClassModule = script }
BattlePassWindow.__index = BattlePassWindow
local v = {
	["NOT STARTED"] = Color3.fromRGB(255, 255, 255),
	INCOMPLETE = Color3.fromRGB(255, 255, 255),
	["IN PROGRESS"] = Color3.fromRGB(255, 200, 0),
	COMPLETED = Color3.fromRGB(180, 255, 0)
}
local v2 = {
	[Enum.GuiState.Idle] = "rbxassetid://93954496571313",
	[Enum.GuiState.Hover] = "rbxassetid://81509616260276",
	[Enum.GuiState.Press] = "rbxassetid://81509616260276"
}
local v3 = {
	active = { normal = "rbxassetid://95382501840852", selected = "rbxassetid://87460704488343" },
	inactive = { normal = "rbxassetid://78914729104591", selected = "rbxassetid://119415381481597" }
}
local v4 = {
	left = {
		"rbxassetid://127356252906666",
		"rbxassetid://81562086893087",
		"rbxassetid://120164736461196",
		"rbxassetid://98579742092558",
		"rbxassetid://92938103888192",
		"rbxassetid://114806854232988"
	},
	middle = {
		"rbxassetid://82203259377500",
		"rbxassetid://98658416909201",
		"rbxassetid://137018402206337",
		"rbxassetid://122334995251216",
		"rbxassetid://134497396733558",
		"rbxassetid://74078166977641"
	},
	right = {
		"rbxassetid://104644830202561",
		"rbxassetid://80332334570747",
		"rbxassetid://99933364290569",
		"rbxassetid://107660394279287",
		"rbxassetid://106608996650789",
		"rbxassetid://80688592156008"
	}
}

local function log(...)
	if RunService:IsStudio() then
		print("[BattlePassWindow]", ...)
	end
end

local function FormatTimeRemaining(now: number, endUnix: number)
	local v5 = math.max(0, endUnix - now)

	if v5 >= 172800 then
		return Lang.Get(Lang.Strings.BattlePass.TimeRemaining.Days, (math.ceil(v5 / 86400)))
	end

	if v5 >= 3600 then
		return Lang.Get(Lang.Strings.BattlePass.TimeRemaining.Hours, (math.ceil(v5 / 3600)))
	end

	return Lang.Get(Lang.Strings.BattlePass.TimeRemaining.Minutes, (math.ceil(v5 / 60)))
end

local function getProgressStatus(childName: string) -- 1 equivalent call inferred from this helper
	local passes = Data.Get("Passes")

	if not passes.Progress[childName] then
		return "NOT STARTED"
	end

	local _, v5, v6 = BattlePass.GetPassProgress(childName, passes.Progress[childName].Tokens)
	local v7

	if v5 == 99999 then
		v7 = v6 == 99999
	else
		v7 = false
	end

	if v7 then
		return "COMPLETED"
	end

	if passes.ActivePass == childName then
		return "IN PROGRESS"
	end

	return "INCOMPLETE"
end

local function setTierState(clone, p: number, flag: boolean, flag2: boolean, flag3: boolean, visible: boolean, p2: string)
	local imageTransparency = 0.5
	local v5

	if p >= 1 then
		v5 = 6
	elseif p >= 0.75 then
		v5 = 5
	elseif p >= 0.5 then
		v5 = 4
	elseif p >= 0.25 then
		v5 = 3
	elseif flag2 then
		v5 = 2
	else
		v5 = 1
	end

	local v6

	if flag or flag2 then
		v6 = "active"
		imageTransparency = not visible and 0 or imageTransparency
	else
		v6 = "inactive"
	end

	clone.bar.Image = v4[p2][v5]
	clone.ImageButton.Image = v3[v6][flag3 and "selected" or "normal"]
	clone.ImageButton.Icon.ImageTransparency = imageTransparency
	clone.ImageButton.check.Visible = visible
end

function BattlePassWindow.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		LastSelected = nil,
		CurrentPass = nil,
		IsPreviewMode = false
	}, BattlePassWindow))
end

function BattlePassWindow:InitBattlePassList()
	local allPasses = BattlePass.GetAllPasses()
	local v5 = {}

	for k, _ in allPasses do
		table.insert(v5, k)
	end

	table.sort(v5, function(a, b)
		return allPasses[a].EndUnix > allPasses[b].EndUnix
	end)
	local currentPass = BattlePass.GetCurrentPass()

	for i, name in ipairs(v5) do
		local allPass = allPasses[name]
		local clone = self.Root.Templates.BattlePassButton:Clone()
		clone.Name = name
		clone.NameLabel.Text = string.upper(Lang.Get(allPass.DisplayName))
		clone.Image = `rbxassetid://{allPass.CardImage}`
		clone.EndDate.Text = DateTime.fromUnixTimestamp(allPass.EndUnix):FormatUniversalTime("L", LocalPlayer.LocaleId)
		clone.Tags.New.Visible = name == currentPass
		local sale = clone.Tags.Sale
		sale.Visible = allPass.UnlockProductInfo ~= nil and allPass.UnlockProductInfo.Sale == true
		clone.LayoutOrder = i
		self.Cleaner:Add(clone:GetPropertyChangedSignal("GuiState"):Connect(function()
			clone.Border.Image = v2[clone.GuiState]
		end))
		local v6 = name
		self.Cleaner:Add(clone.Activated:Connect(function()
			self:ShowPass(v6, Data.Get("Passes").ActivePass ~= v6)
		end))
		clone.Parent = self.Root.BattlePassList.ScrollingFrame
	end

	self:UpdateBattlePassList()
end

function BattlePassWindow:UpdateBattlePassList()
	for childName, _ in BattlePass.GetAllPasses() do
		local progressStatus = getProgressStatus(childName) -- inferred equivalent call
		local child = self.Root.BattlePassList.ScrollingFrame:FindFirstChild(childName)
		child.Status.Text = progressStatus
		child.Status.TextColor3 = v[progressStatus]
	end
end

function BattlePassWindow:Init()
	self.Tabs = Director.GetClassObjectYields(self.Root.Tabs, Tabs)
	self.Tabs:HideAllTabs()
	local passes = Data.Get("Passes")

	if passes then
		local currentPass = BattlePass.GetCurrentPass()
		self.Tabs:SetTabVisible("Active", passes.ActivePass ~= nil)
		self.Tabs:SetTabVisible("All", passes.ActivePass ~= nil)
		self.Tabs:SetTabVisible("Featured", passes.ActivePass ~= currentPass and currentPass ~= nil)
	end

	self.Tabs.OnTabClicked:Connect(function(p: string)
		self.Tabs:SetSelectedTab(p)

		if p == "All" then
			self:ShowPassesList()
		elseif p == "Active" then
			self:ShowPass(Data.Get("Passes").ActivePass, false)
		elseif p == "Featured" then
			self:ShowPass(BattlePass.GetCurrentPass(), true)
		end
	end)
	self.Details = self.Root.BattlePassDetails
	self:InitBattlePassList()
	self.Cleaner:Add(self.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		if self.Root.Visible then
			self:_OnOpen()
		else
			self:_OnClose()
		end
	end))
	local back = self.Details.PreviewInfo.Back
	self.Cleaner:Add(back.Activated:Connect(function()
		self:ShowPassesList()
	end))
	self.Cleaner:Add(back:GetPropertyChangedSignal("GuiState"):Connect(function()
		if back.GuiState == Enum.GuiState.Idle then
			back.Label.TextColor3 = Color3.fromRGB(101, 135, 20)
			back.ImageLabel.Image = "rbxassetid://84861955289548"
		else
			back.Label.TextColor3 = Color3.fromRGB(180, 255, 0)
			back.ImageLabel.Image = "rbxassetid://102259209869236"
		end
	end))
	local v5 = false
	self.Cleaner:Add(Data.Updated:Connect(function(p: string)
		if p ~= "Passes" or v5 then
			return
		end

		v5 = true
		task.defer(function()
			v5 = false

			if self.Root.Parent == nil then
				return
			end

			local passes2 = Data.Get("Passes")

			if self.Root.Visible and self.CurrentPass then
				log("Pass data updated while UI is visible, updating...")
				self:ShowPass(self.CurrentPass, passes2.ActivePass ~= self.CurrentPass)
				self:UpdateQuests()
			end

			local currentPass = BattlePass.GetCurrentPass()
			self.Tabs:SetTabVisible("Active", passes2.ActivePass ~= nil)
			self.Tabs:SetTabVisible("All", passes2.ActivePass ~= nil)
			self.Tabs:SetTabVisible("Featured", passes2.ActivePass ~= currentPass and currentPass ~= nil)
			self:UpdateBattlePassList()
		end)
	end))
	self.Cleaner:Add(self.Details.TierInfo.Buttons.Claim.Activated:Connect(function()
		if Network.Invoke("ClientRequestTierClaim", self.CurrentPass, self.LastSelected.LayoutOrder) then
			SoundHandler.Play("BattlepassClaim")
		end
	end))
	self.Cleaner:Add(self.Details.Unlock.Buttons.Robux.Activated:Connect(function()
		if _G.ALLOW_FREE_BATTLEPASS_UNLOCKING then
			if Network.Invoke("BattlePassRequestFreeUnlock", self.CurrentPass) then
				SoundHandler.Play("HeavyPurchase")
			end
		else
			MarketplaceService:PromptProductPurchase(
				LocalPlayer,
				BattlePass.GetPassData(self.CurrentPass).UnlockProductInfo.ProductId
			)
		end
	end))
	self.Details.Unlock.Buttons.Gift.Visible = _G.BATTLEPASS_GIFTING_ENABLED
	self.Cleaner:Add(self.Details.Unlock.Buttons.Gift.Activated:Connect(function()
		self:PromptGiftPass()
	end))
	self.Cleaner:Add(self.Details.Activate.Buttons.Activate.Activated:Connect(function()
		local activePass = Data.Get("Passes").ActivePass

		if not activePass then
			Network.Invoke("BattlePassRequestActivate", self.CurrentPass)
			return
		end

		self.Details.ActivatePassConfirmation.Description.Text = Lang.Get(
			Lang.Strings.BattlePass.ActivateLabel,
			Lang.Get(BattlePass.GetPassData(activePass).DisplayName)
		)
		self.Details.ActivatePassConfirmation.Visible = true
		self.Details.Darken.Visible = true
	end))
	self.Details.Activate.Buttons.Gift.Visible = _G.BATTLEPASS_GIFTING_ENABLED
	self.Cleaner:Add(self.Details.Activate.Buttons.Gift.Activated:Connect(function()
		self:PromptGiftPass()
	end))
	self.Cleaner:Add(self.Details.ActivatePassConfirmation.Enable.Activated:Connect(function()
		Network.Invoke("BattlePassRequestActivate", self.CurrentPass)
		self.Details.ActivatePassConfirmation.Visible = false
		self.Details.Darken.Visible = false
	end))
	self.Cleaner:Add(self.Details.ActivatePassConfirmation.Cancel.Activated:Connect(function()
		self.Details.ActivatePassConfirmation.Visible = false
		self.Details.Darken.Visible = false
	end))
	self.Cleaner:Add(self.Details.BuyLevel.Activated:Connect(function()
		self:PromptBuyLevel()
	end))
	self.Cleaner:Add(self.Details.TierInfo.Buttons.InProgress.Activated:Connect(function()
		self:PromptBuyLevel()
	end))
	self.Cleaner:Add(self.Details.BuyRemaining.Activated:Connect(function()
		self:PromptBuyRemaining()
	end))
	self.Cleaner:Add(self.Details.BuyDoubleTokens.Activated:Connect(function()
		MarketplaceService:PromptProductPurchase(LocalPlayer, Shared.DOUBLE_TOKENS_ID)
	end))
	self.Cleaner:Add(self.Details.QuestsButton.Activated:Connect(function()
		self:UpdateQuests()
		self.Details.Quests.Visible = not self.Details.Quests.Visible
		self.Details.Darken.Visible = self.Details.Quests.Visible
		Network.Fire("ClientHasSeenBattlePassQuestsRequest")
	end))
	self.Cleaner:Add(self.Details.Quests.Refresh.Activated:Connect(function()
		MarketplaceService:PromptProductPurchase(LocalPlayer, Shared.PASS_QUESTS_REFRESH_PRODUCT_ID)
	end))
	self.Cleaner:Add(self.Details.Quests.Close.Activated:Connect(function()
		self.Details.Quests.Visible = false
		self.Details.Darken.Visible = false
	end))
	self.Cleaner:Add(self.Details.Quests.NoQuests.Refresh.Activated:Connect(function()
		MarketplaceService:PromptProductPurchase(LocalPlayer, Shared.PASS_QUESTS_REFRESH_PRODUCT_ID)
	end))

	for i = 1, 3 do
		local child = self.Details.Quests.Frame:FindFirstChild("Quest" .. i)
		self.Cleaner:Add(child.claim.Activated:Connect(function()
			Network.Fire("ClientClaimBattlePassQuestRequest", child.claim:GetAttribute("QuestId"))
		end))
	end

	task.spawn(function()
		while true do
			task.wait(1)
			self:UpdateTime()
		end
	end)
	self.Details.GiftPass.Visible = _G.BATTLEPASS_GIFTING_ENABLED
	self.Details.GiftPass.Activated:Connect(function()
		self:PromptGiftPass()
	end)
end

function BattlePassWindow:_OnOpen()
	log("OnOpen()")
	local activePass = Data.Get("Passes").ActivePass

	if activePass == nil then
		self:ShowPassesList()
	else
		self:ShowPass(activePass, false)
	end
end

function BattlePassWindow:_OnClose()
	log("OnClose()")
	self.CurrentPass = nil
end

function BattlePassWindow:UpdateQuests()
	local passData = BattlePass.GetPassData(self.CurrentPass)
	local v5 = Data.Get("Passes").Progress[self.CurrentPass]
	local visible = next(v5.Quests) ~= nil
	local quests = self.Details.Quests
	quests.NoQuests.Visible = not visible
	quests.Frame.Visible = visible
	quests.Refresh.Visible = visible

	if visible then
		local count = 0

		for k, quest in v5.Quests do
			count += 1
			local child = quests.Frame:FindFirstChild("Quest" .. count)

			if not child then
				continue
			end

			local quest2 = passData.Quests[k]
			child.reward.Text = `{quest2.TokenReward} Tokens`
			child.description.Text = Lang.Get(Lang.Strings.BattlePass.QuestDescriptions[k]) or "???"
			child.progress.Visible = quest.MaxProgress > 1
			child.progress.Text = `{quest.Progress}/{quest.MaxProgress}`
			local visible2 = quest.Progress >= quest.MaxProgress
			child.claim.Visible = visible2
			child.inprogress.Visible = not visible2
			child.claim:SetAttribute("QuestId", k)
		end

		local findFirstChild = quests.Frame:FindFirstChild("Quest" .. 1)
		findFirstChild.Visible = count >= 1
		local findFirstChild_2 = quests.Frame:FindFirstChild("Quest" .. 2)
		findFirstChild_2.Visible = count >= 2
		local findFirstChild_3 = quests.Frame:FindFirstChild("Quest" .. 3)
		findFirstChild_3.Visible = count >= 3
	end
end

function BattlePassWindow:UpdateSelection(p: string, p2: number)
	local passData = BattlePass.GetPassData(p)
	local currentPass = BattlePass.GetCurrentPass()
	local passes = Data.Get("Passes")
	local v5 = passes.Progress[p]
	local v6 = passData and passData.Tiers[p2]

	if v6 then
		local v7 = not v5 and 0 or v5.Tokens or 0
		local passProgress = BattlePass.GetPassProgress(p, v7)
		local v8 = ""

		if passProgress < p2 then
			v8 = "Locked"
		elseif p2 == passProgress then
			v8 = "InProgress"
		elseif p2 < passProgress then
			v8 = v5 and v5.Tiers[p2] and v5.Tiers[p2].Awarded and "Claimed" or "Claim"
		end

		for _, guiObject in self.Details.TierInfo.Buttons:GetChildren() do
			if not (guiObject:IsA("ImageLabel") or guiObject:IsA("ImageButton")) then
				continue
			end

			guiObject.Visible = guiObject.Name == v8

			if guiObject.Name == "Locked" and guiObject.Visible then
				guiObject.ItemName.Text = Lang.Get(Lang.Strings.BattlePass.TierRequired, p2)
			end
		end

		self.Details.Activate.Visible = false
		self.Details.Unlock.Visible = false
		self.Details.bigicon.ImageTransparency = 0
		self.Details.bigicon.Image = v6.Image
		self.Details.TierInfo.Buttons.Visible = true
		self.Details.TierInfo.itemname.Text = Lang.Get(v6.LangKey, v6.Prize.Amount)
		self.Details.TierInfo.tier.Text = Lang.Get(
			Lang.Strings.BattlePass.TierName,
			p2,
			Lang.Get(Lang.Strings.BattlePass.DisplayTypes[v6.Prize.Type])
		)

		if v8 == "InProgress" or v8 == "Locked" then
			if (v5 and v5.Unlocked or p == currentPass) and passes.ActivePass ~= p then
				self.Details.Activate.Visible = true
				self.Details.Activate.Buttons.Gift.Visible = p ~= currentPass
				self.Details.bigicon.ImageTransparency = 0.5
			elseif p ~= currentPass and not (v5 and v5.Unlocked) and passData.UnlockProductInfo then
				self.Details.Unlock.Visible = true

				if _G.ALLOW_FREE_BATTLEPASS_UNLOCKING then
					self.Details.Unlock.Buttons.Robux.TextLabel.Text = "FREE!"
				else
					self.Details.Unlock.Buttons.Robux.TextLabel.Text = `{utf8.char(57346)} {passData.UnlockProductInfo.ProductDisplayPrice}`
				end

				self.Details.TierInfo.Buttons.Visible = false
				self.Details.bigicon.ImageTransparency = 0.5
			end
		end

		local refundAmount = v6.Prize.RefundAmount
		local towerLangKey = v6.TowerLangKey
		self.Details.TierInfo.refund.Visible = refundAmount ~= nil

		if refundAmount ~= nil then
			self.Details.TierInfo.refund.Text = Lang.Get(Lang.Strings.BattlePass.RefundLabel, refundAmount)
		end

		self.Details.TierInfo.towername.Text = towerLangKey and Lang.Get(towerLangKey) or ""
	end
end

function BattlePassWindow:UpdateLevelInfo(p: string, flag: boolean?)
	local passData = BattlePass.GetPassData(p)
	local v5 = not Data.Get("Passes").Progress[p] and 0 or Data.Get("Passes").Progress[p].Tokens
	local passProgress, v6, v7 = BattlePass.GetPassProgress(p, v5)
	local skipProductId = passData.Tiers[passProgress] and passData.Tiers[passProgress].SkipProductId
	local v8

	if v6 == 99999 then
		v8 = v7 == 99999
	else
		v8 = false
	end

	self.Details.LevelInfo.Next.Visible = passData.Tiers[passProgress + 1] ~= nil
	self.Details.LevelInfo.Next.TextLabel.Text = passProgress + 1
	self.Details.LevelInfo.Current.TextLabel.Text = math.min(passProgress, #passData.Tiers)
	self.Details.LevelInfo.Bar.Fill.Position = UDim2.new(math.clamp(v6 / v7, 0, 1), 0, 0, 0)
	self.Details.LevelInfo.XP.TextLabel.Text = v8 and "Complete" or `{math.floor(v6)}/{math.floor(v7)}`
	self.Details.LevelInfo.XP.TextLabel.TextColor3 = v8 and Color3.fromHex("b4ff00") or Color3.fromHex("ffffff")
	local buyLevel = self.Details.BuyLevel
	buyLevel.Visible = skipProductId ~= nil and skipProductId > 0 and not flag
	local buyRemaining = self.Details.BuyRemaining
	local visible = not v8

	if visible then
		if passData.PurchaseRemainingTiersInfo == nil or passData.PurchaseRemainingTiersInfo.Enabled ~= true then
			visible = false
		else
			visible = not flag and passData.Tiers[passProgress].BuyRemainingProductId ~= nil
		end
	end

	buyRemaining.Visible = visible
end

function BattlePassWindow:UpdateTime()
	local currentPass = BattlePass.GetCurrentPass()

	if self.CurrentPass == currentPass and currentPass ~= nil then
		local text = FormatTimeRemaining(os.time(), BattlePass.GetPassData(currentPass).EndUnix)
		self.Details.Info.TimeRemaining.Text = text
		self.Details.PreviewInfo.TimeRemaining.Text = text
	end

	local visible = Data.Get("DoubleTokenTimer") > os.time()
	self.Details.DoubleTokensLength.Visible = visible
	self.Root.BattlePassList.DoubleTokensLength.Visible = visible
	self.Details.BuyDoubleTokens.Visible = not visible and Data.Get("Passes").ActivePass == self.CurrentPass

	if visible then
		local v5 = Data.Get("DoubleTokenTimer") - os.time()
		local formatted = `2X TOKENS ACTIVE: {string.format("%02d:%02d", v5 // 60, v5 % 60)}`
		self.Details.DoubleTokensLength.Text = formatted
		self.Root.BattlePassList.DoubleTokensLength.Text = formatted
	end
end

function BattlePassWindow:ShowPassesList()
	self.Tabs:SetSelectedTab("All")
	self.Root.Image = `rbxassetid://{BattlePass.GetPassData("TB").FrameImage}`
	self.Root.Background.Visible = false
	self.Root.BattlePassDetails.Visible = false
	self.Root.BattlePassList.Visible = true
	self.CurrentPass = nil
	self.IsPreviewMode = false
end

function BattlePassWindow:ApplyTheme(p: string)
	local colors = BattlePass.GetPassData(p).Colors or BattlePass.GetPassData("TB").Colors

	for _, guiObject in self.Details:GetDescendants() do
		if not guiObject:IsA("GuiObject") then
			continue
		end

		if guiObject:GetAttribute("ThemeTextColor") then
			guiObject.TextColor3 = colors[guiObject:GetAttribute("ThemeTextColor")]
		end

		if guiObject:GetAttribute("ThemeImageColor") then
			guiObject.ImageColor3 = colors[guiObject:GetAttribute("ThemeImageColor")]
		end

		if guiObject:GetAttribute("ThemeBackgroundColor") then
			guiObject.BackgroundColor3 = colors[guiObject:GetAttribute("ThemeBackgroundColor")]
		end

		if not (guiObject:HasTag("ClickEffect3") and guiObject:GetAttribute("AutoApplyThemeColors")) then
			continue
		end

		guiObject:SetAttribute("DefaultTextColor", colors.Primary)
		guiObject:SetAttribute("HoverTextColor", colors.Secondary)
		guiObject.ImageColor3 = colors.Primary
		guiObject.label.TextColor3 = colors.Primary

		if guiObject:FindFirstChild("HoverState") then
			guiObject.HoverState.ImageColor3 = colors.Primary
		end

		if guiObject:FindFirstChild("ClickState") then
			guiObject.ClickState.ImageColor3 = colors.Primary
		end
	end
end

function BattlePassWindow:ShowPass(currentPass: string, flag: boolean)
	local passData = BattlePass.GetPassData(currentPass)

	if not passData then
		warn(`[BattlePassWindow] Cannot show non-existent pass {currentPass}`)
		return
	end

	log(`Showing {currentPass}, isPreview = {flag}, current = {self.CurrentPass}`)
	local flag2 = false

	if currentPass == self.CurrentPass then
		flag2 = true
	else
		self.LastSelected = nil
		self.Details.Quests.Visible = false
		self.Details.ActivatePassConfirmation.Visible = false
		self.Details.Darken.Visible = false
	end

	self.CurrentPass = currentPass
	self.IsPreviewMode = flag
	local passes = Data.Get("Passes")
	local v5 = passes.Progress[currentPass]
	local visible = currentPass == BattlePass.GetCurrentPass()

	if currentPass == passes.ActivePass then
		self.Tabs:SetSelectedTab("Active")
	elseif visible then
		self.Tabs:SetSelectedTab("Featured")
	end

	self:UpdateLevelInfo(currentPass, flag)
	self:UpdateTime()
	self:ApplyTheme(currentPass)
	self.Root.Image = `rbxassetid://{passData.FrameImage}`
	self.Root.Background.Visible = passData.BackgroundImage ~= nil
	self.Root.Background.Image = not passData.BackgroundImage and "" or `rbxassetid://{passData.BackgroundImage}`
	self.Root.BattlePassDetails.Visible = true
	self.Root.BattlePassList.Visible = false
	self.Details.ActivatePassConfirmation.Visible = false
	self.Details.BuyDoubleTokens.Visible = not flag and Data.Get("DoubleTokenTimer") < os.time()
	self.Details.QuestsButton.Visible = not flag and next(passData.Quests) ~= nil

	if passData.PurchaseRemainingTiersInfo ~= nil then
		self.Details.BuyRemaining.Discount.Label.Text = `{passData.PurchaseRemainingTiersInfo.Discount}% SAVINGS`
	end

	self.Details.Info.Visible = not flag
	self.Details.PreviewInfo.Visible = flag
	self.Details.Info.TimeRemaining.Visible = visible
	self.Details.PreviewInfo.TimeRemaining.Visible = visible
	self.Details.GiftPass.Visible = _G.BATTLEPASS_GIFTING_ENABLED and not (flag or visible);
	(flag and self.Root.BattlePassDetails.PreviewInfo or self.Root.BattlePassDetails.Info).DisplayName.Text = string.upper(Lang.Get(passData.DisplayName))
	self.Details.UnlockInfo.Visible = false

	if _G.ALLOW_FREE_BATTLEPASS_UNLOCKING and v5 and v5.WasUnlockedForFree and not flag then
		local v6 = math.floor(v5.Tokens - (v5.TokensWhenUnlockedForFree or 0))
		local TOKENS_TO_KEEP_FREE_BATTLEPASSES = _G.TOKENS_TO_KEEP_FREE_BATTLEPASSES
		self.Details.UnlockInfo.XP.Text = `{v6}/{TOKENS_TO_KEEP_FREE_BATTLEPASSES}`
		self.Details.UnlockInfo.Bar.Fill.Position = UDim2.new(
			math.clamp(v6 / TOKENS_TO_KEEP_FREE_BATTLEPASSES, 0, 1),
			0,
			0,
			0
		)
		local visible2 = TOKENS_TO_KEEP_FREE_BATTLEPASSES <= v6
		self.Details.UnlockInfo.CompletedTitle.Visible = visible2
		self.Details.UnlockInfo.InProgressTitle.Visible = not visible2
		self.Details.UnlockInfo.XP.Visible = not visible2
		self.Details.UnlockInfo.Bar.Visible = not visible2
		self.Details.UnlockInfo.Visible = true
	end

	local scrollingFrame = self.Root.BattlePassDetails.tiers.ScrollingFrame
	local template = scrollingFrame.template
	template.Visible = false

	for _, child in scrollingFrame:GetChildren() do
		if child:IsA(template.ClassName) and child.Name ~= "template" then
			child:Destroy()
		end
	end

	local layoutOrder

	if flag2 and self.LastSelected then
		layoutOrder = self.LastSelected.LayoutOrder
	end

	local v6 = not v5 and 0 or v5.Tokens or 0
	local passProgress, v7, v8 = BattlePass.GetPassProgress(currentPass, v6)
	local v9 = math.min(passProgress, #passData.Tiers)
	local v10 = template.Size.X.Scale * #passData.Tiers

	for k, tier in passData.Tiers do
		if k > 1 then
			v10 += scrollingFrame.UIListLayout.Padding.Scale
		end

		local visible2 = v5 and v5.Tiers[k] and v5.Tiers[k].Awarded and true or false
		local v11 = (flag2 and k == layoutOrder or not flag2 and v9 == k) and true or false
		local clone = template:Clone()
		clone.Visible = true
		clone.Name = k
		clone.ImageButton.Icon.Image = tier.Image
		clone.bar.TextLabel.Text = k
		clone.LayoutOrder = k
		setTierState(
			clone,
			k < v9 and 1 or k ~= v9 and 0 or v7 / v8,
			k < v9,
			v9 == k,
			v11,
			visible2,
			k == 1 and "left" or k == #passData.Tiers and "right" or "middle"
		)

		if v11 then
			self.LastSelected = clone
			self:UpdateSelection(currentPass, k)
		end

		clone.ImageButton.MouseButton1Click:Connect(function()
			local v12 = not Data.Get("Passes").Progress[currentPass] and 0
				or Data.Get("Passes").Progress[currentPass].Tokens

			if self.LastSelected then
				local passProgress2, v13, v14 = BattlePass.GetPassProgress(currentPass, v12)
				local layoutOrder2 = self.LastSelected.LayoutOrder
				local lastSelected = self.LastSelected
				local v15 = layoutOrder2 < passProgress2 and 1 or layoutOrder2 ~= passProgress2 and 0 or v13 / v14
				local v16 = layoutOrder2 < passProgress2
				local v17 = passProgress2 == layoutOrder2
				local v18

				if v5 and v5.Tiers[layoutOrder2] then
					v18 = v5.Tiers[layoutOrder2].Awarded or false
				else
					v18 = false
				end

				setTierState(
					lastSelected,
					v15,
					v16,
					v17,
					false,
					v18,
					layoutOrder2 == 1 and "left" or layoutOrder2 == #passData.Tiers and "right" or "middle"
				)
			end

			self.LastSelected = clone
			local passProgress2, v13, v14 = BattlePass.GetPassProgress(currentPass, v12)
			local layoutOrder2 = clone.LayoutOrder
			local v15 = layoutOrder2 < passProgress2 and 1 or layoutOrder2 ~= passProgress2 and 0 or v13 / v14
			local v16 = layoutOrder2 < passProgress2
			local v17 = passProgress2 == layoutOrder2
			local v18

			if v5 and v5.Tiers[layoutOrder2] then
				v18 = v5.Tiers[layoutOrder2].Awarded or false
			else
				v18 = false
			end

			setTierState(
				clone,
				v15,
				v16,
				v17,
				true,
				v18,
				layoutOrder2 == 1 and "left" or layoutOrder2 == #passData.Tiers and "right" or "middle"
			)
			self:UpdateSelection(currentPass, layoutOrder2)
		end)
		clone.Parent = scrollingFrame
	end

	scrollingFrame.CanvasSize = UDim2.new(v10, 0, 0, 0)

	if not flag2 then
		scrollingFrame.CanvasPosition = Vector2.zero
	end

	task.defer(function()
		if self.LastSelected == nil or flag2 then
			return
		end

		local v11 = scrollingFrame.AbsoluteSize.X * 0.5
		local v12 = math.clamp(
			self.LastSelected.AbsolutePosition.X - scrollingFrame.AbsolutePosition.X - v11,
			0,
			scrollingFrame.AbsoluteSize.X * v10
		)

		if v12 > 0 then
			scrollingFrame.CanvasPosition = Vector2.new(v12 + self.LastSelected.AbsoluteSize.X * 0.5, 0)
		end
	end)
end

function BattlePassWindow:PromptBuyLevel()
	if self.IsPreviewMode or self.CurrentPass ~= Data.Get("Passes").ActivePass then
		return
	end

	local passData = BattlePass.GetPassData(self.CurrentPass)
	local v5 = Data.Get("Passes").Progress[self.CurrentPass]

	if passData and v5 then
		local passProgress = BattlePass.GetPassProgress(self.CurrentPass, v5.Tokens)
		local skipProductId = passData.Tiers[passProgress].SkipProductId

		if skipProductId and skipProductId > 0 then
			MarketplaceService:PromptProductPurchase(LocalPlayer, skipProductId)
		end
	end
end

function BattlePassWindow:PromptBuyRemaining()
	if self.IsPreviewMode or self.CurrentPass ~= Data.Get("Passes").ActivePass then
		return
	end

	local passData = BattlePass.GetPassData(self.CurrentPass)
	local v5 = Data.Get("Passes").Progress[self.CurrentPass]

	if passData and v5 then
		local passProgress = BattlePass.GetPassProgress(self.CurrentPass, v5.Tokens)
		local buyRemainingProductId = passData.Tiers[passProgress].BuyRemainingProductId

		if buyRemainingProductId and buyRemainingProductId > 0 then
			MarketplaceService:PromptProductPurchase(LocalPlayer, buyRemainingProductId)
		end
	end
end

function BattlePassWindow:PromptGiftPass()
	local currentPass = self.CurrentPass

	if not currentPass then
		return
	end

	local formatted = `Battle Pass - {Lang.Get(BattlePass.GetPassData(currentPass).DisplayName)}`
	local firstItem = Director.GetFirstItemFromClass(Director.Classes.GiftingWindow)
	firstItem:SetTargetPlayerId(nil, nil)
	firstItem:SetTargetGift("BattlePass", currentPass, formatted)
	Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("Gifting", function() end)
end

function BattlePassWindow:Destroy()
	self.Cleaner:Clean()
end

if _G.BATTLEPASS_REWORK_ENABLED then
	Director.Register(script.Name, { BattlePassWindow }, game.Players)
end

return BattlePassWindow