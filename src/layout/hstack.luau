const compose = require("../composites/compose")
const translate = require("./translate")
const types = require("../types")

const function hstack(cs: { types.Composite }, gap: number?): types.Composite
	gap = gap or 0
	const placed = table.create<<types.Composite>>(#cs)
	local x = if cs[1] then cs[1].bounds.Min.X else 0
	for index, c in cs do
		placed[index] = translate(c, Vector2.new(x - c.bounds.Min.X, 0))
		x += c.bounds.Width + gap
	end
	return compose(placed)
end

return hstack
