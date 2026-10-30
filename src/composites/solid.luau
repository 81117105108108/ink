local types = require("../types")

--- Creates a composite containing a solid rectangle.
const function solid(bounds: Rect): types.Composite
	return {
		primitives = { { bounds = bounds } },
		bounds = bounds,
	}
end

return solid
