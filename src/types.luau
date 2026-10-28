local scope = require("./runtime/scope")

export type RoundStyle = {
	tl: number?,
	tr: number?,
	bl: number?,
	br: number?,
}

export type TextStyle = {
	size: number,
	font: Enum.Font,
}

export type ImageStyle = {
	idk_bro: never,
}

export type HitState = {
	state: Enum.GuiState,
	activated: boolean,
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
	hit_state: HitState?,
}

export type Composite = {
	primitives: { Primitive },
	bounds: Rect,
	hitbox_scope: scope.Scope?,
}

export type Scope = scope.Scope

return nil
