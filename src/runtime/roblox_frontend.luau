local types = require("../types")

const roblox_frontend = {}
roblox_frontend.__index = roblox_frontend

export type Renderer = setmetatable<{
	pools: { [string]: { instances: { Instance }, used: number } },
	hit_targets: { [ImageButton]: types.HitState },
	root: Instance,
}, typeof(roblox_frontend)>

const COLOR_WHITE = Color3.new(1, 1, 1)
const COLOR_BLACK = Color3.new(0, 0, 0)
const DEFAULT_TEXT_STYLE = { size = 0, font = Enum.Font.Arial }

function roblox_frontend.new(root: Instance): Renderer
	return setmetatable({ pools = {}, hit_targets = {}, root = root }, roblox_frontend)
end

function roblox_frontend.acquire<T>(self: Renderer, class_name: string): (T, boolean)
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
		return instance, true
	end
	return instance, false
end

function roblox_frontend.render_composite(self: Renderer, composite: types.Composite)
	debug.profilebegin("Ink Render")

	for _, pool in self.pools do
		pool.used = 0
	end

	for z, primitive in composite.primitives do
		local instance, fresh

		if primitive.text then
			const text_style = primitive.text_style or DEFAULT_TEXT_STYLE
			instance, fresh = self:acquire<<TextLabel>>("TextLabel")
			instance.BackgroundTransparency = 1
			instance.Text = primitive.text
			instance.TextSize = text_style.size
			instance.TextColor3 = primitive.color or COLOR_BLACK
			instance.TextTransparency = primitive.transparency or 0
			instance.Font = text_style.font
		elseif primitive.image then
			instance, fresh = self:acquire<<ImageLabel>>("ImageLabel")
			instance.BackgroundTransparency = 1
			instance.Image = primitive.image
			instance.ImageColor3 = primitive.color or COLOR_WHITE
			instance.ImageTransparency = primitive.transparency or 0
		elseif primitive.hit_state then
			instance, fresh = self:acquire<<ImageButton>>("ImageButton")
			instance.BackgroundTransparency = 1
			instance.ImageTransparency = 1
			instance.AutoButtonColor = false
			instance.Selectable = false
			if fresh then
				instance.Activated:Connect(function()
					const hit = self.hit_targets[instance :: ImageButton]
					if hit then
						hit.activated = true
					end
				end)
			end
			self.hit_targets[instance] = primitive.hit_state
			primitive.hit_state.state = instance.GuiState
		else
			instance, fresh = self:acquire<<Frame>>("Frame")
			instance.BackgroundColor3 = primitive.color or COLOR_WHITE
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
			corner.TopLeftRadius = UDim.new(0, primitive.round.tl)
			corner.TopRightRadius = UDim.new(0, primitive.round.tr)
			corner.BottomLeftRadius = UDim.new(0, primitive.round.bl)
			corner.BottomRightRadius = UDim.new(0, primitive.round.br)
			corner.Parent = instance
		end
	end

	for _, pool in self.pools do
		for i = pool.used + 1, #pool.instances do
			const instance = pool.instances[i]
			if instance:IsA("GuiObject") then
				instance.Visible = false
			else
				instance.Parent = nil
			end
		end
	end

	debug.profileend()
end

function roblox_frontend.destroy(self: Renderer)
	for _, pool in self.pools do
		for _, instance in pool.instances do
			instance:Destroy()
		end
	end
	table.clear(self.pools)
	table.clear(self.hit_targets)
end

return table.freeze(roblox_frontend)
