local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Data = require(TDX_Shared.Client.Services.Data)
local Director = require(TDX_Shared.Modules.Director)
local flag = false
local nameTagEffects = false
return {
	Init = function(_)
		if flag then
			return
		end

		flag = true
		task.spawn(function()
			while true do
				task.wait(0.5)

				for _, v in Director.GetItemsFromClass(Director.Classes.NameTagPart) do
					local success, result = pcall(v.Update, v, nameTagEffects)

					if not success then
						warn(`NameTagPart update failed for {v.Root:GetFullName()}: {result}`)
					end
				end
			end
		end)
		nameTagEffects = Data.Get("Settings").NameTagEffects
		Data.Updated:Connect(function(p: string, p2)
			if p == "Settings" then
				nameTagEffects = p2.NameTagEffects
			end
		end)
	end
}