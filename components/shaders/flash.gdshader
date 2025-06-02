shader_type canvas_item;

uniform bool u_enabled = false;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if(u_enabled)
	{
		color.rgb = vec3(1.0, 1.0, 1.0);
	}
	COLOR = color;
}
