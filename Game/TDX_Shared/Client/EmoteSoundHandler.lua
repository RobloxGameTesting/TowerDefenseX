local CollectionService = game:GetService("CollectionService")
local flag = false
return {
	Init = function(_)
		if flag then
			return
		end

		flag = true
		task.spawn(function()
			while true do
				task.wait(0.05)
				local position = workspace.CurrentCamera.CFrame.Position
				local v = {}

				for _, v2 in CollectionService:GetTagged("EmoteSound") do
					if v[v2.SoundId] == nil then
						v[v2.SoundId] = {}
					end

					table.insert(v[v2.SoundId], v2)
				end

				for _, v2 in v do
					local v3 = 1e999
					local v4 = nil

					for _, v5 in v2 do
						if not v5.IsPlaying then
							continue
						end

						local magnitude = (position - v5.Parent.Position).Magnitude

						if not (magnitude < v3) then
							continue
						end

						v4 = v5
						v3 = magnitude
					end

					for _, v5 in v2 do
						if v5:GetAttribute("AlwaysPlay") then
							v5.Volume = v5:GetAttribute("Volume") or 0
						else
							v5.Volume = v5 ~= v4 and 0 or v5:GetAttribute("Volume") or 0
						end
					end
				end
			end
		end)
	end
}