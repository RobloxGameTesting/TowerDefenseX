local folder = game.Selection:Get()[1]

for _, model in pairs(folder:GetDescendants()) do
	if model:IsA("Model") and #model:GetChildren() == 0 then
		model:Destroy()
	end
end