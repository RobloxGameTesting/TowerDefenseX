local DataStoreQueue = { QR = true, Queue = {}, Process = 0 }
local v = {}
task.spawn(function()
	while DataStoreQueue.QR do
		task.wait()

		if not (#DataStoreQueue.Queue > 0) then
			continue
		end

		local v2 = DataStoreQueue.Queue[1]
		table.remove(DataStoreQueue.Queue, 1)

		if not v[v2.Key] then
			v[v2.Key] = 0
		end

		DataStoreQueue.Process += 1
		local v3 = v2.Delay + v[v2.Key] - DateTime.now().UnixTimestamp
		local v4 = v3 <= 0 and 0 or v3
		task.delay(v4, function()
			local success, result, v5

			while true do
				v[v2.Key] = DateTime.now().UnixTimestamp
				success, result, v5 = pcall(v2.Func)

				if not success then
					warn(result)
				end

				if success and result or not v2.Delay then
					break
				end

				task.wait(v2.Delay)

				if success and result then
					break
				end
			end

			v2.Event:Fire(success, result, v5)
			DataStoreQueue.Process -= 1
			v[v2.Key] = DateTime.now().UnixTimestamp
		end)
	end
end)

function DataStoreQueue.AddRequest(p, func, delay)
	local bindableEvent = Instance.new("BindableEvent")
	table.insert(DataStoreQueue.Queue, {
		Key = p,
		Delay = delay,
		Func = func,
		Event = bindableEvent
	})
	local v2, v3, v4 = bindableEvent.Event:Wait()
	return v2, v3, v4
end

function DataStoreQueue.RemoveKey(p)
	v[p] = nil
end

return DataStoreQueue