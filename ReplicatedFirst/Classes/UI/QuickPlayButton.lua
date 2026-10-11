local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Network = require(ReplicatedFirst.Client.Network)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local QuickPlayButton = { ClassName = script.Name, ClassModule = script }
QuickPlayButton.__index = QuickPlayButton

function QuickPlayButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, QuickPlayButton))
end

function QuickPlayButton.Init(p)
	p.Cleaner:Add(p.Root.Activated:Connect(function()
		Network.Fire("ClientOpenedPartyRequest")

		for _, v in Director.GetItemsFromClass(Director.Classes.PartyWindow) do
			if v.Root.Visible then
				v:Minimise()
			else
				for _, v2 in Director.GetItemsFromClass(Director.Classes.PartyMinimised) do
					if v2.Root.Visible then
						v.Root.Visible = true
						v2.Root.Visible = false
					else
						v.Root.Visible = true
					end
				end
			end
		end
	end))
end

function QuickPlayButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { QuickPlayButton }, game.Players)
return QuickPlayButton