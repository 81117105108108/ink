local types = require("../types")

const function round(c: types.Composite, amount: number | types.RoundStyle)
	c = table.clone(c)
	const primitives = table.clone(c.primitives)
	const round: types.RoundStyle = type(amount) == "table" and amount
		or { tl = amount, tr = amount, bl = amount, br = amount }
	for _, primitive in primitives do
		primitive.round = round
	end
	return c
end

return round
