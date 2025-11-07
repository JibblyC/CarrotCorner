shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 1.0;

void fragment() {
    vec2 size = TEXTURE_PIXEL_SIZE * outline_width;
    
    // Sample the texture
    vec4 sprite_color = texture(TEXTURE, UV);
    
    // Sample surrounding pixels to detect edges
	// Does this based on alpha channel, if any of them are hit (not 0) we know its next to a pixel
	// If current pixel is transparent AND has solid neighbors: Draw outline
	// If current pixel is solid: Draw sprite (outline calculation is ignored)
    float outline = 0.0;
    outline += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    outline += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
    outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
    outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
    outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
    outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	
	vec4 base = texture(TEXTURE, UV);
    
    // Only show outline where sprite is transparent
    if (base.a < 0.1 && outline > 0.0) {
        COLOR = outline_color;
    } else {
        // Make everything else transparent
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
