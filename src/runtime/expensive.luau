local types = require("../types")

type ExpensiveState<T> = {
	args: types.Pack,
	value: types.Pack,
	first_computed: boolean,
}

const function new_state<T>(): ExpensiveState<T>
	return { args = { n = 0 }, value = { n = 0 }, first_computed = false }
end

const function is_same_args(stored: { [number]: unknown, n: number }, ...: unknown): boolean
	const n = select("#", ...)
	if stored.n ~= n then
		return false
	end
	for i = 1, n do
		if stored[i] ~= select(i, ...) then
			return false
		end
	end
	return true
end

const function expensive<A..., R...>(s: types.Scope, compute: (s: types.Scope, A...) -> R..., ...: A...): R...
	const state = s:once(new_state)

	const skip_recompute = state.first_computed and is_same_args(state.args, ...)
	if skip_recompute then
		return table.unpack<<any>>(state.value, 1, state.value.n)
	end

	state.args = (table.pack :: any)(...)
	state.value = (table.pack :: any)(compute(s, ...))
	state.first_computed = true

	return table.unpack<<any>>(state.value, 1, state.value.n)
end

return expensive
