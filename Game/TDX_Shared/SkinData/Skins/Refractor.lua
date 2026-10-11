local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {},
	ModelSkins = {
		{ Name = "Skeleton" },
		{ Name = "Winter Ops" },
		{ Name = "Calamity" },
		{ Name = "Home Defender" }
	}
}