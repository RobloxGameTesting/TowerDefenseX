local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedFirst.Client.Network)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local TutorialWindow = { ClassName = script.Name, ClassModule = script }
TutorialWindow.__index = TutorialWindow

function TutorialWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, TutorialWindow))
end

function TutorialWindow.Init(p)
	p.Cleaner:Add(p.Root.play.MouseButton1Click:Connect(function()
		Network.Fire("ClientPlayTutorialRequest")
		p.Root.play.label.Text = "TELEPORTING..."
	end))
end

function TutorialWindow.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { TutorialWindow }, Players)
return TutorialWindow