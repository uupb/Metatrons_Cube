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
// trying to make lines more yellowish [[3.138 1.058 0.448] [0.638 0.198 0.138] [-2.002 0.388 3.138] [0.138 1.308 1.248]]

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

vec3 palette3( float t ) {
    vec3 a = vec3(3.138, 1.058, 0.448);
    vec3 b = vec3(0.638, 0.198, 0.138);
    vec3 c = vec3(-2.002, 0.388, 3.138);
    vec3 d = vec3(0.138, 1.308, 1.248);

    return a + b*cos( 6.28318*(c*t+d) );
}

// Utility function to draw a line between two points
void drawLine(vec2 start, vec2 end, vec2 uv, vec3 color, float width, inout vec3 fragColor) {
    float d = sdSegment(uv, start, end);
    if (d < width) {
        fragColor = mix(fragColor, color, smoothstep(width, 0.0, d));
    }
}



void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;
    vec2 uv0 = uv;

    // remove sin to get rid of shake
    uv = rotate2D(uv, (sin(time * 0.5)));
    // uv0 = rotate2D(uv0, (time * -0.75));

    float r = 0.095; // Radius of circles

    // Fract offset

    uv *= 2.0;
    uv = fract(uv);
    uv -= 0.5;


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
    vec3 col = palette(length(uv0) * (sin(time * .25)));

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

    // Line Settings
    // Define a threshold for the line width
    float lineWidth = 0.005; // Adjust this value to set the line width
    float lineWidth1 = 0.0075; // Adjust this value to set the line width
    float lineWidth2 = 0.003; // Adjust this value to set the line width
    float lineWidth3 = 0.009; // Adjust this value to set the line width
    float lineWidth4 = 0.0045; // Adjust this value to set the line width

    // Get the color for the lines from palette2
    vec3 lineColor = palette3(time * 0.15);

    // Define an array of positions for the inner and outer hexagons
    vec2 hexPositions[12] = vec2[](hex1Pos, hex2Pos, hex3Pos, hex4Pos, hex5Pos, hex6Pos,
                                   hex7Pos, hex8Pos, hex9Pos, hex10Pos, hex11Pos, hex12Pos);

    // Midpoints of the outer and inner hexagon sides
    vec2 midPointsInner[6];
    vec2 midPointsOuter[6];

    // Compute midpoints for the hexagon sides
    for (int i = 0; i < 6; ++i) {
        midPointsInner[i] = (hexPositions[i] + hexPositions[(i + 1) % 6]) * 0.5;
        midPointsOuter[i] = (hexPositions[i + 6] + hexPositions[(i + 1) % 6 + 6]) * 0.5;
    }

    // Draw all lines
    for (int i = 0; i < 6; ++i) {
        // Draw lines for the outer hexagon
        drawLine(hexPositions[i + 6], hexPositions[(i + 1) % 6 + 6], uv, lineColor, lineWidth1, color);

        // Draw lines for the inner hexagon
        drawLine(hexPositions[i], hexPositions[(i + 1) % 6], uv, lineColor, lineWidth2, color);

        // Draw the star lines within the inner hexagon
        drawLine(hexPositions[i], hexPositions[(i + 3) % 6], uv, lineColor, lineWidth, color);

        // Draw lines connecting midpoints of the inner hexagon
        drawLine(midPointsInner[i], midPointsInner[(i + 1) % 6], uv, lineColor, lineWidth2, color);

        // Draw lines connecting midpoints of the outer hexagon
        drawLine(midPointsOuter[i], midPointsOuter[(i + 1) % 6], uv, lineColor, lineWidth1, color);

        // Draw lines connecting midpoints of the outer hexagon sides to the vertices of the inner hexagon
        drawLine(midPointsOuter[i], hexPositions[i], uv, lineColor, lineWidth, color);
        drawLine(midPointsOuter[i], hexPositions[(i + 1) % 6], uv, lineColor, lineWidth, color);

        // Draw the inner triangle lines
        for (int i = 0; i < 6; ++i) {
        int nextIndex = (i + 2) % 6; // Skip one vertex to create a triangle line
        drawLine(hexPositions[i], hexPositions[nextIndex], uv, lineColor, lineWidth4, color);
        }

        // Draw the outer triangle lines (larger triangles)
        for (int i = 0; i < 6; ++i) {
        int nextIndex = (i + 2) % 6 + 6; // Skip one vertex to create a triangle line and offset by 6 for outer hexagon
        drawLine(hexPositions[i + 6], hexPositions[nextIndex], uv, lineColor, lineWidth3, color);
        }
    }



    fragColor = vec4(color, 1.0); // Set fragment color


}

