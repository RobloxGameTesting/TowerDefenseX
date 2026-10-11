local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "GDA" },
		{ Name = "Substitute" },
		{ Name = "Pirate" },
		{ Name = "Pumpkin" }
	},
	ModelSkins = {
		{ Name = "Lifeguard" },
		{ Name = "Melu" },
		{ Name = "Easter" },
		{ Name = "Void" },
		{ Name = "Statue" }
	}
}