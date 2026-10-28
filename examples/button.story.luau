const ink = require("../src")

const BUTTON_COLORS = {
	[Enum.GuiState.Idle] = { bg = Color3.fromHex("#18CB40"), fg = Color3.fromHex("#0D5B1E") },
	[Enum.GuiState.Hover] = { bg = Color3.fromHex("#1AD545"), fg = Color3.fromHex("#0D5B1E") },
	[Enum.GuiState.Press] = { bg = Color3.fromHex("#16B63A"), fg = Color3.fromHex("#0D5B1E") },
}

const COLOR_FG = Color3.fromHex("#0D5B1E")
const BUTTON_STYLE: ink.TextStyle = {
	size = 18,
	font = Enum.Font.GothamBold,
}

return {
	controls = {
		label = "Continue Game",
	},
	render = ink.story(function(scope, props)
		local button_content = {
			ink.image(ink.rects.from_size(24, 24), "rbxassetid://8517323790"),
			ink.align(ink.text(props.controls.label, BUTTON_STYLE), ink.rects.from_size(0, 24), nil, 0.5),
		}
		button_content = ink.hstack(button_content, 8)
		button_content = ink.pad_xy(button_content, 16, 12)
		button_content = ink.recolor(button_content, COLOR_FG)

		local button_bg = ink.solid(button_content.bounds)
		button_bg = ink.round(button_bg, UDim.new(0, 8))

		local shadow = ink.solid(button_content.bounds)
		shadow = ink.round(shadow, UDim.new(0, 8))

		local hit, hit_state, hit_activated = ink.hitbox(scope:key("hitbox"), button_bg.bounds)

		local button_colors = BUTTON_COLORS[hit_state]
		button_content = ink.recolor(button_content, button_colors.fg)
		button_bg = ink.recolor(button_bg, button_colors.bg)
		shadow = ink.recolor(shadow, button_colors.fg)

		local button_surface = ink.compose({ button_bg, button_content })
		local is_raised = hit_state == Enum.GuiState.Hover or hit_activated
		button_surface = ink.translate(button_surface, Vector2.new(0, is_raised and -8 or -4))

		if hit_activated then
			const count_scope = scope:key("count")
			const count = count_scope:get(0) + 1
			count_scope:set(count)
			print(`{count}x presses`)
		end

		local button = ink.compose({
			shadow,
			button_surface,
			hit,
		}, button_content.bounds)

		const viewport_size = props.target.AbsoluteSize
		button = ink.align(button, ink.rects.from_xywh(0, 0, viewport_size.X, viewport_size.Y), 0.5, 0.5)

		return button
	end),
}
