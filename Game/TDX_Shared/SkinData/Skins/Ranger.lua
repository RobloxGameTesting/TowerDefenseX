local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "WWII" },
		{ Name = "Christmas" },
		{ Name = "Freedom" },
		{ Name = "Cardboard" },
		{ Name = "Party" },
		{ Name = "Dank" }
	},
	ModelSkins = {}
}