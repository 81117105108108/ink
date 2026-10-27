local types = require("../types")

const function transparency(c: types.Composite, transparency: number?)
	c = table.clone(c)
	const primitives = table.clone(c.primitives)
	for _, primitive in primitives do
		primitive.transparency = transparency
	end
	return c
end

return transparency
