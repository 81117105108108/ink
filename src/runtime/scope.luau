type Clock = { frame: number, dt: number, time: number }

const scope = {}
scope.__index = scope

export type Scope = setmetatable<{
	clock: Clock,
	flipped_on: number,
	previous: { [string]: any },
	current: { [string]: any },
	value: unknown,
	pending: unknown,
	pending_frame: number?,
}, typeof(scope)>

const function new_scope(clock: Clock): Scope
	return setmetatable({
		clock = clock,
		flipped_on = -1,
		previous = {},
		current = {},
		value = nil,
		pending = nil,
		pending_frame = nil,
	}, scope)
end

function scope.new(): Scope
	return new_scope({ frame = 0, dt = 0, time = 0 })
end

function scope.next(self: Scope, dt: number)
	const clock = self.clock
	clock.frame += 1
	clock.dt = dt
	clock.time += dt
end

const function flip(self: Scope)
	const frame = self:frame()
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

function scope.set<T>(self: Scope, value: T)
	self.pending = value
	self.pending_frame = self:frame()
end

function scope.get<T>(self: Scope, default: T): T
	if self.pending_frame and self.pending_frame < self:frame() then
		self.value = self.pending
		self.pending, self.pending_frame = nil, nil
	end
	const value = self.value
	return if value == nil then default else value :: T
end

function scope.frame(self: Scope): number
	return self.clock.frame
end

function scope.dt(self: Scope): number
	return self.clock.dt
end

function scope.time(self: Scope): number
	return self.clock.time
end

return table.freeze(scope)
