const ink = require("../src")
local assets = require("./lib/assets")

type Card = { title: string, body: string, logo: string }

const COLOR_TEXT_BG = Color3.fromHex("#DDDDDD")
const COLOR_TEXT_FG = Color3.fromHex("#000000")
const TITLE_STYLE: ink.TextStyle = { size = 24, font = Enum.Font.GothamBold }
const BODY_STYLE: ink.TextStyle = { size = 16, font = Enum.Font.RobotoMono }

const CARDS = {
	{
		title = "Fusion",
		body = 'scope:New "TextLabel" { ... }',
		logo = assets.fusion,
	},
	{
		title = "React",
		body = 'e("TextLabel", { ... })',
		logo = assets.react,
	},
	{
		title = "Ink",
		body = "ink.text(...)",
		logo = assets.ink,
	},
	{
		title = "Vide",
		body = 'create "TextLabel" { ... }',
		logo = assets.vide,
	},
	{
		title = "Iris",
		body = "Iris.Text({ ... })",
		logo = assets.iris,
	},
}

const function render_card(card: Card)
	local top = ink.solid(ink.rects.from_size(320, 180), COLOR_TEXT_BG)
	top = ink.transparency(top, 2 / 3)

	local logo = ink.image(ink.rects.from_size(160, 160), card.logo)
	logo = ink.pad(logo, -32)
	logo = ink.align(logo, top.bounds, 1, 1)

	local fg = ink.vstack({
		ink.text(card.title, TITLE_STYLE),
		ink.text(card.body, BODY_STYLE),
	})
	fg = ink.recolor(fg, COLOR_TEXT_FG)
	fg = ink.pad(fg, 12)
	fg = ink.compose({ ink.solid(fg.bounds, COLOR_TEXT_BG), fg })

	return ink.compose({ top, logo, fg })
end

return {
	render = ink.story(function(scope, props)
		local c = {}
		for index, card in CARDS do
			c[index] = ink.translate(render_card(card), Vector2.new((index - 1) * 32))
		end
		c = ink.vstack(c, 32)

		const viewport_size = props.target.AbsoluteSize

		return ink.align(c, ink.rects.from_size(viewport_size.X, viewport_size.Y), 0.5, 0.5)
	end),
}
