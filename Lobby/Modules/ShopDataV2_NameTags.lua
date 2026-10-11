local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local NameTagData = require(TDX_Shared.Modules.NameTagData)
local ShopDataV2NameTags = {
	Styles = {
		Blue = { IsOffsale = true },
		Red = { IsOffsale = true },
		Flame = { IsOffsale = true },
		Calamity = { IsOffsale = true },
		Spooky = { IsOffsale = true },
		Glitch = { IsOffsale = true },
		Anniversary2025 = { IsOffsale = true }
	},
	Effects = {
		Lightning = { IsOffsale = true },
		Calamity = { IsOffsale = true },
		TDX = { IsOffsale = true },
		FlameBats = { IsOffsale = true },
		Spooky = { IsOffsale = true },
		Important = { IsOffsale = true },
		Glitch = { IsOffsale = true },
		AnniversaryConfetti2025 = { IsOffsale = true },
		AnniversarySparkler2025 = { IsOffsale = true },
		Aurora = { IsOffsale = true },
		NorthPoleStars = {
			IsOffsale = true,
			LimitedTime = true,
			MinLevel = 0,
			Price = 20,
			Currency = "Cookies",
			PriceInRobux = 125,
			ProductId = 3474378448
		},
		Cookies = { IsOffsale = true },
		ChristmasLights = { IsOffsale = true },
		LunarNewYear2026 = {
			IsOffsale = true,
			LimitedTime = true,
			MinLevel = 0,
			Price = 50,
			Currency = "Envelopes",
			PriceInRobux = 40,
			ProductId = 3539998011
		},
		EasterEggsplosion = { IsOffsale = true, LimitedTime = true, Currency = "Eggs" },
		EasterStickers = {
			IsOffsale = true,
			LimitedTime = true,
			MinLevel = 0,
			Price = 100,
			Currency = "Eggs",
			PriceInRobux = 175,
			ProductId = 3554947117
		},
		EasterGlow = { IsOffsale = true, HideInShop = true, LimitedTime = true, Currency = "Eggs" },
		EasterBunnies = { IsOffsale = true, LimitedTime = true, Currency = "Eggs" },
		ExoVoidsVision = { IsOffsale = true },
		UmbrixVision = { IsOffsale = true },
		VoidsVision = { IsOffsale = true },
		GeneralLeahWorld = { IsOffsale = true },
		VoidDimension = { IsOffsale = true },
		SixSeven = { IsOffsale = true },
		TheVoid = { IsOffsale = true },
		VoidStars = { IsOffsale = true },
		VoidmareGeneralLeah = { IsOffsale = true }
	}
}

for k, effect in NameTagData.Effects do
	ShopDataV2NameTags.Effects[k].Image = effect.Image
end

return ShopDataV2NameTags