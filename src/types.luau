local scope = require("./runtime/scope")

export type Intent = {
	pointer: Vector2,
	pointer_delta: Vector2,
	down: boolean,
	pressed: boolean,
	released: boolean,
	wheel: number,
	keys_held: { [Enum.KeyCode]: boolean },
	keys_pressed: { [Enum.KeyCode]: boolean },
}

export type IntentState = { hotspots: { Primitive }, active: Hotspot? }

export type Hotspot = {
	state: Enum.GuiState,
	clicked: boolean,
	wheel: number,
	drag: Vector2,
	pointer: Vector2,
	bounds: Rect,
}

export type HotspotOptions = { wheel: boolean? }

export type RoundStyle = { radius: number? }

export type TextStyle = { size: number, font: Enum.Font }

export type ImageStyle = {
	scale_type: Enum.ScaleType?,
	slice_center: Rect?,
	resample_mode: Enum.ResamplerMode?,
}

export type Primitive = {
	bounds: Rect,
	clip: Rect?,
	color: Color3?,
	transparency: number?,
	round: RoundStyle?,
	rotation: number?,
	text: string?,
	text_style: TextStyle?,
	image: string?,
	image_style: ImageStyle?,
	hotspot: Hotspot?,
	hotspot_wheel: boolean?,
}

export type Composite = { primitives: { Primitive }, bounds: Rect }

export type Scope = scope.Scope

return nil
