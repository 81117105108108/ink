const types = require("@self/types")

--- Single renderable primitive (solid frame, text, image, or hotspot).
export type Primitive = types.Primitive
--- A collection of primitives bounded by a Rect.
export type Composite = types.Composite
--- Corner rounding configuration for primitives.
export type RoundStyle = types.RoundStyle
--- Snapshot of user input and pointer activity during a frame.
export type Intent = types.Intent
--- Active interaction state and collection of registered hotspots.
export type IntentState = types.IntentState
--- State handle for an interactive hotspot region.
export type Hotspot = types.Hotspot
--- Configuration options for a hotspot.
export type HotspotOptions = types.HotspotOptions
--- Text sizing and font styling options.
export type TextStyle = types.TextStyle
--- Image scaling and slicing options.
export type ImageStyle = types.ImageStyle
--- Hierarchical generational state scope.
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
	oklab = require("@self/animation/oklab"),
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
