local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Ghost Crate",
	ModelType = "GhostCrate",
	Image = "",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Juggernaut_Ghost",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://16262856595"
		},
		{
			Name = "EDJ_Ghost",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://18758253559"
		},
		{
			Name = "Slammer_Ghost",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://18758316902"
		},
		{
			Name = "Railgunner_Ghost",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://18758411763"
		},
		{
			Name = "John_Ghost",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://18758303729"
		},
		{
			Name = "Laser Gunner_Ghost",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://18758343938"
		},
		{
			Name = "Sniper_Ghost",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://18758390361"
		},
		{
			Name = "Missile Trooper_Ghost",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://18758351387"
		},
		{
			Name = "Mine Layer_Ghost",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://18758380641"
		},
		{
			Name = "Grenadier_Ghost",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://18758273602"
		},
		{
			Name = "Shotgunner_Ghost",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://18763488560"
		},
		{
			Name = "Operator_Ghost",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://18758360776"
		}
	}
}