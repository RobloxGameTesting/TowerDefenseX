local v = game.Selection:Get()
local v2 = v[1]
local v3 = v[2]
local v4 = v[3]
v4:ScaleTo(v2.Size.X / v3.Size.X)
local v5 = v2.Position - v3.Position
v4:PivotTo(v4:GetPivot() + v5)