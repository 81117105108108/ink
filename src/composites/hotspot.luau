local types = require("../types")

export type HitState = {
	state: Enum.GuiState,
	clicked: boolean,
	wheel: number,
	drag: Vector2,
	pointer: Vector2,
}

const function new_hotspot(): types.Hotspot
	return {
		state = Enum.GuiState.Idle,
		clicked = false,
		wheel = 0,
		drag = Vector2.zero,
		pointer = Vector2.zero,
		bounds = Rect.new(),
	}
end

const function hotspot(s: types.Scope, bounds: Rect, options: types.HotspotOptions?): (types.Composite, types.Hotspot)
	const hotspot = s:once(new_hotspot)
	const primitive: types.Primitive = {
		bounds = bounds,
		hotspot = hotspot,
		hotspot_wheel = options ~= nil and options.wheel == true,
	}
	return { primitives = { primitive }, bounds = bounds }, hotspot
end

return hotspot
