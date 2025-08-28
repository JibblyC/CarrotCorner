shader_type canvas_item;

uniform float pulse_strength : hint_range(0.0, 0.3) = 0.25;
uniform float pulse_speed : hint_range(0.0, 5.0) = 1.0;
uniform vec4 pulse_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float pulse = sin(TIME * pulse_speed) * pulse_strength + 1.0;
    COLOR = tex_color * vec4(pulse_color.rgb * pulse, 1.0);
}
