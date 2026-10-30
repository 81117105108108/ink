local types = require("../types")

const function rotate(c: types.Composite, degrees: number): types.Composite
	const new_primitives = table.create<<types.Primitive>>(#c.primitives)
	for index, primitive in c.primitives do
		primitive = table.clone(primitive)
		primitive.rotation = degrees
		new_primitives[index] = primitive
	end
	return { primitives = new_primitives, bounds = c.bounds }
end

return rotate
