local MaterialService = game:GetService("MaterialService")

for _, child in pairs(MaterialService:GetChildren()) do
	child.Name = "Ragnarok" .. "_" .. child.Name
end

for _, part in pairs(workspace:GetDescendants()) do
	if part:IsA("BasePart") and part.MaterialVariant ~= "" then
		part.MaterialVariant = "Ragnarok" .. "_" .. part.MaterialVariant
	end
end