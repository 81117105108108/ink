const compose = require("../composites/compose")
const translate = require("./translate")
const types = require("../types")

const function vstack(cs: { types.Composite }, gap: number?): types.Composite
	gap = gap or 0
	const placed = table.create<<types.Composite>>(#cs)
	local y = if cs[1] then cs[1].bounds.Min.Y else 0
	for index, c in cs do
		placed[index] = translate(c, Vector2.new(0, y - c.bounds.Min.Y))
		y += c.bounds.Height + gap
	end
	return compose(placed)
end

return vstack
