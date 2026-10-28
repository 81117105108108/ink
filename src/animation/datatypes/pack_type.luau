const pack_type: { [string]: (value: any) -> { number } } = {
	number = function(value: number)
		return { value }
	end,
	vector = function(value: vector)
		return { value.x, value.y, value.z }
	end,
	Color3 = function(value: Color3)
		return { value.R, value.G, value.B }
	end,
	ColorSequenceKeypoint = function(value: ColorSequenceKeypoint)
		return { value.Time, value.Value.R, value.Value.G, value.Value.B }
	end,
	DateTime = function(value: DateTime)
		return { value.UnixTimestampMillis }
	end,
	CFrame = function(value: CFrame)
		return { value:GetComponents() }
	end,
	NumberRange = function(value: NumberRange)
		return { value.Min, value.Max }
	end,
	NumberSequenceKeypoint = function(value: NumberSequenceKeypoint)
		return { value.Time, value.Value, value.Envelope }
	end,
	PhysicalProperties = function(value: PhysicalProperties)
		return {
			value.Density,
			value.Friction,
			value.Elasticity,
			value.FrictionWeight,
			value.ElasticityWeight,
			value.AcousticAbsorption,
		}
	end,
	Ray = function(value: Ray)
		return {
			value.Origin.X,
			value.Origin.Y,
			value.Origin.Z,
			value.Direction.X,
			value.Direction.Y,
			value.Direction.Z,
		}
	end,
	Rect = function(value: Rect)
		return {
			value.Min.X,
			value.Min.Y,
			value.Max.X,
			value.Max.Y,
		}
	end,
	Region3 = function(value: Region3)
		-- FUTURE: support rotated Region3s if/when they become constructable
		return {
			value.CFrame.X,
			value.CFrame.Y,
			value.CFrame.Z,
			value.Size.X,
			value.Size.Y,
			value.Size.Z,
		}
	end,
	Vector2 = function(value: Vector2)
		return { value.X, value.Y }
	end,
	Vector3 = function(value: Vector3)
		return { value.X, value.Y, value.Z }
	end,
	UDim = function(value: UDim)
		return { value.Scale, value.Offset }
	end,
	UDim2 = function(value: UDim2)
		return { value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset }
	end,
}

return pack_type
