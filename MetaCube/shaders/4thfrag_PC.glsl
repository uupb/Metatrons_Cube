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
    float glowIntensity = 1.0 ; // Intensity of the glow

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
    if (d1 < 0.0) color += vec3(1.0, 0.0, 0.0); // Red inside hexagon 1
    color += vec3(1.0, 0.0, 0.0) * smoothstep(r, r + glowIntensity, -d1); // Glow

    if (d2 < 0.0) color += vec3(0.0, 1.0, 0.0); // Green inside hexagon 2
    color += vec3(0.0, 1.0, 0.0) * smoothstep(r, r + glowIntensity, -d2); // Glow

    if (d3 < 0.0) color += vec3(0.0, 0.0, 1.0); // Blue inside hexagon 3
    color += vec3(0.0, 0.0, 1.0) * smoothstep(r, r + glowIntensity, -d3); // Glow

    if (d4 < 0.0) color += vec3(1.0, 1.0, 0.0); // Yellow inside hexagon 4
    color += vec3(1.0, 1.0, 0.0) * smoothstep(r, r + glowIntensity, -d4); // Glow

    if (d5 < 0.0) color += vec3(0.0, 1.0, 1.0); // Cyan inside hexagon 5
    color += vec3(0.0, 1.0, 1.0) * smoothstep(r, r + glowIntensity, -d5); // Glow

    fragColor = vec4(color, 1.0);
}
