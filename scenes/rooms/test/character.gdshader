shader_type canvas_item;
render_mode skip_vertex_transform, unshaded;
uniform vec2 target_resolution = vec2(320.0, 180.0);
uniform float colors_per_channel: hint_range(1.0, 64.0, 1.0) = 8.0;
uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;

void fragment() {
	vec2 uv = floor(SCREEN_UV * target_resolution) / target_resolution;
	vec3 color = texture(screen_texture, uv).rgb;
	vec3 quantized_color = floor(color * colors_per_channel) / colors_per_channel;
	COLOR = vec4(quantized_color, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
