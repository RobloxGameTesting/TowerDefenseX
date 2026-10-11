local BindableEventWrapperClass = require(script:WaitForChild("BindableEventWrapperClass"))
local bindableEventWrappers = BindableEventWrapperClass.GetBindableEventWrappers()
local BindableHandler = {}

function BindableHandler.CreateBindableEvent(p: string)
	assert(p ~= nil, "Must specify valid bindable event name")
	return BindableEventWrapperClass.New(p)
end

function BindableHandler.GetEvent(p: string)
	local bindableEventWrapper = bindableEventWrappers[p]

	if not bindableEventWrapper then
		warn("No bindable event with name " .. p)
	end

	return bindableEventWrapper
end

return BindableHandler