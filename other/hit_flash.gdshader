shader_type canvas_item;

uniform bool active = false;
uniform vec4 flash_color : source_color = vec4(1.0, 0.2, 0.2, 0.4);

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);
    
    if (active) {
        // Mix the original color with the flash_color.rgb
        // The 4th value of flash_color (the 0.2) now acts as the "intensity"
        vec3 blended_rgb = mix(texture_color.rgb, flash_color.rgb, flash_color.a);
        
        COLOR = vec4(blended_rgb, texture_color.a);
    } else {
        COLOR = texture_color;
    }
}