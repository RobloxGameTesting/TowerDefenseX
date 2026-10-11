local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	GetStatMultipliers = function(items, items2)
		local v = { [true] = 0, [false] = 0 }
		local v2 = { [true] = 0, [false] = 0 }
		local v3 = { [true] = 0, [false] = 0 }
		local v4 = { [true] = 0, [false] = 0 }
		local v5 = { [true] = 0, [false] = 0 }
		local v6 = { [true] = 0, [false] = 0 }
		local v7 = { [true] = 0, [false] = 0 }
		local v8 = { [true] = 0, [false] = 0 }
		local v9 = { [true] = 0, [false] = 0 }
		local v10 = { [true] = 0, [false] = 0 }
		local stunned = false
		local invulnerable = false
		local disabledAbilities = false
		local stealthDetection = false
		local converted = false

		for _, item in pairs(items) do
			local isDebuff = item.IsDebuff
			local amount = item.Amount

			if item.Type == Enums.TowerBuffTypes.Range then
				v[isDebuff] = math.max(v[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Range2 then
				v2[isDebuff] = math.max(v2[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Range3 then
				v3[isDebuff] = math.max(v3[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Firerate then
				v4[isDebuff] = math.max(v4[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Damage then
				v5[isDebuff] = math.max(v5[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Damage2 then
				v6[isDebuff] = math.max(v6[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Damage3 then
				v7[isDebuff] = math.max(v7[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.DeathCashback then
				v8[isDebuff] = math.max(v8[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.EcoBoost then
				v9[isDebuff] = math.max(v9[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Vulnerable then
				v10[isDebuff] = math.max(v10[isDebuff], amount)
			elseif item.Type == Enums.TowerBuffTypes.Stun then
				stunned = true
			elseif item.Type == Enums.TowerBuffTypes.Freeze then
				stunned = true
			elseif item.Type == Enums.TowerBuffTypes.DisableAbilities then
				disabledAbilities = true
			elseif item.Type == Enums.TowerBuffTypes.Uber then
				invulnerable = true
			elseif item.Type == Enums.TowerBuffTypes.Conversion then
				converted = true
			elseif item.Type == Enums.TowerBuffTypes.StealthDetection then
				stealthDetection = true
			end
		end

		if items2 then
			for k, item in pairs(items2) do
				for k2, v11 in pairs(item) do
					if not v11.Active then
						continue
					end

					if k == Enums.TowerBuffTypes.Range then
						v[false] = math.max(v[false], k2)
					elseif k == Enums.TowerBuffTypes.Range2 then
						v2[false] = math.max(v2[false], k2)
					elseif k == Enums.TowerBuffTypes.Range3 then
						v3[false] = math.max(v3[false], k2)
					elseif k == Enums.TowerBuffTypes.Firerate then
						v4[false] = math.max(v4[false], k2)
					elseif k == Enums.TowerBuffTypes.Damage then
						v5[false] = math.max(v5[false], k2)
					elseif k == Enums.TowerBuffTypes.Damage2 then
						v6[false] = math.max(v6[false], k2)
					elseif k == Enums.TowerBuffTypes.Damage3 then
						v7[false] = math.max(v7[false], k2)
					elseif k == Enums.TowerBuffTypes.DeathCashback then
						v8[false] = math.max(v8[false], k2)
					elseif k == Enums.TowerBuffTypes.EcoBoost then
						v9[false] = math.max(v9[false], k2)
					end
				end
			end
		end

		return {
			Stunned = stunned,
			Invulnerable = invulnerable,
			DisabledAbilities = disabledAbilities,
			RangeMultiplier = v[false] - v[true] + v2[false] - v2[true] + v3[false] - v3[true],
			FirerateMultiplier = v4[false] - v4[true],
			DamageMultiplier = v5[false] - v5[true] + v6[false] - v6[true] + v7[false] - v7[true],
			DeathCashbackMultiplier = v8[false] - v8[true],
			StealthDetection = stealthDetection,
			CashPerDamageMultiplier = v9[false] - v9[true],
			Converted = converted
		}
	end
}