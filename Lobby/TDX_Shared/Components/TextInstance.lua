local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Lang = game.ReplicatedStorage.TDX_Shared.Modules.Lang
local TextInstance = { ClassName = script.Name, ClassModule = script }
TextInstance.__index = TextInstance

function TextInstance.new(root)
	return (setmetatable({ Root = root }, TextInstance))
end

function TextInstance:Init()
	self:Update()
end

function TextInstance:Update()
	local root = self.Root
	local module = require(Lang)
	root.Text = string.format(
		module.GetInternal(self.Root:GetAttribute("LangIndex")),
		unpack(string.split(self.Root:GetAttribute("LangStrings", "$£$")))
	)
end

Director.Register(script.Name, { TextInstance })
return TextInstance