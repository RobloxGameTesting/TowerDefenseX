for _, sound in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if sound:IsA("Sound") and sound.Name == "Fire" then
		sound.Volume = 0.13
	end
end