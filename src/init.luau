const types = require("@self/types")

export type Primitive = types.Primitive
export type Composite = types.Composite
export type RoundStyle = types.Intent
export type IntentState = types.IntentState
export type Hotspot = types.Hotspot
export type HotspotOptions = types.HotspotOptions
export type TextStyle = types.TextStyle
export type ImageStyle = types.ImageStyle
export type Scope = types.Scope

return table.freeze({
	version = "0.1.0-rc.2",

	-- Rects
	inset_rect = require("@self/rects/inset_rect"),
	inset_rect_sides = require("@self/rects/inset_rect_sides"),
	inset_rect_xy = require("@self/rects/inset_rect_xy"),
	intersect_rects = require("@self/rects/intersect_rects"),
	is_equal_rects = require("@self/rects/is_equal_rects"),
	is_in_rect = require("@self/rects/is_in_rect"),
	rect = require("@self/rects/rect"),
	rect_sized = require("@self/rects/rect_sized"),
	union_rects = require("@self/rects/union_rects"),

	-- Composites
	compose = require("@self/composites/compose"),
	solid = require("@self/composites/solid"),
	text = require("@self/composites/text"),
	image = require("@self/composites/image"),
	hotspot = require("@self/composites/hotspot"),

	-- Layouts
	align = require("@self/layout/align"),
	clip = require("@self/layout/clip"),
	h_stack = require("@self/layout/h_stack"),
	pad_all = require("@self/layout/pad_all"),
	pad_sides = require("@self/layout/pad_sides"),
	pad_xy = require("@self/layout/pad_xy"),
	translate = require("@self/layout/translate"),
	v_stack = require("@self/layout/v_stack"),

	-- Styling
	rotate = require("@self/styling/rotate"),
	tint = require("@self/styling/tint"),
	round = require("@self/styling/round"),

	-- Animation
	oklab = require("@self/animation/timer"),
	timer = require("@self/animation/timer"),
	tween = require("@self/animation/tween"),

	-- Runtime
	scope = require("@self/runtime/scope"),
	expensive = require("@self/runtime/expensive"),
	update_intent_state = require("@self/runtime/update_intent_state"),
	roblox_renderer = require("@self/runtime/roblox_renderer"),
	roblox_intent = require("@self/runtime/roblox_intent"),
	roblox_story = require("@self/runtime/roblox_story"),
})
