local Enums = require(script.Parent:WaitForChild("Enums"))
local StickerSizes = Enums.StickerSizes
local StickerRarities = Enums.StickerRarities
local StickerShines = Enums.StickerShines
local StockStatus = Enums.StockStatus
local StickerGrades = Enums.StickerGrades
local StickerPackRarities = Enums.StickerPackRarities
local ShopRarities = Enums.ShopRarities
return {
	MaxNumberOfShopsAtOnce = 1,
	ShopRotationTime = 3600,
	ShopRarityWeightings = {
		[ShopRarities.Legendary] = 1,
		[ShopRarities.Rare] = 50,
		[ShopRarities.Common] = 100
	},
	StickerSizes = {
		StickerSizes.XXL,
		StickerSizes.XL,
		StickerSizes.L,
		StickerSizes.M,
		StickerSizes.S,
		StickerSizes.XS
	},
	StickerGrades = { StickerGrades.BGrade, StickerGrades.Normal },
	StickerGradeWeightings = { [StickerGrades.BGrade] = 1, [StickerGrades.Normal] = 1 },
	StickerSizeWeightings = {
		[StickerSizes.XXL] = 1,
		[StickerSizes.XL] = 5,
		[StickerSizes.L] = 15,
		[StickerSizes.M] = 35,
		[StickerSizes.S] = 60,
		[StickerSizes.XS] = 100
	},
	StickerShineTypes = {
		StickerShines.Matte,
		StickerShines.Glossy,
		StickerShines.Glitter,
		StickerShines.Crystal,
		StickerShines.Star
	},
	StickerShineWeightings = {
		[StickerShines.Matte] = 1,
		[StickerShines.Glossy] = 1,
		[StickerShines.Glitter] = 1,
		[StickerShines.Crystal] = 1,
		[StickerShines.Star] = 1
	},
	StickerRarities = {
		StickerRarities.Legendary,
		StickerRarities.Epic,
		StickerRarities.Rare,
		StickerRarities.Uncommon,
		StickerRarities.Common
	},
	StickerRarityWeightings = {
		[StickerRarities.Legendary] = 1,
		[StickerRarities.Epic] = 5,
		[StickerRarities.Rare] = 15,
		[StickerRarities.Uncommon] = 50,
		[StickerRarities.Common] = 100
	},
	StickerPackRarities = {
		StickerPackRarities.Legendary,
		StickerPackRarities.Epic,
		StickerPackRarities.Rare,
		StickerPackRarities.Uncommon,
		StickerPackRarities.Common
	},
	PackRarityWeightings = {
		[StickerPackRarities.Legendary] = 1,
		[StickerPackRarities.Epic] = 5,
		[StickerPackRarities.Rare] = 15,
		[StickerPackRarities.Uncommon] = 50,
		[StickerPackRarities.Common] = 100
	},
	Colors = {
		StockColors = {
			[StockStatus.InStock] = Color3.fromHex("#00AD2E"),
			[StockStatus.JustMissed] = Color3.fromHex("#FFB300"),
			[StockStatus.OutOfStock] = Color3.fromHex("#AD0006")
		},
		ButtonColors = {
			Primary = {
				Normal = Color3.fromHex("#0AC089"),
				Hover = Color3.fromHex("#4DD1A9"),
				Pressed = Color3.fromHex("#8FF1D4"),
				Disabled = Color3.fromHex("#4A4A4A")
			},
			Secondary = {
				Normal = Color3.fromHex("#185643"),
				Hover = Color3.fromHex("#298166"),
				Pressed = Color3.fromHex("#53B396"),
				Disabled = Color3.fromHex("#757575")
			},
			Text = { Normal = Color3.fromHex("#FFFFFF"), Disabled = Color3.fromHex("#A0A0A0") }
		}
	},
	Icons = {
		Indicator = "rbxassetid://138348021093097",
		Cross = "rbxassetid://116232944599718",
		Clock = "rbxassetid://113569623015761",
		Currency = "rbxassetid://140010274241693",
		Robux = "rbxassetid://127552075529316"
	},
	ShopTileBackground = {
		[StickerPackRarities.Common] = "",
		[StickerRarities.Uncommon] = "rbxassetid://99763167735978",
		[StickerRarities.Rare] = "rbxassetid://108411390044395",
		[StickerRarities.Epic] = "rbxassetid://109509234341594",
		[StickerRarities.Legendary] = "rbxassetid://130506341226288"
	},
	OpenPackRarityBackground = {
		[StickerPackRarities.Common] = "",
		[StickerRarities.Uncommon] = "rbxassetid://106930732642614",
		[StickerRarities.Rare] = "rbxassetid://137508929721455",
		[StickerRarities.Epic] = "rbxassetid://122053190227749",
		[StickerRarities.Legendary] = "rbxassetid://139443255079021"
	},
	ButtonAnimationDuration = 0.15,
	ButtonPressedHoldDuration = 0.12,
	IconButtonHoverScale = 1.2,
	IconButtonPressedScale = 0.9,
	PurchaseCooldown = 0.25,
	StickerEquipSizes = {
		[StickerSizes.XS] = 0.6,
		[StickerSizes.S] = 0.8,
		[StickerSizes.M] = 1,
		[StickerSizes.L] = 1.3,
		[StickerSizes.XL] = 1.6,
		[StickerSizes.XXL] = 2
	},
	ButtonSFX = { Click = "", Hover = "" }
}