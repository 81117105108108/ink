local types = require("../types")

const function rotate(c: types.Composite, degrees: number)
	const count = #c.primitives
	const out_primitives = table.create(count)
	for i = 1, count do
		const p = table.clone(c.primitives[i])
		p.rotation = degrees
		out_primitives[i] = p
	end
	return {
		primitives = out_primitives,
		bounds = c.bounds,
	}
end

return rotate
