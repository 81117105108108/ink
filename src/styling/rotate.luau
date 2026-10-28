local types = require("../types")

const function rotate(c: types.Composite, degrees: number)
	c = table.clone(c)
	const primitives = table.clone(c.primitives)
	for _, primitive in primitives do
		primitive.rotation = degrees
	end
	return c
end

return rotate
