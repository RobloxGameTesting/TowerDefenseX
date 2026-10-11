local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local PlayButtons = { ClassName = script.Name, ClassModule = script }
PlayButtons.__index = PlayButtons

function PlayButtons.new(root)
	return (setmetatable({ Root = root }, PlayButtons))
end

function PlayButtons.Init(p)
	p.Root.Visible = _G.NEW_PLAY_BUTTONS_ENABLED
	p.Root.PlaySolo.Activated:Connect(function()
		Director.GetFirstItemFromClass(Director.Classes.GameModeSelectionWindow):Show()
	end)
end

function PlayButtons.Destroy(_) end

Director.Register(script.Name, { PlayButtons }, game.Players)
return PlayButtons