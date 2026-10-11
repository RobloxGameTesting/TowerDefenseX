local Lighting = game:GetService("Lighting")
local v = game.Selection:Get()[1]

for k, v2 in v:GetAttributes() do
	local v3 = Lighting[k]

	if v3 then
		v:SetAttribute(k, v3)
		print(tostring(k) .. ": " .. tostring(v2) .. " -> " .. tostring(v3))

		if k == "ClockTime" and v3 < 0 then
			warn("ClockTime is negative!!!")
		end
	else
		warn(tostring(k) .. " not found in Lighting")
	end
end

local Lighting2 = game:GetService("Lighting")
local v2 = game.Selection:Get()[1]

if v2 then
	for k, v3 in v2:GetAttributes() do
		if Lighting2[k] then
			Lighting2[k] = v3
		else
			warn(tostring(k) .. " not found in Lighting")
		end
	end
end