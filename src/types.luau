export type RoundStyle = {
	tl: UDim,
	tr: UDim,
	bl: UDim,
	br: UDim,
}

export type TextStyle = {
	size: number,
	font: Enum.Font,
}

export type ImageStyle = {
	idk_bro: never,
}

export type Primitive = {
	bounds: Rect,

	color: Color3,
	transparency: number?,
	round: RoundStyle?,
	rotation: number?,

	text: string?,
	text_style: TextStyle?,
	image: string?,
	image_style: ImageStyle?,
}

export type Composite = {
	primitives: { Primitive },
	bounds: Rect,
}

return nil
