local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "Ghost" },
		{ Name = "Cardboard" },
		{ Name = "Christmas" },
		{ Name = "Anime" }
	},
	ModelSkins = {}
}