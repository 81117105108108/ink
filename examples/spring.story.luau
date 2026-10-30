local ink = require("../src")

const CONTROLS = {
	color = Color3.new(1, 1, 1),
	offset_x = { EntryType = "Control", Type = "Slider", ControlValue = 0, Min = -1000, Max = 1000, Step = 1 },
	offset_y = { EntryType = "Control", Type = "Slider", ControlValue = 0, Min = -1000, Max = 1000, Step = 1 },
	offset_damping = { EntryType = "Control", Type = "Slider", ControlValue = 2 / 3, Min = 0, Max = 1 },
	speed = { EntryType = "Control", Type = "Slider", ControlValue = 20, Min = 0, Max = 50 },
}

return ink.ui_labs_story({
	controls = CONTROLS,
	render = function(properties: ink.StoryProperties<typeof(CONTROLS)>)
		const color = ink.spring(properties.scope:key("color"), properties.controls.color, properties.controls.speed, 1)

		const offset_x = ink.spring(
			properties.scope:key("offset_x"),
			properties.controls.offset_x,
			properties.controls.speed,
			properties.controls.offset_damping
		)

		const offset_y = ink.spring(
			properties.scope:key("offset_y"),
			properties.controls.offset_y,
			properties.controls.speed,
			properties.controls.offset_damping
		)

		local rect = ink.solid(ink.rect_sized(128, 128))
		rect = ink.align(rect, properties.target_bounds, 0.5, 0.5)
		rect = ink.tint(rect, color)
		rect = ink.translate(rect, offset_x, offset_y)

		return rect
	end,
})
