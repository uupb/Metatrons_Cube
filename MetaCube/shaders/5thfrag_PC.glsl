#version 430

out vec4 fragColor;

in vec2 fragCord;

uniform vec2 resolution;
uniform float time;

float sdHexagon(in vec2 p, in float r) {
    const vec3 k = vec3(-0.866025404, 0.5, 0.577350269);
    p = abs(p);
    p -= 2.0 * min(dot(k.xy, p), 0.0) * k.xy;
    p -= vec2(clamp(p.x, -k.z * r, k.z * r), r);
    return length(p) * sign(p.y);
}

vec2 rotate2D(vec2 uv, float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c) * uv;
}

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;

    float r = 0.1; // Radius of hexagons
    float glowWidth = 0.01; // Width of the glow

    vec2 hex1Pos = vec2(0.0, 0.0); // Center
    vec2 hex2Pos = vec2(0.25, 0.25); // Top Right
    vec2 hex3Pos = vec2(-0.25, 0.25); // Top Left
    vec2 hex4Pos = vec2(0.25, -0.25); // Bottom Right
    vec2 hex5Pos = vec2(-0.25, -0.25); // Bottom Left

    vec2 rotatedHex1 = rotate2D(uv - hex1Pos, time);
    vec2 rotatedHex2 = rotate2D(uv - hex2Pos, time);
    vec2 rotatedHex3 = rotate2D(uv - hex3Pos, time);
    vec2 rotatedHex4 = rotate2D(uv - hex4Pos, time);
    vec2 rotatedHex5 = rotate2D(uv - hex5Pos, time);

    float d1 = sdHexagon(rotatedHex1, r);
    float d2 = sdHexagon(rotatedHex2, r);
    float d3 = sdHexagon(rotatedHex3, r);
    float d4 = sdHexagon(rotatedHex4, r);
    float d5 = sdHexagon(rotatedHex5, r);

    vec3 color = vec3(0.0); // Initialize to black

    // Apply solid color and glow for each hexagon
    float edgeDist1 = smoothstep(glowWidth, 0.0, abs(d1) - r);
    float edgeDist2 = smoothstep(glowWidth, 0.0, abs(d2) - r);
    float edgeDist3 = smoothstep(glowWidth, 0.0, abs(d3) - r);
    float edgeDist4 = smoothstep(glowWidth, 0.0, abs(d4) - r);
    float edgeDist5 = smoothstep(glowWidth, 0.0, abs(d5) - r);

    color += (1.0 - edgeDist1) * sin(vec3(0.2, 0.8, 0.9) * time); // Color change for hexagon 1
    color += (1.0 - edgeDist2) * sin(vec3(0.3, 0.7, 0.6) * time); // Color change for hexagon 2
    color += (1.0 - edgeDist3) * sin(vec3(0.4, 0.6, 0.5) * time); // Color change for hexagon 3
    color += (1.0 - edgeDist4) * sin(vec3(0.5, 0.5, 0.4) * time); // Color change for hexagon 4
    color += (1.0 - edgeDist5) * sin(vec3(0.6, 0.4, 0.3) * time); // Color change for hexagon 5

    fragColor = vec4(color, 1.0);
}
