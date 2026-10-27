local rects = require("../composites/rects")
local types = require("../types")

const function pad_xy(c: types.Composite, x: number?, y: number?)
	const out = table.clone(c)
	out.bounds = rects.inset_xy(c.bounds, -(x or 0), -(y or 0))
	return out
end

return pad_xy
