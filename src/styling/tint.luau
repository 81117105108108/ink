local types = require("../types")

const function tint(c: types.Composite, color: Color3?, transparency: number?)
	c = table.clone(c)
	const primitives = table.clone(c.primitives)
	for _, primitive in primitives do
		primitive.color = color or primitive.color
		primitive.transparency = transparency or primitive.transparency
	end
	return c
end

return tint
