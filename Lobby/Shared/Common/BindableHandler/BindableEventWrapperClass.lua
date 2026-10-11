local BindableEventWrapperClass = {}
BindableEventWrapperClass.__index = BindableEventWrapperClass
local v = {}

local function CreateBindableEvent(name) -- 1 equivalent call inferred from this helper
	local bindableEvent = Instance.new("BindableEvent")
	bindableEvent.Name = name
	bindableEvent.Parent = script
	return bindableEvent
end

function BindableEventWrapperClass.GetBindableEventWrappers()
	return v
end

function BindableEventWrapperClass.New(name: string)
	assert(v[name] == nil, "Bindable event with name " .. name .. " already exists")
	local v2 = { Name = name, BindableEvent = CreateBindableEvent(name) } -- inferred equivalent call
	v[name] = v2
	return (setmetatable(v2, BindableEventWrapperClass))
end

function BindableEventWrapperClass:Fire(...)
	self.BindableEvent:Fire(...)
end

function BindableEventWrapperClass.AttachCallback(p, callback)
	p.BindableEvent.Event:Connect(function(...)
		callback(...)
	end)
end

return BindableEventWrapperClass