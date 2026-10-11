local parent = script.Parent.Parent
local Enums = require(parent:WaitForChild("Enums"))
require(parent:WaitForChild("Types"))
local StickerRarities = Enums.StickerRarities
return { Name = Enums.StickerNames.FirstDateFrog, Image = "", Rarity = StickerRarities.Rare }