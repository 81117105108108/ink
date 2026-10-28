local types = require("../types")

const function solid(bounds: Rect): types.Composite
	return {
		primitives = { { bounds = bounds } },
		bounds = bounds,
	}
end

return solid
