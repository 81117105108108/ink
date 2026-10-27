const types = require("../types")

const function translate(c: types.Composite, offset: Vector2?): types.Composite
	offset = offset or Vector2.zero
	const primitives = table.create<<primitives.Primitive>>(#c.primitives)
	for _, primitive in c.primitives do
		const q = table.clone(primitive)
		q.bounds = Rect.new(q.bounds.Min + offset, q.bounds.Max + offset)
		table.insert(primitives, q)
	end
	return {
		primitives = primitives,
		bounds = Rect.new(c.bounds.Min + offset, c.bounds.Max + offset),
	}
end

return translate
