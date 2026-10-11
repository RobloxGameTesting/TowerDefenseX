local NetworkingUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local band = bit32.band
local lshift = bit32.lshift
local extract = bit32.extract

function NetworkingUtilities.CompressHashAndPercentage(p: number, value: number)
	local v = math.round(math.clamp(value, 0, 1) * 1048575)
	local v2 = band(lshift(p, 4), 65520)
	local v3 = band(lshift(extract(v, 16, 4), 0), 15)
	local v4 = band(lshift(extract(v, 0, 16), 0), 65535)
	return Vector2int16.new(v2 + v3, v4)
end

function NetworkingUtilities.DecompressHashAndPercentage(p)
	local x = p.X
	local y = p.Y
	local v = extract(x, 4, 12)
	local v2 = extract(x, 0, 4)
	return v, (math.clamp((lshift(v2, 16) + extract(y, 0, 16)) * 9.536752259018191e-7, 0, 1))
end

function NetworkingUtilities.CompressDoubleHash(p: number, p2: number)
	return Vector2int16.new(p, p2)
end

function NetworkingUtilities.DecompressDoubleHash(p)
	return p.X, p.Y
end

function NetworkingUtilities.CompressHashAndInteger(p: number, p2: number)
	local v = band(lshift(p, 4), 65520)
	local v2 = band(lshift(extract(p2, 16, 4), 0), 15)
	local v3 = band(lshift(extract(p2, 0, 16), 0), 65535)
	return Vector2int16.new(v + v2, v3)
end

function NetworkingUtilities.DecompressHashAndInteger(p)
	local x = p.X
	local y = p.Y
	return extract(x, 4, 12), lshift(extract(x, 0, 4), 16) + extract(y, 0, 16)
end

function NetworkingUtilities.CompressHashAndNumber1Place(p: number, p2: number)
	local v = math.round(p2 * 10)
	local v2 = band(lshift(p, 4), 65520)
	local v3 = band(lshift(extract(v, 16, 4), 0), 15)
	local v4 = band(lshift(extract(v, 0, 16), 0), 65535)
	return Vector2int16.new(v2 + v3, v4)
end

function NetworkingUtilities.DecompressHashAndNumber1Place(p)
	local x = p.X
	local y = p.Y
	return extract(x, 4, 12), (lshift(extract(x, 0, 4), 16) + extract(y, 0, 16)) / 10
end

function NetworkingUtilities.CompressProjectileInitPacket(data)
	return {
		data.Name,
		data.OriginEntityClass,
		data.TargetEntityClass,
		data.OriginHash,
		data.TargetHash or false,
		data.TimeToHit,
		data.OverrideGoalPosition or false,
		data.BurnEffectName or false,
		data.BurnEffectDuration or false,
		data.BurstIndex or false,
		data.FromTowerDefaultAttack or false,
		data.SpawnStaticEntityHash or false,
		data.SpawnAttachmentEntityHash or false,
		data.TurretIndex or false,
		data.ProjectileSpeedMultiplier
	}
end

function NetworkingUtilities.DecompressProjectileInitPacket(list)
	return {
		Name = list[1],
		OriginEntityClass = list[2],
		TargetEntityClass = list[3],
		OriginHash = list[4],
		TargetHash = list[5],
		TimeToHit = list[6],
		OverrideGoalPosition = list[7],
		BurnEffectName = list[8],
		BurnEffectDuration = list[9],
		BurstIndex = list[10],
		FromTowerDefaultAttack = list[11],
		SpawnStaticEntityHash = list[12],
		SpawnAttachmentEntityHash = list[13],
		TurretIndex = list[14],
		ProjectileSpeedMultiplier = list[15]
	}
end

return NetworkingUtilities