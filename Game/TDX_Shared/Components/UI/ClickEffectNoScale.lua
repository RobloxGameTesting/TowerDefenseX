local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local ClickEffectNoScale = { ClassName = script.Name, ClassModule = script }
ClickEffectNoScale.__index = ClickEffectNoScale

function ClickEffectNoScale.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Scale = nil }, ClickEffectNoScale))
end

function ClickEffectNoScale.Init(p)
	p.Cleaner:Add(p.Root.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	p.Cleaner:Add(p.Root.MouseButton1Up:Connect(function()
		SoundHandler.Play("ClickUp")
	end))
end

function ClickEffectNoScale.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { ClickEffectNoScale })
return ClickEffectNoScale