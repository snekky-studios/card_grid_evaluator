shader_type canvas_item;

uniform bool u_locked;
uniform bool u_fixed;

uniform vec3 u_color_replace : source_color = vec3(1.0);
uniform vec3 u_color_locked : source_color = vec3(1.0);
uniform vec3 u_color_fixed : source_color = vec3(1.0);

bool is_equal_approx(vec3 value0, vec3 value1, float tolerance)
{
	bool is_equal = true;
	if((value0.r < (value1.r - tolerance)) || (value0.r > (value1.r + tolerance)))
	{
		is_equal = false;
	}
	else if((value0.g < (value1.g - tolerance)) || (value0.g > (value1.g + tolerance))){
		is_equal = false;
	}
	else if((value0.b < (value1.b - tolerance)) || (value0.b > (value1.b + tolerance))){
		is_equal = false;
	}
	return is_equal;
}

void fragment()
{
	vec4 color = texture(TEXTURE, UV);
	bool is_equal = is_equal_approx(color.rgb, u_color_replace, 0.001);
	if(u_locked && is_equal)
	{
		color.rgb = u_color_locked;
	}
	else if(u_fixed && is_equal)
	{
		color.rgb = u_color_fixed;
	}
	COLOR = color;
}
