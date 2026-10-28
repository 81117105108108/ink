local RunService = game:GetService("RunService")

local roblox_frontend = require("./roblox_frontend")
local scope = require("./scope")
local types = require("../types")

const function story(render_ui: (scope: scope.Scope, props: any) -> types.Composite)
	return function(props: { read target: Instance })
		const frontend = roblox_frontend.new(props.target)
		const scope = scope.new()
		const connection = RunService.PreRender:Connect(function(dt)
			scope:next(dt)
			const composite = render_ui(scope, props)
			frontend:render_composite(composite)
		end)
		return function()
			connection:Disconnect()
			frontend:destroy()
		end
	end
end

return story
