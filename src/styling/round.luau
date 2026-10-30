local types = require("../types")

const function round(c: types.Composite, amount: number | types.RoundStyle)
	const style: types.RoundStyle = if type(amount) == "table" then amount else { radius = amount }
	const count = #c.primitives
	const out_primitives = table.create(count)
	for i = 1, count do
		const p = table.clone(c.primitives[i])
		p.round = style
		out_primitives[i] = p
	end
	return {
		primitives = out_primitives,
		bounds = c.bounds,
	}
end

return round
