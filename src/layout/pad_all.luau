local rects = require("../composites/rects")
local types = require("../types")

const function pad(c: types.Composite, amount: number)
	const out = table.clone(c)
	out.bounds = rects.inset(c.bounds, -amount)
	return out
end

return pad
