local scope = require("./scope")

type ExpensiveState<T> = {
	args: { [number]: unknown, n: number },
	first_computed: boolean,
	value: T,
}

const function new_state<T>(): ExpensiveState<T>
	return { args = { n = 0 }, value = nil, first_computed = false }
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

const function expensive<T, A...>(s: scope.Scope, compute: (s: scope.Scope, A...) -> T, ...: A...): T
	const state = s:once(new_state)

	const skip_recompute = state.first_computed and is_same_args(state.args, ...)
	if skip_recompute then
		return state.value
	end

	state.args = table.pack(... :: unknown)
	state.value = compute(s, ...)
	state.first_computed = true

	return state.value
end

return expensive
