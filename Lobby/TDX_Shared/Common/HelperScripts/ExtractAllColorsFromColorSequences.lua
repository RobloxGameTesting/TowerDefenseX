local v = {}

for _, folder in pairs(game.Selection:Get()) do
	for _, emitter in pairs(folder:GetDescendants()) do
		if not emitter:IsA("ParticleEmitter") then
			continue
		end

		local color = emitter.Color

		for _, keypoint in pairs(color.Keypoints) do
			v[keypoint.Value] = true
		end
	end
end

for k, _ in pairs(v) do
	print(math.round(255 * k.R) .. "_" .. math.round(255 * k.G) .. "_" .. math.round(255 * k.B))
end