#version 330 core

layout(location = 0) in vec3 aPos;     // Receives vertex position
layout(location = 1) in vec3 aNormal;   // Receives vertex normal
layout(location = 2) in vec2 aTexCoord; // Receives texture coordinates

out vec3 FragPos;   // Passes fragment position to fragment shader
out vec3 Normal;    // Passes normal vector to fragment shader
out vec2 TexCoords; // Passes texture coordinates to fragment shader

uniform mat4 model;      // Model matrix
uniform mat4 view;       // View matrix
uniform mat4 projection; // Projection matrix

void main()
{
    gl_Position = projection * view * model * vec4(aPos, 1.0f);  // Transforms vertex position

    FragPos = vec3(model * vec4(aPos, 1.0));  // Sets fragment position
    Normal = mat3(transpose(inverse(model))) * aNormal;  // Computes normal vector

    TexCoords = aTexCoord;  // Passes texture coordinates to fragment shader
}

