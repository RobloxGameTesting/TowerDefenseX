local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local Keybinds = require(common:WaitForChild("Keybinds"))
local InputUtilities = require(script.Parent:WaitForChild("InputUtilities"))
local event = BindableHandler.GetEvent("HotkeyStartTowerPlacement")
local event2 = BindableHandler.GetEvent("StopTowerPlacement")
local event3 = BindableHandler.GetEvent("DeselectCurrentTower")
local event4 = BindableHandler.GetEvent("UseAbility")
local event5 = BindableHandler.GetEvent("TowerPlacementRotationIncrement")
local event6 = BindableHandler.GetEvent("HotkeySellTower")
local event7 = BindableHandler.GetEvent("HotkeyUpgradeTower")
local event8 = BindableHandler.GetEvent("HotkeyChangeQueryModeLeft")
local event9 = BindableHandler.GetEvent("HotkeyChangeQueryModeRight")
local event10 = BindableHandler.GetEvent("CycleTowerBarLeft")
local event11 = BindableHandler.GetEvent("CycleTowerBarRight")
local event12 = BindableHandler.GetEvent("OpenUpgradeShop")
local event13 = BindableHandler.GetEvent("HotkeySwitchPVPTab")
local event14 = BindableHandler.GetEvent("StopTowerDirectControl")
local event15 = BindableHandler.GetEvent("DirectControlReload")
local event16 = BindableHandler.GetEvent("DirectControlMoveUp")
local event17 = BindableHandler.GetEvent("DirectControlMoveDown")
local event18 = BindableHandler.GetEvent("DirectControlSelectWeapon")
local event19 = BindableHandler.GetEvent("DirectControlCycleWeaponUp")
local event20 = BindableHandler.GetEvent("DirectControlCycleWeaponDown")
local event21 = BindableHandler.GetEvent("DirectControlZoomOut")
local event22 = BindableHandler.GetEvent("DirectControlZoomIn")
local event23 = BindableHandler.GetEvent("DirectControlUseAbility")

local function FireOnPress(event24) -- 15 equivalent calls inferred from this helper
	return {
		Began = function()
			event24:Fire()
		end
	}
end

local v = {
	StopTowerPlacement = FireOnPress(event2), -- inferred equivalent call
	DeselectCurrentTower = FireOnPress(event3), -- inferred equivalent call
	RotateTowerPlacement = FireOnPress(event5), -- inferred equivalent call
	SellTower = FireOnPress(event6), -- inferred equivalent call
	ChangeQueryModeLeft = FireOnPress(event8), -- inferred equivalent call
	ChangeQueryModeRight = FireOnPress(event9), -- inferred equivalent call
	CycleTowerBarLeft = FireOnPress(event10), -- inferred equivalent call
	CycleTowerBarRight = FireOnPress(event11), -- inferred equivalent call
	SwitchPVPTab = FireOnPress(event13), -- inferred equivalent call
	SelectTower = {
		Began = function(p)
			event:Fire(p)
		end
	},
	UseAbility = {
		Began = function(p)
			event4:Fire(p)
		end
	},
	UpgradeTowerPath = {
		Began = function(p, p2)
			if p2 == "Keyboard" then
				event7:Fire(p, InputUtilities.CtrlHeld())
			else
				event7:Fire(p)
			end
		end
	},
	OpenUpgradeShop = {
		Began = function(_, p)
			if p == "Gamepad" or not InputUtilities.ShiftHeld() then
				event12:Fire()
			end
		end,
		Ended = function(_, p)
			if p == "Keyboard" and not InputUtilities.ShiftHeld() then
				event12:Fire(true)
			end
		end
	},
	DirectControlStop = FireOnPress(event14), -- inferred equivalent call
	DirectControlReload = FireOnPress(event15), -- inferred equivalent call
	DirectControlCycleWeaponUp = FireOnPress(event19), -- inferred equivalent call
	DirectControlCycleWeaponDown = FireOnPress(event20), -- inferred equivalent call
	DirectControlZoomOut = FireOnPress(event21), -- inferred equivalent call
	DirectControlZoomIn = FireOnPress(event22), -- inferred equivalent call
	DirectControlMoveUp = {
		Began = function()
			event16:Fire(true)
		end,
		Ended = function()
			event16:Fire(false)
		end
	},
	DirectControlMoveDown = {
		Began = function()
			event17:Fire(true)
		end,
		Ended = function()
			event17:Fire(false)
		end
	},
	DirectControlAbility = {
		Began = function()
			event23:Fire(1)
		end
	},
	DirectControlSelectWeapon = {
		Began = function(p)
			event18:Fire(p)
		end
	}
}
local HotkeyActions = {}

for _, v2 in ipairs(Keybinds.GetActions()) do
	if not v2.Handler or v[v2.Handler] then
		continue
	end

	warn(`HotkeyActions: no handler "{v2.Handler}" for keybind action {v2.Id}`)
end

function HotkeyActions.Dispatch(p: string, flag: boolean, p2, p3)
	if Keybinds.IsCapturing() then
		return
	end

	for _, v2 in ipairs(Keybinds.GetActionsForKey(flag and "DirectControl" or "Standard", p2, p3)) do
		local v3 = v[v2.Handler]
		local v4 = v3 and v3[p]

		if v4 then
			v4(v2.Param, p2)
		end
	end
end

return HotkeyActions