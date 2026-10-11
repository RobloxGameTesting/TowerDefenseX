for _, Script in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not (Script:IsA("Script") or Script:IsA("LocalScript") or Script:IsA("ModuleScript")) then
		continue
	end

	warn(Script:GetFullName())
end