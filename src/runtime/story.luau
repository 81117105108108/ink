local RunService = game:GetService("RunService")

local renderer = require("./renderer")
local scope = require("./scope")
local types = require("../types")

const function story(render_ui: (scope: scope.Scope, props: any) -> types.Composite)
	return function(props: { read target: Instance })
		const renderer = renderer.new(props.target)
		const scope = scope.new()
		const connection = RunService.PreRender:Connect(function()
			scope:flip_frames()
			const composite = render_ui(scope, props)
			renderer:render_composite(composite)
		end)
		return function()
			connection:Disconnect()
			renderer:destroy()
		end
	end
end

return story
