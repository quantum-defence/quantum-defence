shader_type canvas_item;

uniform vec2 tiled_factor = vec2(5.0, 5.0);
uniform float aspect_ratio = 0.5;

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspect_ratio;
	
	vec2 waves_uv_offset;
	waves_uv_offset.x = cos(TIME) * 0.05;
	waves_uv_offset.y = cos(TIME) * 0.05;

	COLOR = texture(TEXTURE, tiled_uvs + waves_uv_offset); 		
}