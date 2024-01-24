#version 430

out vec4 fragColor;

in vec2 fragCord;

uniform vec2 resolution;
uniform float time;

vec2 rotate2D(vec2 uv, float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c) * uv;
}

// Convert from Oklab to linear sRGB
vec3 oklabToLinearSrgb(vec3 lab) {
    float l = lab.x, a = lab.y, b = lab.z;
    float l_ = l + 0.3963377774 * a + 0.2158037573 * b;
    float m_ = l - 0.1055613458 * a - 0.0638541728 * b;
    float s_ = l - 0.0894841775 * a - 1.2914855480 * b;

    float l = l_ * l_ * l_; // Renamed to avoid conflict
    float m = m_ * m_ * m_;
    float s = s_ * s_ * s_;

    return mat3( 4.0767416621, -3.3077115913, 0.2309699292,
                -1.2684380046,  2.6097574011, -0.3413193965,
                -0.0041960863, -0.7034186147,  1.7076147010) * vec3(l, m, s);
}

void main() {
    // Centers
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;

    // Rotate UV coordinates
    uv = rotate2D(uv, time);

    vec3 col = vec3(0.0); // Initialize color

    // Dots
    float dotIntensity = 0.01;
    col += dotIntensity / length(uv); // First Dot
    col += dotIntensity / length(uv - vec2(0.25, 0.25)); // Second Dot
    col += dotIntensity / length(uv - vec2(-0.25, 0.25)); // Third Dot
    col += dotIntensity / length(uv - vec2(0.25,-0.25)); // Fourth Dot
    col += dotIntensity / length(uv - vec2(-0.25,-0.25)); // Fifth Dot

    // Create a rainbow effect in Oklab
    float hue = time * 0.1; // Adjust for speed
    vec3 oklabColor = vec3(0.8, cos(hue) * 0.2, sin(hue) * 0.2); // Example Oklab values

    // Convert Oklab to linear sRGB
    vec3 rgbColor = oklabToLinearSrgb(oklabColor);

    // Apply rainbow color
    col *= rgbColor;

    fragColor = vec4(col, 1.0);
}
