local types = require("../types")

const function recolor(c: types.Composite, color: Color3)
	c = table.clone(c)
	const primitives = table.clone(c.primitives)
	for _, primitive in primitives do
		primitive.color = color
	end
	return c
end

return recolor
