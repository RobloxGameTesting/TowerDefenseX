local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local EnemyBuffUtilities = {}

function EnemyBuffUtilities.GetVFXScaleForModel(object)
	local extentsSize = object:GetExtentsSize()
	return math.max(extentsSize.X, extentsSize.Y, extentsSize.Z) / 2.0759999752044678
end

function EnemyBuffUtilities.GetStatMultipliers(items)
	local v = { [true] = 0, [false] = 0 }
	local v2 = { [true] = 0, [false] = 0 }
	local v3 = { [true] = 0, [false] = 0 }
	local v4 = { [true] = 0, [false] = 0 }
	local invulnerable = false

	for _, item in pairs(items) do
		local isDebuff = item.IsDebuff
		local amount = item.Amount

		if item.Type == Enums.EnemyBuffTypes.MovementSpeed then
			v[isDebuff] = math.max(v[isDebuff], amount)
		elseif item.Type == Enums.EnemyBuffTypes.Damage then
			v2[isDebuff] = math.max(v2[isDebuff], amount)
		elseif item.Type == Enums.EnemyBuffTypes.Range then
			v3[isDebuff] = math.max(v3[isDebuff], amount)
		elseif item.Type == Enums.EnemyBuffTypes.DamageResistance then
			v4[isDebuff] = math.max(v4[isDebuff], amount)
		elseif item.Type == Enums.EnemyBuffTypes.Uber then
			invulnerable = true
		end
	end

	return {
		MovementSpeedMultiplier = v[false] - v[true],
		DamageMultiplier = v2[false] - v2[true],
		RangeMultiplier = v3[false] - v3[true],
		DamageResistanceModifier = v4[false] - v4[true],
		Invulnerable = invulnerable
	}
end

return EnemyBuffUtilities