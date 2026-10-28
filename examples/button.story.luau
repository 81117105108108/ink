const ink = require("../src")

const BUTTON_COLORS = {
	[Enum.GuiState.Idle] = { bg = Color3.fromHex("#18CB40"), fg = Color3.fromHex("#0D5B1E") },
	[Enum.GuiState.Hover] = { bg = Color3.fromHex("#1AD545"), fg = Color3.fromHex("#0D5B1E") },
	[Enum.GuiState.Press] = { bg = Color3.fromHex("#16B63A"), fg = Color3.fromHex("#0D5B1E") },
}

const BUTTON_STYLE: ink.TextStyle = {
	size = 18,
	font = Enum.Font.GothamBold,
}

return {
	controls = {
		label = "Continue Game",
	},
	render = ink.roblox_story(function(scope, props)
		local content = {
			ink.image(ink.rect_sized(24, 24), "rbxassetid://8517323790"),
			ink.align(ink.text(props.controls.label, BUTTON_STYLE), ink.rect_sized(0, 24), nil, 0.5),
		}
		content = ink.h_stack(content, 8)
		content = ink.pad_xy(content, 16, 12)

		local bg = ink.solid(content.bounds)
		bg = ink.round(bg, 8)

		local shadow = ink.solid(content.bounds)
		shadow = ink.round(shadow, 8)

		local hot, spot = ink.hotspot(scope:key("hitbox"), bg.bounds)

		local colors = BUTTON_COLORS[hot.state]
		local color_bg = ink.tween(scope:key("color_bg"), colors.bg, 0.2)
		local color_fg = ink.tween(scope:key("color_fg"), colors.fg, 0.2)
		bg = ink.tint(bg, color_bg)
		content = ink.tint(content, color_fg)
		shadow = ink.tint(shadow, color_fg)

		local surface = ink.compose({ bg, content })
		shadow = ink.translate(shadow, 0, hot.state == Enum.GuiState.Press and 4 or 6)

		const count_scope = scope:key("count")
		local count = count_scope:get(0)
		if hot.clicked then
			count += 1
			print(`{count}x presses`)
		end
		count_scope:set(count)

		local button = ink.compose({
			shadow,
			surface,
			spot,
		}, shadow.bounds)

		const viewport_size = props.target.AbsoluteSize
		button = ink.align(button, ink.rect(0, 0, viewport_size.X, viewport_size.Y), 0.5, 0.5)

		return button
	end),
}
