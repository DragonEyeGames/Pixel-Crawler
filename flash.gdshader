shader_type canvas_item;

uniform float whiteness : hint_range(0.0, 1.0) = 0.0;

uniform sampler2D noise_tex : source_color;
uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 c = texture(TEXTURE, UV);
	float noise_value = texture(noise_tex, UV).r;
	if (noise_value < dissolve_amount) {
        discard;
    }
    vec3 white = vec3(1.0);

    // Mix original → white based on "whiteness"
    c.rgb = mix(c.rgb, white, whiteness);

    COLOR = c;
}
