local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Base = { ClassName = script.Name, ClassModule = script }
Base.__index = Base

function Base.new(root)
	return (setmetatable({ Root = root }, Base))
end

function Base.Init(_) end

function Base.Destroy(_) end

Director.Register(script.Name, { Base })
return Base