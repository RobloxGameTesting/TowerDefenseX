local abs = math.abs
return {
	GetBoundingBox = function(descendants)
		if typeof(descendants) == "Instance" then
			descendants = descendants:GetDescendants()
		end

		local cframe = CFrame.new()
		local v = 1e999
		local v2 = 1e999
		local v3 = 1e999
		local v4 = -1e999
		local v5 = -1e999
		local v6 = -1e999

		for _, part in pairs(descendants) do
			if not part:IsA("BasePart") then
				continue
			end

			local objectSpace = cframe:ToObjectSpace(part.CFrame)
			local size = part.Size
			local x = size.X
			local y = size.Y
			local z = size.Z
			local components, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 = objectSpace:components()
			local v18 = 0.5 * (abs(v9) * x + abs(v10) * y + abs(v11) * z)
			local v19 = 0.5 * (abs(v12) * x + abs(v13) * y + abs(v14) * z)
			local v20 = 0.5 * (abs(v15) * x + abs(v16) * y + abs(v17) * z)

			if components - v18 < v then
				v = components - v18
			end

			if v7 - v19 < v2 then
				v2 = v7 - v19
			end

			if v8 - v20 < v3 then
				v3 = v8 - v20
			end

			if v4 < components + v18 then
				v4 = components + v18
			end

			if v5 < v7 + v19 then
				v5 = v7 + v19
			end

			if v6 < v8 + v20 then
				v6 = v8 + v20
			end
		end

		local vector = Vector3.new(v, v2, v3)
		local vector2 = Vector3.new(v4, v5, v6)
		local midpoint = (vector2 + vector) / 2
		return cframe - cframe.p + cframe:PointToWorldSpace(midpoint), vector2 - vector
	end
}