const rects = {}

function rects.from_xywh(x: number, y: number, w: number, h: number): Rect
	return Rect.new(Vector2.new(x, y), Vector2.new(x + w, y + h))
end

function rects.from_size(w: number, h: number): Rect
	return Rect.new(Vector2.zero, Vector2.new(w, h))
end

function rects.union(a: Rect?, b: Rect): Rect
	return a and Rect.new(a.Min:Min(b.Min), a.Max:Max(b.Max)) or b
end

function rects.inset_sides(rect: Rect, top: number, left: number, bottom: number, right: number)
	return Rect.new(
		rect.Min.X + left,
		rect.Min.Y + top,
		math.max(rect.Max.X - right, rect.Min.X + left),
		math.max(rect.Max.Y - bottom, rect.Min.Y + top)
	)
end

function rects.inset_xy(rect: Rect, x: number, y: number)
	return rects.inset_sides(rect, y, x, y, x)
end

function rects.inset(rect: Rect, px: number)
	return rects.inset_sides(rect, px, px, px, px)
end

return table.freeze(rects)
