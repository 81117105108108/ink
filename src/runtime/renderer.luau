local types = require("../types")

const renderer = {}
renderer.__index = renderer

export type Renderer = setmetatable<{
	pools: { [string]: { instances: { Instance }, used: number } },
	root: Instance,
}, typeof(renderer)>

const DEFAULT_TEXT_STYLE = { size = 0, font = Enum.Font.Arial }

function renderer.new(root: Instance): Renderer
	return setmetatable({ pools = {}, root = root }, renderer)
end

function renderer.acquire(self: Renderer, class_name: string): Instance
	local pool = self.pools[class_name]
	if not pool then
		pool = { instances = {}, used = 0 }
		self.pools[class_name] = pool
	end
	pool.used += 1
	local instance = pool.instances[pool.used]
	if not instance then
		instance = Instance.new(class_name)
		instance.Parent = self.root
		pool.instances[pool.used] = instance
	end
	return instance
end

function renderer.render_composite(self: Renderer, composite: types.Composite)
	for _, pool in self.pools do
		pool.used = 0
	end

	for z, primitive in composite.primitives do
		local instance: GuiObject

		if primitive.text then
			const text_style = primitive.text_style or DEFAULT_TEXT_STYLE
			instance = self:acquire("TextLabel") :: TextLabel
			instance.BackgroundTransparency = 1
			instance.Text = primitive.text
			instance.TextSize = text_style.size
			instance.TextColor3 = primitive.color
			instance.TextTransparency = primitive.transparency or 0
			instance.Font = text_style.font
		elseif primitive.image then
			instance = self:acquire("ImageLabel") :: ImageLabel
			instance.BackgroundTransparency = 1
			instance.Image = primitive.image
			instance.ImageColor3 = primitive.color
			instance.ImageTransparency = primitive.transparency or 0
		else
			instance = self:acquire("Frame") :: Frame
			instance.BackgroundColor3 = primitive.color
			instance.BackgroundTransparency = primitive.transparency or 0
		end

		instance.BorderSizePixel = 0
		instance.Visible = true
		instance.Position = UDim2.fromOffset(primitive.bounds.Min.X, primitive.bounds.Min.Y)
		instance.Size = UDim2.fromOffset(primitive.bounds.Width, primitive.bounds.Height)
		instance.Rotation = primitive.rotation or 0
		instance.ZIndex = z

		if primitive.round then
			const corner = self:acquire("UICorner") :: UICorner
			corner.TopLeftRadius = primitive.round.tl
			corner.TopRightRadius = primitive.round.tr
			corner.BottomLeftRadius = primitive.round.bl
			corner.BottomRightRadius = primitive.round.br
			corner.Parent = instance
		end
	end

	for _, pool in self.pools do
		for i = pool.used + 1, #pool.instances do
			const instance = pool.instances[i]
			if instance:IsA("GuiObject") then
				instance.Visible = false
			end
		end
	end
end

function renderer.destroy(self: Renderer)
	for _, pool in self.pools do
		for _, instance in pool.instances do
			instance:Destroy()
		end
	end
	table.clear(self.pools)
end

return table.freeze(renderer)
