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


void main() {

    // centers
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;


    uv = rotate2D(uv, time);


    // Dot calculations with rotation and individual color application
    float dotIntensity = 0.01;
    vec3 color1 = vec3(dotIntensity) / length(rotate2D(uv, time));
    vec3 color2 = vec3(dotIntensity) / length(rotate2D(uv - vec2(0.25, 0.25), time));
    vec3 color3 = vec3(dotIntensity) / length(rotate2D(uv - vec2(-0.25, 0.25), time));
    vec3 color4 = vec3(dotIntensity) / length(rotate2D(uv - vec2(0.25, -0.25), time));
    vec3 color5 = vec3(dotIntensity) / length(rotate2D(uv - vec2(-0.25, -0.25), time));

    // Apply time-varying effect to each color separately
    color1 *= sin(vec3(0.2, 0.8, 0.9) * time);
    color2 *= sin(vec3(0.3, 0.7, 0.6) * time);
    color3 *= sin(vec3(0.4, 0.6, 0.5) * time);
    color4 *= sin(vec3(0.5, 0.5, 0.4) * time);
    color5 *= sin(vec3(0.6, 0.4, 0.3) * time);

    // Sum up all the colors
    vec3 col = color1 + color2 + color3 + color4 + color5;

    fragColor = vec4(col, 1.0);
}