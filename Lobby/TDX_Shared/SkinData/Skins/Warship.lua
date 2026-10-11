local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "United" },
		{ Name = "Gold" }
	},
	ModelSkins = {}
}