return {
	GetAutoHandledEffectInstances = function(instance, p)
		local children = {}

		if not (p.AutoHandleEffects and p.AnimationName) then
			return nil, children
		end

		local animationName = p.AnimationName
		local child = instance:FindFirstChild(animationName)
		local primaryPart = instance.PrimaryPart
		local sfx = primaryPart and primaryPart:FindFirstChild("SFX")
		local child2 = sfx and sfx:FindFirstChild(animationName)

		if child2 then
			table.insert(children, child2)
		end

		local child3 = instance:FindFirstChild(animationName .. "Instant")

		if child3 then
			table.insert(children, child3)
		end

		return child, children
	end
}