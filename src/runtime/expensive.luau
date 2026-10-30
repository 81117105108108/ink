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

--- Memoizes the result of `compute` within the given Scope `s`.
--- Recomputes only when any arguments change by reference equality (`==`).
--- Note: Pass a dedicated child scope (e.g. `scope:key("name")`) so memoized state
--- does not collide with other values in the same scope.
const function expensive<T, A...>(s: scope.Scope, compute: (s: scope.Scope, A...) -> T, ...: A...): T
	const state = s:once(new_state) :: ExpensiveState<T>

	const skip_recompute = state.first_computed and is_same_args(state.args, ...)
	if skip_recompute then
		return state.value
	end

	const n = select("#", ...)
	table.clear(state.args)
	state.args.n = n
	for i = 1, n do
		state.args[i] = select(i, ...)
	end

	state.value = compute(s, ...)
	state.first_computed = true

	return state.value
end

return expensive
