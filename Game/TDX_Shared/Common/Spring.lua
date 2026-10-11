local cos = math.cos
local sin = math.sin
return {
	New = function(value)
		local now = tick()
		local v = value or 0
		local v2 = not value and 0 or 0 * value or 0
		local v3 = value or 0
		local v4 = 1
		local v5 = 1
		local v6 = 1

		local function positionvelocity(now2)
			local v7 = now2 - now
			local v8 = v - v3
			local v9 = v6 * v5

			if v5 == 0 then
				return v, 0
			end

			if v4 < 1 then
				local v10 = (1 - v4 * v4) ^ 0.5
				local v11 = (v2 / v9 + v4 * v8) / v10
				local v12 = cos(v10 * v9 * v7)
				local v13 = sin(v10 * v9 * v7)
				local v14 = 2.718281828459045 ^ (v4 * v9 * v7)
				return
					v3 + (v8 * v12 + v11 * v13) / v14,
					v9 * ((v10 * v11 - v4 * v8) * v12 - (v10 * v8 + v4 * v11) * v13) / v14
			else
				local v10 = v2 / v9 + v8
				local v11 = 2.718281828459045 ^ (v9 * v7)
				return v3 + (v8 + v10 * v9 * v7) / v11, v9 * (v10 - v8 - v10 * v9 * v7) / v11
			end
		end

		return (setmetatable({
			Accelerate = function(_, p)
				local now2 = tick()
				local v7, v8 = positionvelocity(now2)
				v = v7
				v2 = v8 + p * v6
				now = now2
			end
		}, {
			__index = function(_, p)
				if p == "Position" then
					local v7, _ = positionvelocity(tick())
					return v7
				elseif p == "Velocity" then
					local _, v7 = positionvelocity(tick())
					return v7
				end

				if p == "Acceleration" then
					local v7 = tick() - now
					local v8 = v - v3
					local v9 = v6 * v5

					if v5 == 0 then
						return 0
					end

					if not (v4 < 1) then
						local v10 = v2 / v9 + v8
						return v9 * v9 * (v8 - 2 * v10 + v10 * v9 * v7) / 2.718281828459045 ^ (v9 * v7)
					end

					local v10 = (1 - v4 * v4) ^ 0.5
					local v11 = (v2 / v9 + v4 * v8) / v10
					return v9 * v9 * ((v4 * v4 * v8 - v10 * 2 * v4 * v11 - v10 * v10 * v8) * cos(v10 * v9 * v7) + (v4 * v4 * v11 + v10 * 2 * v4 * v8 - v10 * v10 * v11) * sin(v10 * v9 * v7)) / 2.718281828459045 ^ (v4 * v9 * v7)
				else
					if p == "Target" then
						return v3
					elseif p == "Damper" then
						return v4
					elseif p == "Speed" then
						return v6 * v5
					elseif p == "SpeedMultiplier" then
						return v6
					end

					error(p .. " is not a valid member of spring", 0)
				end
			end,
			__newindex = function(_, p, p2)
				local now2 = tick()

				if p == "Position" then
					local _, v7 = positionvelocity(now2)
					v = p2
					v2 = v7
				elseif p == "Velocity" then
					local v7, _ = positionvelocity(now2)
					v = v7
					v2 = p2
				elseif p == "Acceleration" then
					local v7, v8 = positionvelocity(now2)
					local v9 = v8 + p2
					v = v7
					v2 = v9
				elseif p == "Target" then
					v, v2 = positionvelocity(now2)
					v3 = p2
				elseif p == "Damper" then
					v, v2 = positionvelocity(now2)
					v4 = p2 < 0 and 0 or p2 < 1 and p2 or 1
				elseif p == "Speed" then
					v, v2 = positionvelocity(now2)
					v5 = p2 < 0 and 0 or p2
				elseif p == "SpeedMultiplier" then
					v6 = p2
				else
					error(p .. " is not a valid member of spring", 0)
				end

				now = now2
			end
		}))
	end
}