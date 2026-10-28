local RunService = game:GetService("RunService")

local roblox_renderer = require("./roblox_renderer")
local scope = require("./scope")
local types = require("../types")
local roblox_intent = require("./roblox_intent")
local update_intent_state = require("./update_intent_state")

const function story(render_ui: (scope: scope.Scope, props: any) -> types.Composite)
	return function(props: { read target: Instance })
		const renderer = roblox_renderer.new(props.target)
		const scope = scope.new()
		const target = props.target :: GuiObject
		const intent = roblox_intent.new(function(p)
			return p - target.AbsolutePosition
		end)

		const connection = RunService.PreRender:Connect(function(dt)
			scope:next(dt)
			update_intent_state(intent.state, intent:take())
			const composite = render_ui(scope, props)
			intent:commit(composite)
			renderer:render(composite)
		end)

		return function()
			connection:Disconnect()
			intent:destroy()
			renderer:destroy()
		end
	end
end

return story
