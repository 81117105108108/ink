const lerp_type = require("./datatypes/lerp_type")

const function lerp<T>(goal: T, initial: T, alpha: number): T
	const kind = typeof(goal)
	const lerp_type = lerp_type[kind]
	return if lerp_type then lerp_type(goal, initial, alpha) elseif alpha > 0.5 then initial else goal
end

return lerp
