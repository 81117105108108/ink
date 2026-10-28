type Clock = { frame: number, dt: number, time: number }

const scope = {}
scope.__index = scope

export type Scope = setmetatable<
	{
		-- frame, dt, time
		clock: vector,
		flipped_on: number,
		previous: { [string]: any },
		current: { [string]: any },
		value: unknown,
	},
	typeof(scope)
>

const function new_scope(clock: vector): Scope
	return setmetatable({
		clock = clock,
		flipped_on = -1,
		previous = {},
		current = {},
		value = nil,
	}, scope)
end

function scope.new(): Scope
	return new_scope(vector.zero)
end

function scope.next(self: Scope, dt: number)
	self.clock = vector.create(1, dt, self.clock.z + dt)
end

const function flip(self: Scope)
	const frame = self.clock.x
	if self.flipped_on ~= frame then
		self.flipped_on = frame
		const old = self.previous
		self.previous = self.current
		self.current = old
		table.clear(old)
	end
end

function scope.key(self: Scope, name: string): Scope
	flip(self)
	local child = self.current[name]
	if child == nil then
		child = self.previous[name] or new_scope(self.clock)
		self.current[name] = child
	end
	return child
end

function scope.once<T>(self: Scope, init: () -> T): T
	if self.value == nil then
		self.value = init()
	end
	return self.value :: T
end

function scope.get<T>(self: Scope, default: T): T
	const value = self.value
	if value == nil then
		return default
	end
	return value :: T
end

function scope.set<T>(self: Scope, value: T)
	self.value = value
end

function scope.frame(self: Scope): number
	return self.clock.x
end

function scope.dt(self: Scope): number
	return self.clock.y
end

function scope.time(self: Scope): number
	return self.clock.z
end

return table.freeze(scope)
