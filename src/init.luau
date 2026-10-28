const types = require("@self/types")

export type Primitive = types.Primitive
export type Composite = types.Composite
export type RoundStyle = types.RoundStyle
export type TextStyle = types.TextStyle
export type ImageStyle = types.ImageStyle
export type Scope = types.Scope

return table.freeze({
	version = "0.1.0-alpha.1",

	compose = require("@self/composites/compose"),
	hitbox = require("@self/composites/hitbox"),
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

	scope = require("@self/runtime/scope"),
	renderer = require("@self/runtime/roblox_frontend"),
	story = require("@self/runtime/story"),
	timer = require("@self/runtime/timer"),
})
