const UserInputService = game:GetService("UserInputService")

const types = require("../types")

const roblox_intent = {}
roblox_intent.__index = roblox_intent

export type RobloxIntent = setmetatable<
	{
		pending: types.Intent, -- built up by events between frames
		state: types.IntentState, -- hotspots and the active hotspot
		to_local: (Vector2) -> Vector2,
		screen_pointer: Vector2,
		last_pointer: Vector2,
		touch: InputObject?,
		connections: { RBXScriptConnection },
	},
	typeof(roblox_intent)
>

const function new_intent(): types.Intent
	return {
		pointer = Vector2.zero,
		pointer_delta = Vector2.zero,
		down = false,
		pressed = false,
		released = false,
		wheel = 0,
		keys_held = {},
		keys_pressed = {},
	}
end

function roblox_intent.new(to_local: (Vector2) -> Vector2): RobloxIntent
	const self: RobloxIntent = setmetatable({
		pending = new_intent(),
		state = { hotspots = {}, active = nil },
		to_local = to_local,
		screen_pointer = Vector2.zero,
		last_pointer = Vector2.zero,
		touch = nil,
		connections = {},
	}, roblox_intent)

	const pending = self.pending

	const function is_primary(input: InputObject): boolean
		return input.UserInputType == Enum.UserInputType.MouseButton1
			or (input.UserInputType == Enum.UserInputType.Touch and (self.touch == nil or self.touch == input))
	end

	table.insert(
		self.connections,
		UserInputService.InputBegan:Connect(function(input)
			if is_primary(input) then
				if input.UserInputType == Enum.UserInputType.Touch then
					self.touch = input
				end
				self.screen_pointer = Vector2.new(input.Position.X, input.Position.Y)
				pending.down = true
				pending.pressed = true
			elseif input.UserInputType == Enum.UserInputType.Keyboard then
				pending.keys_held[input.KeyCode] = true
				pending.keys_pressed[input.KeyCode] = true
			end
		end)
	)

	table.insert(
		self.connections,
		UserInputService.InputChanged:Connect(function(input)
			const t = input.UserInputType
			if t == Enum.UserInputType.MouseMovement or (t == Enum.UserInputType.Touch and input == self.touch) then
				self.screen_pointer = Vector2.new(input.Position.X, input.Position.Y)
			elseif t == Enum.UserInputType.MouseWheel then
				pending.wheel += input.Position.Z
			end
		end)
	)

	table.insert(
		self.connections,
		UserInputService.InputEnded:Connect(function(input)
			if is_primary(input) then
				self.touch = nil
				pending.down = false
				pending.released = true
			elseif input.UserInputType == Enum.UserInputType.Keyboard then
				pending.keys_held[input.KeyCode] = nil
			end
		end)
	)

	return self
end

function roblox_intent.take(self: RobloxIntent): types.Intent
	const pending = self.pending
	const pointer = self.to_local(self.screen_pointer)

	pending.pointer = pointer
	pending.pointer_delta = pointer - self.last_pointer
	self.last_pointer = pointer

	const snapshot = table.clone(pending)
	pending.pressed = false
	pending.released = false
	pending.wheel = 0
	pending.keys_pressed = {}

	return snapshot
end

function roblox_intent.commit(self: RobloxIntent, composite: types.Composite)
	const hotspots = self.state.hotspots
	table.clear(hotspots)
	for _, primitive in composite.primitives do
		const hotspot = primitive.hotspot
		if hotspot then
			hotspot.bounds = primitive.bounds
			table.insert(hotspots, primitive)
		end
	end
end

function roblox_intent.destroy(self: RobloxIntent)
	for _, connection in self.connections do
		connection:Disconnect()
	end
	table.clear(self.connections)
	table.clear(self.state.hotspots)
	self.state.active = nil
end

return table.freeze(roblox_intent)
