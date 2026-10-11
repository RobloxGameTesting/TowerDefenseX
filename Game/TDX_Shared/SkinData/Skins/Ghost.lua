local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "Christmas" },
		{ Name = "Cowboy" },
		{ Name = "PVP" },
		{ Name = "Hidden" }
	},
	ModelSkins = {
		{ Name = "Elite" },
		{ Name = "Neko" }
	}
}