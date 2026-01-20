class_name ColorUtil extends Object

## converts rbga32 hex color to `Color`
static func format_hex(hex: int) -> Color:
	return Color.hex(hex)

## converts array of 3 ints to `Color`
static func format_rgb(color_arr: Array) -> Color:
	if (color_arr.size() == 3):
		return Color8(int(color_arr[0]), int(color_arr[1]), int(color_arr[2]))
	else:
		print("WARNING: invalid color array: " + str(color_arr))
		return Color.WHITE

## converts `Color` to rgba32 hex
static func format_color_hex(col: Color) -> int:
	return col.to_rgba32()
