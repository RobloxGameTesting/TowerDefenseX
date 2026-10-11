local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {},
	ModelSkins = {
		{ Name = "GDA" },
		{ Name = "Biker" },
		{ Name = "Void" },
		{ Name = "Pink" }
	}
}