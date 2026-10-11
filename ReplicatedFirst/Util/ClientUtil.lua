local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local ResourceManager = require(Common.ResourceManager)
local Crates = require(TDX_Shared.Modules.Crates)
local Data = require(TDX_Shared.Client.Services.Data)
local ShopDataV2 = require(game.ReplicatedStorage.Modules.ShopDataV2)
require(game.ReplicatedStorage.Modules.ShopUtil)
local Network = require(game.ReplicatedFirst.Client.Network)
local v = {}
local frozen = nil
Data.Updated:Connect(function(p)
	if p == "Inventory" then
		frozen = nil
	end
end)

function v.OwnsSkin(p: string, p2: string)
	if p2 == "" then
		return true
	end

	local formatted = `{p}_{p2}`
	return v.GetOwnedSkinsSet()[formatted] == true
end

function v.GetOwnedSkinsSet()
	if frozen then
		return frozen
	end

	local v2 = {}
	local inventory = Data.Get("Inventory")

	if inventory and inventory.Skins then
		for _, skin in inventory.Skins do
			v2[skin] = true
		end
	end

	frozen = table.freeze(v2)
	return frozen
end

function v.OwnsAllCrateSkins(p: string)
	local crateData = Crates.GetCrateData(p)

	if not crateData.NoDupes then
		return false
	end

	for _, skin in crateData.Skins do
		local v2, v3 = unpack(string.split(skin.Name, "_"))

		if not v.OwnsSkin(v2, v3) then
			return false
		end
	end

	return true
end

function v.OwnsItem(p, value: string)
	if p == "Towers" then
		return Data.Get("Inventory").Towers[value]
	elseif p == "Skins" then
		local v2, v3 = unpack(string.split(value, "_"))
		return v.OwnsSkin(v2, v3)
	elseif p == "NameTagEffects" then
		return Data.Get("Inventory").NameTagEffects[value]
	elseif p == "Crates" then
		return v.OwnsAllCrateSkins(value)
	elseif p == "Emotes" then
		return Data.Get("Inventory").Emotes[value]
	elseif p == "Enemies" then
		return Data.Get("Inventory").Enemies[value]
	elseif p == "PowerUps" then
		return (Data.Get("Inventory").PowerUps[value] or 0) > 0
	end

	if p ~= "Bundles" then
		warn(`Unsupported/unimplemented OwnsItem check for category {p}`)
		return false
	end

	for k, content in ShopDataV2.Items.Bundles[value].Contents do
		for _, v2 in content do
			if not v.OwnsItem(k, v2) then
				return false
			end
		end
	end

	return true
end

function v.IsItemEquipped(p, value: string)
	if p == "Towers" then
		return table.find(Data.Get("Loadout"), value) ~= nil
	elseif p == "Skins" then
		local v2, v3 = unpack(string.split(value, "_"))
		return Data.Get("TowerSkins")[v2] == v3
	elseif p == "Emotes" then
		return table.find(Data.Get("Emotes"), value) ~= nil
	end

	if p == "PowerUps" then
		local powerUp = ShopDataV2.Items.PowerUps[value]

		if not (powerUp and powerUp.PVPOnly) then
			return table.find(Data.Get("PowerUpsLoadout"), value) ~= nil
		end

		local pvpPowerUpsLoadout = Data.Get("PVPPowerUpsLoadout")

		if pvpPowerUpsLoadout then
			for _, v2 in pvpPowerUpsLoadout do
				if v2 == value then
					return true
				end
			end
		end

		return false
	else
		if p == "NameTagEffects" then
			return Data.Get("NameTagEffect") == value
		elseif p == "Enemies" then
			return table.find(Data.Get("EnemiesLoadout"), value) ~= nil
		elseif p == "Crates" then
			return false
		end

		warn(`Unsupported/unimplemented IsItemEquipped check for category {p}`)
		return false
	end
end

function v.EquipItem(p, value: string)
	if p == "Towers" then
		local loadout = Data.Get("Loadout")
		local flag = false

		for i = 1, 6 do
			if not (loadout[i] == "" or loadout[i] == nil) then
				continue
			end

			loadout[i] = value
			flag = true
			break
		end

		if flag then
			Network.Fire("UpdateLoadout", loadout)
			Data.Set("Loadout", loadout)
		end

		return flag
	elseif p == "Enemies" then
		local enemiesLoadout = Data.Get("EnemiesLoadout")
		local flag = false

		for i = 1, #Data.Get("EnemiesLoadout") do
			if not (enemiesLoadout[i] == "" or enemiesLoadout[i] == nil) then
				continue
			end

			enemiesLoadout[i] = value
			flag = true
			break
		end

		if flag then
			Network.Fire("UpdateEnemiesLoadout", enemiesLoadout)
			Data.Set("EnemiesLoadout", enemiesLoadout)
		end

		return flag
	elseif p == "Skins" then
		local v2, v3 = unpack(string.split(value, "_"))
		Network.Fire("ClientSetSkinRequest", v2, v3)
		Data.Update("TowerSkins", function(p2)
			p2[v2] = v3
			return p2
		end)
		return true
	elseif p == "Emotes" then
		local v2 = 0

		for i = 1, 6 do
			local v3 = Data.Get("Emotes")[i]

			if not (v3 == "" or v3 == nil) then
				continue
			end

			v2 = i
			break
		end

		if v2 == 0 then
			return false
		end

		local v3 = Network.Invoke("ClientEquipEmoteRequest", value, v2)

		if v3 then
			Data.Update("Emotes", function(options)
				local selected = options or {}
				selected[v2] = value
				return selected
			end)
		end

		return v3
	elseif p == "PowerUps" then
		local powerUp = ShopDataV2.Items.PowerUps[value]

		if powerUp and powerUp.PVPOnly then
			local regularPowerUpConfig = ResourceManager.GetRegularPowerUpConfig(value)

			if not regularPowerUpConfig or Data.Get("PVPPowerUpsLoadout")[regularPowerUpConfig.Category] ~= "" then
				return false
			end

			Network.Fire("ClientEquipPowerUpRequest", value)
			return true
		else
			local v2 = 0

			for i = 1, game.Players.LocalPlayer:GetAttribute("VIP") and 6 or 4 do
				local v3 = Data.Get("PowerUpsLoadout")[i]

				if not (v3 == "" or v3 == nil) then
					continue
				end

				v2 = i
				break
			end

			if v2 > 0 then
				Network.Fire("ClientEquipPowerUpRequest", value)
				Data.Update("PowerUpsLoadout", function(options)
					local selected = options or {}
					selected[v2] = value
					return selected
				end)
				return true
			else
				return false
			end
		end
	elseif p == "NameTagEffects" then
		Network.Fire("ClientRequestEquipNameTagEffect", value)
		return true
	else
		warn(`Unsupported/unimplemented EquipItem check for category {p}`)
		return false
	end
end

function v.UnequipItem(p, value: string)
	if p == "Towers" then
		local loadout = Data.Get("Loadout")
		local index = table.find(loadout, value)

		if not index then
			return false
		end

		loadout[index] = ""
		Network.Fire("UpdateLoadout", loadout)
		Data.Set("Loadout", loadout)
		return true
	elseif p == "Enemies" then
		local enemiesLoadout = Data.Get("EnemiesLoadout")
		local index = table.find(enemiesLoadout, value)

		if not index then
			return false
		end

		enemiesLoadout[index] = ""
		Network.Fire("UpdateEnemiesLoadout", enemiesLoadout)
		Data.Set("EnemiesLoadout", enemiesLoadout)
		return true
	elseif p == "Skins" then
		local v2 = string.split(value, "_")[1]
		Network.Fire("ClientSetSkinRequest", v2, "")
		Data.Update("TowerSkins", function(p2)
			p2[v2] = ""
			return p2
		end)
		return true
	elseif p == "Emotes" then
		local v2 = 0

		for i = 1, 6 do
			if Data.Get("Emotes")[i] ~= value then
				continue
			end

			v2 = i
			break
		end

		if v2 == 0 or not Network.Invoke("ClientEquipEmoteRequest", "", v2) then
			return false
		end

		Data.Update("Emotes", function(options)
			local selected = options or {}
			selected[v2] = ""
			return selected
		end)
		return true
	elseif p == "PowerUps" then
		local powerUp = ShopDataV2.Items.PowerUps[value]

		if powerUp and powerUp.PVPOnly then
			local regularPowerUpConfig = ResourceManager.GetRegularPowerUpConfig(value)

			if not regularPowerUpConfig or Data.Get("PVPPowerUpsLoadout")[regularPowerUpConfig.Category] ~= value then
				return false
			end

			Network.Fire("ClientUnequipPowerUpRequest", value)
			return true
		else
			local v2 = 0

			for i = 1, 6 do
				if Data.Get("PowerUpsLoadout")[i] ~= value then
					continue
				end

				v2 = i
				break
			end

			if v2 > 0 then
				Network.Fire("ClientUnequipPowerUpRequest", value)
				Data.Update("PowerUpsLoadout", function(options)
					local selected = options or {}
					selected[v2] = ""
					return selected
				end)
				return true
			else
				return false
			end
		end
	elseif p == "NameTagEffects" then
		Network.Fire("ClientRequestUnequipNameTagEffect")
		return true
	else
		warn(`Unsupported/unimplemented UnequipItem check for category {p}`)
		return false
	end
end

return table.freeze(v)