shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest_mipmap;

void fragment(){
	
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV).rgba;
	
	COLOR = vec4(1.0 - color.rgb, color.a);
}