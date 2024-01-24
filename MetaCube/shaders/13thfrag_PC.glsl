#version 430

out vec4 fragColor;

in vec2 fragCord;


uniform vec2 resolution;
uniform float time;

float sdCircle( vec2 p, float r )
{
    return length(p) - r;
}

vec2 rotate2D(vec2 uv, float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c) * uv;
}

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;
    uv = rotate2D(uv, time);

    float r = 0.1; // Radius of hexagons

    // New values from wolf ram aplha
    // Center
    vec2 hex0Pos = vec2(0.0, 0.0); // Old Value: 0.0, 0.0
   // Inner Ring
    vec2 hex1Pos = vec2(0.260,0.150); // Old Value: 0.25, 0.15 || New Old: 0.433,0.25
    vec2 hex2Pos = vec2(0.000,0.300); // Old Value: -0.25, 0.15 || New Old: 0.0,0.5
    vec2 hex3Pos = vec2(-0.260,0.150); // Old Value: 0.25, -0.15 || New Old: -0.433,0.25
    vec2 hex4Pos = vec2(-0.260,-0.150); // Old Value: -0.25, -0.15 || New Old: -0.433,-0.25
    vec2 hex5Pos = vec2(0.000,-0.300); // Old Value: 0.0, 0.25 || New Old: 0.0,-0.5
    vec2 hex6Pos = vec2(0.260,-0.150); // Old Value: 0.0, -0.25 || New Old: 0.433,-0.25
   // Outer Ring
    vec2 hex7Pos = vec2(0.520,0.300); // Old Value: 0.612,0.354
    vec2 hex8Pos = vec2(0.000,0.600); // Old Value: 0.000,0.707
    vec2 hex9Pos = vec2(-0.520,0.300); // Old Value: -0.612,0.354
    vec2 hex10Pos = vec2(-0.520,-0.300); // Old Value: -0.612,-0.354
    vec2 hex11Pos = vec2(0.000,-0.600); // Old Value: 0.000,-0.707
    vec2 hex12Pos = vec2(0.520,-0.300); // Old Value: 0.612,-0.354


    //Rotations
    vec2 rotatedHex0 = rotate2D(uv - hex0Pos, time);
    vec2 rotatedHex1 = rotate2D(uv - hex1Pos, time);
    vec2 rotatedHex2 = rotate2D(uv - hex2Pos, time);
    vec2 rotatedHex3 = rotate2D(uv - hex3Pos, time);
    vec2 rotatedHex4 = rotate2D(uv - hex4Pos, time);
    vec2 rotatedHex5 = rotate2D(uv - hex5Pos, time);
    vec2 rotatedHex6 = rotate2D(uv - hex6Pos, time);

    vec2 rotatedHex7 = rotate2D(uv - hex7Pos, time);
    vec2 rotatedHex8 = rotate2D(uv - hex8Pos, time);
    vec2 rotatedHex9 = rotate2D(uv - hex9Pos, time);
    vec2 rotatedHex10 = rotate2D(uv - hex10Pos, time);
    vec2 rotatedHex11 = rotate2D(uv - hex11Pos, time);
    vec2 rotatedHex12 = rotate2D(uv - hex12Pos, time);


    float d0 = sdCircle(rotatedHex0, r);


    float d1 = sdCircle(rotatedHex1, r);
    float d2 = sdCircle(rotatedHex2, r);
    float d3 = sdCircle(rotatedHex3, r);
    float d4 = sdCircle(rotatedHex4, r);
    float d5 = sdCircle(rotatedHex5, r);
    float d6 = sdCircle(rotatedHex6, r);

    float d7 = sdCircle(rotatedHex7, r);
    float d8 = sdCircle(rotatedHex8, r);
    float d9 = sdCircle(rotatedHex9, r);
    float d10 = sdCircle(rotatedHex10, r);
    float d11 = sdCircle(rotatedHex11, r);
    float d12 = sdCircle(rotatedHex12, r);

    vec3 color = vec3(0.0); // Initialize color

    float glowIntensity = 0.09 ; // Adjust this value for more or less glow

    // Apply variable color for each hexagon based on time and add glow
    if (d0 < 0.0) color += vec3(sin(time), cos(time), sin(time * 12.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d0));

    if (d1 < 0.0) color += vec3(cos(time), sin(time * 3.0), cos(time)) * (0.5 - smoothstep(0.0, glowIntensity, -d1));
    if (d2 < 0.0) color += vec3(sin(time * 5.0), cos(time), sin(time)) * (0.5 - smoothstep(0.0, glowIntensity, -d2));
    if (d3 < 0.0) color += vec3(cos(time * 7.0), sin(time), cos(time * 7.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d3));
    if (d4 < 0.0) color += vec3(sin(time), cos(time * 9.0), sin(time * 9.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d4));
    if (d5 < 0.0) color += vec3(sin(time), cos(time * 9.0), sin(time * 9.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d5));
    if (d6 < 0.0) color += vec3(sin(time), cos(time * 9.0), sin(time * 9.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d6));

    if (d7 < 0.0) color += vec3(cos(time), sin(time * 30.0), cos(time)) * (0.5 - smoothstep(0.0, glowIntensity, -d7));
    if (d8 < 0.0) color += vec3(sin(time * 50.0), cos(time), sin(time)) * (0.5 - smoothstep(0.0, glowIntensity, -d8));
    if (d9 < 0.0) color += vec3(cos(time * 70.0), sin(time), cos(time * 70.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d9));
    if (d10 < 0.0) color += vec3(sin(time), cos(time * 90.0), sin(time * 90.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d10));
    if (d11 < 0.0) color += vec3(sin(time), cos(time * 90.0), sin(time * 90.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d11));
    if (d12 < 0.0) color += vec3(sin(time), cos(time * 90.0), sin(time * 90.0)) * (0.5 - smoothstep(0.0, glowIntensity, -d12));

    fragColor = vec4(color, 1.0); // Set fragment color



}
