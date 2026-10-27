const types = require("@self/types")
const renderer = require("@self/runtime/renderer")
const scope = require("@self/runtime/scope")

export type Primitive = types.Primitive
export type Composite = types.Composite
export type RoundStyle = types.RoundStyle
export type TextStyle = types.TextStyle
export type ImageStyle = types.ImageStyle
export type Renderer = renderer.Renderer
export type Scope = scope.Scope

return table.freeze({
	version = "0.1.0-alpha.1",

	compose = require("@self/composites/compose"),
	rects = require("@self/composites/rects"),
	solid = require("@self/composites/solid"),
	text = require("@self/composites/text"),
	image = require("@self/composites/image"),
	recolor = require("@self/composites/recolor"),
	transparency = require("@self/composites/transparency"),
	round = require("@self/composites/round"),

	align = require("@self/layout/align"),
	hstack = require("@self/layout/hstack"),
	pad = require("@self/layout/pad"),
	pad_sides = require("@self/layout/pad_sides"),
	pad_xy = require("@self/layout/pad_xy"),
	translate = require("@self/layout/translate"),
	vstack = require("@self/layout/vstack"),

	scope = scope,
	renderer = renderer,
	story = require("@self/runtime/story"),
})
