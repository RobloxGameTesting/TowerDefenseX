local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "Combat" },
		{ Name = "Summer" },
		{ Name = "Winter Ops" }
	},
	ModelSkins = {
		{ Name = "Plague Doctor" },
		{ Name = "Real" },
		{ Name = "Hidden" }
	}
}