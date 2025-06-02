shader_type canvas_item;

uniform bool u_locked;
uniform bool u_fixed;

uniform vec3 u_color_replace : source_color = vec3(1.0);
uniform vec3 u_color_locked : source_color = vec3(1.0);
uniform vec3 u_color_fixed : source_color = vec3(1.0);

void fragment()
{
	vec4 color = texture(TEXTURE, UV);
	if(u_locked && color.rgb == u_color_replace)
	{
		color.rgb = u_color_locked;
	}
	else if(u_fixed && color.rgb == u_color_replace)
	{
		color.rgb = u_color_fixed;
	}
	COLOR = color;
}
