// This draws JUST the outline, relying on the regular camera rendering for everything else.
shader_type canvas_item;

uniform float thickness = 5.0;
uniform vec4 color: source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	vec4 raw_tex = texture(TEXTURE, UV);

	/*
	Sample the pixels in a cross shape, depending on the size and needs, also doing diagonal samples could help
	*/
	vec4 temp0 = texture(TEXTURE, UV + vec2(SCREEN_PIXEL_SIZE.x * thickness, 0.0));
	vec4 temp1 = texture(TEXTURE, UV + vec2(-SCREEN_PIXEL_SIZE.x * thickness, 0.0));
	vec4 temp2 = texture(TEXTURE, UV + vec2(0.0, SCREEN_PIXEL_SIZE.y * thickness));
	vec4 temp3 = texture(TEXTURE, UV + vec2(0.0, -SCREEN_PIXEL_SIZE.y * thickness));

	COLOR.rgb = color.rgb; // We only need the highlight color

	// If any sample is opaque, we want to count that as opaque
	float alpha = max(
		max(temp0.a, temp1.a),
		max(temp2.a, temp3.a)
	);
	
	float red_over = max(
		max(temp0.r, temp1.r),
		max(temp2.r, temp3.r)
	);
	
	alpha *= step(1.0, red_over); // The red-over shader blows it out red so anything less is an occluding object
	// Because we just use the highlight color, we DON'T want to draw over the original, so invert it.
	COLOR.a = alpha * (1.0 - step(1.0, raw_tex.r)) * color.a;
	
	int mode = 0;
	switch (mode)
	{
		case 0: // Regular
			break;
		case 1: // The viewport as the camera renders it, should look normal except anything set to highlight should be red
			COLOR = raw_tex;
			break;
		case 2: // Anything set to highlight will show up as white, everything else black
			COLOR.rgb = vec3(step( 1.0, raw_tex.r));
			COLOR.a = 1.0;
			break;
	};
	
	//COLOR.rgb = raw_tex.rgb;
	//COLOR.rgb = vec3(0.0, 0., 1.0);
	//COLOR.r = step( 1.0, raw_tex.r);
	//COLOR.gb = vec2(0.0);
	//COLOR.a = 1.0;
}