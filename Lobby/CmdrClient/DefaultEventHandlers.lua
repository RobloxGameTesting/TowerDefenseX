local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")
local Window = require(script.Parent.CmdrInterface.Window)
return function(object)
	object:HandleEvent("Message", function(p)
		if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
			StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = ("[Announcement] %s"):format(p),
				Color = Color3.fromRGB(249, 217, 56)
			})
		else
			TextChatService.TextChannels.RBXSystem:DisplaySystemMessage(`<font color="rgb(249, 217, 56)">[Announcement] {p}</font>`)
		end
	end)
	object:HandleEvent("AddLine", function(...)
		Window:AddLine(...)
	end)
end