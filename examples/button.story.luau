const ink = require("../src")

const COLOR_BG = Color3.fromHex("#18CB40")
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

		local button_bg = ink.solid(button_content.bounds, COLOR_BG)
		button_bg = ink.round(button_bg, UDim.new(0, 8))

		local button_shadow = ink.solid(button_content.bounds, COLOR_FG)
		button_shadow = ink.round(button_shadow, UDim.new(0, 8))
		button_shadow = ink.translate(button_shadow, Vector2.new(0, 4))

		local button = ink.compose({
			button_shadow,
			button_bg,
			button_content,
		}, button_content.bounds)

		const viewport_size = props.target.AbsoluteSize
		return ink.align(button, ink.rects.from_xywh(0, 0, viewport_size.X, viewport_size.Y), 0.5, 0.5)
	end),
}
