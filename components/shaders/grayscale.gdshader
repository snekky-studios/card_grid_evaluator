shader_type canvas_item;

uniform bool u_enabled = false;
uniform float u_intensity : hint_range(0.0, 1.0);

float grayscale(vec4 color)
{
	return (color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722);
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if(u_enabled)
	{
		float gray = grayscale(color);
		color.rgb = u_intensity * vec3(gray, gray, gray);
	}
	COLOR = color;
}
