# Metatrons_Cube
GLSL rendering of Metatron's Cube runs in a python enviroment

Includes the 19 files it took to get to the final display, I have markdown file of note's I made along the way if any one is interested.

## Files
main.py: The primary Python script that initializes an OpenGL window with moderngl_window and loads shaders to produce the final render of a Metatron's Cube.

19thfrag_PC.glsl: The final fragment shader that defines the colors and patterns of the rendering, showcasing a colorful Metatron's Cube. It uses uniform variables for dynamic effects based on resolution and time.

vert_PC.glsl: The vertex shader responsible for defining the vertices' positions, contributing to the geometry of the rendered image.

frag_XX.glsl: A series of 19 fragment shader files (XX represents the stage number from 01 to 19) that illustrate the developmental journey of the shader code, culminating in the final colorful render.

## Render Output
The application's output is a dynamic, colorful render of Metatron's Cube, composed of overlapping circles and polyhedron projections, depicted in a neon color scheme against a dark backdrop.

### Editable options
- The fract offset changes from one cube to as many as you can run just change the mulitplication value
- The Pallette colors are changeable you'll want to use [This website by Ingio Quiez](https://iquilezles.org/articles/palettes/)
- The spin can be changed by messing with the sin multiplication
- The shapes can be swapped you'll just want a new sd from [This other website by Ingio Quiez](https://iquilezles.org/articles/distfunctions2d/)
- Sizing and spacing of shapes can also be altered


## Images
![image](https://github.com/uupb/Metatrons_Cube/assets/93621948/1e5195a3-02ec-47cd-82e5-3fcb238fa5ed)![image](https://github.com/uupb/Metatrons_Cube/assets/93621948/777d0d0d-52c9-4353-9ab4-582a3840fcb9)

## Requirements
Python 3.x
moderngl_window library
OpenGL-compatible graphics setup

## Setup
To get started with this project:

>pip install moderngl_window

## Usage
Running main.py opens a window with the shader-rendered Metatron's Cube. Developers can modify any of the 19 fragment shader stages to experiment with different rendering techniques and effects.

## References:
- [Python Enviroment Setup](https://youtu.be/sW56us0ZBEQ?si=pEGrPHT8mh4kpmRx)
- [Shader Overview - Entry](https://www.youtube.com/watch?v=3mfvZ-mdtZQ&t=814s)
- [Shader Overview - Intermediate](https://www.youtube.com/watch?v=f4s1h2YETNY)

## Other Resources
- [Inspiration](https://www.shadertoy.com/)
- [Color Pallette Help](http://dev.thi.ng/gradients/)
- [Math Visulizer](https://graphtoy.com/)
- [Plotting help](https://www.desmos.com/calculator)

## License
This project is open-sourced under the MIT License. See the LICENSE file for more details.

## Contributions
Contributions are encouraged, especially those that refine the visual output or optimize the shader performance. Please fork this repository, commit your improvements, and open a pull request with your changes.



