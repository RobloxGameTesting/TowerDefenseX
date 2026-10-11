local clouds = workspace.Terrain:FindFirstChildOfClass("Clouds")

if not clouds then
	warn("Clouds not found in Lighting")
	return
end

local configuration = Instance.new("Configuration", workspace)
configuration.Name = "CloudsConfig"

for _, v in ipairs({ "Cover", "Density", "Color" }) do
	local cloud = clouds[v]

	if cloud then
		configuration:SetAttribute(v, cloud)
	else
		warn(tostring(v) .. " not found in Clouds")
	end
end

local v = game.Selection:Get()[1]

if v then
	local clouds2 = Instance.new("Clouds")

	for k, v2 in v:GetAttributes() do
		clouds2[k] = v2
	end

	clouds2.Parent = workspace.Terrain
end