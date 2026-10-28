local scope = require("./scope")

const function timer(s: scope.Scope)
	const elapsed = s:get(0) + s:dt()
	s:set(elapsed)
	return elapsed
end

return timer
