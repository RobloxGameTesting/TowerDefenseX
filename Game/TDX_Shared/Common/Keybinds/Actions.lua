local v = {
	"One",
	"Two",
	"Three",
	"Four",
	"Five",
	"Six",
	"Seven",
	"Eight",
	"Nine",
	"Zero"
}
local v2 = {
	Placement = "Standard",
	Selection = "Standard",
	Global = "Standard",
	DirectControl = "DirectControl"
}
local Actions = {}

local function Add(p: string, id: string, keyboard, gamepad, p2: string?, param: number?)
	table.insert(Actions, {
		Id = id,
		Scopes = { p },
		Context = v2[p],
		Handler = p2 or id,
		Param = param,
		Keyboard = keyboard,
		Gamepad = gamepad
	})
end

local function AddListened(scopes, id: string, keyboard) -- 3 equivalent calls inferred from this helper
	table.insert(Actions, { Id = id, Scopes = scopes, Keyboard = keyboard, Gamepad = {} })
end

Add("Placement", "StopTowerPlacement", { "Q" }, { "ButtonB" })
Add("Selection", "DeselectCurrentTower", {}, { "ButtonB" })
Add("Placement", "RotateTowerPlacement", { "R" }, { "ButtonL2" })

for i, v3 in ipairs(v) do
	Add("Global", `SelectTower{i}`, { v3 }, {}, "SelectTower", i)
end

Add("Selection", "UseAbility1", { "G" }, { "ButtonY" }, "UseAbility", 1)
Add("Selection", "UseAbility2", { "H" }, {}, "UseAbility", 2)
Add("Selection", "UseAbility3", { "J" }, {}, "UseAbility", 3)
Add("Selection", "UseAbility4", { "K" }, {}, "UseAbility", 4)
Add("Selection", "SellTower", { "Backspace" }, { "ButtonX" })
Add("Selection", "UpgradeTowerPath1", { "E" }, { "DPadUp" }, "UpgradeTowerPath", 1)
Add("Selection", "UpgradeTowerPath2", { "R" }, { "DPadDown" }, "UpgradeTowerPath", 2)
Add("Selection", "ChangeQueryModeLeft", { "C" }, {})
Add("Selection", "ChangeQueryModeRight", { "V" }, { "DPadRight" })
Add("Global", "CycleTowerBarLeft", {}, { "ButtonL1" })
Add("Global", "CycleTowerBarRight", {}, { "ButtonR1" })
Add("Global", "OpenUpgradeShop", { "T" }, { "DPadLeft" })
Add("Global", "SwitchPVPTab", { "Y" }, { "DPadLeft" })
Add("DirectControl", "DirectControlStop", { "X" }, { "ButtonX" })
Add("DirectControl", "DirectControlReload", { "R" }, { "ButtonB" })
Add("DirectControl", "DirectControlMoveUp", { "E" }, { "DPadUp" })
Add("DirectControl", "DirectControlMoveDown", { "Q" }, { "DPadDown" })
Add("DirectControl", "DirectControlAbility", { "F" }, { "ButtonY" })

for i = 1, 9 do
	Add("DirectControl", `DirectControlSelectWeapon{i}`, { v[i] }, {}, "DirectControlSelectWeapon", i)
end

Add("DirectControl", "DirectControlCycleWeaponUp", {}, { "DPadLeft" })
Add("DirectControl", "DirectControlCycleWeaponDown", {}, { "DPadRight" })
Add("DirectControl", "DirectControlZoomOut", { "Minus" }, { "ButtonL1" })
Add("DirectControl", "DirectControlZoomIn", { "Equals" }, { "ButtonR1" })
AddListened({ "Global", "DirectControl" }, "Ping", { "LeftAlt" }) -- inferred equivalent call
AddListened({ "Global", "Lobby" }, "Emote", { "B" }) -- inferred equivalent call
AddListened({ "Lobby" }, "EatFood", { "E" }) -- inferred equivalent call
return Actions