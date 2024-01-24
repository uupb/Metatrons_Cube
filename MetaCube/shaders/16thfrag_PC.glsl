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

float sdSegment( in vec2 p, in vec2 a, in vec2 b )
{
    vec2 pa = p-a, ba = b-a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h );
}

vec2 rotate2D(vec2 uv, float a) {
    float s = sin(-a);
    float c = cos(-a);
    return mat2(c, -s, s, c) * uv;
}

// new from palette [[0.244 0.102 0.600] [0.378 0.900 0.237] [0.700 1.392 0.006] [4.643 4.744 2.001]]
// Old from vid: [0.5, 0.5, 0.5], [0.5, 0.5, 0.5],[1.0, 1.0, 1.0],[0.263, 0.416, 0.557]
// third palette for lines [[-0.672 3.138 0.448] [3.138 0.485 0.968] [-3.142 1.553 3.138] [3.138 0.801 1.248]]

vec3 palette( float t ) {
    vec3 a = vec3(0.244, 0.102, 0.600);
    vec3 b = vec3(0.378, 0.900, 0.237);
    vec3 c = vec3(0.700, 1.392, 0.006);
    vec3 d = vec3(4.643, 4.744, 2.001);

    return a + b*cos( 6.28318*(c*t+d) );
}

vec3 palette2( float t ) {
    vec3 a = vec3(-0.672, 3.138, 0.448);
    vec3 b = vec3(3.138, 0.485, 0.968);
    vec3 c = vec3(-3.142, 1.553, 3.138);
    vec3 d = vec3(3.138, 0.801, 1.248);

    return a + b*cos( 6.28318*(c*t+d) );
}


void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;
    vec2 uv0 = uv;

    uv = rotate2D(uv, time);

    float r = 0.095; // Radius of circles

    // Fract offset

    //uv *= 2.0;
    //uv = fract(uv);
    //uv -= 0.5;


    // ORBS VVVVVVV

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

    // sdCircle builds the orbs

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
    vec3 col = palette(length(uv0) * time);

    // Example of modifying color based on distance to each circle
    float blendFactor = 0.75; // Adjust this for blending strength

    if (sdCircle(rotatedHex0, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex1, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex2, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex3, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex4, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex5, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex6, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex7, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex8, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex9, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex10, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex11, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }
    if (sdCircle(rotatedHex12, r) < 0.0) {
        color = mix(color, col, blendFactor);
    }



    // core lines

    // Using the positions of the outer circles to define extended lines
    vec2 line1Start = hex1Pos; // Top right inner circle
    vec2 line1End = hex4Pos; // Bottom left inner circle

    vec2 line2Start = hex2Pos; // Top inner circle
    vec2 line2End = hex5Pos; // Bottom inner circle

    vec2 line3Start = hex3Pos; // Top left inner circle
    vec2 line3End = hex6Pos; // Bottom right inner circle

    vec2 line4Start = hex7Pos; // Top right outer circle
    vec2 line4End = hex10Pos; // Bottom left outer circle

    vec2 line5Start = hex8Pos; // Top outer circle
    vec2 line5End = hex11Pos; // Bottom outer circle

    vec2 line6Start = hex9Pos; // Top left outer circle
    vec2 line6End = hex12Pos; // Bottom right outer circle

    // Calculate distances to the line segments
    float dLine1 = sdSegment(uv, line1Start, line1End);
    float dLine2 = sdSegment(uv, line2Start, line2End);
    float dLine3 = sdSegment(uv, line3Start, line3End);
    float dLine4 = sdSegment(uv, line4Start, line4End);
    float dLine5 = sdSegment(uv, line5Start, line5End);
    float dLine6 = sdSegment(uv, line6Start, line6End);

    // Define a threshold for the line width
    float lineWidth = 0.005; // Adjust this value to set the line width

    // Get the color for the lines from palette2
    vec3 lineColor = palette2(time);

    // Mix the colors if the distance to the line is within the threshold
    if (dLine1 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dLine1));
    if (dLine2 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dLine2));
    if (dLine3 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dLine3));
    if (dLine4 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dLine4));
    if (dLine5 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dLine5));
    if (dLine6 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dLine6));



    // Outter ring lines

    // Define a threshold for the line width
    float lineWidth2 = 0.01; // Adjust this value to set the line width

    // Define lines connecting the outer circles
    float dHex7Hex8 = sdSegment(uv, hex7Pos, hex8Pos);
    float dHex8Hex9 = sdSegment(uv, hex8Pos, hex9Pos);
    float dHex9Hex10 = sdSegment(uv, hex9Pos, hex10Pos);
    float dHex10Hex11 = sdSegment(uv, hex10Pos, hex11Pos);
    float dHex11Hex12 = sdSegment(uv, hex11Pos, hex12Pos);
    float dHex12Hex7 = sdSegment(uv, hex12Pos, hex7Pos);


    // Mix the colors if the distance to the line is within the threshold
    if (dHex7Hex8 < lineWidth2) color = mix(color, lineColor, smoothstep(lineWidth2, 0.0, dHex7Hex8));
    if (dHex8Hex9 < lineWidth2) color = mix(color, lineColor, smoothstep(lineWidth2, 0.0, dHex8Hex9));
    if (dHex9Hex10 < lineWidth2) color = mix(color, lineColor, smoothstep(lineWidth2, 0.0, dHex9Hex10));
    if (dHex10Hex11 < lineWidth2) color = mix(color, lineColor, smoothstep(lineWidth2, 0.0, dHex10Hex11));
    if (dHex11Hex12 < lineWidth2) color = mix(color, lineColor, smoothstep(lineWidth2, 0.0, dHex11Hex12));
    if (dHex12Hex7 < lineWidth2) color = mix(color, lineColor, smoothstep(lineWidth2, 0.0, dHex12Hex7));


    // inner ring lines

    // Define lines connecting the inner circles
    float dHex1Hex2 = sdSegment(uv, hex1Pos, hex2Pos);
    float dHex2Hex3 = sdSegment(uv, hex2Pos, hex3Pos);
    float dHex3Hex4 = sdSegment(uv, hex3Pos, hex4Pos);
    float dHex4Hex5 = sdSegment(uv, hex4Pos, hex5Pos);
    float dHex5Hex6 = sdSegment(uv, hex5Pos, hex6Pos);
    float dHex6Hex1 = sdSegment(uv, hex6Pos, hex1Pos);

    // Mix the colors if the distance to the line is within the threshold
    if (dHex1Hex2 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dHex1Hex2));
    if (dHex2Hex3 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dHex2Hex3));
    if (dHex3Hex4 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dHex3Hex4));
    if (dHex4Hex5 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dHex4Hex5));
    if (dHex5Hex6 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dHex5Hex6));
    if (dHex6Hex1 < lineWidth) color = mix(color, lineColor, smoothstep(lineWidth, 0.0, dHex6Hex1));







    fragColor = vec4(color, 1.0); // Set fragment color


}
