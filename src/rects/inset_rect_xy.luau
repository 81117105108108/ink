local inset_rect_sides = require("./inset_rect_sides")

const function inset_rect_xy(r: Rect, x: number, y: number)
	return inset_rect_sides(r, y, x, y, x)
end

return inset_rect_xy
