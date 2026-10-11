local EconomyEvents = {}
local AnalyticsService = game:GetService("AnalyticsService")
require(script.Parent.CurrencyTypes)

function EconomyEvents.LogSpendCurrencyInShop(instance, p, p2: string, p3: string, p4: number, p5: number)
	if instance:GetAttribute("Developer") then
		return
	end

	AnalyticsService:LogEconomyEvent(
		instance,
		Enum.AnalyticsEconomyFlowType.Sink,
		p,
		p4,
		p5,
		Enum.AnalyticsEconomyTransactionType.Shop.Name,
		p3,
		{
			[Enum.AnalyticsCustomFieldKeys.CustomField01.Name] = "Category - " .. p2
		}
	)
end

function EconomyEvents.LogEarnCurrency(instance, p, p2, p3: number, p4: number)
	if instance:GetAttribute("Developer") then
		return
	end

	AnalyticsService:LogEconomyEvent(
		instance,
		Enum.AnalyticsEconomyFlowType.Source,
		p,
		p3,
		p4,
		Enum.AnalyticsEconomyTransactionType.Gameplay.Name,
		p2
	)
end

function EconomyEvents.LogBuyCurrency(instance, p, p2: string, p3: number, p4: number)
	if instance:GetAttribute("Developer") then
		return
	end

	AnalyticsService:LogEconomyEvent(
		instance,
		Enum.AnalyticsEconomyFlowType.Source,
		p,
		p3,
		p4,
		Enum.AnalyticsEconomyTransactionType.IAP.Name,
		p2
	)
end

function EconomyEvents.LogDailyReward(instance, p: number, p2: number)
	if instance:GetAttribute("Developer") then
		return
	end

	AnalyticsService:LogEconomyEvent(
		instance,
		Enum.AnalyticsEconomyFlowType.Source,
		"Gold",
		p,
		p2,
		Enum.AnalyticsEconomyTransactionType.TimedReward.Name,
		"Daily Reward"
	)
end

function EconomyEvents.LogOnboardingReward(instance, p: string, p2, p3: number, p4: number)
	if instance:GetAttribute("Developer") then
		return
	end

	AnalyticsService:LogEconomyEvent(
		instance,
		Enum.AnalyticsEconomyFlowType.Source,
		p2,
		p3,
		p4,
		Enum.AnalyticsEconomyTransactionType.Onboarding.Name,
		p
	)
end

function EconomyEvents.LogBuyRewindWithGold(instance, p: number, p2: number)
	if instance:GetAttribute("Developer") then
		return
	end

	AnalyticsService:LogEconomyEvent(
		instance,
		Enum.AnalyticsEconomyFlowType.Sink,
		"Gold",
		p,
		p2,
		Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name,
		"Rewind"
	)
end

function EconomyEvents.LogSellSkin(instance, p: string, p2: number, p3: number)
	if instance:GetAttribute("Developer") then
		return
	end

	AnalyticsService:LogEconomyEvent(
		instance,
		Enum.AnalyticsEconomyFlowType.Source,
		"Gold",
		p2,
		p3,
		Enum.AnalyticsEconomyTransactionType.Shop.Name,
		p,
		{ [Enum.AnalyticsCustomFieldKeys.CustomField01.Name] = "Category - Skin" }
	)
end

return EconomyEvents