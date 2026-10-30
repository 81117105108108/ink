const types = require("@self/types")

export type Primitive = types.Primitive
export type Composite = types.Composite
export type RoundStyle = types.Intent
export type IntentState = types.IntentState
export type Hotspot = types.Hotspot
export type HotspotOptions = types.HotspotOptions
export type TextStyle = types.TextStyle
export type ImageStyle = types.ImageStyle
export type Story<C = nil> = types.Story<C>
export type StoryProperties<C = nil> = types.StoryProperties<C>
export type Scope = types.Scope

--- @class Ink
--- Zero-hierarchy immediate-mode UI library for Roblox and Vortex.
const ink = table.freeze({
	version = require("@self/version"),

	-- Composites
	compose = require("@self/composites/compose"),
	solid = require("@self/composites/solid"),
	text = require("@self/composites/text"),
	image = require("@self/composites/image"),
	hotspot = require("@self/composites/hotspot"),

	-- Layouts
	align = require("@self/layout/align"),
	clip = require("@self/layout/clip"),
	distribute = require("@self/layout/distribute"),
	h_stack = require("@self/layout/h_stack"),
	masonry = require("@self/layout/masonry"),
	pad_all = require("@self/layout/pad_all"),
	pad_sides = require("@self/layout/pad_sides"),
	pad_xy = require("@self/layout/pad_xy"),
	translate = require("@self/layout/translate"),
	v_stack = require("@self/layout/v_stack"),

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

	-- Styling
	rotate = require("@self/styling/rotate"),
	tint = require("@self/styling/tint"),
	round = require("@self/styling/round"),

	-- Animation
	lerp = require("@self/animation/lerp"),
	color = require("@self/animation/color"),
	spring = require("@self/animation/spring"),
	tween = require("@self/animation/tween"),

	-- Timing
	timer = require("@self/timing/timer"),
	after = require("@self/timing/after"),
	every = require("@self/timing/every"),

	-- Runtime
	async = require("@self/runtime/async"),
	scope = require("@self/runtime/scope"),
	expensive = require("@self/runtime/expensive"),
	update_intent_state = require("@self/runtime/update_intent_state"),
	gui_object_renderer = require("@self/runtime/gui_object_renderer"),
	input_source_intent = require("@self/runtime/input_source_intent"),
	ui_labs_story = require("@self/runtime/ui_labs_story"),
})

return ink
