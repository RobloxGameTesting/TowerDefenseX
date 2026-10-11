local Keybinds = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local Signal = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Signal"))
local Actions = require(script:WaitForChild("Actions"))
local Overrides = require(script:WaitForChild("Overrides"))
local frozen = table.freeze({})
local v = Signal.new()
Keybinds.Changed = Signal.new()
local actionsById = {}
local v2 = nil
local v3 = {}
local v4 = {}
local v5 = { "Keyboard", "Gamepad" }
local v6 = false
local v7 = {
	Zero = "0",
	One = "1",
	Two = "2",
	Three = "3",
	Four = "4",
	Five = "5",
	Six = "6",
	Seven = "7",
	Eight = "8",
	Nine = "9",
	Backspace = "BKSP",
	Delete = "DEL",
	Insert = "INS",
	Home = "HOME",
	End = "END",
	PageUp = "PGUP",
	PageDown = "PGDN",
	KeypadZero = "NUM0",
	KeypadOne = "NUM1",
	KeypadTwo = "NUM2",
	KeypadThree = "NUM3",
	KeypadFour = "NUM4",
	KeypadFive = "NUM5",
	KeypadSix = "NUM6",
	KeypadSeven = "NUM7",
	KeypadEight = "NUM8",
	KeypadNine = "NUM9",
	KeypadPeriod = "NUM.",
	KeypadDivide = "NUM/",
	KeypadMultiply = "NUM*",
	KeypadMinus = "NUM-",
	KeypadPlus = "NUM+",
	KeypadEnter = "NUMENT",
	LeftShift = "SHIFT",
	RightShift = "SHIFT",
	LeftControl = "CTRL",
	RightControl = "CTRL",
	LeftAlt = "ALT",
	RightAlt = "RALT",
	Space = "SPACE",
	Return = "ENTER",
	Escape = "ESC",
	Tab = "TAB"
}

for _, action in ipairs(Actions) do
	actionsById[action.Id] = action
end

local function GetOverrides() -- 5 equivalent calls inferred from this helper
	local keybinds = v2 and v2.Get("Keybinds")

	if typeof(keybinds) == "table" then
		return keybinds
	end

	return {}
end

local function GetKeysWithOverrides(data, p: string, p2) -- 1 equivalent call inferred from this helper
	if p == "Gamepad" then
		return data.Gamepad
	end

	local v8 = p2[data.Id]

	if v8 == nil or not Overrides.IsValidKeyList(v8) then
		return data.Keyboard
	end

	return v8
end

local function Rebuild()
	local overrides = GetOverrides() -- inferred equivalent call
	v3 = {}
	v4 = {}

	for _, action in ipairs(Actions) do
		local v8 = {}
		v4[action.Id] = v8

		for _, v9 in ipairs(v5) do
			local gamepad

			if v9 == "Gamepad" then
				gamepad = action.Gamepad
			else
				gamepad = overrides[action.Id]

				if gamepad == nil or not Overrides.IsValidKeyList(gamepad) then
					gamepad = action.Keyboard
				end
			end

			for _, v10 in ipairs(gamepad) do
				local v11 = Enum.KeyCode:FromName(v10)

				if v11 then
					if v9 == "Keyboard" then
						v8[v11] = true
					end

					if action.Context then
						local v12 = v3[action.Context] or {}
						v3[action.Context] = v12
						local v13 = v12[v9] or {}
						v12[v9] = v13
						local actions = v13[v11] or {}
						v13[v11] = actions
						table.insert(actions, action)
					end
				else
					warn(`Keybinds: {action.Id} has unknown {v9} key "{v10}"`)
				end
			end
		end
	end

	Keybinds.Changed:Fire()
end

function Keybinds.GetActions()
	return Actions
end

function Keybinds.GetActionsForKey(p, p2: string, p3)
	local v8 = v3[p]
	local v9 = v8 and v8[p2]
	return v9 and v9[p3] or frozen
end

function Keybinds.GetKeys(p: string, p2: string)
	local v8 = actionsById[p]

	if not v8 then
		warn(`Keybinds: unknown action {p}`)
		return {}
	end

	return GetKeysWithOverrides(v8, p2, GetOverrides()) -- inferred equivalent call
end

function Keybinds.IsActionInput(p: string, p2)
	if v6 or p2.UserInputType ~= Enum.UserInputType.Keyboard then
		return false
	end

	local v8 = v4[p]

	if v8 then
		return v8[p2.KeyCode] == true
	end

	warn(`Keybinds: unknown action {p}`)
	return false
end

function Keybinds.Update(p)
	if not v2 then
		v:Wait()
	end

	local v8 = Overrides.Apply(GetOverrides(), p) -- inferred equivalent call

	if not v8 then
		warn("Keybinds: rejected invalid keybind change")
		return false
	end

	v2.Set("Keybinds", v8)
	Rebuild()
	NetworkingHandler.GetEvent("RequestUpdateKeybinds"):FireServer(p)
	return true
end

function Keybinds.ResetAll()
	local keybinds = v2 and v2.Get("Keybinds")
	local v8 = {}

	for k in pairs(typeof(keybinds) ~= "table" and {} or keybinds) do
		v8[k] = false
	end

	if next(v8) == nil then
		return true
	end

	return Keybinds.Update(v8)
end

local function ScopeCovers(scope, scope2) -- 2 equivalent calls inferred from this helper
	if scope == scope2 then
		return true
	elseif scope == "Global" then
		return scope2 == "Placement" or scope2 == "Selection"
	else
		return false
	end
end

local function ScopesOverlap(p, action)
	for _, scope in ipairs(p.Scopes) do
		for _, scope2 in ipairs(action.Scopes) do
			if not ScopeCovers(scope, scope2) and not ScopeCovers(scope2, scope) then -- inferred equivalent call
				continue
			end

			return true
		end
	end

	return false
end

local function IsKeyTakenFor(action, p: string, p2, p3)
	for _, action2 in ipairs(Actions) do
		if not (action2 ~= action and action2 ~= p2 and ScopesOverlap(action, action2)) then
			continue
		end

		local keyboard = p3[action2.Id]

		if keyboard == nil or not Overrides.IsValidKeyList(keyboard) then
			keyboard = action2.Keyboard
		end

		if table.find(keyboard, p) then
			return true
		end
	end

	return false
end

function Keybinds.Assign(p: string, p2: number, p3: string)
	local v8 = actionsById[p]

	if not v8 or p2 < 1 or Overrides.MAX_KEYS_PER_ACTION < p2 or not Overrides.IsBindableKey(p3) then
		return false, {}
	end

	local overrides = GetOverrides() -- inferred equivalent call
	local keyboard = overrides[v8.Id]

	if keyboard == nil or not Overrides.IsValidKeyList(keyboard) then
		keyboard = v8.Keyboard
	end

	local clone = table.clone(keyboard)
	local v9 = clone[p2]
	local index = table.find(clone, p3)

	if index == p2 then
		return true, {}
	end

	if v9 then
		clone[p2] = p3

		if index then
			clone[index] = v9
		end
	elseif index then
		return true, {}
	else
		table.insert(clone, p3)
	end

	local clonesById = { [p] = clone }
	local ids = {}

	if not index then
		for _, action in ipairs(Actions) do
			if not (action ~= v8 and ScopesOverlap(v8, action)) then
				continue
			end

			local keyboard2 = overrides[action.Id]

			if keyboard2 == nil or not Overrides.IsValidKeyList(keyboard2) then
				keyboard2 = action.Keyboard
			end

			local clone2 = table.clone(keyboard2)
			local index2 = table.find(clone2, p3)

			if not index2 then
				continue
			end

			if
				v9
				and Overrides.IsBindableKey(v9)
				and not (table.find(clone2, v9) or IsKeyTakenFor(action, v9, v8, overrides))
			then
				clone2[index2] = v9
			else
				table.remove(clone2, index2)
			end

			clonesById[action.Id] = clone2
			table.insert(ids, action.Id)
		end
	end

	if Keybinds.Update(clonesById) then
		return true, ids
	end

	return false, {}
end

function Keybinds.Unassign(p: string, p2: number)
	local v8 = actionsById[p]

	if not v8 then
		return false
	end

	local keyboard = GetOverrides()[v8.Id] -- inferred equivalent call

	if keyboard == nil or not Overrides.IsValidKeyList(keyboard) then
		keyboard = v8.Keyboard
	end

	local clone = table.clone(keyboard)

	if clone[p2] == nil then
		return true
	end

	table.remove(clone, p2)
	return Keybinds.Update({ [p] = clone })
end

function Keybinds.IsBindableKey(p: string)
	return Overrides.IsBindableKey(p)
end

function Keybinds.GetKeyDisplayName(p: string)
	local v8 = v7[p]

	if v8 then
		return v8
	end

	local v9 = Enum.KeyCode:FromName(p)
	local v10 = not v9 and "" or UserInputService:GetStringForKeyCode(v9)

	if v10 == "" then
		v10 = p
	end

	return string.upper(v10)
end

function Keybinds.GetKeyLabel(p: string)
	local v8 = Keybinds.GetKeys(p, "Keyboard")[1]

	if v8 then
		return (Keybinds.GetKeyDisplayName(v8))
	end

	return nil
end

function Keybinds:BindLabel(p: string, p2)
	local v8 = p2 or self

	local function Update() -- 1 equivalent call inferred from this helper
		local keyLabel = Keybinds.GetKeyLabel(p)
		self.Text = keyLabel or ""
		v8.Visible = keyLabel ~= nil
	end

	Update() -- inferred equivalent call
	local changedConnection = Keybinds.Changed:Connect(Update)
	self.Destroying:Once(function()
		changedConnection:Disconnect()
	end)
end

function Keybinds.FormatText(value: string)
	local v8 = string.gsub(value, "{Key:(%w+)}", function(p: string)
		return Keybinds.GetKeyLabel(p) or "(UNBOUND)"
	end)
	return (string.gsub(v8, "{Keys:(%a+)(%d+)%-(%d+)}", function(p: string, p2: string, p3: string)
		local keyLabels = {}
		local v9 = true

		for i = tonumber(p2), tonumber(p3) do
			local keyLabel = Keybinds.GetKeyLabel(`{p}{i}`)

			if keyLabel then
				local v10 = tonumber(keyLabel)
				local v11 = tonumber(keyLabels[#keyLabels])

				if not v10 or v11 and v10 ~= v11 + 1 then
					v9 = false
				end

				table.insert(keyLabels, keyLabel)
			else
				v9 = false
			end
		end

		if #keyLabels == 0 then
			return "(UNBOUND)"
		end

		if v9 and #keyLabels > 1 then
			return `{keyLabels[1]}-{keyLabels[#keyLabels]}`
		end

		return table.concat(keyLabels, ", ")
	end))
end

function Keybinds.SetCapturing(flag: boolean)
	v6 = flag
end

function Keybinds.IsCapturing()
	return v6
end

Rebuild()
task.spawn(function()
	local Data = require(TDX_Shared:WaitForChild("Client"):WaitForChild("Services"):WaitForChild("Data"))
	v2 = Data
	v2.Updated:Connect(function(p)
		if p == "Keybinds" or typeof(p) == "table" then
			Rebuild()
		end
	end)
	Rebuild()
	v:Fire()
end)
return Keybinds