const scope = {}
scope.__index = scope

export type Scope = setmetatable<{
	previous_frame: {},
	next_frame: {},
}, typeof(scope)>

function scope.new(): Scope
	return setmetatable({ previous_frame = {}, next_frame = {} }, scope)
end

function scope.flip_frames(self: Scope)
	self.previous_frame, self.next_frame = self.next_frame, {}
end

function scope.key(self: Scope, key: string) end

return table.freeze(scope)
