local EnemyUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Utilities"))
local MapUtilities = require(common:WaitForChild("MapUtilities"))

function EnemyUtilities.CreateDamageReductionMap(items)
	if not items then
		return
	end

	local damageReductionsByDamageType = {}

	for _, item in pairs(items) do
		damageReductionsByDamageType[item.DamageType] = item.DamageReduction

		if item.DamageReduction > 1 then
			warn("Found case where damage reduction is greater than 1")
		elseif item.DamageReduction < 0 then
			warn("Found case where damage reduction is less than 0")
		end
	end

	return damageReductionsByDamageType
end

function EnemyUtilities.GetAdjustedDamage(p: number, p2: number, flag: boolean, p3, p4: number?, p5: number)
	local v = (flag or not p3) and 0 or p3[p2] or 0

	if v ~= 0 then
		v = math.clamp(v + p5, 0, 1)
	end

	local v2 = (1 - v) * p

	if p4 and p4 >= 0 then
		return (math.min(v2, p4))
	end

	return v2
end

function EnemyUtilities.ResolvePositionByMap(p, p2)
	if not p2 then
		return p
	end

	local mapName = workspace:GetAttribute("MapName")
	local selected = mapName and p2[MapUtilities.GetResourceMapName(mapName)]
	return selected or p
end

function EnemyUtilities.GetStaticSpawnCFrame(p)
	if p and p.StaticSpawnCFrame then
		return EnemyUtilities.ResolvePositionByMap(p.StaticSpawnCFrame, p.StaticSpawnCFrameByMap)
	end

	return nil
end

return EnemyUtilities