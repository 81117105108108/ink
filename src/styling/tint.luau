local types = require("../types")

const function tint(c: types.Composite, color: Color3?, transparency: number?)
	const count = #c.primitives
	const out_primitives = table.create(count)
	for i = 1, count do
		const p = table.clone(c.primitives[i])
		p.color = color or p.color
		p.transparency = transparency or p.transparency
		out_primitives[i] = p
	end
	return {
		primitives = out_primitives,
		bounds = c.bounds,
	}
end

return tint
