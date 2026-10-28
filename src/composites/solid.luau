local types = require("../types")

const function solid(bounds: Rect, color: Color3?, transparency: number?): types.Composite
	return {
		primitives = { { bounds = bounds, color = color, transparency = transparency } },
		bounds = bounds,
	}
end

return solid
