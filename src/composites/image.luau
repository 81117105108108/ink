local types = require("../types")

const function image(bounds: Rect, content: string): types.Composite
	return {
		primitives = { { bounds = bounds, color = Color3.new(1, 1, 1), transparency = 0, image = content } },
		bounds = bounds,
	}
end

return image
