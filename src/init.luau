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
	solid = require("@self/composites/solid"),
	text = require("@self/composites/text"),
	image = require("@self/composites/image"),
	hit_region = require("@self/composites/hit_region"),

	align = require("@self/layout/align"),
	h_stack = require("@self/layout/h_stack"),
	pad_all = require("@self/layout/pad_all"),
	pad_sides = require("@self/layout/pad_sides"),
	pad_xy = require("@self/layout/pad_xy"),
	translate = require("@self/layout/translate"),
	v_stack = require("@self/layout/v_stack"),

	rotate = require("@self/styling/rotate"),
	tint = require("@self/styling/tint"),
	round = require("@self/styling/round"),

	rects = require("@self/composites/rects"),

	scope = require("@self/runtime/scope"),
	renderer = require("@self/runtime/roblox_frontend"),
	story = require("@self/runtime/story"),
	timer = require("@self/runtime/timer"),
})
