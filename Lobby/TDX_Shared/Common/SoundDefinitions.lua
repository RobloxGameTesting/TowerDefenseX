local SoundDefinitions = {
	SFX = function(assetId: string, volume: number?, items)
		local result = { AssetId = assetId, Volume = volume }

		if items then
			for k, item in pairs(items) do
				result[k] = item
			end
		end

		return result
	end,
	BossMusic = function(assetId: string, volume: number?, title: string?)
		return {
			AssetId = assetId,
			Volume = volume,
			Looped = true,
			LayerCount = 1,
			IsMusic = true,
			IsBossMusic = true,
			Title = title
		}
	end,
	Music = function(assetId: string, volume: number?, title: string?)
		return {
			AssetId = assetId,
			Volume = volume,
			LayerCount = 1,
			IsMusic = true,
			Title = title
		}
	end,
	LoopedMusic = function(assetId: string, volume: number?, title: string?)
		return {
			AssetId = assetId,
			Volume = volume,
			Looped = true,
			LayerCount = 1,
			IsMusic = true,
			Title = title
		}
	end,
	AmbientMusic = function(assetId: string, volume: number?, title: string?)
		return {
			AssetId = assetId,
			Volume = volume,
			LayerCount = 1,
			IsMusic = true,
			IsAmbientMusic = true,
			Title = title
		}
	end
}

function SoundDefinitions.AmbientSet(p: string, p2: number?, list)
	local result = {}

	for i, v in ipairs(list) do
		result[p .. i] = SoundDefinitions.AmbientMusic(v[1], p2, v[2])
	end

	return result
end

function SoundDefinitions.Merge(...)
	local result = {}

	for _, v in ipairs({ ... }) do
		for k, v2 in pairs(v) do
			assert(result[k] == nil, `Sound "{k}" is defined twice`)
			result[k] = v2
		end
	end

	return result
end

return SoundDefinitions