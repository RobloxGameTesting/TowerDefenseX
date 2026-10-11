return function(vector: Vector3, vector2: Vector3, p: number, p2: number)
	local v = -p2
	local x = vector.X
	local y = vector.Y
	local z = vector.Z
	local v2 = vector2.X - x
	local v3 = vector2.Z - z
	local v4 = v2 * v2 + v3 * v3
	local v5 = vector2.Y - y

	if not (v4 > 0) then
		local vector3 = Vector3.new(0, p * (v5 > 0 and 1 or v5 < 0 and -1 or 0), 0)
		return vector3, vector3
	end

	local v6 = p * p
	local v7 = v4 / ((v4 + v5 * v5) * 2)
	local v8 = v * v5 + v6
	local v9 = v6 * (v * 2 * v5 + v6) - v * v * v4

	if not (v9 > 0) then
		return nil, nil, Vector3.new(v2, v4 ^ 0.5, v3).Unit * p
	end

	local v10 = v9 ^ 0.5
	local v11 = v7 * (v8 + v10)
	local v12 = v7 * (v8 - v10)
	local v13 = v4 ^ 0.5
	local v14 = v11 ^ 0.5
	local v15 = v12 ^ 0.5
	local v16 = v2 / v13 * v14
	local v17 = (v6 - v11) ^ 0.5
	local v18 = v3 / v13 * v14
	local v19 = v2 / v13 * v15
	local v20 = (v6 - v12) ^ 0.5
	local v21 = v3 / v13 * v15
	return Vector3.new(v16, v * v4 / (v6 * 2) < v5 and v17 or -v17, v18), (Vector3.new(v19, v20, v21))
end