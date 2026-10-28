local inset_rect = require("../rects/inset_rect")
local types = require("../types")

const function pad(c: types.Composite, amount: number)
	const out = table.clone(c)
	out.bounds = inset_rect(c.bounds, -amount)
	return out
end

return pad
