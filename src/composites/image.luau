local types = require("../types")

const function image(bounds: Rect, content: string): types.Composite
	return {
		primitives = { { bounds = bounds, image = content } },
		bounds = bounds,
	}
end

return image
