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
    vec3 col = vec3(0.0);

    uv = rotate2D(uv, time);


    // Dot
    col += 0.01 / length(uv);
    //Second Dot
    col += 0.01 / length(uv - vec2(0.25, 0.25));
    //Thrid Dot
    col += 0.01 / length(uv - vec2(-0.25, 0.25));
    //Forth Dot
    col += 0.01 / length(uv - vec2(0.25,-.25));
    //Fifth Dot
    col += 0.01 / length(uv - vec2(-0.25,-.25));

    col *= sin(vec3(0.2, 0.8, 0.9) * time);

    fragColor = vec4(col, 1.0);
}