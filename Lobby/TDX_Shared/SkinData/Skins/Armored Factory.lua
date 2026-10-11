local parent = script.Parent.Parent
require(parent:WaitForChild("SkinTypes"))
return {
	ColorSkins = {},
	MeshPartSkins = {
		{ Name = "Patriot" },
		{ Name = "Tower Battles" }
	},
	ModelSkins = {
		{ Name = "Clown" },
		{ Name = "Anime" },
		{ Name = "Food" }
	}
}