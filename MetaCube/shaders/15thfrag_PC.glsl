#version 430

out vec4 fragColor;

in vec2 fragCord;


uniform vec2 resolution;
uniform float time;

// Function to safely calculate the inverse of d
float inverse(float d) {
    return d != 0.0 ? 0.02 / d : 0.0;  // Returns inverse of d, or 0 if d is zero. 0/.02 is what the ? is
}


float sdCircle( vec2 p, float r )
{
    return length(p) - r;
}

vec2 rotate2D(vec2 uv, float a) {
    float s = sin(-a);
    float c = cos(-a);
    return mat2(c, -s, s, c) * uv;
}

// new from palette [[0.244 0.102 0.600] [0.378 0.900 0.237] [0.700 1.392 0.006] [4.643 4.744 2.001]]
// Old from vid: [0.5, 0.5, 0.5], [0.5, 0.5, 0.5],[1.0, 1.0, 1.0],[0.263, 0.416, 0.557]

vec3 palette( float t ) {
    vec3 a = vec3(0.244, 0.102, 0.600);
    vec3 b = vec3(0.378, 0.900, 0.237);
    vec3 c = vec3(0.700, 1.392, 0.006);
    vec3 d = vec3(4.643, 4.744, 2.001);

    return a + b*cos( 6.28318*(c*t+d) );
}

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;
    uv = rotate2D(uv, time);

    float r = 0.1; // Radius of circles

    // Fract offset
    // uv *= 2.0;
    // uv = fract(uv);
    // uv -= 0.5;

    // Center
    vec2 hex0Pos = vec2(0.0, 0.0); // Old Value in frag13
   // Inner Ring
    vec2 hex1Pos = vec2(0.173,0.100); // Old Value in frag13
    vec2 hex2Pos = vec2(0.000,0.200); // Old Value in frag13
    vec2 hex3Pos = vec2(-0.173,0.100); // Old Value in frag13
    vec2 hex4Pos = vec2(-0.173,-0.100); // Old Value in frag13
    vec2 hex5Pos = vec2(0.000,-0.200); // Old Value in frag13
    vec2 hex6Pos = vec2(0.173,-0.100); // Old Value in frag13
   // Outer Ring
    vec2 hex7Pos = vec2(0.346,0.200); // Old Value in frag13
    vec2 hex8Pos = vec2(0.000,0.400); // Old Value: Old Value in frag13
    vec2 hex9Pos = vec2(-0.346,0.200); // Old Value: Old Value in frag13
    vec2 hex10Pos = vec2(-0.346,-0.200); // Old Value: Old Value in frag13
    vec2 hex11Pos = vec2(0.000,-0.400); // Old Value in frag13
    vec2 hex12Pos = vec2(0.346,-0.200); // Old Value in frag13


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

    float glowIntensity = 1.0; // Adjust this value for more or less glow


    // Apply palette color for each hexagon based on time and inverse of d
    if (d0 < 0.0) color += palette(sin(time)) * clamp(inverse(-d0), 0.0, glowIntensity);
    // Inner
    if (d1 < 0.0) color += palette(cos(time * 3.0)) * clamp(inverse(-d1), 0.0, glowIntensity);
    if (d2 < 0.0) color += palette(sin(time * 5.0)) * clamp(inverse(-d2), 0.0, glowIntensity);
    if (d3 < 0.0) color += palette(cos(time * 7.0)) * clamp(inverse(-d3), 0.0, glowIntensity);
    if (d4 < 0.0) color += palette(sin(time * 9.0)) * clamp(inverse(-d4), 0.0, glowIntensity);
    if (d5 < 0.0) color += palette(cos(time * 12.0)) * clamp(inverse(-d5), 0.0, glowIntensity);
    if (d6 < 0.0) color += palette(sin(time * 15.0)) * clamp(inverse(-d6), 0.0, glowIntensity);
    // Outer
    if (d7 < 0.0) color += palette(cos(time * 15.0)) * clamp(inverse(-d7), 0.0, glowIntensity);
    if (d8 < 0.0) color += palette(sin(time * 12.0)) * clamp(inverse(-d8), 0.0, glowIntensity);
    if (d9 < 0.0) color += palette(cos(time * 9.0)) * clamp(inverse(-d9), 0.0, glowIntensity);
    if (d10 < 0.0) color += palette(sin(time * 7.0)) * clamp(inverse(-d10), 0.0, glowIntensity);
    if (d11 < 0.0) color += palette(cos(time * 5.0)) * clamp(inverse(-d11), 0.0, glowIntensity);
    if (d12 < 0.0) color += palette(sin(time * 3.0)) * clamp(inverse(-d12), 0.0, glowIntensity);

    fragColor = vec4(color, 1.0); // Set fragment color




}
