local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "Christmas" }
	},
	ModelSkins = {
		{ Name = "Anime" },
		{ Name = "Evil", DisplayName = "Candy" }
	}
}