local SanityChecks = {}

function SanityChecks.CheckIfEnumHasInstance(items, p, p2)
	for _, item in pairs(items) do
		if not p[item] then
			warn(`{p2} instance not found for enum {item}`)
		end
	end
end

function SanityChecks.CheckIfEnumHasCConfig(items, instance, p)
	local count = 0

	for _, _ in pairs(items) do
		count += 1
	end

	if count ~= #instance:GetChildren() then
		warn(`Mismatch in # of enums ({count}) and # of configs ({#instance:GetChildren()}) for {p}`)
	end
end

return SanityChecks