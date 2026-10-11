local parent = script.Parent
local v = { parent.Turret1, parent.Turret2, parent.Turret3, parent.Turret4, parent.Turret5 }
local v2 = {
	parent.Mortar1,
	parent.Mortar2,
	parent.Mortar3,
	parent.Mortar4,
	parent.Mortar5,
	parent.Mortar6,
	parent.Mortar7,
	parent.Mortar8
}
local v3 = {
	script.BattleshipMainCannonFire1,
	script.BattleshipMainCannonFire2,
	script.BattleshipMainCannonFire3,
	script.BattleshipMainCannonFire4,
	script.BattleshipMainCannonFire5
}
local v4 = {
	script.BattleshipMortarFire1,
	script.BattleshipMortarFire2,
	script.BattleshipMortarFire3,
	script.BattleshipMortarFire4
}

local function InsertSounds(instance, items)
	for _, model in pairs(instance:GetChildren()) do
		if not (model:IsA("Model") and model.Name:find("Gun")) then
			continue
		end

		local barrel = model:FindFirstChild("Barrel")

		if not barrel then
			continue
		end

		for _, item in pairs(items) do
			local clone = item:Clone()
			clone.Parent = barrel
			clone.Name = "Fire"
		end
	end
end

for _, v5 in pairs(v) do
	InsertSounds(v5, v3)
end

for _, v5 in pairs(v2) do
	InsertSounds(v5, v4)
end

return nil