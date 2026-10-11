local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "Lunar" }
	},
	ModelSkins = {
		{ Name = "Golden Commando" },
		{ Name = "Patriot" },
		{ Name = "Elite" },
		{ Name = "Pumpkin" },
		{ Name = "Void" }
	}
}