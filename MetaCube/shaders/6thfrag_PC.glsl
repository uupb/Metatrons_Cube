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

    float r = 0.05; // Radius of hexagons
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

    vec3 color = vec3(0.0, 0.0, 0.0); // Initialize to black as the default background color

    // Set a glow boundary threshold, where the glow will be visible
    float glowBoundary = r + glowWidth;

    // Apply color and glow for each hexagon
    // The glow is stronger at the edges and fades out
    if (abs(d1) < glowBoundary) {
        float alpha = 1.0 - smoothstep(r, glowBoundary, abs(d1));
        color += alpha * sin(vec3(0.2, 0.8, 0.9) * time + vec3(0.0, 2.0, 4.0)); // Color change with time for hexagon 1
    }

    // Calculate the glow effect and apply color for each hexagon
    // Make sure to clamp the color values to prevent overflow
    float edgeDist1 = smoothstep(glowWidth, 0.0, abs(d1) - r);
    float edgeDist2 = smoothstep(glowWidth, 0.0, abs(d2) - r);
    float edgeDist3 = smoothstep(glowWidth, 0.0, abs(d3) - r);
    float edgeDist4 = smoothstep(glowWidth, 0.0, abs(d4) - r);
    float edgeDist5 = smoothstep(glowWidth, 0.0, abs(d5) - r);

    vec3 hexColor1 = vec3(1.0, 0.0, 0.0); // Red color for hexagon 1
    vec3 hexColor2 = vec3(0.0, 1.0, 0.0); // Green color for hexagon 2
    vec3 hexColor3 = vec3(0.0, 0.0, 1.0); // Blue color for hexagon 3
    vec3 hexColor4 = vec3(1.0, 1.0, 0.0); // Yellow color for hexagon 4
    vec3 hexColor5 = vec3(0.0, 1.0, 1.0); // Cyan color for hexagon 5

    vec3 finalColor1 = mix(hexColor1, vec3(0.0), edgeDist1);
    vec3 finalColor2 = mix(hexColor2, vec3(0.0), edgeDist2);
    vec3 finalColor3 = mix(hexColor3, vec3(0.0), edgeDist3);
    vec3 finalColor4 = mix(hexColor4, vec3(0.0), edgeDist4);
    vec3 finalColor5 = mix(hexColor5, vec3(0.0), edgeDist5);

    finalColor1 = clamp(finalColor1, 0.0, 1.0); // Clamp the color for hexagon 1
    finalColor2 = clamp(finalColor2, 0.0, 1.0); // Clamp the color for hexagon 2
    finalColor3 = clamp(finalColor3, 0.0, 1.0); // Clamp the color for hexagon 3
    finalColor4 = clamp(finalColor4, 0.0, 1.0); // Clamp the color for hexagon 4
    finalColor5 = clamp(finalColor5, 0.0, 1.0); // Clamp the color for hexagon 5

    // Combine colors from all hexagons if within their respective boundaries
    if (abs(d1) < r) color += finalColor1;
    if (abs(d2) < r) color += finalColor2;
    if (abs(d3) < r) color += finalColor3;
    if (abs(d4) < r) color += finalColor4;
    if (abs(d5) < r) color += finalColor5;

    // Clamp the final color to prevent any component from exceeding the range [0, 1]
    color = clamp(color, 0.0, 1.0);

    fragColor = vec4(color, 1.0); // Output the final color

}
