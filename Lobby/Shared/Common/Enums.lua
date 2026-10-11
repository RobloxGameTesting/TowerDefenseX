local Enums = {
	ShopNames = { FrogsAreTheBest = "Frogs Are The Best" },
	ShopRarities = { Common = "Common", Rare = "Rare", Legendary = "Legendary" },
	StickerRarities = {
		Common = "Common",
		Uncommon = "Uncommon",
		Rare = "Rare",
		Epic = "Epic",
		Legendary = "Legendary"
	},
	StickerShines = {
		Matte = "Matte",
		Glossy = "Glossy",
		Glitter = "Glitter",
		Crystal = "Crystal",
		Star = "Star"
	},
	StickerSizes = {
		XS = "XS",
		S = "S",
		M = "M",
		L = "L",
		XL = "XL",
		XXL = "XXL"
	},
	StickerGrades = { BGrade = "B-Grade", Normal = "Perfect" },
	StickerPackNames = {
		FroggyLovePack = "Froggy Love Pack",
		FroggyHappyPack = "Froggy Happy Pack"
	},
	StockStatus = { InStock = "In Stock", OutOfStock = "Out of Stock", JustMissed = "Just Missed" },
	StickerPackRarities = {
		Common = "Common",
		Uncommon = "Uncommon",
		Rare = "Rare",
		Epic = "Epic",
		Legendary = "Legendary"
	},
	StickerNames = {
		Froggy = "Froggy",
		FrogInLove = "Frog in Love",
		FirstDateFrog = "Froggy First Date"
	},
	ShopCategories = { StickerPacks = "StickerPacks" },
	ButtonStates = {
		Normal = "Normal",
		Hover = "Hover",
		Pressed = "Pressed",
		Disabled = "Disabled"
	},
	InventoryItemTypes = { StickerPack = "StickerPack", Sticker = "Sticker" }
}
table.freeze(Enums)
return Enums