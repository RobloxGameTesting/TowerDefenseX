local Players = game:GetService("Players")
return {
	GetPlayerWrapperKey = function(instance)
		if instance:IsDescendantOf(Players) then
			return (tostring(instance.UserId))
		end

		return instance.Name
	end
}