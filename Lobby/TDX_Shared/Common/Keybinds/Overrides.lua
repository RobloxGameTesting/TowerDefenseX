local Overrides = {}
local Actions = require(script.Parent:WaitForChild("Actions"))
Overrides.MAX_KEYS_PER_ACTION = 2
local v = {}

for _, v2 in ipairs({
	"B",
	"C",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"T",
	"U",
	"V",
	"X",
	"Y",
	"Z",
	"Zero",
	"One",
	"Two",
	"Three",
	"Four",
	"Five",
	"Six",
	"Seven",
	"Eight",
	"Nine",
	"Minus",
	"Equals",
	"LeftBracket",
	"RightBracket",
	"BackSlash",
	"Semicolon",
	"Quote",
	"Comma",
	"Period",
	"Backquote",
	"Backspace",
	"Delete",
	"Insert",
	"Home",
	"End",
	"PageUp",
	"PageDown",
	"KeypadZero",
	"KeypadOne",
	"KeypadTwo",
	"KeypadThree",
	"KeypadFour",
	"KeypadFive",
	"KeypadSix",
	"KeypadSeven",
	"KeypadEight",
	"KeypadNine",
	"KeypadPeriod",
	"KeypadDivide",
	"KeypadMultiply",
	"KeypadMinus",
	"KeypadPlus",
	"KeypadEnter",
	"F1",
	"F3",
	"F4",
	"F5",
	"F6",
	"F7",
	"F8",
	"LeftAlt",
	"RightAlt"
}) do
	v[v2] = true
end

local actionsById = {}

for _, action in ipairs(Actions) do
	actionsById[action.Id] = action
end

function Overrides.IsBindableKey(value)
	return typeof(value) == "string" and v[value] == true
end

function Overrides.IsValidKeyList(list)
	if typeof(list) ~= "table" then
		return false
	end

	local count = 0

	for _ in pairs(list) do
		count += 1
	end

	if Overrides.MAX_KEYS_PER_ACTION < count or count ~= #list then
		return false
	end

	local v2 = {}

	for i = 1, count do
		local v3 = list[i]

		if Overrides.IsBindableKey(v3) and not v2[v3] then
			v2[v3] = true
		else
			return false
		end
	end

	return true
end

local function IsSameKeySet(item, keyboard)
	if #item ~= #keyboard then
		return false
	end

	for _, v2 in ipairs(item) do
		if not table.find(keyboard, v2) then
			return false
		end
	end

	return true
end

function Overrides.Apply(p, items)
	if typeof(items) ~= "table" then
		return nil
	end

	local clone = table.clone(p)

	for k, item in pairs(items) do
		if typeof(k) ~= "string" then
			return nil
		end

		local v2 = actionsById[k]

		if item == false then
			clone[k] = nil
		elseif v2 and Overrides.IsValidKeyList(item) then
			if IsSameKeySet(item, v2.Keyboard) then
				clone[k] = nil
			else
				clone[k] = table.clone(item)
			end
		else
			return nil
		end
	end

	return clone
end

return Overrides