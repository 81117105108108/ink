const scope = require("../runtime/scope")
const types = require("../types")

const function new_state(): types.HitState
	return { state = Enum.GuiState.Idle, activated = false }
end

const function hit_region(s: scope.Scope, bounds: Rect): (types.Composite, Enum.GuiState, boolean)
	const hit = s:once(new_state)

	const clicked = hit.activated
	hit.activated = false

	const c: types.Composite = {
		primitives = { { bounds = bounds, hit_state = hit } },
		bounds = bounds,
	}

	return c, hit.state, clicked
end

return hit_region
