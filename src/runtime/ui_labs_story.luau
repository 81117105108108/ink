local RunService = game:GetService("RunService")

local rect_sized = require("../rects/rect_sized")
local roblox_renderer = require("./roblox_renderer")
local scope = require("./scope")
local types = require("../types")
local roblox_intent = require("./roblox_intent")
local update_intent_state = require("./update_intent_state")

type Cleanup = () -> ()

type GenericInfo<T> = { __old: T, __new: T }

type SubscribeListener = (values: { [string]: unknown }, info: { [string]: GenericInfo<unknown> }) -> ()

type GenericProperties = {
	controls: { [string]: unknown },
	target: GuiObject,
	converted: { [string]: unknown },
	subscribe: (listener: SubscribeListener) -> Cleanup,
}

type GenericStory<C = nil> = {
	name: string?,
	summary: string?,
	cleanup: Cleanup?,
	controls: C?,
	render: (properties: GenericProperties) -> Cleanup?,
}

const function ui_lab_story<C>(story: types.Story<C>): GenericStory<C>
	return {
		name = story.name,
		summary = story.summary,
		cleanup = story.cleanup,
		controls = story.controls,
		render = function(generic_properties)
			const root_scope = scope.new()
			const renderer = roblox_renderer.new(generic_properties.target)

			const catcher = Instance.new("Frame")
			catcher.Name = "InkInputCatcher"
			catcher.BackgroundTransparency = 1
			catcher.Size = UDim2.fromScale(1, 1)
			catcher.ZIndex = 2_000_000_000
			catcher.Active = true
			catcher.Parent = generic_properties.target

			const intent = roblox_intent.new(catcher, function(point)
				return point - generic_properties.target.AbsolutePosition
			end)

			const ink_properties: types.StoryProperties<C> = {
				controls = table.clone(generic_properties.controls) :: types.ProcessControls<C>,
				target = generic_properties.target,
				target_bounds = Rect.new(),
				scope = root_scope,
			}

			const unsubscribe = generic_properties.subscribe(function(values)
				ink_properties.controls = values :: any
			end)

			const connection = RunService.PreRender:Connect(function(dt: number)
				ink_properties.target_bounds =
					rect_sized(generic_properties.target.AbsoluteSize.X, generic_properties.target.AbsoluteSize.Y)

				root_scope:next(dt)
				update_intent_state(intent.state, intent:take())
				const composite = story.render(ink_properties)
				intent:commit(composite)
				renderer:render(composite)
			end)

			return function()
				connection:Disconnect()
				renderer:destroy()
				intent:destroy()
				unsubscribe()
			end
		end,
	}
end

return ui_lab_story
